From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Handle deltified object correctly in git-*-pull family.
Date: Thu, 02 Jun 2005 17:31:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0506021713330.17354@localhost.localdomain>
References: <7vy89ums2l.fsf@assigned-by-dhcp.cox.net>
 <7vis0xkjn4.fsf@assigned-by-dhcp.cox.net>
 <7v4qcg906f.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0506020959250.1876@ppc970.osdl.org>
 <7v3bs07fmu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 23:37:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdxNJ-00053k-98
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 23:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVFBVjJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 17:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVFBVhK
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 17:37:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41678 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261348AbVFBVbs
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 17:31:48 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IHH00J0B7S8QG@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 02 Jun 2005 17:31:20 -0400 (EDT)
In-reply-to: <7v3bs07fmu.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2 Jun 2005, Junio C Hamano wrote:

> The initial parts of each retrieved SHA1 file is inflated and
> inspected to see if it is deltified, and its base object is
> asked from the remote side when it is.  Since this partial
> inflation and inspection has a small performance hit, it can
> optionally be skipped by giving -d flag to git-*-pull commands.

It is still way more expensive than it could.

> diff --git a/sha1_file.c b/sha1_file.c
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -325,7 +325,13 @@ void *unpack_sha1_rest(z_stream *stream,
>  	int bytes = strlen(buffer) + 1;
>  	char *buf = xmalloc(1+size);
>  
> -	memcpy(buf, buffer + bytes, stream->total_out - bytes);
> +	/* (stream->total_out - bytes) is what we already have.  The
> +	 * caller could be asking for something smaller than that.
> +	 */
> +	if (size < stream->total_out - bytes)
> +		memcpy(buf, buffer + bytes, size);
> +	else
> +		memcpy(buf, buffer + bytes, stream->total_out - bytes);
>  	bytes = stream->total_out - bytes;
>  	if (bytes < size) {
>  		stream->next_out = buf + bytes;

This hunk is completely unneeded.

> @@ -401,6 +407,41 @@ void * unpack_sha1_file(void *map, unsig
>  	return unpack_sha1_rest(&stream, hdr, *size);
>  }
>  
> +int sha1_delta_base(const unsigned char *sha1, unsigned char *base_sha1)
> +{
> +	int ret;
> +	unsigned long mapsize, size;
> +	void *map;
> +	z_stream stream;
> +	char hdr[1024], type[20];

Don't make hdr 1024 bytes long.  If you do so unpack_sha1_header() will 
uncompress up to 1024 bytes which is way above required.  Instead, 
consider a value of say 64 which is plenty sufficient (10 for the type 
string, another 10 for the size, 20 for the reference sha1 and another 
10 for the beginning of the delta data that must include the size, and 
the rest for good measure).

> +	void *delta_data_head;
> +
> +	map = map_sha1_file(sha1, &mapsize);
> +	if (!map)
> +		return -1;
> +	ret = unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr));
> +	if (ret < Z_OK || parse_sha1_header(hdr, type, &size) < 0) {
> +		ret = -1;
> +		goto out;
> +	}
> +	if (strcmp(type, "delta")) {
> +		ret = 0;
> +		goto out;
> +	}
> +	delta_data_head = unpack_sha1_rest(&stream, hdr, 20);

Here you don't need to call unpack_sha1_rest() at all which would call 
xmalloc and another memcpy needlessly.  Instead, just use:

	memcpy(base_sha1, hdr + strlen(hdr) + 1, 20);

and you're done.  No need to call an extra free() either.

And maybe this function should live in delta.c instead?


Nicolas
