From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] copy vs rename detection: avoid unnecessary O(n*m) loops
Date: Fri, 26 Oct 2007 15:53:21 -0700
Message-ID: <7vabq5wkri.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.or g>
	<alpine.LFD.0.999.0710251119120.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Oct 27 00:53:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlY3h-0001p7-If
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 00:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbXJZWx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 18:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbXJZWx3
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 18:53:29 -0400
Received: from rune.pobox.com ([208.210.124.79]:54380 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939AbXJZWx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 18:53:29 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 39861150AE1;
	Fri, 26 Oct 2007 18:53:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 290291509DE;
	Fri, 26 Oct 2007 18:53:44 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0710251119120.30120@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 25 Oct 2007 11:20:56 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62448>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> @@ -2640,27 +2640,21 @@ static void diff_resolve_rename_copy(void)
>  		 * either in-place edit or rename/copy edit.
>  		 */
>  		else if (DIFF_PAIR_RENAME(p)) {
> +			/*
> +			 * A rename might have re-connected a broken
> +			 * pair up, causing the pathnames to be the
> +			 * same again. If so, that's not a rename at
> +			 * all, just a modification..
> +			 *
> +			 * Otherwise, see if this source was used for
> +			 * multiple renames, in which case we decrement
> +			 * the count, and call it a copy.
>  			 */
> +			if (!strcmp(p->one->path, p->two->path))
> +				p->status = DIFF_STATUS_MODIFIED;
> +			else if (--p->one->rename_used > 0)
>  				p->status = DIFF_STATUS_COPIED;
> +			else
>  				p->status = DIFF_STATUS_RENAMED;
>  		}
>  		else if (hashcmp(p->one->sha1, p->two->sha1) ||

The interaction between the above and ...

> @@ -338,15 +320,25 @@ void diffcore_rename(struct diff_options *options)
>  				locate_rename_dst(p->two, 1);
>  		}
>  		else if (!DIFF_FILE_VALID(p->two)) {
> +			/*
> +			 * If the source is a broken "delete", and
>  			 * they did not really want to get broken,
>  			 * that means the source actually stays.
> +			 * So we increment the "rename_used" score
> +			 * by one, to indicate ourselves as a user
> +			 */
> +			if (p->broken_pair && !p->score)
> +				p->one->rename_used++;
> +			register_rename_src(p->one, p->score);
> +		}
> +		else if (detect_rename == DIFF_DETECT_COPY) {
> +			/*
> +			 * Increment the "rename_used" score by
> +			 * one, to indicate ourselves as a user.
>  			 */
> +			p->one->rename_used++;
> +			register_rename_src(p->one, p->score);
>  		}
>  	}
>  	if (rename_dst_nr == 0 || rename_src_nr == 0)
>  		goto cleanup; /* nothing to do */

... this part feels a bit too subtle for a still-jet-lagged
brain to grok.  I wonder what happens if the preimage of a
broken pair is used as the rename source for more than two
postimages.
