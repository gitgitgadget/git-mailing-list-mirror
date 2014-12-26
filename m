From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH 1/2] t4255: test am submodule with diff.submodule
Date: Fri, 26 Dec 2014 17:11:45 -0600
Message-ID: <1419635506-5045-2-git-send-email-dougk.ff7@gmail.com>
References: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
Cc: Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 27 00:12:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y4e3B-0004Hq-OI
	for gcvg-git-2@plane.gmane.org; Sat, 27 Dec 2014 00:12:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbaLZXL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2014 18:11:56 -0500
Received: from mail-oi0-f54.google.com ([209.85.218.54]:51430 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbaLZXLx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2014 18:11:53 -0500
Received: by mail-oi0-f54.google.com with SMTP id u20so23508055oif.13
        for <git@vger.kernel.org>; Fri, 26 Dec 2014 15:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NSAunH6+2cc8gc36ldGRhZGMUlSpUYsf6Maavez3+qM=;
        b=YsQsG6WDESpUtxRYIqCLbwrZiXJlbvah+WotaRelBMr71OCulm2x5LYtSRgRCUZaLK
         HuaNzvex90MbM2xWvYIJ21A0ceG+kurDBNakJljrfBnwIDLeiHi1WbLbbhfpDwvsgA9R
         R3IpR+C6Rk74m9PjXrpyTn5lCxNsvxOJczivpSIogIh9gguul8QKW2FM/swty3pYvXDA
         JRSgXyVyv9X+cRN5z/XSHKKmzhjbF8lMuRsu+/4oUseO5B0EIUyqSCUlPar4wZ5eSnkc
         4gYOFSumKme6/qSp77uNEgAz9xERiNguNvFYJzWOGn6wbm5ofrh2Dj50zCfzoYJwIGJT
         kS1A==
X-Received: by 10.182.241.133 with SMTP id wi5mr26131653obc.10.1419635513338;
        Fri, 26 Dec 2014 15:11:53 -0800 (PST)
Received: from kenshin.dougk-ff7.net (64-151-63-23.static.everestkc.net. [64.151.63.23])
        by mx.google.com with ESMTPSA id w81sm15074486oiw.10.2014.12.26.15.11.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Dec 2014 15:11:52 -0800 (PST)
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261831>

git am will break when using diff.submodule=log; add some test cases
to illustrate this breakage as simply as possible.  There are
currently two ways this can fail:

* With errors ("unrecognized input"), if only change
* Silently (no submodule change), if other files change

Test for both conditions and ensure without diff.submodule this works.

Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
---
 t/t4255-am-submodule.sh | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
index 8bde7db..d9a1d79 100755
--- a/t/t4255-am-submodule.sh
+++ b/t/t4255-am-submodule.sh
@@ -18,4 +18,87 @@ am_3way () {
 KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
 test_submodule_switch "am_3way"
 
+test_expect_success 'setup diff.submodule' '
+	echo one >one &&
+	git add one &&
+	test_tick &&
+	git commit -m initial &&
+	git rev-parse HEAD >initial &&
+
+	git init submodule &&
+	(cd submodule &&
+		echo two >two &&
+		git add two &&
+		test_tick &&
+		git commit -m "initial submodule" &&
+		git rev-parse HEAD >../initial-submodule) &&
+	git submodule add ./submodule &&
+	test_tick &&
+	git commit -m first &&
+	git rev-parse HEAD >first &&
+
+	(cd submodule &&
+		echo three >three &&
+		git add three &&
+		test_tick &&
+		git commit -m "first submodule" &&
+		git rev-parse HEAD >../first-submodule) &&
+	git add submodule &&
+	test_tick &&
+	git commit -m second &&
+	git rev-parse HEAD >second &&
+
+	(cd submodule &&
+		git mv two four &&
+		test_tick &&
+		git commit -m "second submodule" &&
+		git rev-parse HEAD >../second-submodule) &&
+	git add submodule &&
+	echo four >four &&
+	git add four &&
+	test_tick &&
+	git commit -m third &&
+	git rev-parse HEAD >third &&
+	git submodule update --init
+'
+
+INITIAL=$(cat initial)
+SECOND=$(cat second)
+THIRD=$(cat third)
+
+run_test() {
+	START_COMMIT=$1
+	EXPECT=$2
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
+	run_test $SECOND 'first-submodule'
+'
+
+test_expect_success 'diff.submodule unset with extra file' '
+	(git config --unset diff.submodule || true) &&
+	run_test $THIRD 'second-submodule'
+'
+
+test_expect_success 'diff.submodule=log' '
+	git config diff.submodule log &&
+	run_test $SECOND 'first-submodule'
+'
+
+test_expect_success 'diff.submodule=log with extra file' '
+	git config diff.submodule log &&
+	run_test $THIRD 'second-submodule'
+'
+
 test_done
-- 
2.0.5
