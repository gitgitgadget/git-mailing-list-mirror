From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-commit --allow-empty
Date: Mon, 03 Dec 2007 00:53:05 -0800
Message-ID: <7vzlwsjh1q.fsf@gitster.siamese.dyndns.org>
References: <4751A0FB.6090705@gmail.com>
	<7vd4tq41zt.fsf@gitster.siamese.dyndns.org>
	<7v63zgkw0x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stelian@popies.net, git@vger.kernel.org
To: Mark Drago <markdrago@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 09:53:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz73V-0006dJ-3L
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 09:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbXLCIxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 03:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbXLCIxM
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 03:53:12 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:49896 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbXLCIxL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 03:53:11 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id D51D52EF;
	Mon,  3 Dec 2007 03:53:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 26B569B558;
	Mon,  3 Dec 2007 03:53:29 -0500 (EST)
In-Reply-To: <7v63zgkw0x.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 03 Dec 2007 00:44:14 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66889>

It does not usually make sense to record a commit that has the exact
same tree as its sole parent commit and that is why git-commit prevents
you from making such a mistake, but when data from foreign scm is
involved, it is a different story.  We are equipped to represent such an
(perhaps insane, perhaps by mistake, or perhaps done on purpose) empty
change, and it is better to represent it bypassing the safety valve for
native use.

This is primarily for use by foreign scm interface scripts.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * And this is for 'master'.

 Documentation/git-commit.txt |    8 +++++++-
 git-commit.sh                |   13 ++++++++++---
 t/t7501-commit.sh            |    7 +++++++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index d4bfd49..a7ef71f 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git-commit' [-a | --interactive] [-s] [-v] [-u]
 	   [(-c | -C) <commit> | -F <file> | -m <msg> | --amend]
-	   [--no-verify] [-e] [--author <author>]
+	   [--allow-empty] [--no-verify] [-e] [--author <author>]
 	   [--] [[-i | -o ]<file>...]
 
 DESCRIPTION
@@ -89,6 +89,12 @@ OPTIONS
 	This option bypasses the pre-commit hook.
 	See also link:hooks.html[hooks].
 
+--allow-empty::
+	Usually recording a commit that has the exact same tree as its
+	sole parent commit and the command prevents you from making such
+	a mistake.  This option bypasses the safety, and is primarily
+	for use by foreign scm interface scripts.
+
 -e|--edit::
 	The message taken from file with `-F`, command line with
 	`-m`, and from file with `-C` are usually used as the
diff --git a/git-commit.sh b/git-commit.sh
index cef76a7..2c4a406 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -74,6 +74,7 @@ trap '
 
 all=
 also=
+allow_empty=f
 interactive=
 only=
 logfile=
@@ -114,6 +115,10 @@ do
 	-a|--a|--al|--all)
 		all=t
 		;;
+	--allo|--allow|--allow-|--allow-e|--allow-em|--allow-emp|\
+	--allow-empt|--allow-empty)
+		allow_empty=t
+		;;
 	--au=*|--aut=*|--auth=*|--autho=*|--author=*)
 		force_author="${1#*=}"
 		;;
@@ -515,9 +520,11 @@ else
 	# we need to check if there is anything to commit
 	run_status >/dev/null
 fi
-case "$?,$PARENTS" in
-0,* | *,-p' '?*-p' '?*)
-	# a merge commit can record the same tree as its parent.
+case "$allow_empty,$?,$PARENTS" in
+t,* | ?,0,* | ?,*,-p' '?*-p' '?*)
+	# an explicit --allow-empty, or a merge commit can record the
+	# same tree as its parent.  Otherwise having commitable paths
+	# is required.
 	;;
 *)
 	rm -f "$GIT_DIR/COMMIT_EDITMSG" "$GIT_DIR/SQUASH_MSG"
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 2e7bcb0..0316ecf 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -256,6 +256,13 @@ test_expect_success 'same tree (single parent)' '
 
 '
 
+test_expect_success 'same tree (single parent) --allow-empty' '
+
+	git commit --allow-empty -m "forced empty" &&
+	git cat-file commit HEAD | grep forced
+
+'
+
 test_expect_success 'same tree (merge and amend merge)' '
 
 	git checkout -b side HEAD^ &&
-- 
1.5.3.7-2077-ga07a
