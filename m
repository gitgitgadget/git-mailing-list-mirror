From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH v2 1/2] t4255: test am submodule with diff.submodule
Date: Sat, 27 Dec 2014 19:04:23 -0600
Message-ID: <1419728664-18627-1-git-send-email-dougk.ff7@gmail.com>
References: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
Cc: Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 28 02:04:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y52Hu-0003Hv-Ti
	for gcvg-git-2@plane.gmane.org; Sun, 28 Dec 2014 02:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbaL1BEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2014 20:04:49 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:53899 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbaL1BEs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2014 20:04:48 -0500
Received: by mail-ob0-f180.google.com with SMTP id wp4so37766776obc.11
        for <git@vger.kernel.org>; Sat, 27 Dec 2014 17:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZGsXWDDus+5Z9MxW1Yp2/OMMuMdfVJPrSDlpq+ILM5U=;
        b=J7yWo4PuemvxmfeWbGL7LR0cvfQY9MyaBO9ikNOfqfAmayauzbsyCFZ9FzLYxYklbK
         bwmHPQSM1zJXVbSciAobbhDhksAdNLxS/14rIdvzSHGDPw959JooF3PYVzqAW7JKsnnF
         BxLi4tQA4teYogXAiDmu+dxd0v3tKP3jkOLEXrUqKR/Jv2wOzQ47qqae95C9TVpg8J+I
         S+ZkdSfJTjzNmGounVlgy7Dc/Fei42SeYQ1j596+LNfL+D8Ch1jgmSUmW4MtekWkEEsE
         r62r95YB0zHBeSK4hxuhP9b2XWMXZ3aPVi03wzacOD517MtOZ/5bdajqk+1z0w8utTyZ
         de6g==
X-Received: by 10.182.58.102 with SMTP id p6mr28899722obq.84.1419728687943;
        Sat, 27 Dec 2014 17:04:47 -0800 (PST)
Received: from kenshin.dougk-ff7.net (64-151-63-23.static.everestkc.net. [64.151.63.23])
        by mx.google.com with ESMTPSA id y15sm16526262oia.20.2014.12.27.17.04.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Dec 2014 17:04:46 -0800 (PST)
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261850>

git am will break when using diff.submodule=log; add some test cases
to illustrate this breakage as simply as possible.  There are
currently two ways this can fail:

* With errors ("unrecognized input"), if only change
* Silently (no submodule change), if other files change

Test for both conditions and ensure without diff.submodule this works.

Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
---
 t/t4255-am-submodule.sh | 84 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
index 8bde7db..a2dc083 100755
--- a/t/t4255-am-submodule.sh
+++ b/t/t4255-am-submodule.sh
@@ -18,4 +18,88 @@ am_3way () {
 KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
 test_submodule_switch "am_3way"
 
+test_expect_success 'setup diff.submodule' '
+	echo one >one &&
+	git add one &&
+	test_tick &&
+	git commit -m initial &&
+	INITIAL=$(git rev-parse HEAD) &&
+
+	git init submodule &&
+	(
+		cd submodule &&
+		echo two >two &&
+		git add two &&
+		test_tick &&
+		git commit -m "initial submodule" &&
+		git rev-parse HEAD >../initial-submodule
+	) &&
+	git submodule add ./submodule &&
+	test_tick &&
+	git commit -m first &&
+
+	(
+		cd submodule &&
+		echo three >three &&
+		git add three &&
+		test_tick &&
+		git commit -m "first submodule" &&
+		git rev-parse HEAD >../first-submodule
+	) &&
+	git add submodule &&
+	test_tick &&
+	git commit -m second &&
+	SECOND=$(git rev-parse HEAD) &&
+
+	(
+		cd submodule &&
+		git mv two four &&
+		test_tick &&
+		git commit -m "second submodule" &&
+		git rev-parse HEAD >../second-submodule
+	) &&
+	git add submodule &&
+	echo four >four &&
+	git add four &&
+	test_tick &&
+	git commit -m third &&
+	THIRD=$(git rev-parse HEAD) &&
+	git submodule update --init
+'
+
+run_test() {
+	START_COMMIT=$1 &&
+	EXPECT=$2 &&
+	(git am --abort || true) &&
+	git reset --hard $START_COMMIT &&
+	rm -f *.patch &&
+	git format-patch -1 &&
+	git reset --hard $START_COMMIT^ &&
+	git submodule update &&
+	git am *.patch &&
+	git submodule update &&
+	(cd submodule && git rev-parse HEAD >../actual) &&
+	test_cmp $EXPECT actual
+}
+
+test_expect_success 'diff.submodule unset' '
+	(git config --unset diff.submodule || true) &&
+	run_test $SECOND first-submodule
+'
+
+test_expect_success 'diff.submodule unset with extra file' '
+	(git config --unset diff.submodule || true) &&
+	run_test $THIRD second-submodule
+'
+
+test_expect_failure 'diff.submodule=log' '
+	git config diff.submodule log &&
+	run_test $SECOND first-submodule
+'
+
+test_expect_failure 'diff.submodule=log with extra file' '
+	git config diff.submodule log &&
+	run_test $THIRD second-submodule
+'
+
 test_done
-- 
2.0.5
