X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-explain
Date: Mon, 04 Dec 2006 19:48:35 -0800
Message-ID: <7vwt57j94c.fsf_-_@assigned-by-dhcp.cox.net>
References: <200612031701.15594.alan@chandlerfamily.org.uk>
	<Pine.LNX.4.64.0612031024480.3476@woody.osdl.org>
	<7v1wngwws6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 03:48:51 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v1wngwws6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 03 Dec 2006 12:26:49 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33293>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrRIO-0002Cn-FB for gcvg-git@gmane.org; Tue, 05 Dec
 2006 04:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968043AbWLEDsh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 22:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968067AbWLEDsh
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 22:48:37 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:40278 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S968043AbWLEDsg (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 22:48:36 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061205034836.VWEV5575.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Mon, 4
 Dec 2006 22:48:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id urol1V00p1kojtg0000000; Mon, 04 Dec 2006
 22:48:46 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> So "git reset" is generally your friend whenever something goes wrong. If 
>> you also want to reset your checked-out files (which you did NOT want to 
>> do in this case, of course), you would have added the "--hard" flag to git 
>> reset.
>>
>> And that (finally) concludes this particularly boring "git usage 101" 
>> session.
>
> One observation about git, made in a relatively distant past,
> was "git is not a usable system yet; there is no 'git undo'".  I
> think it was on the kernel list (I think it was from Alan who
> seems to have lost his last name from his From: line lately, but
> I may be mistaken).
>
> It left a deep psychological trauma in me, not because it was
> stated in a brutal way (it wasn't) but because I fully agreed
> with that statement from the end user point of view, but I did
> not see a good solution to the problem (and I from the beginning
> kept saying "I do not do Porcelains" and kept calling what is
> shipped with core "Porcelain-ish").
> ...
> I think one cause of the "problem" (if not having a general
> "undo" is a problem, and I think it is to some extent) is that
> git Porcelain-ish commands try to stay stateless to allow mixing
> and matching of different commands to leave the door open to the
> end user to be flexible, but they go too far.

They go too far by doing too little.

And here is throwing an idea to remedy it; it is far from
complete but sending it out early before spending too much time
on pursuit of a wild goose.

-- >8 --
[PATCH] git-explain

This patch adds "git-explain" script that notices various clues
other commands can leave the working tree and repository in and
intended to guide the end user out of the confused mess.

This is only a demonstration-of-concept, as many commands do not
leave enough information for us to truly figure out what state
we are in nor how we got into the mess.  As a demonstration, it
makes "git merge" to leave a new "$GIT_DIR/FAILED_MERGE" file
when it gives up before touching the working tree.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-explain.sh |  172 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 git-merge.sh   |    3 +-
 git-reset.sh   |    3 +-
 3 files changed, 176 insertions(+), 2 deletions(-)

diff --git a/git-explain.sh b/git-explain.sh
new file mode 100755
index 0000000..07115ae
--- /dev/null
+++ b/git-explain.sh
@@ -0,0 +1,172 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Junio C Hamano
+#
+
+SUBDIRECTORY_OK=Yes
+. git-sh-setup
+
+TOP=`git-rev-parse --show-cdup`
+test -z "$TOP" && TOP=./
+
+say_with_indent() {
+	echo "$@" | sed -e 's/^/	/'
+}
+
+explain_merge_conflict () {
+	test -f $GIT_DIR/HEAD &&
+	test -f "$GIT_DIR/MERGE_HEAD" &&
+	test -f "$GIT_DIR/MERGE_MSG" &&
+	test "z`git ls-files -u`" != z || return 1
+
+	title=$(sed -e q "$GIT_DIR/MERGE_MSG")
+
+	conflicts=$(git ls-files -u |
+		sed -e 's/^[0-7]* [0-9a-f]* [0-3]	//' |
+		uniq)
+
+	git diff-index -r --name-only HEAD >"$tmp-1"
+	git diff-tree -r --name-only HEAD MERGE_HEAD >"$tmp-2"
+	locals=`comm -23 "$tmp-1" "$tmp-2"`
+
+	cat <<EOF
+You tried a merge whose title will be
+
+	$title
+
+This may have successfully merged some paths and they are already
+staged for the next commit, but the following paths could not be
+automatically merged:
+
+EOF
+
+	say_with_indent "$conflicts"
+
+	if test "z$locals" != z
+	then
+		cat <<\EOF
+
+Also you seem to have local modifications unrelated to this
+merge in the following paths:
+
+EOF
+
+		say_with_indent "$locals"
+	fi
+
+	cat <<\EOF
+
+There are two ways to proceed from here:
+
+(1) You can decide to abort this for now and get back to the
+    state before you started the merge.
+
+	$ git reset --hard
+
+    will revert your working tree files to the latest commit
+    before this merge.  Note that you would lose the local
+    modifications with this action, so you might want to
+    preserve them with this command before doing so:
+
+	$ git diff HEAD -- <locally changed files> >preserved-local-changes
+
+    Then you can re-apply the changes after running "git reset
+    --hard".
+
+(2) To resolve the conflicts and record this merge, you first
+    need to examine the conflicted paths listed above, and edit
+    them in your working tree.  After you are done, stage the
+    final version of these paths and make a commit, like this:
+
+	$ git add <locally changed files>
+	$ git commit
+
+    Do not use "git commit -a" unless you want the local
+    modifications that are not related to this merge committed
+    along with the changes this merge brings in.
+EOF
+}
+
+explain_merge_stop () {
+	test -f $GIT_DIR/HEAD &&
+	test -f $GIT_DIR/FAILED_MERGE &&
+	test "z`git rev-parse HEAD`" = "z`git rev-parse ORIG_HEAD`" &&
+	test "z`git ls-files -u`" = z || return 1
+
+	git diff-index -r --name-only HEAD >"$tmp-1"
+	git diff-tree -r --name-only HEAD FAILED_MERGE >"$tmp-2"
+	conflicts=`comm -12 "$tmp-1" "$tmp-2"`
+	locals=`comm -23 "$tmp-1" "$tmp-2"`
+
+	cat <<\EOF
+You tried a merge but it stopped without touching your working tree,
+because you had local changes in the following paths that may also
+be involved in the merge:
+
+EOF
+	say_with_indent "$conflicts"
+
+	if test "z$locals" != z
+	then
+		cat <<\EOF
+
+Also you seem to have local modifications unrelated to this
+merge in the following paths:
+
+EOF
+
+		say_with_indent "$locals"
+
+	fi
+
+	cat <<\EOF
+
+There are two ways to proceed from here:
+
+(1) You can decide to abort this merge for now.  You do not have
+    to do anything in this case because the merge hasn't touched
+    your working tree files yet.
+
+(2) You can first make the merge and re-apply your local changes
+    on top of the merge result.  To do this, first stash away
+    your local changes in a temporary commit, like this:
+
+	$ git commit -a -m 'WIP'
+	$ git tag WIP
+	$ git reset --hard HEAD^
+
+    and run the same "git merge" (or "git pull") again.  After
+    you finished the merge, you can review the local change with:
+
+	$ git show WIP
+
+    and re-apply them to your working tree as you see fit.
+EOF
+}
+
+explain_am () {
+	test -d $TOP/.dotest || return 1
+
+	cat <<EOF
+You tried to apply a series of `cat .dotest/last` patch(es) and
+are currently handling patch #`cat .dotest/next`.
+
+EOF
+
+}
+
+explain_base () {
+	# This comes at the end.
+	cat <<EOF
+Don't worry, you are not in the middle of anything complicated.
+EOF
+
+}
+
+tmp="$GIT_DIR/tmp"
+trap 'rm -f $tmp-*' 0
+
+explain_merge_conflict ||
+explain_merge_stop ||
+explain_am ||
+explain_base
\ No newline at end of file
diff --git a/git-merge.sh b/git-merge.sh
index 272f004..674abad 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -20,7 +20,7 @@ index_merge=t
 
 dropsave() {
 	rm -f -- "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/MERGE_MSG" \
-		 "$GIT_DIR/MERGE_SAVE" || exit 1
+		 "$GIT_DIR/MERGE_SAVE" "$GIT_DIR/FAILED_MERGE" || exit 1
 }
 
 savestate() {
@@ -400,6 +400,7 @@ case "$best_strategy" in
 '')
 	restorestate
 	echo >&2 "No merge strategy handled the merge."
+	echo "$@" >"$GIT_DIR/FAILED_MERGE"
 	exit 2
 	;;
 "$wt_strategy")
diff --git a/git-reset.sh b/git-reset.sh
index 3133b5b..045ee79 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -63,6 +63,7 @@ case "$reset_type" in
 	;;
 esac
 
-rm -f "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/rr-cache/MERGE_RR" "$GIT_DIR/SQUASH_MSG"
+rm -f "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/rr-cache/MERGE_RR" \
+	"$GIT_DIR/SQUASH_MSG" "$GIT_DIR/FAILED_MERGE"
 
 exit $update_ref_status
-- 
1.4.4.1.g15e3

