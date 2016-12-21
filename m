Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD7DB1FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 21:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758770AbcLUVvj (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 16:51:39 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:3989 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750818AbcLUVvi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 16:51:38 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tkSzD15stz5tlC;
        Wed, 21 Dec 2016 22:51:36 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id CA7D72222;
        Wed, 21 Dec 2016 22:51:35 +0100 (CET)
Subject: [PATCH bw/realpath-wo-chdir] real_path: canonicalize directory
 separators in root parts
To:     Brandon Williams <bmwill@google.com>
References: <1481241494-6861-1-git-send-email-bmwill@google.com>
 <1481566615-75299-1-git-send-email-bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, pclouds@gmail.com
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <097e3e2e-f46d-b0aa-be9c-68c274c5e3dc@kdbg.org>
Date:   Wed, 21 Dec 2016 22:51:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1481566615-75299-1-git-send-email-bmwill@google.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When an absolute path is resolved, resolution begins at the first path
component after the root part. The root part is just copied verbatim,
because it must not be inspected for symbolic links. For POSIX paths,
this is just the initial slash, but on Windows, the root part has the
forms c:\ or \\server\share. We do want to canonicalize the back-slashes
in the root part because these parts are compared to the result of
getcwd(), which does return a fully canonicalized path.

Factor out a helper that splits off the root part, and have it
canonicalize the copied part.

This change was prompted because t1504-ceiling-dirs.sh caught a breakage
in GIT_CEILING_DIRECTORIES handling on Windows.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This introduces the second #ifdef GIT_WINDOWS_NATIVE in this file.
 It could be avoided if convert_slashes were defined as a do-nothing
 on POSIX, but that would not help the other occurrence. Therefore,
 I suggest to leave it at this.

 abspath.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/abspath.c b/abspath.c
index 79ee310867..1d56f5ed9f 100644
--- a/abspath.c
+++ b/abspath.c
@@ -48,6 +48,19 @@ static void get_next_component(struct strbuf *next, struct strbuf *remaining)
 	strbuf_remove(remaining, 0, end - remaining->buf);
 }
 
+/* copies root part from remaining to resolved, canonicalizing it on the way */
+static void get_root_part(struct strbuf *resolved, struct strbuf *remaining)
+{
+	int offset = offset_1st_component(remaining->buf);
+
+	strbuf_reset(resolved);
+	strbuf_add(resolved, remaining->buf, offset);
+#ifdef GIT_WINDOWS_NATIVE
+	convert_slashes(resolved->buf);
+#endif
+	strbuf_remove(remaining, 0, offset);
+}
+
 /* We allow "recursive" symbolic links. Only within reason, though. */
 #define MAXSYMLINKS 5
 
@@ -80,14 +93,10 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 			goto error_out;
 	}
 
-	strbuf_reset(resolved);
+	strbuf_addstr(&remaining, path);
+	get_root_part(resolved, &remaining);
 
-	if (is_absolute_path(path)) {
-		/* absolute path; start with only root as being resolved */
-		int offset = offset_1st_component(path);
-		strbuf_add(resolved, path, offset);
-		strbuf_addstr(&remaining, path + offset);
-	} else {
+	if (!resolved->len) {
 		/* relative path; can use CWD as the initial resolved path */
 		if (strbuf_getcwd(resolved)) {
 			if (die_on_error)
@@ -95,7 +104,6 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 			else
 				goto error_out;
 		}
-		strbuf_addstr(&remaining, path);
 	}
 
 	/* Iterate over the remaining path components */
@@ -150,10 +158,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 
 			if (is_absolute_path(symlink.buf)) {
 				/* absolute symlink; set resolved to root */
-				int offset = offset_1st_component(symlink.buf);
-				strbuf_reset(resolved);
-				strbuf_add(resolved, symlink.buf, offset);
-				strbuf_remove(&symlink, 0, offset);
+				get_root_part(resolved, &symlink);
 			} else {
 				/*
 				 * relative symlink
-- 
2.11.0.79.gf6b77ca

