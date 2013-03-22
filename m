From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH] t7600: test merge configuration override
Date: Fri, 22 Mar 2013 11:09:03 +0100
Message-ID: <1363946943-30269-1-git-send-email-ydroneaud@opteya.com>
References: <1363704914.6289.39.camel@test.quest-ce.net> <loom.20130321T212911-611@post.gmane.org> <cdc4f45e7520ce1fc48588c260214717@meuh.org>
Cc: Yann Droneaud <ydroneaud@opteya.com>, Git <git@vger.kernel.org>
To: Max Nanasy <max.nanasy@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 11:11:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIywN-0006yx-JH
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 11:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932867Ab3CVKKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 06:10:46 -0400
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:60485 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932633Ab3CVKKo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 06:10:44 -0400
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id D7B7BD1AD96
	for <git@vger.kernel.org>; Fri, 22 Mar 2013 11:10:36 +0100 (CET)
Received: from test.quest-ce.net (unknown [37.161.251.30])
	by smtp6-g21.free.fr (Postfix) with ESMTP id AACEF82256;
	Fri, 22 Mar 2013 11:09:57 +0100 (CET)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id r2MA9Zf9030307;
	Fri, 22 Mar 2013 11:09:47 +0100
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id r2MA9SSe030306;
	Fri, 22 Mar 2013 11:09:28 +0100
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <cdc4f45e7520ce1fc48588c260214717@meuh.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218788>

Set the configuration variable 'merge.ff' to either 'only' or 'no'
and check that this configuration can be overridden on command line.

Additionally, test for currently not tested option '--no-ff-only'

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 t/t7600-merge.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 5e19598..b524bdb 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -254,6 +254,32 @@ test_expect_success 'merges with merge.ff=only' '
 	verify_head $c3
 '
 
+test_expect_success 'merges with merge.ff=only and --no-ff-only' '
+	git reset --hard c1 &&
+	test_tick &&
+	test_when_finished "git config --unset merge.ff" &&
+	git config merge.ff only &&
+	test_must_fail git merge --no-ff c2 &&
+	git merge --no-ff-only c2 &&
+
+	git reset --hard c1 &&
+	git merge --no-ff-only --no-ff c2
+'
+
+test_expect_success 'merges with merge.ff=no and --ff' '
+	git reset --hard c0 &&
+	test_tick &&
+	test_when_finished "git config --unset merge.ff" &&
+	git config merge.ff no &&
+	test_must_fail git merge --ff-only c1 &&
+	git merge --ff c1 &&
+	verify_head $c1 &&
+
+	git reset --hard c0 &&
+	git merge --ff --ff-only c1 &&
+	verify_head $c1
+'
+
 test_expect_success 'merge c0 with c1 (no-commit)' '
 	git reset --hard c0 &&
 	git merge --no-commit c1 &&
-- 
1.7.11.7
