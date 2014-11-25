From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 2/2] git-am: add --message-id/--no-message-id
Date: Tue, 25 Nov 2014 15:00:56 +0100
Message-ID: <1416924056-29993-3-git-send-email-bonzini@gnu.org>
References: <1416924056-29993-1-git-send-email-bonzini@gnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 15:01:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtGg8-0007nP-7G
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 15:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbaKYOBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 09:01:12 -0500
Received: from mail-wi0-f173.google.com ([209.85.212.173]:63269 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbaKYOBI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 09:01:08 -0500
Received: by mail-wi0-f173.google.com with SMTP id r20so9211895wiv.6
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 06:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GgyD0iSMpPgZG+SDrbjwptCnE8ge/WFDNe/SgaA+Spc=;
        b=y4qDBLFJkOukah9/M39SWMSqS1MpSJHsqe4Qt9+zZU0u6Gn0L+L1UvrRjfYXddh8Bv
         8ybcnhUGojALkYqALuzLlm/abZMg0vZCHH0CLqRGiTYzjHJSjXMU5czc51sDYmOr5hkd
         egHVkYZsRc4XRwEU3CYebIt5G4b+A4NcSTnyE5bAAGFyB4dXWqqb4rBF0NKfpp8mE4OA
         qPhX4PEDzKsu1NvYhNu/w3BLvT4UZr1YPvznBAWOllxAEBx64YQM6FIM5R8B6ROCWDmG
         yrQ/6ePvtfCOyQ/3UyZtNUFfccHVghsHcK/vAq815BZDVuZJGmENaNQmBzTa4Xvh7DOF
         lu6Q==
X-Received: by 10.180.21.140 with SMTP id v12mr32233190wie.44.1416924067438;
        Tue, 25 Nov 2014 06:01:07 -0800 (PST)
Received: from donizetti.redhat.com (net-93-146-133-240.cust.vodafonedsl.it. [93.146.133.240])
        by mx.google.com with ESMTPSA id d5sm2009054wjb.34.2014.11.25.06.01.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Nov 2014 06:01:06 -0800 (PST)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1416924056-29993-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260220>

From: Paolo Bonzini <pbonzini@redhat.com>

Parse the option and pass it directly to git-mailinfo.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/git-am.txt | 11 +++++++++++
 git-am.sh                | 21 +++++++++++++++++++--
 t/t4150-am.sh            | 23 +++++++++++++++++++++++
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 9adce37..cfb74bc 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -57,6 +57,17 @@ OPTIONS
 --no-scissors::
 	Ignore scissors lines (see linkgit:git-mailinfo[1]).
 
+-m::
+--message-id::
+	Pass the `-m` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]),
+	so that the Message-ID header is added to the commit message.
+	The `am.messageid` configuration variable can be used to specify
+	the default behaviour.
+
+--no-message-id::
+	Do not add the Message-ID header to the commit message.
+	`no-message-id` is useful to override `am.messageid`.
+
 -q::
 --quiet::
 	Be quiet. Only print error messages.
diff --git a/git-am.sh b/git-am.sh
index ee61a77..c92632f 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -17,6 +17,7 @@ s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
 k,keep          pass -k flag to git-mailinfo
 keep-non-patch  pass -b flag to git-mailinfo
+m,message-id    pass -m flag to git-mailinfo
 keep-cr         pass --keep-cr flag to git-mailsplit for mbox format
 no-keep-cr      do not pass --keep-cr flag to git-mailsplit independent of am.keepcr
 c,scissors      strip everything before a scissors line
@@ -371,13 +372,18 @@ split_patches () {
 prec=4
 dotest="$GIT_DIR/rebase-apply"
 sign= utf8=t keep= keepcr= skip= interactive= resolved= rebasing= abort=
-resolvemsg= resume= scissors= no_inbody_headers=
+messageid= resolvemsg= resume= scissors= no_inbody_headers=
 git_apply_opt=
 committer_date_is_author_date=
 ignore_date=
 allow_rerere_autoupdate=
 gpg_sign_opt=
 
+if test "$(git config --bool --get am.messageid)" = true
+then
+    messageid=t
+fi
+
 if test "$(git config --bool --get am.keepcr)" = true
 then
     keepcr=t
@@ -400,6 +406,10 @@ it will be removed. Please do not use it anymore."
 		utf8=t ;; # this is now default
 	--no-utf8)
 		utf8= ;;
+	-m|--message-id)
+		messageid=t ;;
+	--no-message-id)
+		messageid=f ;;
 	-k|--keep)
 		keep=t ;;
 	--keep-non-patch)
@@ -567,6 +577,7 @@ Use \"git am --abort\" to remove it.")"
 	echo "$sign" >"$dotest/sign"
 	echo "$utf8" >"$dotest/utf8"
 	echo "$keep" >"$dotest/keep"
+	echo "$messageid" >"$dotest/messageid"
 	echo "$scissors" >"$dotest/scissors"
 	echo "$no_inbody_headers" >"$dotest/no_inbody_headers"
 	echo "$GIT_QUIET" >"$dotest/quiet"
@@ -621,6 +632,12 @@ b)
 *)
 	keep= ;;
 esac
+case "$(cat "$dotest/messageid")" in
+t)
+	messageid=-m ;;
+f)
+	messageid= ;;
+esac
 case "$(cat "$dotest/scissors")" in
 t)
 	scissors=--scissors ;;
@@ -692,7 +709,7 @@ do
 			get_author_ident_from_commit "$commit" >"$dotest/author-script"
 			git diff-tree --root --binary --full-index "$commit" >"$dotest/patch"
 		else
-			git mailinfo $keep $no_inbody_headers $scissors $utf8 "$dotest/msg" "$dotest/patch" \
+			git mailinfo $keep $no_inbody_headers $messageid $scissors $utf8 "$dotest/msg" "$dotest/patch" \
 				<"$dotest/$msgnum" >"$dotest/info" ||
 				stop_here $this
 
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 5edb79a..306e6f3 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -85,6 +85,7 @@ test_expect_success setup '
 
 	git format-patch --stdout first >patch1 &&
 	{
+		echo "Message-Id: <1226501681-24923-1-git-send-email-bda@mnsspb.ru>" &&
 		echo "X-Fake-Field: Line One" &&
 		echo "X-Fake-Field: Line Two" &&
 		echo "X-Fake-Field: Line Three" &&
@@ -536,4 +537,26 @@ test_expect_success 'am empty-file does not infloop' '
 	test_i18ncmp expected actual
 '
 
+test_expect_success 'am --message-id really adds the message id' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout HEAD^ &&
+	git am --message-id patch1.eml &&
+	test_path_is_missing .git/rebase-apply &&
+	git cat-file commit HEAD | tail -n1 >actual &&
+	grep Message-Id patch1.eml >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'am --message-id -s signs off after the message id' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout HEAD^ &&
+	git am -s --message-id patch1.eml &&
+	test_path_is_missing .git/rebase-apply &&
+	git cat-file commit HEAD | tail -n2 | head -n1 >actual &&
+	grep Message-Id patch1.eml >expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.1.0
