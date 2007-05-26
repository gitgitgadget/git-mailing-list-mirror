From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH v3] Prevent megablobs from gunking up git packs
Date: Sat, 26 May 2007 15:51:48 -0700
Message-ID: <7vwsyvgpvf.fsf@assigned-by-dhcp.cox.net>
References: <465887AB.1010001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 27 00:51:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs576-0008LE-Pt
	for gcvg-git@gmane.org; Sun, 27 May 2007 00:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbXEZWvv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 18:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbXEZWvv
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 18:51:51 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:36929 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbXEZWvu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 18:51:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070526225150.VQJX13995.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sat, 26 May 2007 18:51:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3yrp1X00K1kojtg0000000; Sat, 26 May 2007 18:51:50 -0400
In-Reply-To: <465887AB.1010001@gmail.com> (Dana How's message of "Sat, 26 May
	2007 12:16:59 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48501>

Dana How <danahow@gmail.com> writes:

> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 19b0aa1..59be849 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> ...
> @@ -371,8 +372,6 @@ static unsigned long write_object(struct sha1file *f,
>  				pack_size_limit - write_offset : 0;
>  				/* no if no delta */
>  	int usable_delta =	!entry->delta ? 0 :
> -				/* yes if unlimited packfile */
> -				!pack_size_limit ? 1 :
>  				/* no if base written to previous pack */
>  				entry->delta->offset == (off_t)-1 ? 0 :
>  				/* otherwise double-check written to this
> @@ -408,7 +407,7 @@ static unsigned long write_object(struct sha1file *f,
>  		buf = read_sha1_file(entry->sha1, &type, &size);
>  		if (!buf)
>  			die("unable to read %s", sha1_to_hex(entry->sha1));
> -		if (size != entry->size)
> +		if (size != entry->size && type == obj_type)
>  			die("object %s size inconsistency (%lu vs %lu)",
>  			    sha1_to_hex(entry->sha1), size, entry->size);
>  		if (usable_delta) {

I do not quite get how these two hunks relate to the topic of
this patch.  Care to enlighten?

> @@ -564,6 +563,17 @@ static off_t write_one(struct sha1file *f,
>  			return 0;
>  	}
>  
> +	/* refuse to include as many megablobs as possible */
> +	if (max_blob_size && e->size >= max_blob_size) {
> +		struct stat st;
> +		/* skip if unpacked, remotely packed, or loose anywhere */
> +		if (!e->in_pack || !e->in_pack->pack_local || find_sha1_file(e->sha1, &st)) {
> +			e->offset = (off_t)-1;	/* might drop reused delta base if mbs less */
> +			written++;
> +			return offset;
> +		}
> +	}
> +
>  	e->offset = offset;
>  	size = write_object(f, e, offset);
>  	if (!size) {

I thought that you are simply ignoring the "naughty blobs"---why
should it be done this late in the call sequence?  I haven't
followed the existing code nor your patch closely, but I wonder
why the filtering is simply done inside (or by the caller of)
add_object_entry().  You would need to do sha1_object_info()
much earlier than the current code does, though.
