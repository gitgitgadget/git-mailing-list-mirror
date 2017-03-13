Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A20320373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753464AbdCMULT (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:11:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:58817 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751874AbdCMULR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:11:17 -0400
Received: from virtualbox ([95.208.58.29]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MSZ6u-1cdVsP1Njg-00RbW3; Mon, 13
 Mar 2017 21:11:01 +0100
Date:   Mon, 13 Mar 2017 21:10:45 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v6 05/12] Introduce the discover_git_directory() function
In-Reply-To: <cover.1489435755.git.johannes.schindelin@gmx.de>
Message-ID: <0bfe47c18ef3c156dc7aa1b201a97b84070c515c.1489435755.git.johannes.schindelin@gmx.de>
References: <cover.1489098170.git.johannes.schindelin@gmx.de> <cover.1489435755.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dekL+6RFes+X2cnZ+63GvnPLM81AqK03FMH8PShL9W50gt8HVc0
 D+0uBMPGJkJngWZrEctPPgAtqGoedYLBxfi8DmmbjKAXG8iInxvl+PV/i9PjafmWlH6Ugy8
 ZfhOLWJAwBIG8ALHFpsCv3FEeh6pqYag7x8gP58ZGss+nx0k8Q5dSaO38GrwG89s/B9VmdQ
 DRlRo68kYDlaVdCrsXNuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XI3F/pBWAFA=:F8x+MtNOnK52UfIj/MLIxX
 RgVNHxMR1V+0WkDwJhyVmNDSPKdVvqZx5udSgPrF9l47o8z8/VjaeTlGq9KEvlHXMZmKg1gfn
 fkpihr9OSZNiAxXxj3EF/wqMJwMJQi11U/G22uLFZIARi7eWDjK8igIofWuPPPcYsU1NsFkR3
 8FwAWTfNd2FqPwV3DNgCj6UdryWJV49AGMHACk1XpV2nuX0VFKuHVTxZAfRMJP8V8Qx+INNeS
 eLiAbvCC5Pw/b929gkQaRG0lTphxOJC60zA0mXIVE5SNBM0W3tuB3qaHZ+QK0A4m1P+WnHGR/
 0vfqPsuNPIetYDRmmodXdsNFm14TFvjAqwDPVX1UsDzQ7kg5xGg3yWNqMvWVvvocDyglbN6CI
 coSx1AS0TIVzlFVr8pKFnunWsxWWw41JkKeGRl5U0R1qhw1fVPtyQSQfGFC+PQlGU5PP+T/Fw
 RASWPJDgFLEZ256y2QVfpphF22/UVx6TM8P1mS58QXkpeIoUZ6zvWAkTtx6pmHz+8FtPUBBx6
 qxFlra0bWgFJYCLMlRkdJlQFwHQq/FEHSvhwFrEJYDCwRaYLS2pVweCRuP18P7sZckXrqW5cz
 //9M6JvQDz060WBDQNHt1fM4wCv0b+Tk6r7cSZljEhwkvHLvn7NbYieeuuHYUAX7yGgOOdaIp
 JlJX12XaJRuMVHHMVYoW+LxK+u3VLPKVCaayiHKciSRpkmsiuTnKzryKf+mEg5eueiBpA2v1o
 KQ4vqlq4VFy9l41hFqjI72fcgNPM9pvGa+iGgJaKLiGLYXXiafnc/6kO0/h/59elFH3Rl/dir
 bwjvkQx
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
index 8c0e6442076..086bd9fa433 100644
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
index 99a722ed5f9..411e8342972 100644
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


