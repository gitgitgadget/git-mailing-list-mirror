Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2413202F8
	for <e@80x24.org>; Tue,  7 Mar 2017 14:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932551AbdCGOdc (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 09:33:32 -0500
Received: from mout.gmx.net ([212.227.15.19]:57865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755648AbdCGOdY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 09:33:24 -0500
Received: from virtualbox ([37.201.194.72]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LwJRe-1cCSnm3ugA-0183JH; Tue, 07
 Mar 2017 15:33:05 +0100
Date:   Tue, 7 Mar 2017 15:33:02 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v4 05/10] Introduce the discover_git_directory() function
In-Reply-To: <cover.1488897111.git.johannes.schindelin@gmx.de>
Message-ID: <b73714db4555626e6c4ca3f2771683f1fa9d7312.1488897111.git.johannes.schindelin@gmx.de>
References: <cover.1488562287.git.johannes.schindelin@gmx.de> <cover.1488897111.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iV98drlQkYC+R1yi4mkd21C0ImX5t17UV6ioahD1xoWBiB+nGXi
 o/xCd27LGVADek10rRxLhBnI+V7epHnqnAXJEXTuAYoXRoXjniids69hm7N4Hp4VDFn73ZM
 GSuzV3QJeZ2+K9p5jyOTYVvtd7Iz1m/JfZ8+SLAUy+pq+lD7Ni4O4OXSKlEuQB8V1Gi/cT6
 5UDHB6a6t+bRdjPlUDgsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aP/7XyWDHH8=:3O1yPF22+Y6+XnTySktyk2
 /1KJ5uHyd5JTno6yuDOauNBHtwDfNH7OIriKuSRMbB2T+owDPV4qqy+CVgwuWGJDUj50bLb21
 Gp3rHfSY5O64/o0MKXb6xtfm+g6iLkXlGu5q/SOufMAwQYkqBJYF0rnIQTtnKnymvq6grJnG1
 agX09X8QEnK/1op+a145MvRcYacWVjZoxsCv1iozohWFoClOBht0nVQ9sXj4f7dlizTlpwvPX
 p6TIbfKmLhoOBKOw2jHK5/9usvO7wgiHvG588jatK1piC6sh7zh3SryKx4o8rklkj3W7E3WMH
 cg844sFbBfPauLcTGckh9aK+hsU0i0v7wnF0g/QalvO0BoSVMIxgN5+WfvfUWslpVPwdxln4U
 P/+BJ0iEIReebMvi25yddypD8FTsaXSEy6Nh4QreFpnVokeQlxJI1nAShgE+D9quZ7gZAH/ei
 LTiquEhAP/2tZpeyfjarGga0DAZW7axmSZrFcpA5IlaqMG2krIpMScPLga2pzWQ+ilfKw5vut
 ht4/e96CYTSnL9+lVgpXdNmVibkmnNte+Oe7Epafr4wq1eBdHqTJrz4CHrdc4KK5KD1rto/z2
 mZcwh9VSW8/ubChZgaHlvSh2nOJA1slEHtYF12ID8Xvp81KqcteUxqIRNQbkaeqf3cN3gukAn
 NXNC4kEp7koGzymBkBguO/LZmkz0hkqtlGquO7rLE3nb3GR0HQ3U9/HZwFDLWeeuXIi8848Et
 /NVJK0mnVHJG57M0eEj8b4j/OoT2qh7W/ubsYCcVCVqkbSdk4FY7nJioA5vC+ysZXkbbrlqZh
 PeiQRBt
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
index d7af343d14e..486acda2054 100644
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
 	struct strbuf cwd = STRBUF_INIT, dir = STRBUF_INIT, gitdir = STRBUF_INIT;
-- 
2.12.0.windows.1.7.g94dafc3b124


