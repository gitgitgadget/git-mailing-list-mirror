Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E8361FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 19:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753682AbcLNThm (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 14:37:42 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:15080 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751674AbcLNThl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 14:37:41 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tf6Kv0xHfz5tlc;
        Wed, 14 Dec 2016 20:37:39 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id AD5992216;
        Wed, 14 Dec 2016 20:37:38 +0100 (CET)
Subject: [PATCH v2] fix pushing to //server/share/dir on Windows
To:     Jeff King <peff@peff.net>
References: <2ff2613c-47da-a780-5d38-93e16cb16328@kdbg.org>
 <20161214173034.inbyakdykjv5j7ua@sigill.intra.peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <787a421b-8b7a-14c5-768f-06c3dc183cf4@kdbg.org>
Date:   Wed, 14 Dec 2016 20:37:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161214173034.inbyakdykjv5j7ua@sigill.intra.peff.net>
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

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 14.12.2016 um 18:30 schrieb Jeff King:
> Would it be reasonable to
> write:
> 
>   /* Copy initial part of absolute path, converting separators on Windows */
>   const char *end = src + offset_1st_component(src);
>   while (src < end) {
> 	  char c = *src++;
> 	  if (c == '\\')
> 		  c = '/';
> 	  *dst++ = c;
>   }

Makes a lot of sense! I haven't had an opportunity, though, to test
on Windows.

> ? I'm not sure if it's wrong to convert backslashes in that first
> component or not (but certainly we were before). I don't think we'd need
> is_dir_sep() in that "if()", because we can leave slashes as-is. But
> maybe it would make the code easier to read.

is_dir_sep() is preferable, IMO.

I also changed the commit message and subject line slightly.

 path.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/path.c b/path.c
index 52d889c88e..efcedafba6 100644
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
@@ -1014,17 +1014,22 @@ const char *remove_leading_path(const char *in, const char *prefix)
 int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
 {
 	char *dst0;
-	int i;
+	const char *end;
 
-	for (i = has_dos_drive_prefix(src); i > 0; i--)
-		*dst++ = *src++;
+	/*
+	 * Copy initial part of absolute path: "/", "C:/", "//server/share/".
+	 */
+	end = src + offset_1st_component(src);
+	while (src < end) {
+		char c = *src++;
+		if (is_dir_sep(c))
+			c = '/';
+		*dst++ = c;
+	}
 	dst0 = dst;
 
-	if (is_dir_sep(*src)) {
-		*dst++ = '/';
-		while (is_dir_sep(*src))
-			src++;
-	}
+	while (is_dir_sep(*src))
+		src++;
 
 	for (;;) {
 		char c = *src;
-- 
2.11.0.79.g263f27a

