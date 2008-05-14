From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-apply: check for empty files when detecting
 creation patch
Date: Tue, 13 May 2008 17:13:54 -0700
Message-ID: <7vve1hrbct.fsf@gitster.siamese.dyndns.org>
References: <1210257579-30975-1-git-send-email-imre.deak@gmail.com>
 <7vlk2h8t4d.fsf@gitster.siamese.dyndns.org>
 <500f3d130805131316m59898392l46e0dbf7cb352981@mail.gmail.com>
 <7vprrpswof.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0805131514300.3019@woody.linux-foundation.org>
 <7vlk2dsujm.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0805131552410.3019@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Imre Deak <imre.deak@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 14 02:15:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw4e2-0005qB-Fi
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 02:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756880AbYENAOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 20:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756727AbYENAOG
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 20:14:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46010 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964AbYENAOF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 20:14:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3B26E5D6E;
	Tue, 13 May 2008 20:14:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CF9025D6A; Tue, 13 May 2008 20:13:56 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A77D4BEA-214A-11DD-AAD6-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82055>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I think this is the fundamental problem:
>
> 	..
> 	if (patch->is_new < 0 && !oldlines) {
> 		patch->is_new = 1;
> 	..
>
> because that logic simply isn't right. (is_new < 0 && !oldlines) does 
> *not* mean that it must be new.
>
> We can say it the other way around, of course:
>
> 	if (patch->is_new < 0 && oldlines)
> 		patch->is_new = 0;
>
> and that's a valid rule, but I think we already would never set "is_new" 
> to -1 if we had old lines, so that would probably be a pointless thing to 
> do.

Yeah, in fact we have this:

	if (patch->is_new < 0 &&
	    (oldlines || (patch->fragments && patch->fragments->next)))
		patch->is_new = 0;

a several lines above the piece you quoted in parse_single_patch().


> So: remove the check for (is_new < 0 && !oldlines) because it doesn't 
> actually add any information, and leave "is_new" as unknown until later 
> when we actually *see* that file or not. Hmm?

That leads to the similar logic to remove "If we do not know if it is
delete or not, not adding any lines (or any replacement lines) means
delete" logic as well, which in turn means the whole if (!unidiff_zero...)
block would go.

Which actually is a good thing, I think.  As Imre mentioned, I do not
think 

	if (!unidiff_zero || context)

makes sense.  I cannot guess what the intention of that was.

    commit 4be609625e48e908f2b76d35bfeb61a8ba3a83a0
    Author: Junio C Hamano <junkio@cox.net>
    Date:   Sun Sep 17 01:04:24 2006 -0700

        apply --unidiff-zero: loosen sanity checks for --unidiff=0 patches

        In "git-apply", we have a few sanity checks and heuristics that
        expects that the patch fed to us is a unified diff with at least
        one line of context.

         ...description of good tests)...

        These sanity checks are good safety measures, but breaks down
        when people feed a diff generated with --unified=0.  This was
        recently noticed first by Matthew Wilcox and Gerrit Pape.

        This adds a new flag, --unified-zero, to allow bypassing these
        checks.  If you are in control of the patch generation process,
        you should not use --unified=0 patch and fix it up with this
        flag; rather you should try work with a patch with context.  But
        if all you have to work with is a patch without context, this
        flag may come handy as the last resort.

        Signed-off-by: Junio C Hamano <junkio@cox.net>

So unless unidiff-zero is given, we would want extra checks inside that
block.  Also if we have context in the patch anywhere, that means the
patch cannot be coming from "diff -u0", so we go into that block.

Even though other checks that are guarded with "if (!unidiff_zero)"
elsewhere in the code do make sense, however, this block may not do
anything useful, as you pointed out.

With the change to remove the whole block, all tests still passes, and a
limited test with this:

        --- empty	2008-05-13 16:56:57.000000000 -0700
        +++ empty.1	2008-05-13 16:57:07.000000000 -0700
        @@ -0,0 +1 @@
        +foo

to update an originally empty file "empty" also seems to work.

However, with this change, it no longer allows you to accept such a patch
and treat it as a creation of "empty".  Instead we barf with "error:
empty: No such file or directory", if you do not have an empty "empty"
file in the work tree when you run "git apply" on the above patch.

When "diff" was run with flags that could produce context (that is what we
get from !unidiff_zero), if we do not see any lines that begin with '-',
the only case that it is not a creation patch is if you compared the
postimage with a preimage of size 0.  Because we do not have usable
/dev/null cue, we cannot tell that case from a creation patch.

I am having a strong suspicion that doing this change is robbing Peter to
pay Imre.  We simply cannot have it both ways, methinks.

---

 builtin-apply.c |   17 +----------------
 1 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 1103625..395f16b 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -418,7 +418,7 @@ static int guess_p_value(const char *nameline)
 }
 
 /*
- * Get the name etc info from the --/+++ lines of a traditional patch header
+ * Get the name etc info from the ---/+++ lines of a traditional patch header
  *
  * FIXME! The end-of-filename heuristics are kind of screwy. For existing
  * files, we can happily check the index for a match, but for creating a
@@ -1143,21 +1143,6 @@ static int parse_single_patch(char *line, unsigned long size, struct patch *patc
 	if (patch->is_delete < 0 &&
 	    (newlines || (patch->fragments && patch->fragments->next)))
 		patch->is_delete = 0;
-	if (!unidiff_zero || context) {
-		/* If the user says the patch is not generated with
-		 * --unified=0, or if we have seen context lines,
-		 * then not having oldlines means the patch is creation,
-		 * and not having newlines means the patch is deletion.
-		 */
-		if (patch->is_new < 0 && !oldlines) {
-			patch->is_new = 1;
-			patch->old_name = NULL;
-		}
-		if (patch->is_delete < 0 && !newlines) {
-			patch->is_delete = 1;
-			patch->new_name = NULL;
-		}
-	}
 
 	if (0 < patch->is_new && oldlines)
 		die("new file %s depends on old contents", patch->new_name);
