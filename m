Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FC3520966
	for <e@80x24.org>; Fri,  7 Apr 2017 14:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756579AbdDGOXR (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 10:23:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:43982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755901AbdDGOXP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 10:23:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 01DF5AC1E;
        Fri,  7 Apr 2017 14:23:13 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] Fix nonnull errors reported by UBSAN with GCC 7.
To:     Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <295981e7-d2e9-d3db-e32d-8dd80ca47136@suse.cz>
 <20170406083425.7psdmrploxar3h6v@sigill.intra.peff.net>
 <998bf391-7fc5-8329-db58-ef0f24517707@suse.cz>
 <33c63fb9-281c-8fd2-66e7-b85f62f4f447@web.de>
 <8555c61f-2617-eec8-6dbe-87c79c6ca302@suse.cz>
 <587b0cb9-bd66-ddf7-5cca-023df3470883@kdbg.org>
 <e392e05c-2815-8cfa-eed0-bd990f8ce954@web.de>
 <357d045a-b1c5-1a73-2256-839efb543fe3@kdbg.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Message-ID: <96beb4c6-0569-0c12-8151-462c20be6a2a@suse.cz>
Date:   Fri, 7 Apr 2017 16:23:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <357d045a-b1c5-1a73-2256-839efb543fe3@kdbg.org>
Content-Type: multipart/mixed;
 boundary="------------9B621E80B6A9910A0DFF8B32"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------9B621E80B6A9910A0DFF8B32
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 04/06/2017 10:49 PM, Johannes Sixt wrote:
> Am 06.04.2017 um 19:31 schrieb René Scharfe:
>> Am 06.04.2017 um 18:33 schrieb Johannes Sixt:
>>> Am 06.04.2017 um 17:42 schrieb Martin Liška:
>>>> +static inline void *sane_memmove(void *dest, const void *src, size_t n)
>>>> +{
>>>> +    if (n > 0)
>>>> +        return memmove(dest, src, n);
>>>> +    else
>>>> +        return dest;
>>>> +}
>>>
>>> Huh? memmove with n == 0 is well-defined. This wrapper is pointless.
>>
>> memmove(3) with NULL pointers is undefined.
> 
> Then don't hide this helper behind a macro with a suspiciously similar name. Using the name sane_mmemove at the call site is preferable. memmove_or_null or something similar perhaps even more so.
> 
> -- Hannes
> 

Good. There's tested v4.

Martin

--------------9B621E80B6A9910A0DFF8B32
Content-Type: text/x-patch;
 name="0001-Fix-nonnull-errors-reported-by-UBSAN-with-GCC-7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Fix-nonnull-errors-reported-by-UBSAN-with-GCC-7.patch"

From 0bdf4d717d3d368dd9676d15d20f8592c4d22fde Mon Sep 17 00:00:00 2001
From: marxin <mliska@suse.cz>
Date: Wed, 5 Apr 2017 14:31:32 +0200
Subject: [PATCH 1/2] Fix nonnull errors reported by UBSAN with GCC 7.

Replace call to memmove with newly introduced function memmove_or_null
and call to memcpy with COPY_ARRAY macro.

Signed-off-by: Martin Liska <mliska@suse.cz>
---
 apply.c            | 4 +---
 builtin/ls-files.c | 2 +-
 git-compat-util.h  | 8 ++++++++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index e6dbab26a..121f3f414 100644
--- a/apply.c
+++ b/apply.c
@@ -2802,9 +2802,7 @@ static void update_image(struct apply_state *state,
 			img->line + applied_pos + preimage_limit,
 			(img->nr - (applied_pos + preimage_limit)) *
 			sizeof(*img->line));
-	memcpy(img->line + applied_pos,
-	       postimage->line,
-	       postimage->nr * sizeof(*img->line));
+	COPY_ARRAY(img->line + applied_pos, postimage->line, postimage->nr);
 	if (!state->allow_overlap)
 		for (i = 0; i < postimage->nr; i++)
 			img->line[applied_pos + i].flag |= LINE_PATCHED;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index d449e46db..0a6cc1e8a 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -391,7 +391,7 @@ static void prune_cache(const char *prefix, size_t prefixlen)
 		}
 		last = next;
 	}
-	memmove(active_cache, active_cache + pos,
+	memmove_or_null(active_cache, active_cache + pos,
 		(last - pos) * sizeof(struct cache_entry *));
 	active_nr = last - pos;
 }
diff --git a/git-compat-util.h b/git-compat-util.h
index 8a4a3f85e..81f6e56ac 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1002,6 +1002,14 @@ int git_qsort_s(void *base, size_t nmemb, size_t size,
 		die("BUG: qsort_s() failed");			\
 } while (0)
 
+static inline void *memmove_or_null(void *dest, const void *src, size_t n)
+{
+	if (n > 0)
+		return memmove(dest, src, n);
+	else
+		return dest;
+}
+
 #ifndef REG_STARTEND
 #error "Git requires REG_STARTEND support. Compile with NO_REGEX=NeedsStartEnd"
 #endif
-- 
2.12.2


--------------9B621E80B6A9910A0DFF8B32--
