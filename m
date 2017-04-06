Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B28EC1FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 15:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753730AbdDFPmm (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 11:42:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:58487 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753473AbdDFPmh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 11:42:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 84362AB43;
        Thu,  6 Apr 2017 15:42:35 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] Fix nonnull errors reported by UBSAN with GCC 7.
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
References: <295981e7-d2e9-d3db-e32d-8dd80ca47136@suse.cz>
 <20170406083425.7psdmrploxar3h6v@sigill.intra.peff.net>
 <998bf391-7fc5-8329-db58-ef0f24517707@suse.cz>
 <33c63fb9-281c-8fd2-66e7-b85f62f4f447@web.de>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Message-ID: <8555c61f-2617-eec8-6dbe-87c79c6ca302@suse.cz>
Date:   Thu, 6 Apr 2017 17:42:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <33c63fb9-281c-8fd2-66e7-b85f62f4f447@web.de>
Content-Type: multipart/mixed;
 boundary="------------FED35BC504D56233A26D983A"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------FED35BC504D56233A26D983A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 04/06/2017 02:26 PM, René Scharfe wrote:
> Am 06.04.2017 um 11:52 schrieb Martin Liška:
>> I'm sending (v2), where I updated commit message and wrapped 2 problematic
>> places to newly introduced macros that do the check. Follow-up patch can
>> change usages of memcpy and memove.
> 
>> diff --git a/apply.c b/apply.c
>> index e6dbab26a..eacca29fa 100644
>> --- a/apply.c
>> +++ b/apply.c
>> @@ -2802,9 +2802,9 @@ static void update_image(struct apply_state *state,
>>  			img->line + applied_pos + preimage_limit,
>>  			(img->nr - (applied_pos + preimage_limit)) *
>>  			sizeof(*img->line));
>> -	memcpy(img->line + applied_pos,
>> -	       postimage->line,
>> -	       postimage->nr * sizeof(*img->line));
>> +	MEMCPY(img->line + applied_pos,
>> +		postimage->line,
>> +		postimage->nr * sizeof(*img->line));
> 
> Using the existing macro COPY_ARRAY would yield a nicer result:

Yes, it's nicer. I'm sending tested version 3.

Martin

> 
> 	COPY_ARRAY(img->line + applied_pos, postimage->line, postimage->nr);
> 
>>  	if (!state->allow_overlap)
>>  		for (i = 0; i < postimage->nr; i++)
>>  			img->line[applied_pos + i].flag |= LINE_PATCHED;
>> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
>> index d449e46db..7caeeb6a6 100644
>> --- a/builtin/ls-files.c
>> +++ b/builtin/ls-files.c
>> @@ -391,7 +391,7 @@ static void prune_cache(const char *prefix, size_t prefixlen)
>>  		}
>>  		last = next;
>>  	}
>> -	memmove(active_cache, active_cache + pos,
>> +	MEMMOVE(active_cache, active_cache + pos,
>>  		(last - pos) * sizeof(struct cache_entry *));
>>  	active_nr = last - pos;
>>  }
> 
> Perhaps we should add MOVE_ARRAY to complement COPY_ARRAY.
> 
> René
> 


--------------FED35BC504D56233A26D983A
Content-Type: text/x-patch;
 name="0001-Fix-nonnull-errors-reported-by-UBSAN-with-GCC-7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Fix-nonnull-errors-reported-by-UBSAN-with-GCC-7.patch"

From 4784ff90b2c4cd0d78a25c8d8ed77f299686348c Mon Sep 17 00:00:00 2001
From: marxin <mliska@suse.cz>
Date: Wed, 5 Apr 2017 14:31:32 +0200
Subject: [PATCH 1/2] Fix nonnull errors reported by UBSAN with GCC 7.

Memory functions like memmove and memcpy should only be called
with positive sizes. That is achieved by newly introduced macro
MEMMOVE and usage of ARRAY_COPY.

Signed-off-by: Martin Liska <mliska@suse.cz>
---
 apply.c            |  4 +---
 builtin/ls-files.c |  2 +-
 git-compat-util.h  | 10 ++++++++++
 3 files changed, 12 insertions(+), 4 deletions(-)

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
index 8a4a3f85e..b75e21cff 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1002,6 +1002,16 @@ int git_qsort_s(void *base, size_t nmemb, size_t size,
 		die("BUG: qsort_s() failed");			\
 } while (0)
 
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


--------------FED35BC504D56233A26D983A--
