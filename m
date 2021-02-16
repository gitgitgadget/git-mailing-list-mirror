Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E52C4332B
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5540064E07
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhBPOpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 09:45:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:34212 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhBPOpS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 09:45:18 -0500
Received: (qmail 13435 invoked by uid 109); 16 Feb 2021 14:44:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 14:44:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24759 invoked by uid 111); 16 Feb 2021 14:44:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 09:44:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 09:44:37 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Blake Burkhart <bburky@bburky.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: [PATCH 6/6] mailmap: do not respect symlinks for in-tree .mailmap
Message-ID: <YCvaVZEUuIwAFWxe@coredump.intra.peff.net>
References: <YCvaJg8o882IqNnx@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCvaJg8o882IqNnx@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with .gitattributes and .gitignore, we would like to make sure that
.mailmap files are handled consistently whether read from the a blob (as
is the default behavior in a bare repo) or from the filesystem.
Likewise, we would like to avoid reading out-of-tree files pointed to by
a symlink, which could have security implications in certain setups.

We can cover both by using open_nofollow() when opening the in-tree
files. We'll continue to follow links for mailmap.file, as well as when
reading .mailmap from the current directory when outside of a repository
entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
 mailmap.c          | 22 +++++++++++++++++-----
 t/t4203-mailmap.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index eb77c6e77c..7ac966107e 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -157,20 +157,30 @@ static void read_mailmap_line(struct string_list *map, char *buffer)
 		add_mapping(map, name1, email1, name2, email2);
 }
 
-static int read_mailmap_file(struct string_list *map, const char *filename)
+/* Flags for read_mailmap_file() */
+#define MAILMAP_NOFOLLOW (1<<0)
+
+static int read_mailmap_file(struct string_list *map, const char *filename,
+			     unsigned flags)
 {
 	char buffer[1024];
 	FILE *f;
+	int fd;
 
 	if (!filename)
 		return 0;
 
-	f = fopen(filename, "r");
-	if (!f) {
+	if (flags & MAILMAP_NOFOLLOW)
+		fd = open_nofollow(filename, O_RDONLY);
+	else
+		fd = open(filename, O_RDONLY);
+
+	if (fd < 0) {
 		if (errno == ENOENT)
 			return 0;
 		return error_errno("unable to open mailmap at %s", filename);
 	}
+	f = xfdopen(fd, "r");
 
 	while (fgets(buffer, sizeof(buffer), f) != NULL)
 		read_mailmap_line(map, buffer);
@@ -225,10 +235,12 @@ int read_mailmap(struct string_list *map)
 	if (!git_mailmap_blob && is_bare_repository())
 		git_mailmap_blob = "HEAD:.mailmap";
 
-	err |= read_mailmap_file(map, ".mailmap");
+	err |= read_mailmap_file(map, ".mailmap",
+				 startup_info->have_repository ?
+				 MAILMAP_NOFOLLOW : 0);
 	if (startup_info->have_repository)
 		err |= read_mailmap_blob(map, git_mailmap_blob);
-	err |= read_mailmap_file(map, git_mailmap_file);
+	err |= read_mailmap_file(map, git_mailmap_file, 0);
 	return err;
 }
 
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 621f9962d5..96a4e6132f 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -889,4 +889,35 @@ test_expect_success 'empty syntax: setup' '
 	test_cmp expect actual
 '
 
+test_expect_success SYMLINKS 'set up symlink tests' '
+	git commit --allow-empty -m foo --author="Orig <orig@example.com>" &&
+	echo "New <new@example.com> <orig@example.com>" >map &&
+	rm -f .mailmap
+'
+
+test_expect_success SYMLINKS 'symlinks respected in mailmap.file' '
+	test_when_finished "rm symlink" &&
+	ln -s map symlink &&
+	git -c mailmap.file="$(pwd)/symlink" log -1 --format=%aE >actual &&
+	echo "new@example.com" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success SYMLINKS 'symlinks respected in non-repo shortlog' '
+	git log -1 >input &&
+	test_when_finished "nongit rm .mailmap" &&
+	nongit ln -sf "$TRASH_DIRECTORY/map" .mailmap &&
+	nongit git shortlog -s <input >actual &&
+	echo "     1	New" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success SYMLINKS 'symlinks not respected in-tree' '
+	test_when_finished "rm .mailmap" &&
+	ln -s map .mailmap &&
+	git log -1 --format=%aE >actual &&
+	echo "orig@example.com" >expect&&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.30.1.986.gd86016a168
