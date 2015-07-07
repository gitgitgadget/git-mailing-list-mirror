From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 00/12] Improve git-am test coverage
Date: Tue,  7 Jul 2015 22:08:22 +0800
Message-ID: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:08:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTYM-0005SN-Ki
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756960AbbGGOIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:08:49 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36136 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991AbbGGOIs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:08:48 -0400
Received: by pddu5 with SMTP id u5so39055569pdd.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=FYNbYTePs7FPD0TT1Q7SJz65urMokOuACtSuF8RWaIs=;
        b=tGhqCc3l0YU4Yhl2cmYRmE0xdQZp1/lL1gjfCXnIyT6zKAgex32ptAPhzA4gtInShX
         3/zi+D5pppc5rT3SIUKxTOgKSWAtXCu0DKujghCsZurydvl8Wjh5ksQziHAh6SCQDJGO
         8ASEZfTNouSDD5qqpbJs/ZcN15WmwszBSmc80/hEtRNN4McPNN5dn1buaxXeXF1LU26m
         z2uNo8iCbvN76Dg0yWDwwzTDJuBZM6CPqPti1hs61KqHSGandgG/UKr7FfwsbI1AAk/g
         CeNqSbzSdlCxE/T6jjWysWVFN0C9WMFGZwG0wJ/DU+8wE1FSKhn7MLdfMO4N3+5TcVAW
         3ofA==
X-Received: by 10.66.131.110 with SMTP id ol14mr9485342pab.0.1436278127658;
        Tue, 07 Jul 2015 07:08:47 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id im7sm22004766pbc.25.2015.07.07.07.08.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:08:46 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273507>

This is a re-roll of [v1]. Thanks Junio, Johannes, Paolo, Stefan for the
reviews last round. Interdiff below.

Previous versions:

[v1] http://thread.gmane.org/gmane.comp.version-control.git/273254

Increase test coverage of git-am.sh to help prevent regressions that could arise
from the rewrite of git-am.sh to C. This patch series, along with
pt/am-foreign, improved test coverage as measured by kcov from 56.5%[1] to
67.3%[2].

No tests for git-am's interactive mode, though, as test_terminal does not seem
to attach a pseudo-tty to stdin(?), thus making git-am's "test -t 0" check fail.

This is part of my GSoC project to rewrite git-am.sh to a C builtin[3].

[1] http://pyokagan.github.io/git/20150430132408-a75942b//kcov-merged/git-am.eb79278e.html
[2] http://pyokagan.github.io/git/20150702173751-2fdae08//kcov-merged/git-am.eb79278e.html
[3] https://gist.github.com/pyokagan/1b7b0d1f4dab6ba3cef1

Paul Tan (12):
  t4150: am.messageid really adds the message id
  t4150: am fails if index is dirty
  t4151: am --abort will keep dirty index intact
  t4150: am refuses patches when paused
  t4150: am --resolved fails if index has no changes
  t4150: am --resolved fails if index has unmerged entries
  t4150: am with applypatch-msg hook
  t4150: am with pre-applypatch hook
  t4150: am with post-applypatch hook
  t4150: tests for am --[no-]scissors
  t3418: non-interactive rebase --continue with rerere enabled
  t3901: test git-am encoding conversion

 t/t3418-rebase-continue.sh |  19 ++++
 t/t3901-i18n-patch.sh      |  62 +++++++++++++
 t/t4150-am.sh              | 217 +++++++++++++++++++++++++++++++++++++++++++++
 t/t4151-am-abort.sh        |  15 ++++
 4 files changed, 313 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 94e7c18..67fbf0e 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -182,9 +182,10 @@ test_expect_success 'am applies patch correctly' '
 '
 
 test_expect_success 'am fails if index is dirty' '
-	test_when_finished "rm -fr dirtyfile" &&
+	test_when_finished "rm -f dirtyfile" &&
 	rm -fr .git/rebase-apply &&
-	git checkout -f first &&
+	git reset --hard &&
+	git checkout first &&
 	echo dirtyfile >dirtyfile &&
 	git add dirtyfile &&
 	test_must_fail git am patch1 &&
@@ -231,12 +232,10 @@ test_expect_success 'am with applypatch-msg hook' '
 	git reset --hard &&
 	git checkout first &&
 	mkdir -p .git/hooks &&
-	cat >.git/hooks/applypatch-msg <<-\EOF &&
-	#!/bin/sh
+	write_script .git/hooks/applypatch-msg <<-\EOF &&
 	cat "$1" >actual-msg &&
 	echo hook-message >"$1"
 	EOF
-	chmod +x .git/hooks/applypatch-msg &&
 	git am patch1 &&
 	test_path_is_missing .git/rebase-apply &&
 	git diff --exit-code second &&
@@ -253,11 +252,9 @@ test_expect_success 'am with failing applypatch-msg hook' '
 	git reset --hard &&
 	git checkout first &&
 	mkdir -p .git/hooks &&
-	cat >.git/hooks/applypatch-msg <<-\EOF &&
-	#!/bin/sh
+	write_script .git/hooks/applypatch-msg <<-\EOF &&
 	exit 1
 	EOF
-	chmod +x .git/hooks/applypatch-msg &&
 	test_must_fail git am patch1 &&
 	test_path_is_dir .git/rebase-apply &&
 	git diff --exit-code first &&
@@ -270,17 +267,14 @@ test_expect_success 'am with pre-applypatch hook' '
 	git reset --hard &&
 	git checkout first &&
 	mkdir -p .git/hooks &&
-	cat >.git/hooks/pre-applypatch <<-\EOF &&
-	#!/bin/sh
+	write_script .git/hooks/pre-applypatch <<-\EOF &&
 	git diff first >diff.actual
 	exit 0
 	EOF
-	chmod +x .git/hooks/pre-applypatch &&
 	git am patch1 &&
 	test_path_is_missing .git/rebase-apply &&
 	git diff --exit-code second &&
 	test_cmp_rev second HEAD &&
-	test_cmp_rev second^ HEAD^ &&
 	git diff first..second >diff.expected &&
 	test_cmp diff.expected diff.actual
 '
@@ -291,11 +285,9 @@ test_expect_success 'am with failing pre-applypatch hook' '
 	git reset --hard &&
 	git checkout first &&
 	mkdir -p .git/hooks &&
-	cat >.git/hooks/pre-applypatch <<-\EOF &&
-	#!/bin/sh
+	write_script .git/hooks/pre-applypatch <<-\EOF &&
 	exit 1
 	EOF
-	chmod +x .git/hooks/pre-applypatch &&
 	test_must_fail git am patch1 &&
 	test_path_is_dir .git/rebase-apply &&
 	git diff --exit-code second &&
@@ -308,13 +300,11 @@ test_expect_success 'am with post-applypatch hook' '
 	git reset --hard &&
 	git checkout first &&
 	mkdir -p .git/hooks &&
-	cat >.git/hooks/post-applypatch <<-\EOF &&
-	#!/bin/sh
+	write_script .git/hooks/post-applypatch <<-\EOF &&
 	git rev-parse HEAD >head.actual
 	git diff second >diff.actual
 	exit 0
 	EOF
-	chmod +x .git/hooks/post-applypatch &&
 	git am patch1 &&
 	test_path_is_missing .git/rebase-apply &&
 	test_cmp_rev second HEAD &&
@@ -330,12 +320,10 @@ test_expect_success 'am with failing post-applypatch hook' '
 	git reset --hard &&
 	git checkout first &&
 	mkdir -p .git/hooks &&
-	cat >.git/hooks/post-applypatch <<-\EOF &&
-	#!/bin/sh
+	write_script .git/hooks/post-applypatch <<-\EOF &&
 	git rev-parse HEAD >head.actual
 	exit 1
 	EOF
-	chmod +x .git/hooks/post-applypatch &&
 	git am patch1 &&
 	test_path_is_missing .git/rebase-apply &&
 	git diff --exit-code second &&
@@ -782,7 +770,8 @@ test_expect_success 'am --message-id really adds the message id' '
 
 test_expect_success 'am.messageid really adds the message id' '
 	rm -fr .git/rebase-apply &&
-	git checkout -f HEAD^ &&
+	git reset --hard &&
+	git checkout HEAD^ &&
 	test_config am.messageid true &&
 	git am patch1.eml &&
 	test_path_is_missing .git/rebase-apply &&

-- 
2.5.0.rc1.76.gf60a929
