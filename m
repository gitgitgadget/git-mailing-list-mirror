Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16106209F1
	for <e@80x24.org>; Thu,  6 Apr 2017 09:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754313AbdDFJwW (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 05:52:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:38482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752825AbdDFJwT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 05:52:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9A934AAB2;
        Thu,  6 Apr 2017 09:52:17 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] Fix nonnull errors reported by UBSAN with GCC 7.
To:     Jeff King <peff@peff.net>
References: <295981e7-d2e9-d3db-e32d-8dd80ca47136@suse.cz>
 <20170406083425.7psdmrploxar3h6v@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Message-ID: <998bf391-7fc5-8329-db58-ef0f24517707@suse.cz>
Date:   Thu, 6 Apr 2017 11:52:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170406083425.7psdmrploxar3h6v@sigill.intra.peff.net>
Content-Type: multipart/mixed;
 boundary="------------068A9022C043A51D247AA346"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------068A9022C043A51D247AA346
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 04/06/2017 10:34 AM, Jeff King wrote:
> On Thu, Apr 06, 2017 at 10:02:22AM +0200, Martin Liška wrote:
> 
>> Subject: [PATCH 1/2] Fix nonnull errors reported by UBSAN with GCC 7.
>>
>> Memory functions like memmove and memcpy should not be called
>> with an argument equal to NULL.
> 
> Yeah, makes sense. Your fixes are obviously correct. In other cases
> we've added wrappers like sane_qsort() that do the size check
> automatically. I'm not sure if we'd want to do the same here.
> 
> Either way, it probably makes sense to take this as a quick fix and
> worry about refactoring as a possible patch on top.
> 
> Thanks.
> 
> -Peff
> 

Hello.

I'm sending (v2), where I updated commit message and wrapped 2 problematic
places to newly introduced macros that do the check. Follow-up patch can
change usages of memcpy and memove.

Martin

--------------068A9022C043A51D247AA346
Content-Type: text/x-patch;
 name="0001-Fix-nonnull-errors-reported-by-UBSAN-with-GCC-7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Fix-nonnull-errors-reported-by-UBSAN-with-GCC-7.patch"

From 876cfa4f4b2e74d43b9fd93d1056b88ab2ace0cd Mon Sep 17 00:00:00 2001
From: marxin <mliska@suse.cz>
Date: Wed, 5 Apr 2017 14:31:32 +0200
Subject: [PATCH 1/2] Fix nonnull errors reported by UBSAN with GCC 7.

Memory functions like memmove and memcpy should not be called
with an argument equal to NULL.

Signed-off-by: Martin Liska <mliska@suse.cz>
---
 apply.c            |  6 +++---
 builtin/ls-files.c |  2 +-
 git-compat-util.h  | 20 ++++++++++++++++++++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index e6dbab26a..eacca29fa 100644
--- a/apply.c
+++ b/apply.c
@@ -2802,9 +2802,9 @@ static void update_image(struct apply_state *state,
 			img->line + applied_pos + preimage_limit,
 			(img->nr - (applied_pos + preimage_limit)) *
 			sizeof(*img->line));
-	memcpy(img->line + applied_pos,
-	       postimage->line,
-	       postimage->nr * sizeof(*img->line));
+	MEMCPY(img->line + applied_pos,
+		postimage->line,
+		postimage->nr * sizeof(*img->line));
 	if (!state->allow_overlap)
 		for (i = 0; i < postimage->nr; i++)
 			img->line[applied_pos + i].flag |= LINE_PATCHED;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index d449e46db..7caeeb6a6 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -391,7 +391,7 @@ static void prune_cache(const char *prefix, size_t prefixlen)
 		}
 		last = next;
 	}
-	memmove(active_cache, active_cache + pos,
+	MEMMOVE(active_cache, active_cache + pos,
 		(last - pos) * sizeof(struct cache_entry *));
 	active_nr = last - pos;
 }
diff --git a/git-compat-util.h b/git-compat-util.h
index 8a4a3f85e..e5323f6c7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1002,6 +1002,26 @@ int git_qsort_s(void *base, size_t nmemb, size_t size,
 		die("BUG: qsort_s() failed");			\
 } while (0)
 
+static inline void *sane_memcpy(void *dest, const void *src, size_t n)
+{
+	if (n > 0)
+		return memcpy(dest, src, n);
+	else
+		return dest;
+}
+
+#define MEMCPY(dest, src, n) sane_memcpy(dest, src, n)
+
+static inline void *sane_memmove(void *dest, const void *src, size_t n)
+{
+	if (n > 0)
+		return memmove(dest, src, n);
+	else
+		return dest;
+}
+
+#define MEMMOVE(dest, src, n) sane_memmove(dest, src, n)
+
 #ifndef REG_STARTEND
 #error "Git requires REG_STARTEND support. Compile with NO_REGEX=NeedsStartEnd"
 #endif
-- 
2.12.2


--------------068A9022C043A51D247AA346--
