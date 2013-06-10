Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_MSGID,MSGID_NOFQDN1,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 14220 invoked by uid 102); 10 Jun 2013 15:17:05 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.84) with ESMTP; Mon, 10 Jun 2013 10:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507Ab3FJPQJ (ORCPT <rfc822;peff@peff.net>);
	Mon, 10 Jun 2013 11:16:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47835 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752247Ab3FJPQI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 11:16:08 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5AFD7eS025935
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 17:13:07 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5AFD9CH016064;
	Mon, 10 Jun 2013 17:13:09 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5AFD82F007153;
	Mon, 10 Jun 2013 17:13:08 +0200
Received: (from garciagj@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id r5AFD8cr007150;
	Mon, 10 Jun 2013 17:13:08 +0200
From:	y@ensimag.imag.fr
To:	git@vger.kernel.org
Cc:	gitster@pobox.com,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: v3 [PATCH 2/2] status:introduce status.branch to enable --branch by default
Date:	Mon, 10 Jun 2013 17:13:04 +0200
Message-Id: <1370877184-19409-2-git-send-email-y>
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1370877184-19409-1-git-send-email-y>
References: <y>
 <1370877184-19409-1-git-send-email-y>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 10 Jun 2013 17:13:07 +0200 (CEST)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>

Some people often run 'git status -b'.
The config variable status.branch allows to set it by default.

Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
--- 
Changes to be commented:
- Cleaning test

 Documentation/config.txt |    4 ++++
 builtin/commit.c         |    4 ++++
 t/t7508-status.sh        |   27 +++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1983bf7..ecdcd6d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2070,6 +2070,10 @@ status.short::
 	Set to true to enable --short by default in linkgit:git-status[1].
 	The option --no-short takes precedence over this variable.
 
+status.branch::
+	Set to true to enable --branch by default in linkgit:git-status[1].
+	The option --no-branch takes precedence over this variable.
+
 status.showUntrackedFiles::
 	By default, linkgit:git-status[1] and linkgit:git-commit[1] show
 	files which are not currently tracked by Git. Directories which
diff --git a/builtin/commit.c b/builtin/commit.c
index 287f1cb..f2b5d44 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1117,6 +1117,10 @@ static int git_status_config(const char *k, const char *v, void *cb)
 			status_format = STATUS_FORMAT_SHORT;
 		return 0;
 	}
+	if (!strcmp(k, "status.branch")) {
+		s->show_branch = git_config_bool(k, v);
+		return 0;
+	}
 	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
 		s->use_color = git_config_colorbool(k, v);
 		return 0;
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 9a07f15..958617a 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1366,6 +1366,33 @@ test_expect_success '"status.short=false" weaker than "-s"' '
 	test_cmp actual expected_short
 '
 
+test_expect_success '"status.branch=true" same as "-b"' '
+	git -c status.branch=true status -s >actual &&
+	git status -sb >expected_branch &&
+	test_cmp actual expected_branch
+'
+
+test_expect_success '"status.branch=true" different from "--no-branch"' '
+	git -c status.branch=true status -s >actual &&
+	git status -s --no-branch  >expected_nobranch &&
+	test_must_fail test_cmp actual expected_nobranch
+'
+
+test_expect_success '"status.branch=true" weaker than "--no-branch"' '
+	git -c status.branch=true status -s --no-branch >actual &&
+	test_cmp actual expected_nobranch
+'
+
+test_expect_success '"status.branch=false" same as "--no-branch"' '
+	git -c status.branch=false status -s >actual &&
+	test_cmp actual expected_nobranch
+'
+
+test_expect_success '"status.branch=false" weaker than "-b"' '
+	git -c status.branch=false status -sb >actual &&
+	test_cmp actual expected_branch
+'
+
 test_expect_success '"Back to environment of test by default"' '
 	git config status.showUntrackedFiles yes
 '
-- 
1.7.8

