From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 1/2] diffcore-break: don't divide by zero
Date: Tue, 2 Apr 2013 22:36:51 +0100
Message-ID: <20130402213651.GG2222@serenity.lan>
References: <cover.1364931627.git.john@keeping.me.uk>
 <a2b6c61371ac6ff1e180c6600e57499ff94b2fd2.1364931627.git.john@keeping.me.uk>
 <7vvc84ab2y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 23:37:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN8tU-00080n-C7
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 23:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762012Ab3DBVg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 17:36:58 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:39945 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761870Ab3DBVg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 17:36:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 52844CDA5AF;
	Tue,  2 Apr 2013 22:36:57 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eMFInOWUjFx5; Tue,  2 Apr 2013 22:36:56 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 873A7CDA590;
	Tue,  2 Apr 2013 22:36:53 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vvc84ab2y.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219890>

On Tue, Apr 02, 2013 at 02:15:17PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > When the source file is empty, the calculation of the merge score
> > results in a division by zero.  Since the merge score is initialized to
> > zero, it makes sense to just leave it as it is if the source size is
> > zero.  This means that we still use the extent of damage metric to
> > decide whether to break the filepair.
> 
> Well spotted.  An empty blob to another blob that is larger than 400
> bytes will trigger div0, and it makes sense to leave merge-score to
> 0 (i.e. do not show as whole-delete-then-whole-add after rename
> detection is done and the broken filepair is merged back).
> 
> Actually, if src->size is 0, we probably shouldn't break the filepair
> in the first place.  That is, if your preimage and postimage looked
> like these:
> 
> 
>      == preimage ==		== postimage ==
> 
>      F (empty file)		F (a large file)
> 			        E (a new empty file)
> 
> do we want to see F renamed to E and then a new file created as F
> while running "git diff -B -M"?  I doubt it.
> 
> So in that sense, this might be a better solution.  I dunno.

I considered this, but didn't quite understand the code well enough to
be sure that was the right thing to do.  Does it make sense to bail out
early if dst->size is zero as well?

The message for commit 6dd4b66 (Fix diffcore-break total breakage)
indicates that "don't bother to break small files" is wrong in some
cases, but it I wonder if "don't bother to break empty files" is okay.

>  diffcore-break.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/diffcore-break.c b/diffcore-break.c
> index 44f8678..eabafd5 100644
> --- a/diffcore-break.c
> +++ b/diffcore-break.c
> @@ -67,6 +67,8 @@ static int should_break(struct diff_filespec *src,
>  	max_size = ((src->size > dst->size) ? src->size : dst->size);
>  	if (max_size < MINIMUM_BREAK_SIZE)
>  		return 0; /* we do not break too small filepair */
> +	if (src->size == 0)
> +		return 0; /* we do not let empty files get renamed */
>  
>  	if (diffcore_count_changes(src, dst,
>  				   &src->cnt_data, &dst->cnt_data,
