Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A33AC7618A
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 16:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjCTQUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 12:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjCTQTs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 12:19:48 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F891126EA
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 09:11:34 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i9so10906086wrp.3
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 09:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679328693;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+quL3Un10xVjBNXlInkbJ2zLErEmH5B4yrxPWxEnA30=;
        b=fbEsdZkLo3TzfBDcHVvsi6gE8sL9ZyClC0hL1B9cemLN0M6QImxhbervCxpRTTRT0S
         KtRZwB1YxKcPqXhjZf7CD7QOGA0UKuovk5RELO+zTYMmLoWfk3tsB0vPnosLPwbnIna3
         6/MpZC00/sRqV4D8N2MIFG5E9hJaCNTmPuxAorcMs9GrFU9GdK54+EnVayrpyEWpa8BR
         2/mUn5hTgT/Vm2BG/NB63/1CUKAOfUXuCdEnkXrIs2q2PfI8Gq3x7ENCGS1a3uwR4q3O
         ZI4zWo2WOjj00zHIl4SYz/aTXV8XZP/aGy2airJE9n1fiop2rfbTUzELiCqMeDoq1v4r
         eS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679328693;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+quL3Un10xVjBNXlInkbJ2zLErEmH5B4yrxPWxEnA30=;
        b=yjHAA7+NJQ/t32gvCa85oqwy3VusgoNw2NLTQRNMHIoOb3aVaOGd1FDE7Lyr4lYxLI
         TIrjcq2GLEqj8bFc0UdBXNjD5j7X7MzaSSbdG6zHoyE8oNxUGD065jtxErcEq9hlKO4g
         ddzyg/UwKZydv9n/fVEn1LipUCELwFVLMAgpw0m0QH3ETaNVRuXoQYSDaCeXExs8OuiI
         7OBdVmX56bEykBq8a98hHZoPAbooSqpnmrEeMqoO8omeoH7VuQ8te/lvUJcaJsOz77o5
         xHbUQ4TblsPPx9hYkM2FPnTFGr+80pit4lE0UBOUU/7Ly7Jr6r2EaEouiZPbvVTapXEn
         VSgA==
X-Gm-Message-State: AO0yUKXpr6WztD5Y1E0FAChVNd24xMkvyXJtzb7Ynr9WdsyS7vhrBjbm
        IRCh2MTqo+eAwB+yoc/cVX3zjGHK03U=
X-Google-Smtp-Source: AK7set8kZV8pr1nx7M4ivyhJQXD9mT4KbRbDRcWJmHWDtZGHm96tnB7UdqwCc521r9E55tn+lDDYMA==
X-Received: by 2002:a05:6000:1144:b0:2c7:a3c:5bd6 with SMTP id d4-20020a056000114400b002c70a3c5bd6mr14217125wrx.52.1679328692820;
        Mon, 20 Mar 2023 09:11:32 -0700 (PDT)
Received: from localhost.localdomain ([90.253.29.198])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d484c000000b002c59f18674asm9279628wrs.22.2023.03.20.09.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:11:32 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/3] wildmatch: fix exponential behavior
Date:   Mon, 20 Mar 2023 16:10:00 +0000
Message-Id: <13accf6f99d367d137eefd02e3f6bf05bf099e00.1679328580.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679328580.git.phillip.wood@dunelm.org.uk>
References: <cover.1679328580.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When dowild() cannot match a '*' or '/**/' wildcard then it must return
WM_ABORT_TO_STARSTAR or WM_ABORT_ALL respectively. Failure to observe
this results in unnecessary backtracking and the time taken for a failed
match increases exponentially with the number of wildcards in the
pattern [1]. Unfortunately in some instances dowild() returns WM_NOMATCH
for a failed match resulting in long match times for patterns containing
multiple wildcards as can be seen in the following benchmark.
(Note that the timings in the Benchmark 1 are really measuring the time
to execute test-tool rather than the time to match the pattern)

Benchmark 1: t/helper/test-tool wildmatch wildmatch aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab "*a"
  Time (mean ± σ):      22.8 ms ±   1.7 ms    [User: 12.1 ms, System: 10.6 ms]
  Range (min … max):    19.4 ms …  26.9 ms    113 runs

  Warning: Ignoring non-zero exit code.

Benchmark 2: t/helper/test-tool wildmatch wildmatch aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab "*a*a*a*a*a*a*a*a*a"
  Time (mean ± σ):      5.244 s ±  0.228 s    [User: 5.229 s, System: 0.010 s]
  Range (min … max):    4.969 s …  5.707 s    10 runs

  Warning: Ignoring non-zero exit code.

Summary
  't/helper/test-tool wildmatch wildmatch aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab "*a"' ran
  230.37 ± 20.04 times faster than 't/helper/test-tool wildmatch wildmatch aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab "*a*a*a*a*a*a*a*a*a"'

The security implications are limited as it only affects operations that
are potentially DoS vectors. For example by creating a blob containing
such a pattern a malicious user can exploit this behavior to use large
amounts of CPU time on a remote server by pushing the blob and then
creating a new clone with --filter=sparse:oid. However this filter type
is usually disabled as it is known to consume large amounts of CPU time
even without this bug.

The WM_MATCH changed in the first hunk of this patch comes from the
original implementation imported from rsync in 5230f605e1 (Import
wildmatch from rsync, 2012-10-15). Compared to the others converted here
it is fairly harmless as it only triggers at the end of the pattern and
so will only cause a single unnecessary backtrack. The others introduced
by 6f1a31f0aa (wildmatch: advance faster in <asterisk> + <literal>
patterns, 2013-01-01) and 46983441ae (wildmatch: make a special case for
"*/" with FNM_PATHNAME, 2013-01-01) are more pernicious and will cause
exponential behavior.

A new test is added to protect against future regressions.

[1] https://research.swtch.com/glob

Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3070-wildmatch.sh |  9 +++++++++
 wildmatch.c          | 12 ++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 5d871fde96..b91a7cb712 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -431,4 +431,13 @@ match 1 1 1 1 'a' '[B-a]'
 match 0 1 0 1 'z' '[Z-y]'
 match 1 1 1 1 'Z' '[Z-y]'
 
+test_expect_success 'matching does not exhibit exponential behavior' '
+	test-tool wildmatch wildmatch \
+		aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab \
+		"*a*a*a*a*a*a*a*a*a*a*a*a*a*a*a*a" &
+	pid=$! &&
+	sleep 2 &&
+	! kill $!
+'
+
 test_done
diff --git a/wildmatch.c b/wildmatch.c
index 7e5a7ea1ea..06861bd8bc 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -114,7 +114,7 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 				 * only if there are no more slash characters. */
 				if (!match_slash) {
 					if (strchr((char *)text, '/'))
-						return WM_NOMATCH;
+						return WM_ABORT_TO_STARSTAR;
 				}
 				return WM_MATCH;
 			} else if (!match_slash && *p == '/') {
@@ -125,7 +125,7 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 				 */
 				const char *slash = strchr((char*)text, '/');
 				if (!slash)
-					return WM_NOMATCH;
+					return WM_ABORT_ALL;
 				text = (const uchar*)slash;
 				/* the slash is consumed by the top-level for loop */
 				break;
@@ -153,8 +153,12 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 							break;
 						text++;
 					}
-					if (t_ch != p_ch)
-						return WM_NOMATCH;
+					if (t_ch != p_ch) {
+						if (match_slash)
+							return WM_ABORT_ALL;
+						else
+							return WM_ABORT_TO_STARSTAR;
+					}
 				}
 				if ((matched = dowild(p, text, flags)) != WM_NOMATCH) {
 					if (!match_slash || matched != WM_ABORT_TO_STARSTAR)
-- 
2.39.2

