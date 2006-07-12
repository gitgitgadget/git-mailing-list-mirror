From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack
 file format"
Date: Wed, 12 Jul 2006 02:39:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607120226210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <20060711145527.GA32468@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org> <Pine.LNX.4.64.0607111010320.5623@g5.osdl.org>
 <44B4172B.3070503@stephan-feder.de> <Pine.LNX.4.64.0607111449190.5623@g5.osdl.org>
 <7vejwr3ftl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0607111656250.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, sf <sf-gmane@stephan-feder.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 12 02:39:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0SlI-0001Qc-IM
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 02:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWGLAj3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 20:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWGLAj3
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 20:39:29 -0400
Received: from mail.gmx.de ([213.165.64.21]:62357 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932300AbWGLAj2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 20:39:28 -0400
Received: (qmail invoked by alias); 12 Jul 2006 00:39:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 12 Jul 2006 02:39:27 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607111656250.5623@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23751>

Hi,

On Tue, 11 Jul 2006, Linus Torvalds wrote:

> On Tue, 11 Jul 2006, Junio C Hamano wrote:
> > 
> > I do not like to rely too heavily on what zlib compression's
> > beginning of stream looks like.
> 
> Well, I normally would agree with you if it was a "oh, all our zlib 
> objects seem to start with 0x78" thing, but after having dug into both the 
> zlib standard (which is actually an RFC, not just some random thing), and 
> looked at the sources, it's definitely the case that the "0x78" byte isn't 
> just an implementation detail.
> 
> It's actually really part of the specs, and not just happenstance.

Good.

> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -684,26 +684,74 @@ static void *map_sha1_file_internal(cons
>  	return map;
>  }
>  
> -static int unpack_sha1_header(z_stream *stream, void *map, unsigned long mapsize, void *buffer, unsigned long size)
> +static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz)
>  {
> +	unsigned char c;
> +	unsigned int word, bits;
> +	unsigned long size;
> +	static const char *typename[8] = {
> +		NULL,	/* OBJ_EXT */
> +		"commit", "tree", "blob", "tag",
> +		NULL, NULL, NULL
> +	};

I completely forgot to mention that type_names[] is already declared in 
object.h. Obviously, it is not really important, but maybe it would be 
better to obey the DRY principle (think addition of "bind" object type).

> +	while (!(c & 0x80)) {
> +		if (bits >= 8*sizeof(long))

Another nit: while it is safe to assume that sizeof(long) == 
sizeof(unsigned long), it was nevertheless a little confusing to yours 
truly (especially since you changed it since your last patch).

>  static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size)
>  {
>  	int bytes = strlen(buffer) + 1;
>  	unsigned char *buf = xmalloc(1+size);
> +	unsigned long n;
>  
> -	memcpy(buf, (char *) buffer + bytes, stream->total_out - bytes);
> -	bytes = stream->total_out - bytes;
> +	n = stream->total_out - bytes;
> +	if (n > size)
> +		n = size;

Just out of curiosity: when can this happen? I mean, there is no error or 
something which could tell the caller that not the whole object was 
copied.

>  	memset(&stream, 0, sizeof(stream));
>  	deflateInit(&stream, zlib_compression_level);
> -	size = deflateBound(&stream, len+hdrlen);
> +	size = 8 + deflateBound(&stream, len+hdrlen);

Again, I had to think why this is correct. I think it should be something 
like 2 + sizeof(unsigned long) * 8 / 7, but I did not think all that hard.

It looks good to me, but I did not really test...

Ciao,
Dscho
