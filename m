From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2] diffcore-break: don't divide by zero
Date: Wed, 3 Apr 2013 20:24:05 +0100
Message-ID: <20130403192405.GJ2222@serenity.lan>
References: <cover.1364931627.git.john@keeping.me.uk>
 <a2b6c61371ac6ff1e180c6600e57499ff94b2fd2.1364931627.git.john@keeping.me.uk>
 <7vvc84ab2y.fsf@alter.siamese.dyndns.org>
 <20130402213651.GG2222@serenity.lan>
 <7va9pga73t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 03 21:24:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNTIY-0007Ns-KU
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 21:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090Ab3DCTYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 15:24:13 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:45102 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761851Ab3DCTYL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 15:24:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 4578F198047;
	Wed,  3 Apr 2013 20:24:11 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7atfeoBA-4tg; Wed,  3 Apr 2013 20:24:10 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id C22A4198043;
	Wed,  3 Apr 2013 20:24:07 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7va9pga73t.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219961>

When the source file is empty, the calculation of the merge score
results in a division by zero.  In the situation:

     == preimage ==             == postimage ==

     F (empty file)             F (a large file)
                                E (a new empty file)

it does not make sense to consider F->E as a rename, so it is better not
to break the pre- and post-image of F.

Bail out early in this case to avoid hitting the divide-by-zero.  This
causes the merge score to be left at zero.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
On Tue, Apr 02, 2013 at 03:41:10PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > The message for commit 6dd4b66 (Fix diffcore-break total breakage)
> > indicates that "don't bother to break small files" is wrong in some
> > cases, but it I wonder if "don't bother to break empty files" is okay.
> 
> This has a rather subtle ramifications, and we would need to think
> carefully.  "break" does two very different things, and the criteria
> you would want to use to decide to "break" a filepair depends on
> which one you are interested in.
> 
> The very original motivation of "break" was to show a patch that
> rewrites an existing file completely in a way different from the
> usual "diff -u" output, which will try to minimize the output by
> finding (rare) lines that happen to be the same between the preimage
> and postimage, intersparsed in many lines of "-" (deletion) and "+"
> (addition).  Such a change is often easier to understand when shown
> as a single block of "-" (deletion) of the entire original contents,
> followed by a single block of "+" (addition) of the entire new
> contents.
> 
> A totally separate motivation of "break" is the one Linus talks
> about in the log message of the said commit.  A path filename.h was
> moved to filename_32.h, and a new (and much smaller) filename.h was
> introduced, that "#include"s filename_32.h.  "diff -M" that pairs
> deleted files with created files to compute renames in such a case
> would not consider the original filename.h as a possible source of
> filename_32.h that was created.  You want to break modification of
> filename.h into (virtual) deletion and addition of filename.h.
> 
> For the purpose of the former, you would want not to break a file
> too aggressively.  If you started from a file with 1000 lines in it,
> and deleted 910 lines and added 10 lines to result in a file with
> 100 lines, you still have 90 lines of shared contents between the
> preimage and the postimage, and you do not want to show it as
> "delete 1000 lines and add 100 lines".  You would want to base your
> decision on how much common material exists between the two.
> 
> For the purpose of the latter, however, it is better to err on the
> side of breaking than not breaking.  After breaking a suspicious
> modification into addition and deletion, if rename comparison does
> not find a suitable destination for the virtual deletion, the broken
> halves will be merged back, so breaking too little can hurt by
> missing potential renames, but breaking too much will not.  You do
> want to break the "900 deleted out of 1000 and then added 10" case,
> as that 900 lines may have gone to another file that was created in
> the same commit.  "But we have 90 lines of common material" does not
> matter for the decision to break.
> 
> In today's code, the return value of should_break() is about the
> latter, while the score it stores in *merge_score is about the
> former.

Thanks for this explanation.  Following it through, it seems that
bailing out early when the destination is empty will do the wrong thing,
whereas letting the code carry on should result in a merge score of
MAX_SCORE and the function returning 1.

So it seems that the patch you proposed is the best way to handle this.

 diffcore-break.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/diffcore-break.c b/diffcore-break.c
index 44f8678..1d9e530 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -68,6 +68,9 @@ static int should_break(struct diff_filespec *src,
 	if (max_size < MINIMUM_BREAK_SIZE)
 		return 0; /* we do not break too small filepair */
 
+	if (!src->size)
+		return 0; /* we do not let empty files get renamed */
+
 	if (diffcore_count_changes(src, dst,
 				   &src->cnt_data, &dst->cnt_data,
 				   0,
-- 
1.8.2.540.gf023cfe
