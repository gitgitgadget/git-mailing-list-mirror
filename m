Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF70C209B5
	for <e@80x24.org>; Tue, 13 Dec 2016 21:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754075AbcLMVc4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 16:32:56 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:13793 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752941AbcLMVcy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 16:32:54 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tdXwL1cHqz5tlJ;
        Tue, 13 Dec 2016 22:32:02 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C61A5221F;
        Tue, 13 Dec 2016 22:32:01 +0100 (CET)
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] fix pushing to //server/share/dir paths on Windows
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Message-ID: <2ff2613c-47da-a780-5d38-93e16cb16328@kdbg.org>
Date:   Tue, 13 Dec 2016 22:32:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

normalize_path_copy() is not prepared to keep the double-slash of a
//server/share/dir kind of path, but treats it like a regular POSIX
style path and transforms it to /server/share/dir.

The bug manifests when 'git push //server/share/dir master' is run,
because tmp_objdir_add_as_alternate() uses the path in normalized
form when it registers the quarantine object database via
link_alt_odb_entries(). Needless to say that the directory cannot be
accessed using the wrongly normalized path.

Fix it by skipping all of the root part, not just a potential drive
prefix. offset_1st_component takes care of this, see the
implementation in compat/mingw.c::mingw_offset_1st_component().

There is a change in behavior: \\server\share is not transformed
into //server/share anymore, but all subsequent directory separators
are rewritten to '/'. This should not make a difference; Windows can
handle the mix. In the context of 'git push' this cannot be verified,
though, as there seems to be an independent bug that transforms the
double '\\' to a single '\' on the way.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Another long-standing bug uncovered by the quarantine series.

 Dscho, it looks like this could fix the original report at
 https://github.com/git-for-windows/git/issues/979

 This patch should cook well because of the change in behavior.
 I would not be surprised if there is some fall-out.

 The other bug I'm alluding to, I still have to investigate. I do
 not think that it can be counted as fall-out.

 path.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/path.c b/path.c
index 52d889c88e..02dc70fb92 100644
--- a/path.c
+++ b/path.c
@@ -991,7 +991,7 @@ const char *remove_leading_path(const char *in, const char *prefix)
  *
  * Performs the following normalizations on src, storing the result in dst:
  * - Ensures that components are separated by '/' (Windows only)
- * - Squashes sequences of '/'.
+ * - Squashes sequences of '/' except "//server/share" on Windows
  * - Removes "." components.
  * - Removes ".." components, and the components the precede them.
  * Returns failure (non-zero) if a ".." component appears as first path
@@ -1014,17 +1014,23 @@ const char *remove_leading_path(const char *in, const char *prefix)
 int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
 {
 	char *dst0;
-	int i;
-
-	for (i = has_dos_drive_prefix(src); i > 0; i--)
-		*dst++ = *src++;
-	dst0 = dst;
+	int offset;
 
-	if (is_dir_sep(*src)) {
+	/*
+	 * Handle initial part of absolute path: "/", "C:/", "\\server\share/".
+	 */
+	offset = offset_1st_component(src);
+	if (offset) {
+		/* Convert the trailing separator to '/' on Windows. */
+		memcpy(dst, src, offset - 1);
+		dst += offset - 1;
 		*dst++ = '/';
-		while (is_dir_sep(*src))
-			src++;
+		src += offset;
 	}
+	dst0 = dst;
+
+	while (is_dir_sep(*src))
+		src++;
 
 	for (;;) {
 		char c = *src;
-- 
2.11.0.79.g263f27a

