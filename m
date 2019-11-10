Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B5061F454
	for <e@80x24.org>; Sun, 10 Nov 2019 20:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKJUlu (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 15:41:50 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:55990 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbfKJUlu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 15:41:50 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 89DDF34CB22
        for <git@vger.kernel.org>; Sun, 10 Nov 2019 20:41:49 +0000 (UTC)
Received: (qmail 13440 invoked by uid 129); 10 Nov 2019 20:41:41 -0000
X-HELO: thorne.orbis-terrarum.net
Authentication-Results: orbis-terrarum.net; auth=pass (cram-md5) smtp.auth=robbat2-thorne@orbis-terrarum.net; iprev=pass
Received: from d173-181-74-218.bchsia.telus.net (HELO thorne.orbis-terrarum.net) (173.181.74.218)
 by orbis-terrarum.net (qpsmtpd/0.95) with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted); Sun, 10 Nov 2019 20:41:41 +0000
Received: by thorne.orbis-terrarum.net (Postfix, from userid 10000)
        id 56A21198B0F; Sun, 10 Nov 2019 20:41:26 +0000 (UTC)
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     git@vger.kernel.org
Subject: [PATCH v3 3/3] bundle-verify: add --quiet
Date:   Sun, 10 Nov 2019 12:41:26 -0800
Message-Id: <20191110204126.30553-3-robbat2@gentoo.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191110204126.30553-1-robbat2@gentoo.org>
References: <1f7f0aa1e8fae54bf967ae83a160be2b30db634f.1573248640.git.gitgitgadget@gmail.com>
 <20191110204126.30553-1-robbat2@gentoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Checked: Checked by ClamAV on orbis-terrarum.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add --quiet to git-bundle verify as proposed on the mailing list [1].

Reference: https://www.mail-archive.com/git@vger.kernel.org/msg182844.html <robbat2-20190806T191156-796782357Z@orbis-terrarum.net>
Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 Documentation/git-bundle.txt | 2 +-
 builtin/bundle.c             | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 96bb94df7b..ccada80a4a 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git bundle' create [-q | --quiet | --progress | --all-progress] [--all-progress-implied] <file> <git-rev-list-args>
-'git bundle' verify <file>
+'git bundle' verify [-q | --quiet] <file>
 'git bundle' list-heads <file> [<refname>...]
 'git bundle' unbundle <file> [<refname>...]
 
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 39b3e88d40..f049d27a14 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -13,7 +13,7 @@
 
 static const char * const builtin_bundle_usage[] = {
   N_("git bundle create [<options>] <file> <git-rev-list args>"),
-  N_("git bundle verify <file>"),
+  N_("git bundle verify [<options>] <file>"),
   N_("git bundle list-heads <file> [<refname>...]"),
   N_("git bundle unbundle <file> [<refname>...]"),
   NULL
@@ -25,7 +25,7 @@ static const char * const builtin_bundle_create_usage[] = {
 };
 
 static const char * const builtin_bundle_verify_usage[] = {
-  N_("git bundle verify <file>"),
+  N_("git bundle verify [<options>] <file>"),
   NULL
 };
 
@@ -97,8 +97,11 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
 static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
 	struct bundle_header header;
 	int bundle_fd = -1;
+	int quiet = 0;
 
 	struct option options[] = {
+		OPT_BOOL('q', "quiet", &quiet,
+			    N_("do not show bundle details")),
 		OPT_END()
 	};
 	const char* bundle_file;
@@ -111,7 +114,7 @@ static int cmd_bundle_verify(int argc, const char **argv, const char *prefix) {
 	if ((bundle_fd = read_bundle_header(bundle_file, &header)) < 0)
 		return 1;
 	close(bundle_fd);
-	if (verify_bundle(the_repository, &header, 1))
+	if (verify_bundle(the_repository, &header, !quiet))
 		return 1;
 	fprintf(stderr, _("%s is okay\n"), bundle_file);
 	return 0;
-- 
2.23.0

