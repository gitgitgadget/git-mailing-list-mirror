From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] Documentation: update "howto maintain git"
Date: Thu, 03 Jan 2013 12:40:11 -0800
Message-ID: <7vbod6vw44.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 03 21:40:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqrae-0006Ch-IE
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 21:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823Ab3ACUkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 15:40:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47227 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753710Ab3ACUkP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 15:40:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82F3DBF15;
	Thu,  3 Jan 2013 15:40:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=u
	LAhy3bq/dKvAmvl+VvpmwljC0c=; b=ML8pj507kLn7L4fnOXq6qZEyPzKg7cR4A
	juRYjSxT0+ij2F8xV7VFJFBj3uuWvwTAtsiBqSz+ENQZ5eLgye/fpMyQIXXbbV4i
	rbkUFF/Znr0kBzxG9DhyKSKhzjZccAG+P9rBh9d5bt+Zc8hsMz+3fxmxQeuXN8nT
	8R8iODsWJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=oOD
	N1vxfRYDd2iyNKzlzpLeTnQxTAhkJMY2Lg38XoCKKybMPJkTGbyW5s/q4Yd1P2VX
	wC5q4zMp1OHwNWnjpnAHBgyalljhFmPb7TLvm97Tr9caRjV5dUkq8KFlaGFFNpmM
	xAxdnXjLk8LVKb/18UbSnRPYVnQMW/6yHy+BQAiA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75459BF14;
	Thu,  3 Jan 2013 15:40:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D280BF13; Thu,  3 Jan 2013
 15:40:13 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C6043D60-55E5-11E2-96B0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212610>

The flow described in the document is still correct, but over time I
have automated various parts of the workflow with tools and their
use was not explained at all.

Update it and outline the use of two key scripts from the 'todo'
branch, "Reintegrate" and "cook".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I sent an incomplete preview some time ago; this is an update.
   The old one is at:

   http://thread.gmane.org/gmane.comp.version-control.git/210632

   Antoine Cc'ed because this is a more detailed answer to his
   question in:

   http://thread.gmane.org/gmane.comp.version-control.git/212127/focus=212333


 Documentation/howto/maintain-git.txt | 314 +++++++++++++++++++++++++----------
 1 file changed, 225 insertions(+), 89 deletions(-)

diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
index 8823a37..a4ec3cb 100644
--- a/Documentation/howto/maintain-git.txt
+++ b/Documentation/howto/maintain-git.txt
@@ -8,20 +8,20 @@ Abstract: Imagine that git development is racing along as usual, when our friend
 
 The maintainer's git time is spent on three activities.
 
- - Communication (60%)
+ - Communication (45%)
 
    Mailing list discussions on general design, fielding user
    questions, diagnosing bug reports; reviewing, commenting on,
    suggesting alternatives to, and rejecting patches.
 
- - Integration (30%)
+ - Integration (50%)
 
    Applying new patches from the contributors while spotting and
    correcting minor mistakes, shuffling the integration and
    testing branches, pushing the results out, cutting the
    releases, and making announcements.
 
- - Own development (10%)
+ - Own development (5%)
 
    Scratching my own itch and sending proposed patch series out.
 
@@ -35,6 +35,9 @@ The policy.
    contain bugfixes and enhancements in any area, including
    functionality, performance and usability, without regression.
 
+ - One release cycle for a feature release is expected to last for
+   eight to ten weeks.
+
  - Maintenance releases are numbered as vX.Y.Z.W and are meant
    to contain only bugfixes for the corresponding vX.Y.Z feature
    release and earlier maintenance releases vX.Y.Z.V (V < W).
@@ -58,12 +61,15 @@ The policy.
  - 'pu' branch is used to publish other proposed changes that do
    not yet pass the criteria set for 'next'.
 
- - The tips of 'master', 'maint' and 'next' branches will always
-   fast-forward, to allow people to build their own
-   customization on top of them.
+ - The tips of 'master' and 'maint' branches will not be rewound to
+   allow people to build their own customization on top of them.
+   Early in a new development cycle, 'next' is rewound to the tip of
+   'master' once, but otherwise it will not be rewound until the end
+   of the cycle.
 
- - Usually 'master' contains all of 'maint', 'next' contains all
-   of 'master' and 'pu' contains all of 'next'.
+ - Usually 'master' contains all of 'maint' and 'next' contains all
+   of 'master'.  'pu' contains all the topics merged to 'next', but
+   is rebuilt directly on 'master'.
 
  - The tip of 'master' is meant to be more stable than any
    tagged releases, and the users are encouraged to follow it.
@@ -76,11 +82,16 @@ The policy.
 A typical git day for the maintainer implements the above policy
 by doing the following:
 
- - Scan mailing list and #git channel log.  Respond with review
-   comments, suggestions etc.  Kibitz.  Collect potentially
-   usable patches from the mailing list.  Patches about a single
-   topic go to one mailbox (I read my mail in Gnus, and type
-   \C-o to save/append messages in files in mbox format).
+ - Scan mailing list.  Respond with review comments, suggestions
+   etc.  Kibitz.  Collect potentially usable patches from the
+   mailing list.  Patches about a single topic go to one mailbox (I
+   read my mail in Gnus, and type \C-o to save/append messages in
+   files in mbox format).
+
+ - Write his own patches to address issues raised on the list but
+   nobody has stepped up solving.  Send it out just like other
+   contributors do, and pick them up just like patches from other
+   contributors (see above).
 
  - Review the patches in the saved mailboxes.  Edit proposed log
    message for typofixes and clarifications, and add Acks
@@ -96,40 +107,32 @@ by doing the following:
    - Obviously correct fixes that pertain to the tip of 'master'
      are directly applied to 'master'.
 
+   - Other topics are not handled in this step.
+
    This step is done with "git am".
 
      $ git checkout master    ;# or "git checkout maint"
-     $ git am -3 -s mailbox
+     $ git am -sc3 mailbox
      $ make test
 
- - Merge downwards (maint->master):
-
-     $ git checkout master
-     $ git merge maint
-     $ make test
+   In practice, almost no patch directly goes to 'master' or
+   'maint'.
 
  - Review the last issue of "What's cooking" message, review the
-   topics scheduled for merging upwards (topic->master and
-   topic->maint), and merge.
+   topics ready for merging (topic->master and topic->maint).  Use
+   "Meta/cook -w" script (where Meta/ contains a checkout of the
+   'todo' branch) to aid this step.
+
+   And perform the merge.  Use "Meta/Reintegrate -e" script (see
+   later) to aid this step.
+
+     $ Meta/cook -w last-issue-of-whats-cooking.mbox
 
      $ git checkout master    ;# or "git checkout maint"
-     $ git merge ai/topic     ;# or "git merge ai/maint-topic"
+     $ echo ai/topic | Meta/Reintegrate -e ;# "git merge ai/topic"
      $ git log -p ORIG_HEAD.. ;# final review
      $ git diff ORIG_HEAD..   ;# final review
      $ make test              ;# final review
-     $ git branch -d ai/topic ;# or "git branch -d ai/maint-topic"
-
- - Merge downwards (maint->master) if needed:
-
-     $ git checkout master
-     $ git merge maint
-     $ make test
-
- - Merge downwards (master->next) if needed:
-
-     $ git checkout next
-     $ git merge master
-     $ make test
 
  - Handle the remaining patches:
 
@@ -138,9 +141,9 @@ by doing the following:
      and not in 'master') is applied to a new topic branch that
      is forked from the tip of 'master'.  This includes both
      enhancements and unobvious fixes to 'master'.  A topic
-     branch is named as ai/topic where "ai" is typically
-     author's initial and "topic" is a descriptive name of the
-     topic (in other words, "what's the series is about").
+     branch is named as ai/topic where "ai" is two-letter string
+     named after author's initial and "topic" is a descriptive name
+     of the topic (in other words, "what's the series is about").
 
    - An unobvious fix meant for 'maint' is applied to a new
      topic branch that is forked from the tip of 'maint'.  The
@@ -158,7 +161,8 @@ by doing the following:
 
    The above except the "replacement" are all done with:
 
-     $ git am -3 -s mailbox
+     $ git checkout ai/topic ;# or "git checkout -b ai/topic master"
+     $ git am -sc3 mailbox
 
    while patch replacement is often done by:
 
@@ -166,93 +170,166 @@ by doing the following:
 
    then replace some parts with the new patch, and reapplying:
 
+     $ git checkout ai/topic
      $ git reset --hard ai/topic~$n
-     $ git am -3 -s 000*.txt
+     $ git am -sc3 -s 000*.txt
 
    The full test suite is always run for 'maint' and 'master'
    after patch application; for topic branches the tests are run
    as time permits.
 
- - Update "What's cooking" message to review the updates to
-   existing topics, newly added topics and graduated topics.
-
-   This step is helped with Meta/cook script (where Meta/ contains
-   a checkout of the 'todo' branch).
+ - Merge maint to master as needed:
 
- - Merge topics to 'next'.  For each branch whose tip is not
-   merged to 'next', one of three things can happen:
+     $ git checkout master
+     $ git merge maint
+     $ make test
 
-   - The commits are all next-worthy; merge the topic to next:
+ - Merge master to next as needed:
 
      $ git checkout next
-     $ git merge ai/topic     ;# or "git merge ai/maint-topic"
+     $ git merge master
      $ make test
 
+ - Review the last issue of "What's cooking" again and see if topics
+   that are ready to be merged to 'next' are still in good shape
+   (e.g. has there any new issue identified on the list with the
+   series?)
+
+ - Prepare 'jch' branch, which is used to represent somewhere
+   between 'master' and 'pu' and often is slightly ahead of 'next'.
+
+     $ Meta/Reintegrate master..pu >Meta/redo-jch.sh
+
+   The result is a script that lists topics to be merged in order to
+   rebuild 'pu' as the input to Meta/Reintegrate script.  Remove
+   later topics that should not be in 'jch' yet.  Add a line that
+   consists of '###' before the name of the first topic in the output
+   that should be in 'jch' but not in 'next' yet.
+
+ - Now we are ready to start merging topics to 'next'.  For each
+   branch whose tip is not merged to 'next', one of three things can
+   happen:
+
+   - The commits are all next-worthy; merge the topic to next;
    - The new parts are of mixed quality, but earlier ones are
-     next-worthy; merge the early parts to next:
+     next-worthy; merge the early parts to next;
+   - Nothing is next-worthy; do not do anything.
+
+   This step is aided with Meta/redo-jch.sh script created earlier.
+   If a topic that was already in 'next' gained a patch, the script
+   would list it as "ai/topic~1".  To include the new patch to the
+   updated 'next', drop the "~1" part; to keep it excluded, do not
+   touch the line.  If a topic that was not in 'next' should be
+   merged to 'next', add it at the end of the list.  Then:
+
+     $ git checkout -B jch master
+     $ Meta/redo-jch.sh -c1
+
+   to rebuild the 'jch' branch from scratch.  "-c1" tells the script
+   to stop merging at the '###' line you added earlier.
+
+   At this point, build-test the result.  It may reveal semantic
+   conflicts (e.g. a topic renamed a variable, another added a new
+   reference to the variable under its old name), in which case
+   prepare an appropriate merge-fix first (see appendix), and
+   rebuild the 'jch' branch from scratch, starting at the tip of
+   'master'.
+
+   Then do the same to 'next'
 
      $ git checkout next
-     $ git merge ai/topic~2   ;# the tip two are dubious
-     $ make test
+     $ sh Meta/redo-jch.sh -c1 -e
 
-   - Nothing is next-worthy; do not do anything.
+   The "-e" option allows the merge message that comes from the
+   history of the topic and the comments in the "What's cooking" to
+   be edited.  The resulting tree should match 'jch' as the same set
+   of topics are merged on 'master'; otherwise there is a mismerge.
+   Investigate why and do not proceed until the mismerge is found
+   and rectified.
 
- - [** OBSOLETE **] Optionally rebase topics that do not have any commit
-   in next yet, when they can take advantage of low-level framework
-   change that is merged to 'master' already.
+     $ git diff jch next
 
-     $ git rebase master ai/topic
+   When all is well, clean up the redo-jch.sh script with
 
-   This step is helped with Meta/git-topic.perl script to
-   identify which topic is rebaseable.  There also is a
-   pre-rebase hook to make sure that topics that are already in
-   'next' are not rebased beyond the merged commit.
+     $ sh Meta/redo-jch.sh -u
 
- - [** OBSOLETE **] Rebuild "pu" to merge the tips of topics not in 'next'.
+   This removes topics listed in the script that have already been
+   merged to 'master'.  This unfortunately loses the "###" marker,
+   so add it again to the appropriate place.
 
-     $ git checkout pu
-     $ git reset --hard next
-     $ git merge ai/topic     ;# repeat for all remaining topics
-     $ make test
+ - Rebuild 'pu'.
+
+     $ Meta/Reintegrate master..pu >Meta/redo-pu.sh
+
+   Edit the result by adding new topics that are not still in 'pu'
+   in the script.  Then
+
+     $ git checkout -B pu jch
+     $ sh Meta/redo-pu.sh
+
+   When all is well, clean up the redo-pu.sh script with
+
+     $ sh Meta/redo-pu.sh -u
+
+   Double check by running
+
+     $ git branch --no-merged pu
+
+   to see there is no unexpected leftover topics.
+
+   At this point, build-test the result for semantic conflicts, and
+   if there are, prepare an appropriate merge-fix first (see
+   appendix), and rebuild the 'pu' branch from scratch, starting at
+   the tip of 'jch'.
+
+ - Update "What's cooking" message to review the updates to
+   existing topics, newly added topics and graduated topics.
 
-   This step is helped with Meta/PU script
+   This step is helped with Meta/cook script.
 
- - Push four integration branches to a private repository at
-   k.org and run "make test" on all of them.
+     $ Meta/cook
 
- - Push four integration branches to /pub/scm/git/git.git at
-   k.org.  This triggers its post-update hook which:
+   This script inspects the history between master..pu, finds tips
+   of topic branches, compares what it found with the current
+   contents in Meta/whats-cooking.txt, and updates that file.
+   Topics not listed in the file but are found in master..pu are
+   added to the "New topics" section, topics listed in the file that
+   are no longer found in master..pu are moved to the "Graduated to
+   master" section, and topics whose commits changed their states
+   (e.g. used to be only in 'pu', now merged to 'next') are updated
+   with change markers "<<" and ">>".
 
-    (1) runs "git pull" in $HOME/git-doc/ repository to pull
-        'master' just pushed out;
+   Look for lines enclosed in "<<" and ">>"; they hold contents from
+   old file that are replaced by this integration round.  After
+   verifying them, remove the old part.  Review the description for
+   each topic and update its doneness and plan as needed.  To review
+   the updated plan, run
 
-    (2) runs "make doc" in $HOME/git-doc/, install the generated
-        documentation in staging areas, which are separate
-        repositories that have html and man branches checked
-        out.
+     $ Meta/cook -w
 
-    (3) runs "git commit" in the staging areas, and run "git
-        push" back to /pub/scm/git/git.git/ to update the html
-        and man branches.
+   which will pick up comments given to the topics, such as "Will
+   merge to 'next'", etc. (see Meta/cook script to learn what kind
+   of phrases are supported).
 
-    (4) installs generated documentation to /pub/software/scm/git/docs/
-        to be viewed from http://www.kernel.org/
+ - Compile, test and install all four (five) integration branches;
+   Meta/Dothem script may aid this step.
 
- - Fetch html and man branches back from k.org, and push four
-   integration branches and the two documentation branches to
-   repo.or.cz and other mirrors.
+ - Format documentation if the 'master' branch was updated;
+   Meta/dodoc.sh script may aid this step.
 
+ - Push the integration branches out to public places; Meta/pushall
+   script may aid this step.
 
 Some observations to be made.
 
- * Each topic is tested individually, and also together with
-   other topics cooking in 'next'.  Until it matures, none part
-   of it is merged to 'master'.
+ * Each topic is tested individually, and also together with other
+   topics cooking first in 'pu', then in 'jch' and then in 'next'.
+   Until it matures, no part of it is merged to 'master'.
 
  * A topic already in 'next' can get fixes while still in
    'next'.  Such a topic will have many merges to 'next' (in
    other words, "git log --first-parent next" will show many
-   "Merge ai/topic to next" for the same topic.
+   "Merge branch 'ai/topic' to next" for the same topic.
 
  * An unobvious fix for 'maint' is cooked in 'next' and then
    merged to 'master' to make extra sure it is Ok and then
@@ -274,3 +351,62 @@ Some observations to be made.
  * Being in the 'next' branch is not a guarantee for a topic to
    be included in the next feature release.  Being in the
    'master' branch typically is.
+
+
+[Appendix]
+
+Preparing a "merge-fix"
+
+A merge of two topics may not textually conflict but still have
+conflict at the semantic level. A classic example is for one topic
+to rename an variable and all its uses, while another topic adds a
+new use of the variable under its old name. When these two topics
+are merged together, the reference to the variable newly added by
+the latter topic will still use the old name in the result.
+
+The Meta/Reintegrate script that is used by redo-jch and redo-pu
+scripts implements a crude but usable way to work this issue around.
+When the script merges branch $X, it checks if "refs/merge-fix/$X"
+exists, and if so, the effect of it is squashed into the result of
+the mechanical merge.  In other words,
+
+     $ echo $X | Meta/Reintegrate
+
+is roughly equivalent to this sequence:
+
+     $ git merge --rerere-autoupdate $X
+     $ git commit
+     $ git cherry-pick -n refs/merge-fix/$X
+     $ git commit --amend
+
+The goal of this "prepare a merge-fix" step is to come up with a
+commit that can be squashed into a result of mechanical merge to
+correct semantic conflicts.
+
+After finding that the result of merging branch "ai/topic" to an
+integration branch had such a semantic conflict, say pu~4, check the
+problematic merge out on a detached HEAD, edit the working tree to
+fix the semantic conflict, and make a separate commit to record the
+fix-up:
+
+     $ git checkout pu~4
+     $ git show -s --pretty=%s ;# double check
+     Merge branch 'ai/topic' to pu
+     $ edit
+     $ git commit -m 'merge-fix/ai/topic' -a
+
+Then make a reference "refs/merge-fix/ai/topic" to point at this
+result:
+
+     $ git update-ref refs/merge-fix/ai/topic HEAD
+
+Then double check the result by asking Meta/Reintegrate to redo the
+merge:
+
+     $ git checkout pu~5 ;# the parent of the problem merge
+     $ echo ai/topic | Meta/Reintegrate
+     $ git diff pu~4
+
+This time, because you prepared refs/merge-fix/ai/topic, the
+resulting merge should have been tweaked to include the fix for the
+semantic conflict.
-- 
1.8.1.293.g4a210a9
