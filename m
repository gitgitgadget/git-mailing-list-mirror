From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 10/10] t7063: add tests for core.untrackedCache
Date: Tue, 29 Dec 2015 08:09:34 +0100
Message-ID: <1451372974-16266-11-git-send-email-chriscool@tuxfamily.org>
References: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:13:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDoSv-0000Dn-V3
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:13:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbbL2HM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:12:58 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34400 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbbL2HM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:12:26 -0500
Received: by mail-wm0-f46.google.com with SMTP id u188so2211820wmu.1
        for <git@vger.kernel.org>; Mon, 28 Dec 2015 23:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iex5i/VQSsj/5521kJb18pGW4tiPJCxbB2i7zj6lbUw=;
        b=AAexwZ4jlUihSM58UJzjtsmUtKpqWcMn6Nqiy5a8YikOG3BbIq61cn6tycaQo5tyR2
         YgPpYLCN3qLqiqWreUeCBu7ww4v/+U66kqTxXAPd/ZEneriJMKQpbbiiRos8KtrN0dcK
         HWQc0qZADhtoNNO0S+OPdI5mc/joQDozEzNFzWgKChxZuVyvx1QBMMTpgJOIeqdD8COn
         J6ehcJrlCbD0BdfFfPe3b39t7JOMkcs+2V/utcERY1YF2WkZUDJuzBVd9hlxTCpf+UaB
         N2TJxJ+kCx8dbBZaIdE5V/n6F/tfSBZcEzHDfU7Ut0AuEp+uj1kRabmmeosT7OsniJLg
         EBHw==
X-Received: by 10.28.142.8 with SMTP id q8mr30562707wmd.47.1451373145628;
        Mon, 28 Dec 2015 23:12:25 -0800 (PST)
Received: from localhost.localdomain (243.40.126.78.rev.sfr.net. [78.126.40.243])
        by smtp.gmail.com with ESMTPSA id uw6sm59795661wjc.42.2015.12.28.23.12.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Dec 2015 23:12:24 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.rc2.10.g544ad6b
In-Reply-To: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283089>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7063-status-untracked-cache.sh | 75 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 4 deletions(-)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 253160a..67e049e 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -18,6 +18,10 @@ if ! test_have_prereq UNTRACKED_CACHE; then
 	test_done
 fi
 
+test_expect_success 'core.untrackedCache is unset' '
+	test_must_fail git config --get core.untrackedCache
+'
+
 test_expect_success 'setup' '
 	git init worktree &&
 	cd worktree &&
@@ -30,13 +34,13 @@ test_expect_success 'setup' '
 
 test_expect_success 'untracked cache is empty' '
 	test-dump-untracked-cache >../actual &&
-	cat >../expect <<EOF &&
+	cat >../expect-empty <<EOF &&
 info/exclude 0000000000000000000000000000000000000000
 core.excludesfile 0000000000000000000000000000000000000000
 exclude_per_dir .gitignore
 flags 00000006
 EOF
-	test_cmp ../expect ../actual
+	test_cmp ../expect-empty ../actual
 '
 
 cat >../status.expect <<EOF &&
@@ -506,7 +510,7 @@ EOF
 
 test_expect_success 'verify untracked cache dump (sparse/subdirs)' '
 	test-dump-untracked-cache >../actual &&
-	cat >../expect <<EOF &&
+	cat >../expect-from-test-dump <<EOF &&
 info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
 core.excludesfile 0000000000000000000000000000000000000000
 exclude_per_dir .gitignore
@@ -525,7 +529,7 @@ file
 /dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
 two
 EOF
-	test_cmp ../expect ../actual
+	test_cmp ../expect-from-test-dump ../actual
 '
 
 test_expect_success 'test sparse status again with untracked cache and subdir' '
@@ -569,4 +573,67 @@ EOF
 	test_cmp ../status.expect ../status.actual
 '
 
+test_expect_success '--no-untracked-cache removes the cache' '
+	git update-index --no-untracked-cache &&
+	test-dump-untracked-cache >../actual &&
+	echo "no untracked cache" >../expect &&
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'git status does not change anything' '
+	git status &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'setting core.untrackedCache to true and using git status creates the cache' '
+	git config core.untrackedCache true &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect ../actual &&
+	git status &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-from-test-dump ../actual
+'
+
+test_expect_success 'using --no-untracked-cache fails when core.untrackedCache is true' '
+	test_must_fail git update-index --no-untracked-cache &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-from-test-dump ../actual
+'
+
+test_expect_success 'setting core.untrackedCache to false and using git status removes the cache' '
+	git config core.untrackedCache false &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-from-test-dump ../actual &&
+	git status &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'using --untracked-cache fails when core.untrackedCache is false' '
+	test_must_fail git update-index --untracked-cache &&
+	test_must_fail git update-index --force-untracked-cache &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'setting core.untrackedCache to keep' '
+	git config core.untrackedCache keep &&
+	git update-index --untracked-cache &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-empty ../actual &&
+	git status &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-from-test-dump ../actual &&
+	git update-index --no-untracked-cache &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect ../actual &&
+	git update-index --force-untracked-cache &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-empty ../actual &&
+	git status &&
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../expect-from-test-dump ../actual
+'
+
 test_done
-- 
2.7.0.rc2.10.g544ad6b
