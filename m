From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] am: read from the right mailbox when started from a
 subdirectory
Date: Tue,  4 Mar 2008 00:25:04 -0800
Message-ID: <1204619106-30449-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 09:26:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWSTF-0004hC-BG
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 09:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbYCDIZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 03:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbYCDIZU
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 03:25:20 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38726 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbYCDIZT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 03:25:19 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E8E73879
	for <git@vger.kernel.org>; Tue,  4 Mar 2008 03:25:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 278E43878 for <git@vger.kernel.org>; Tue,  4 Mar 2008 03:25:17 -0500
 (EST)
X-Mailer: git-send-email 1.5.4.3.529.gb25fb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76048>

An earlier commit c149184 (allow git-am to run in a subdirectory) taught
git-am to start from a subdirectory by going up to the root of the work
tree byitself, but it did not adjust the path to read the mbox from when
it did so.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is a fixed-up version of an earlier patch I sent to Jeff and the
   list, and should be considered as a bugfix.

 git-am.sh            |   25 ++++++++++++++++-
 t/t4150-am-subdir.sh |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 2 deletions(-)
 create mode 100755 t/t4150-am-subdir.sh

diff --git a/git-am.sh b/git-am.sh
index a2c6fea..2b5bbb7 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -24,6 +24,7 @@ r,resolved      to be used after a patch failure
 skip            skip the current patch"
 
 . git-sh-setup
+prefix=$(git rev-parse --show-prefix)
 set_reflog_action am
 require_work_tree
 cd_to_toplevel
@@ -124,7 +125,8 @@ reread_subject () {
 }
 
 prec=4
-dotest=.dotest sign= utf8=t keep= skip= interactive= resolved= binary=
+dotest="${prefix}.dotest"
+sign= utf8=t keep= skip= interactive= resolved= binary=
 resolvemsg= resume=
 git_apply_opt=
 
@@ -150,7 +152,8 @@ do
 	--skip)
 		skip=t ;;
 	-d|--dotest)
-		shift; dotest=$1;;
+		shift
+		case "$1" in /*) dotest=$1;; *) dotest="$prefix$1" ;; esac ;;
 	--resolvemsg)
 		shift; resolvemsg=$1 ;;
 	--whitespace)
@@ -206,6 +209,24 @@ else
 	# Start afresh.
 	mkdir -p "$dotest" || exit
 
+	if test -n "$prefix" && test $# != 0
+	then
+		first=t
+		for arg
+		do
+			test -n "$first" && {
+				set x
+				first=
+			}
+			case "$arg" in
+			/*)
+				set "$@" "$arg" ;;
+			*)
+				set "$@" "$prefix$arg" ;;
+			esac
+		done
+		shift
+	fi
 	git mailsplit -d"$prec" -o"$dotest" -b -- "$@" > "$dotest/last" ||  {
 		rm -fr "$dotest"
 		exit 1
diff --git a/t/t4150-am-subdir.sh b/t/t4150-am-subdir.sh
new file mode 100755
index 0000000..929d2cb
--- /dev/null
+++ b/t/t4150-am-subdir.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+
+test_description='git am running from a subdirectory'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo hello >world &&
+	git add world &&
+	test_tick &&
+	git commit -m initial &&
+	git tag initial &&
+	echo goodbye >world &&
+	git add world &&
+	test_tick &&
+	git commit -m second &&
+	git format-patch --stdout HEAD^ >patchfile &&
+	: >expect
+'
+
+test_expect_success 'am regularly from stdin' '
+	git checkout initial &&
+	git am <patchfile &&
+	git diff master >actual &&
+	diff -u expect actual
+'
+
+test_expect_success 'am regularly from file' '
+	git checkout initial &&
+	git am patchfile &&
+	git diff master >actual &&
+	diff -u expect actual
+'
+
+test_expect_success 'am regularly from stdin in subdirectory' '
+	rm -fr subdir &&
+	git checkout initial &&
+	(
+		mkdir -p subdir &&
+		cd subdir &&
+		git am <../patchfile
+	) &&
+	git diff master>actual &&
+	diff -u expect actual
+'
+
+test_expect_success 'am regularly from file in subdirectory' '
+	rm -fr subdir &&
+	git checkout initial &&
+	(
+		mkdir -p subdir &&
+		cd subdir &&
+		git am ../patchfile
+	) &&
+	git diff master >actual &&
+	diff -u expect actual
+'
+
+test_expect_success 'am regularly from file in subdirectory with full path' '
+	rm -fr subdir &&
+	git checkout initial &&
+	P=$(pwd) &&
+	(
+		mkdir -p subdir &&
+		cd subdir &&
+		git am "$P/patchfile"
+	) &&
+	git diff master >actual &&
+	diff -u expect actual
+'
+
+test_done
-- 
1.5.4.3.529.gb25fb

