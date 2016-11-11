Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9B48203E2
	for <e@80x24.org>; Fri, 11 Nov 2016 20:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935120AbcKKU1J (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 15:27:09 -0500
Received: from koekblik.kaarsemaker.net ([141.138.139.206]:38876 "EHLO
        koekblik.kaarsemaker.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756146AbcKKU1G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 15:27:06 -0500
Received: from hurricane.home.kaarsemaker.net (unknown [145.132.209.114])
        by koekblik.kaarsemaker.net (Postfix) with ESMTP id 433918097E;
        Fri, 11 Nov 2016 21:19:59 +0100 (CET)
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH 2/2] diff --no-index: support reading from pipes
Date:   Fri, 11 Nov 2016 21:19:58 +0100
Message-Id: <20161111201958.2175-3-dennis@kaarsemaker.net>
X-Mailer: git-send-email 2.11.0-rc0-22-gcc0501c
In-Reply-To: <20161111201958.2175-1-dennis@kaarsemaker.net>
References: <20161111201958.2175-1-dennis@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

diff <(command1) <(command2) provides useful output, let's make it
possible for git to do the same.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 diff-no-index.c |  8 ++++++++
 diff.c          | 13 +++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 15811c2..487dbf5 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -83,6 +83,14 @@ static struct diff_filespec *noindex_filespec(const char *name, int mode)
 		name = "/dev/null";
 	s = alloc_filespec(name);
 	fill_filespec(s, null_sha1, 0, mode);
+	/*
+	 * In --no-index mode, we support reading from pipes. canon_mode, called by
+	 * fill_filespec, gets confused by this and thinks we now have subprojects.
+	 * Detect this and tell the rest of the diff machinery to treat pipes as
+	 * normal files.
+	 */
+	if (S_ISGITLINK(s->mode))
+		s->mode = S_IFREG | ce_permissions(mode);
 	if (name == file_from_standard_input)
 		populate_from_stdin(s);
 	return s;
diff --git a/diff.c b/diff.c
index 1eaf604..c599efb 100644
--- a/diff.c
+++ b/diff.c
@@ -2839,9 +2839,18 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		fd = open(s->path, O_RDONLY);
 		if (fd < 0)
 			goto err_empty;
-		s->data = xmmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
+		if (!S_ISREG(st.st_mode)) {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_read(&sb, fd, 0);
+			s->size = sb.len;
+			s->data = strbuf_detach(&sb, NULL);
+			s->should_free = 1;
+		}
+		else {
+			s->data = xmmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
+			s->should_munmap = 1;
+		}
 		close(fd);
-		s->should_munmap = 1;
 
 		/*
 		 * Convert from working tree format to canonical git format
-- 
2.10.1-449-gab0f84c

