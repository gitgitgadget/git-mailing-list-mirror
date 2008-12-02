From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/5] optimize parse_sha1_header() a little by detecting
	object type
Date: Tue, 2 Dec 2008 07:53:00 -0800
Message-ID: <20081202155300.GL23984@spearce.org>
References: <493399B7.5000505@gmail.com> <7voczws3np.fsf@gitster.siamese.dyndns.org> <49349579.2030506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: Liu Yubao <yubao.liu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 16:54:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7XZu-0004eL-M3
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 16:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbYLBPxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 10:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbYLBPxD
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 10:53:03 -0500
Received: from george.spearce.org ([209.20.77.23]:42598 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbYLBPxB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 10:53:01 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8408F38200; Tue,  2 Dec 2008 15:53:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49349579.2030506@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102149>

Liu Yubao <yubao.liu@gmail.com> wrote:
> diff --git a/sha1_file.c b/sha1_file.c
> index dccc455..79062f0 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1099,7 +1099,8 @@ static void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
>  
>  		if (!fstat(fd, &st)) {
>  			*size = xsize_t(st.st_size);
> -			map = xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
> +			if (*size > 0)
> +				map = xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
>  		}
>  		close(fd);
>  	}

This has nothing to do with this change description.  Why are we
returning NULL from map_sha1_file when the file length is 0 bytes?
No loose object should ever be an empty file, there must always be
some sort of type header present.  So it probably is an error to
have a 0 length file here.  But that bug is a different change.

> @@ -1257,6 +1258,8 @@ static int parse_sha1_header(const char *hdr, unsigned long length, unsigned lon
>  	 * terminating '\0' that we add), and is followed by
>  	 * a space, at least one byte for size, and a '\0'.
>  	 */
> +	if ('b' != *hdr && 'c' != *hdr && 't' != *hdr)	/* blob/commit/tag/tree */
> +		return -1;
>  	i = 0;
>  	while (hdr < hdr_end - 2) {
>  		char c = *hdr++;

Oh.  I wouldn't do that.  Its a cute trick and it works to quickly
determine if the header is an uncompressed header vs. a zlib header
vs. a new-style loose object header (which git cannot write anymore,
but it still can read).  But its just asking for trouble when/if a
new object type was ever added to the type table.

Given that we know that no type name can be more than 10 bytes and
if you use my patch from earlier today you can be certain hdr has a
'\0' terminator, so you could write a function to test for the type
against the hdr, stopping on either ' ' or '\0'.  Or find the first
' ' in the first 10 bytes (which is what this loop does anyway) and
then test that against the type name table.

-- 
Shawn.
