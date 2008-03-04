From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] am: --rebasing
Date: Tue,  4 Mar 2008 00:25:06 -0800
Message-ID: <1204619106-30449-3-git-send-email-gitster@pobox.com>
References: <1204619106-30449-1-git-send-email-gitster@pobox.com>
 <1204619106-30449-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 09:26:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWSTV-0004l3-9r
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 09:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbYCDIZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 03:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbYCDIZf
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 03:25:35 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38773 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbYCDIZd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 03:25:33 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 468DC3880
	for <git@vger.kernel.org>; Tue,  4 Mar 2008 03:25:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6D04D387F for <git@vger.kernel.org>; Tue,  4 Mar 2008 03:25:32 -0500
 (EST)
X-Mailer: git-send-email 1.5.4.3.529.gb25fb
In-Reply-To: <1204619106-30449-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76050>

The new option --rebasing is used internally for rebase to tell am that
it is being used for its purpose.  This would leave .dotest/rebasing to
help "completion" scripts tell if the ongoing operation is am or rebase.

Also the option at the same time stands for --binary, -3 and -k which
are always given when rebase drives am as its backend.

Using the information "am" leaves, git-completion.bash tells ongoing
rebase and am apart.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash |   10 +++++++++-
 git-am.sh                              |   13 +++++++++++--
 git-rebase.sh                          |    2 +-
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8f70e1e..5ae8799 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -70,7 +70,15 @@ __git_ps1 ()
 		local b
 		if [ -d "$g/../.dotest" ]
 		then
-			r="|AM/REBASE"
+			if test -f "$g/../.dotest/rebasing"
+			then
+				r="|REBASE"
+			elif test -f "$g/../.dotest/applying"
+			then
+				r="|AM"
+			else
+				r="|AM/REBASE"
+			fi
 			b="$(git symbolic-ref HEAD 2>/dev/null)"
 		elif [ -f "$g/.dotest-merge/interactive" ]
 		then
diff --git a/git-am.sh b/git-am.sh
index 25129e6..db8171c 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -21,7 +21,8 @@ C=              pass it through git-apply
 p=              pass it through git-apply
 resolvemsg=     override error message when patch failure occurs
 r,resolved      to be used after a patch failure
-skip            skip the current patch"
+skip            skip the current patch
+rebasing        (internal use for git-rebase)"
 
 . git-sh-setup
 prefix=$(git rev-parse --show-prefix)
@@ -122,7 +123,7 @@ reread_subject () {
 
 prec=4
 dotest=".dotest"
-sign= utf8=t keep= skip= interactive= resolved= binary=
+sign= utf8=t keep= skip= interactive= resolved= binary= rebasing=
 resolvemsg= resume=
 git_apply_opt=
 
@@ -147,6 +148,8 @@ do
 		resolved=t ;;
 	--skip)
 		skip=t ;;
+	--rebasing)
+		rebasing=t threeway=t keep=t binary=t ;;
 	-d|--dotest)
 		die "-d option is not longer supported.  Do not use."
 		;;
@@ -237,6 +240,12 @@ else
 	echo "$utf8" >"$dotest/utf8"
 	echo "$keep" >"$dotest/keep"
 	echo 1 >"$dotest/next"
+	if test -n "$rebasing"
+	then
+		: >"$dotest/rebasing"
+	else
+		: >"$dotest/applying"
+	fi
 fi
 
 case "$resolved" in
diff --git a/git-rebase.sh b/git-rebase.sh
index 6b9af96..452c5e7 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -376,7 +376,7 @@ fi
 if test -z "$do_merge"
 then
 	git format-patch -k --stdout --full-index --ignore-if-in-upstream "$upstream"..ORIG_HEAD |
-	git am $git_am_opt --binary -3 -k --resolvemsg="$RESOLVEMSG" &&
+	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
 	ret=$?
 	test 0 != $ret -a -d .dotest &&
-- 
1.5.4.3.529.gb25fb

