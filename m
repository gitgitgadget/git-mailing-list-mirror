From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 4/5] support reading uncompressed loose object
Date: Tue, 2 Dec 2008 07:58:06 -0800
Message-ID: <20081202155806.GM23984@spearce.org>
References: <493399B7.5000505@gmail.com> <7voczws3np.fsf@gitster.siamese.dyndns.org> <493495B4.5070304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: Liu Yubao <yubao.liu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 16:59:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Xep-0006mY-Ag
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 16:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683AbYLBP6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 10:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbYLBP6J
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 10:58:09 -0500
Received: from george.spearce.org ([209.20.77.23]:41982 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755662AbYLBP6H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 10:58:07 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id BC78438200; Tue,  2 Dec 2008 15:58:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <493495B4.5070304@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102150>

Liu Yubao <yubao.liu@gmail.com> wrote:
> 
> Signed-off-by: Liu Yubao <yubao.liu@gmail.com>

I'd like to see a bit more of an explanation of the new loose
object format you are reading in the commit message.  We have a
long history of explaining *why* the code behaves the way it does
in our commits, so we can look at it in blame/log and understand
what the heck went on.
 
> ---
>  sha1_file.c |   20 +++++++++++++++++++-
>  1 files changed, 19 insertions(+), 1 deletions(-)
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index 79062f0..05a9fa3 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1985,6 +1985,16 @@ static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *size
>  	map = map_sha1_file(sha1, &mapsize);
>  	if (!map)
>  		return error("unable to find %s", sha1_to_hex(sha1));
> +
> +	/*
> +	 * Is it an uncompressed loose objects?
> +	 */
> +	if ((status = parse_sha1_header(map, mapsize, &size)) >= 0) {
> +		if (sizep)
> +			*sizep = size;
> +		goto L_leave;
> +	}
> +
>  	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
>  		status = error("unable to unpack %s header",
>  			       sha1_to_hex(sha1));
> @@ -1993,6 +2003,8 @@ static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *size
>  	else if (sizep)
>  		*sizep = size;
>  	inflateEnd(&stream);
> +
> +L_leave:
>  	munmap(map, mapsize);
>  	return status;
>  }
> @@ -2124,7 +2136,13 @@ void *read_object(const unsigned char *sha1, enum object_type *type,
>  		return buf;
>  	map = map_sha1_file(sha1, &mapsize);
>  	if (map) {
> -		buf = unpack_sha1_file(map, mapsize, type, size, sha1);
> +		/*
> +		 * Is it an uncompressed loose object?
> +		 */
> +		if ((*type = parse_sha1_header(map, mapsize, size)) >= 0)
> +			buf = xmemdupz(map + strlen(map) + 1, *size);
> +		else
> +			buf = unpack_sha1_file(map, mapsize, type, size, sha1);
>  		munmap(map, mapsize);
>  		return buf;
>  	}

-- 
Shawn.
