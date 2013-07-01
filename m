From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] git stash: avoid data loss when "git stash save" kills a directory
Date: Mon,  1 Jul 2013 14:59:11 -0700
Message-ID: <1372715951-3224-3-git-send-email-gitster@pobox.com>
References: <20130628150532.GD12252@machine.or.cz>
 <1372715951-3224-1-git-send-email-gitster@pobox.com>
Cc: Petr Baudis <pasky@ucw.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 01 23:59:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utm8D-0002jK-QU
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 23:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755506Ab3GAV7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 17:59:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61416 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755479Ab3GAV7S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 17:59:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E493B2DC33;
	Mon,  1 Jul 2013 21:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=KrgK
	6UwHJr6WwGRhJNxO3rYTsIs=; b=SZgC6c4JM0MZSfPGijecpIVS0xqXHez3jSbI
	q5x7nZJ/TRcZxdHrGAmEtgGvwcJCqAjU8arnoVyxzNnPClzSKUP68ypGPd1p8dc4
	O8FhQ/4jo0Esqurws8L3b4jcZiO8r0zUy5HxCTxEDp9yIakUcmie2wzWHEdo251M
	H5ImjmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	XMQ+XknIkpirlCox0rEwTAqaQmaV5xRrlI/xvPHs0nb3O9M4AdZ7Mun66gEV0cuP
	HVMheXxIF4en7h6+pQILJA3nxq1bsm+xVf+BV0xBrxNH2iEm6PhW9e+qxo8gxMUN
	ylo9u0uB7YSCS6SU6HHkTiPVn7LFGnR1/IILHKpNESA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC08F2DC32;
	Mon,  1 Jul 2013 21:59:17 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2AB1D2DC31;
	Mon,  1 Jul 2013 21:59:17 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-795-g615e8f0
In-Reply-To: <1372715951-3224-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 798F3BD8-E299-11E2-B77A-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229332>

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
 Documentation/git-stash.txt | 12 ++++++++++--
 git-stash.sh                | 12 ++++++++++++
 t/t3903-stash.sh            | 18 ++++++++++++++++++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index db7e803..7c8b648 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -14,7 +14,8 @@ SYNOPSIS
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
 'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
-	     [-u|--include-untracked] [-a|--all] [<message>]]
+	     [-u|--include-untracked] [-a|--all] [-f|--force]
+	     [<message>]]
 'git stash' clear
 'git stash' create [<message>]
 'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
@@ -44,7 +45,7 @@ is also possible).
 OPTIONS
 -------
 
-save [-p|--patch] [--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
+save [-p|--patch] [--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-f|--force] [<message>]::
 
 	Save your local modifications to a new 'stash', and run `git reset
 	--hard` to revert them.  The <message> part is optional and gives
@@ -71,6 +72,13 @@ linkgit:git-add[1] to learn how to operate the `--patch` mode.
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
index 1e541a2..85c9e2c 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -195,6 +195,7 @@ save_stash () {
 	keep_index=
 	patch_mode=
 	untracked=
+	force=
 	while test $# != 0
 	do
 		case "$1" in
@@ -215,6 +216,9 @@ save_stash () {
 		-u|--include-untracked)
 			untracked=untracked
 			;;
+		-f|--force)
+			force=t
+			;;
 		-a|--all)
 			untracked=all
 			;;
@@ -258,6 +262,14 @@ save_stash () {
 		say "$(gettext "No local changes to save")"
 		exit 0
 	fi
+	if test -z "$untracked$force" &&
+	   test -n "$(git ls-files --killed | head -n 1)"
+	then
+		say "$(gettext "The following untracked files would NOT be saved but need to be removed by stash save:")"
+		test -n "$GIT_QUIET" || git ls-files --killed | sed 's/^/\t/'
+		say "$(gettext "Aborting. Consider using either the --force or --include-untracked option.")" >&2
+		exit 1
+	fi
 	test -f "$GIT_DIR/logs/$ref_stash" ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index debda7a..5d22f17 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -673,4 +673,22 @@ test_expect_success 'store updates stash ref and reflog' '
 	grep quux bazzy
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
1.8.3.2-798-g923e168
