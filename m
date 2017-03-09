Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3898C202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753917AbdCIWZD (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:25:03 -0500
Received: from mout.gmx.net ([212.227.17.21]:61965 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753033AbdCIWZD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:25:03 -0500
Received: from virtualbox ([37.201.193.18]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MH4Os-1czrr427LG-00Do6t; Thu, 09
 Mar 2017 23:24:52 +0100
Date:   Thu, 9 Mar 2017 23:24:45 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v5 05/11] Introduce the discover_git_directory() function
In-Reply-To: <cover.1489098170.git.johannes.schindelin@gmx.de>
Message-ID: <81afe73dd398d24127683a57953ea34c7d9b92c6.1489098170.git.johannes.schindelin@gmx.de>
References: <cover.1488897111.git.johannes.schindelin@gmx.de> <cover.1489098170.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qlZm+6D1NGU/7+0eoTkYXVEhk4SnSj16liXfVVe5sRzxMKT8QyI
 5SmE2yo6zaNGcoTZ4+86jpLO2VPXPKxzWdGRu5JTy/FgSoeGW4aufnzAuDw38CHrsmDAP15
 cQjrQBSBK8D1BUDRfu3Es3Lk7vrIamayINm9Z6pGvMcs9R9Hi3H4PtuZcVsx3aua6SHg51U
 uKyPLFtvxkhRr45t2G2aw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/tgm0973zuI=:rHqiCItTIJsTwXv8PGHqcy
 iDNWqlpqJT7QPGEUHDbKmn2A4r01KuxSZY5axQAl+RNLNFve9hlMaYws/ab2wlly1A11qgws0
 YQuheF2ELc5wD1R9+azwwu4ubouftScYIHQy5J3NeG2vAUL3MEncEd6D4h1YMI1hoUhj6Gk8l
 6UtvpH7/nDvwIyg2BK1NgCAZHqKVsxmGoHNqZfktch+2D93B/fx3xLAexi/UZ8N52xy0UH54w
 VzveuyozLtptTCdT69lzaxF8NmFCpSIE3o/CRbrAV0mB6Rm6R9gSU1S1pgtyPz644ASMoCAWc
 WHKDQ52/g4ivOG16LP99GizSCKfeQyfl+ayvIQhIefVVbyFrsyI1AjlxwxvH8QIEI4bV6FHD9
 TLKzyeZxDO24h9Crd3HM4IjNyiOwUHzpzmJHx4c3pJP9aO068RDaVGEzCYKk9WkaSG1Pt9ZbI
 PtCUv49Gqi6+7Kxjn8FvEFVAxL9YUo15hUFEKwLcJqSKPxkMfdbU8NjpvXQ5sqQcVlnJn8bEr
 CKpkQ3LJAVWnwkg8s+2jY+0LlfjljWC4BztzxaqqrMac8+fj6oVq9J45EAzZlOGc7OwWsHZue
 PnYUVWP9KFo8nIBtNwqrz9nY5+AnuV4tNZD+hNtF+21bEIXhkGZ2hyspWgfN1asAAzp2L6bTT
 FDblkJ5yT9jvdNz9hsGPi6gwEcgG7IVXvBCkVXoCrg6ulf+2AccS3ehvp55T+cOIh/oGjyrhX
 Ev2x/PtCqoP+DvA5U+N+rFKG4G6W1u0eME5ZlTr5aLrmZ9LOzblFaViymZBzZIivcS9LtyiIm
 UXQ3W+K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We modified the setup_git_directory_gently_1() function earlier to make
it possible to discover the GIT_DIR without changing global state.

However, it is still a bit cumbersome to use if you only need to figure
out the (possibly absolute) path of the .git/ directory. Let's just
provide a convenient wrapper function with an easier signature that
*just* discovers the .git/ directory.

We will use it in a subsequent patch to fix the early config.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h |  7 +++++++
 setup.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/cache.h b/cache.h
index 80b6372cf76..5218726cf88 100644
--- a/cache.h
+++ b/cache.h
@@ -518,6 +518,13 @@ extern void set_git_work_tree(const char *tree);
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
 extern void setup_work_tree(void);
+/*
+ * Find GIT_DIR of the repository that contains the current working directory,
+ * without changing the working directory or other global state. The result is
+ * appended to gitdir. The return value is either NULL if no repository was
+ * found, or pointing to the path inside gitdir's buffer.
+ */
+extern const char *discover_git_directory(struct strbuf *gitdir);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
 extern char *prefix_path(const char *prefix, int len, const char *path);
diff --git a/setup.c b/setup.c
index a7bb09608c0..43f522fa996 100644
--- a/setup.c
+++ b/setup.c
@@ -924,6 +924,49 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 	}
 }
 
+const char *discover_git_directory(struct strbuf *gitdir)
+{
+	struct strbuf dir = STRBUF_INIT, err = STRBUF_INIT;
+	size_t gitdir_offset = gitdir->len, cwd_len;
+	struct repository_format candidate;
+
+	if (strbuf_getcwd(&dir))
+		return NULL;
+
+	cwd_len = dir.len;
+	if (setup_git_directory_gently_1(&dir, gitdir) <= 0) {
+		strbuf_release(&dir);
+		return NULL;
+	}
+
+	/*
+	 * The returned gitdir is relative to dir, and if dir does not reflect
+	 * the current working directory, we simply make the gitdir absolute.
+	 */
+	if (dir.len < cwd_len && !is_absolute_path(gitdir->buf + gitdir_offset)) {
+		/* Avoid a trailing "/." */
+		if (!strcmp(".", gitdir->buf + gitdir_offset))
+			strbuf_setlen(gitdir, gitdir_offset);
+		else
+			strbuf_addch(&dir, '/');
+		strbuf_insert(gitdir, gitdir_offset, dir.buf, dir.len);
+	}
+
+	strbuf_reset(&dir);
+	strbuf_addf(&dir, "%s/config", gitdir->buf + gitdir_offset);
+	read_repository_format(&candidate, dir.buf);
+	strbuf_release(&dir);
+
+	if (verify_repository_format(&candidate, &err) < 0) {
+		warning("ignoring git dir '%s': %s",
+			gitdir->buf + gitdir_offset, err.buf);
+		strbuf_release(&err);
+		return NULL;
+	}
+
+	return gitdir->buf + gitdir_offset;
+}
+
 const char *setup_git_directory_gently(int *nongit_ok)
 {
 	static struct strbuf cwd = STRBUF_INIT;
-- 
2.12.0.windows.1.7.g94dafc3b124


