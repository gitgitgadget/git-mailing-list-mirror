Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7DA71F954
	for <e@80x24.org>; Thu, 23 Aug 2018 00:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbeHWEP1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 00:15:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:52530 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725727AbeHWEP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 00:15:27 -0400
Received: (qmail 12098 invoked by uid 109); 23 Aug 2018 00:48:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Aug 2018 00:48:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6226 invoked by uid 111); 23 Aug 2018 00:48:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 Aug 2018 20:48:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2018 20:48:21 -0400
Date:   Wed, 22 Aug 2018 20:48:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: [PATCH 4/9] interpret-trailers: tighten check for "---" patch
 boundary
Message-ID: <20180823004821.GD3126@sigill.intra.peff.net>
References: <20180823004300.GA1355@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180823004300.GA1355@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The interpret-trailers command accepts not only raw commit
messages, but it also can manipulate trailers in
format-patch output. That means it must find the "---"
boundary separating the commit message from the patch.
However, it does so by looking for any line starting with
"---", regardless of whether there is further content.

This is overly lax compared to the parsing done in
mailinfo.c's patchbreak(), and may cause false positives
(e.g., t/perf output tables uses dashes; if you cut and
paste them into your commit message, it fools the parser).

We could try to reuse patchbreak() here, but it actually has
several heuristics that are not of interest to us (e.g.,
matching "diff -" without a three-dash separator or even a
CVS "Index:" line). We're not interested in taking in
whatever random cruft people may send, but rather handling
git-formatted patches.

Note that the existing documentation was written in a loose
way, so technically we are changing the behavior from what
it said. But this should implement the original intent in a
more accurate way.

Signed-off-by: Jeff King <peff@peff.net>
---
By itself, this would fix the case that spawned this
discussion, though we still have false positives on "---" in
a commit message.

 Documentation/git-interpret-trailers.txt |  5 +++--
 t/t7513-interpret-trailers.sh            | 22 ++++++++++++++++++++++
 trailer.c                                |  4 +++-
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index b8fafb1e8b..7385bfdb45 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -56,8 +56,9 @@ least one Git-generated or user-configured trailer and consists of at
 least 25% trailers.
 The group must be preceded by one or more empty (or whitespace-only) lines.
 The group must either be at the end of the message or be the last
-non-whitespace lines before a line that starts with '---'. Such three
-minus signs start the patch part of the message.
+non-whitespace lines before a line that starts with '---' (followed by a
+space or the end of the line). Such three minus signs start the patch
+part of the message.
 
 When reading trailers, there can be whitespaces after the
 token, the separator and the value. There can also be whitespaces
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 164719d1c9..e13b40b43f 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -1417,4 +1417,26 @@ test_expect_success 'unfold' '
 	test_cmp expected actual
 '
 
+test_expect_success 'handling of --- lines in input' '
+	echo "real-trailer: just right" >expected &&
+
+	git interpret-trailers --parse >actual <<-\EOF &&
+	subject
+
+	body
+
+	not-a-trailer: too soon
+	------ this is just a line in the commit message with a bunch of
+	------ dashes; it does not have any syntactic meaning.
+
+	real-trailer: just right
+	---
+	below the dashed line may be a patch, etc.
+
+	not-a-trailer: too late
+	EOF
+
+	test_cmp expected actual
+'
+
 test_done
diff --git a/trailer.c b/trailer.c
index e769c5b72c..8392c6c030 100644
--- a/trailer.c
+++ b/trailer.c
@@ -793,7 +793,9 @@ static size_t find_patch_start(const char *str)
 	const char *s;
 
 	for (s = str; *s; s = next_line(s)) {
-		if (starts_with(s, "---"))
+		const char *v;
+
+		if (skip_prefix(s, "---", &v) && isspace(*v))
 			return s - str;
 	}
 
-- 
2.19.0.rc0.412.g7005db4e88

