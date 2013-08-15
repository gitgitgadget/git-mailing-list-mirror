From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/3] git stash: avoid data loss when "git stash save" kills a directory
Date: Thu, 15 Aug 2013 16:30:32 -0700
Message-ID: <7vli42o7l3.fsf_-_@alter.siamese.dyndns.org>
References: <7v8v02rb2g.fsf@alter.siamese.dyndns.org>
	<1376602090-19142-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Josh Triplett <josh@joshtriplett.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 16 01:30:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA704-00019J-Oe
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 01:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527Ab3HOXah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 19:30:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50171 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752417Ab3HOXag (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 19:30:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5ABA39F1F;
	Thu, 15 Aug 2013 23:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tJacpC2VrUSm21NXiRdcqbhnJD4=; b=Ufq+2U
	ZN8uAHoU6bkdBryI6Df7oM0oLNtZYzm6+J997F3GYhULtcPDun2NMnnM63t8F0Yy
	GDTlncBLd06FnvUzAR8G99aznQmyuY4JEkRtzI7qFn+t6VRx5W1uyl4I2S0Icd0E
	EM7G4kZbSu7DLM0BvGUAq3/ptw2yakwajkgNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mh9EFzYNsqrk3WlOe4roQc1/d3L97c2K
	ZW7hsfGUnj0S4Zw7PKIpJ7X4LPqrHe8vY1VBO2JV3ejW7rS6X8MxtsKkOEd/VmVf
	HfMVXAIHBKojLOXeGrkxGYzQq0AvjZWZ2vG3rinEwZ8H3KNWlpJ0Cvl7Ed76QMKi
	rCeaF+1SPKA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB9F239F1E;
	Thu, 15 Aug 2013 23:30:34 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA7EF39F1B;
	Thu, 15 Aug 2013 23:30:33 +0000 (UTC)
In-Reply-To: <1376602090-19142-1-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Thu, 15 Aug 2013 14:28:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE695DA2-0602-11E3-BE3D-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232387>

From: Petr Baudis <pasky@ucw.cz>

"stash save" is about saving the local change to the working tree,
but also about restoring the state of the last commit to the working
tree.  When a local change is to turn a non-directory to a directory,
in order to restore the non-directory, everything in the directory
needs to be removed.

Which is fine when running "git stash save --include-untracked",
but without that option, untracked, newly created files in the
directory will have to be discarded, if the state you are restoring
to has a non-directory at the same path as the directory.

Introduce a safety valve to fail the operation in such case, using
the "ls-files --killed" which was designed for this exact purpose.

The "stash save" is stopped when untracked files need to be
discarded because their leading path ceased to be a directory, and
the user is required to pass --force to really have the data
removed.

Signed-off-by: Petr Baudis <pasky@ucw.cz>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * And this is the reverted patch ported on top of the "ls-files -k"
   miniseries I sent earlier.  The updates to the test in t3903
   compared to the original illustrates that the check implemented
   in the original did not protect once a path that was turned into
   a directory from a file gets added to the index, which this round
   also fixes by running "ls-files -k" against the state in the HEAD.

 Documentation/git-stash.txt | 11 +++++++++--
 git-stash.sh                | 20 ++++++++++++++++++++
 t/t3903-stash.sh            | 22 ++++++++++++++++++++++
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 711ffe1..61fadc5 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
 'git stash' [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
-	     [-u|--include-untracked] [-a|--all] [<message>]]
+	     [-u|--include-untracked] [-a|--all] [-f|--force] [<message>]]
 'git stash' clear
 'git stash' create
 
@@ -43,7 +43,7 @@ is also possible).
 OPTIONS
 -------
 
-save [-p|--patch] [--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
+save [-p|--patch] [--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-f|--force] [<message>]::
 
 	Save your local modifications to a new 'stash', and run `git reset
 	--hard` to revert them.  The <message> part is optional and gives
@@ -70,6 +70,13 @@ linkgit:git-add[1] to learn how to operate the `--patch` mode.
 +
 The `--patch` option implies `--keep-index`.  You can use
 `--no-keep-index` to override this.
++
+In some cases, saving a stash could mean irretrievably removing some
+data - if a directory with untracked files replaces a tracked file of
+the same name, the new untracked files are not saved (except in case
+of `--include-untracked`) but the original tracked file shall be restored.
+By default, `stash save` will abort in such a case; `--force` will allow
+it to remove the untracked files.
 
 list [<options>]::
 
diff --git a/git-stash.sh b/git-stash.sh
index bbefdf6..2d539f3 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -156,10 +156,19 @@ create_stash () {
 	die "$(gettext "Cannot record working tree state")"
 }
 
+# This helper MUST be run inside a subshell.
+list_killed_files () {
+	GIT_INDEX_FILE=$TMP-ls-files-k &&
+	export GIT_INDEX_FILE &&
+	git read-tree HEAD &&
+	git ls-files --killed
+}
+
 save_stash () {
 	keep_index=
 	patch_mode=
 	untracked=
+	force=
 	while test $# != 0
 	do
 		case "$1" in
@@ -180,6 +189,9 @@ save_stash () {
 		-u|--include-untracked)
 			untracked=untracked
 			;;
+		-f|--force)
+			force=t
+			;;
 		-a|--all)
 			untracked=all
 			;;
@@ -223,6 +235,14 @@ save_stash () {
 		say "$(gettext "No local changes to save")"
 		exit 0
 	fi
+	if test -z "$untracked$force" &&
+	   test -n "$(list_killed_files | head -n 1)"
+	then
+		say "$(gettext "The following untracked files would NOT be saved but need to be removed by stash save:")"
+		test -n "$GIT_QUIET" || (list_killed_files | sed 's/^/\t/')
+		say "$(gettext "Aborting. Consider using either the --force or --include-untracked option.")" >&2
+		exit 1
+	fi
 	test -f "$GIT_DIR/logs/$ref_stash" ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 5dfbda7..08ce23b 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -637,4 +637,26 @@ test_expect_success 'stash where working directory contains "HEAD" file' '
 	test_cmp output expect
 '
 
+test_expect_success 'stash a change to turn a non-directory to a directory' '
+	git reset --hard &&
+	>testfile &&
+	git add testfile &&
+	git commit -m "add testfile as a regular file" &&
+	rm testfile &&
+	mkdir testfile &&
+	>testfile/file &&
+	test_must_fail git stash save "recover regular file" &&
+	test -f testfile/file &&
+
+	git add testfile/file &&
+	test_must_fail git stash save "recover regular file after adding" &&
+	test -f testfile/file
+'
+
+test_expect_success 'stash a change to turn a non-directory to a directory (forced)' '
+	git stash save --force "recover regular file (forced)" &&
+	! test -f testfile/file &&
+	test -f testfile
+'
+
 test_done
-- 
1.8.4-rc3-236-g903ae4b
