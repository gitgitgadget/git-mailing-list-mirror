Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC641D90AD
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 20:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759869254; cv=none; b=AldhhJ75zOmvXaGY9B3y665ieqswd3v85SXkPn9XvzgOUI1LP/RaUAn8azhW+vsENZtsF/zXfR/gWySr/SaTJVRiJmDpFucOt7Xc+abqHS+mD/HzUxvJp2jEPTmGc/Hqb9z906rvM2bf/SuVE4EPsU/8u1jMOcxhjy+76W/l2aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759869254; c=relaxed/simple;
	bh=+osOctyojmxpiKzgXkuYatHuSj5KKslJUvBGdFGczgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a//5/clvusrSzy7031+bEu5pZ8HBABzXdhoV8e6eU3gNeME6jdu/YGKq7TECItq+2RL3gmGPSZ4LIi5F1Q5BMsvvKifFflfyN5xTZGDOXUDm08J4Uc9yyatRmft5lhgSctizFSHtwiXHDaVaNdveiSzw70ifIz3/jBOyCeZ3Q8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=E0plQ8Ft; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="E0plQ8Ft"
Received: (qmail 161435 invoked by uid 109); 7 Oct 2025 20:34:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+osOctyojmxpiKzgXkuYatHuSj5KKslJUvBGdFGczgQ=; b=E0plQ8FtJJqYOvH1FfiaBJQOSWiu4UiHWgpIQok5qNlXia6SozY973VnFWXwly25ttH8no0uqxI7m5NFnyvRe2Jy2LwX+x5xMS99IV0Dmrd0Ywbs37GIGsv7sFWs/xing/eWzQ0doNgKrWanm/rgv5Kk8zx6+fe7B0Br/zQBEV7QP8mryoKME9acn99P1v+0YbChQjY18WuKhvAL+f7mr4TG7sGkxJxspfqT6Ez5AfGfH30K4cgfq1cf4F035TY/QAMUaoMH4j1hzEJ3yu1c9HWjHSF+skXXF2HXXKTynIcdkBn+54rQUsyl72fDmsnRq2nRibDYt/YhC/lfZz3zoA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Oct 2025 20:34:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 239947 invoked by uid 111); 7 Oct 2025 20:34:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Oct 2025 16:34:06 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Oct 2025 16:34:06 -0400
From: Jeff King <peff@peff.net>
To: Langbart <Langbart@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH] status: make coloring of "-z --short" consistent
Message-ID: <20251007203406.GA4028057@coredump.intra.peff.net>
References: <XCDlwEkTlgoZIyIf_8BfOGl1C3C63Ioxeib4BRNJ9Jm_CtYWKT3qu-pDaeXVtS1Ifq6E4pT9G0yDbIS_nSwN-uiBuBNAlMyrOv0R1RyM7oc=@protonmail.com>
 <20251007082920.GA3349249@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251007082920.GA3349249@coredump.intra.peff.net>

When running "git status -z --short", the marker on modified index
entries (e.g., "M") is colorized, but the "??" marker for untracked
entries is not. Let's fix the "??" entries to show color here.

At first glance you might think that neither should be colorized, as
usually one would use "-z" to get machine-readable output. But this is a
tricky and unusual case. We have two output formats, "--short" and
"--porcelain", which are substantially similar but differ in that
"--short" is for humans and "--porcelain" is for machines. And "-z" by
itself, without any other output option, does default to "--porcelain",
so "git status -z" is for machines and will not colorize anything.

But if you ask for "-z" and "--short" together, then that is explicitly
asking for the human-readable output, but separated by NULs. This is
unlikely to be useful directly, but could for example be used if the
output will be shown to a human outside of the terminal. At any rate,
the current behavior is clearly wrong (since we colorize some things but
not others), and I think colorizing everything is the least-surprising
thing we can do here.

Reported-by: Langbart <Langbart@protonmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
Same fix that I posted earlier, but now with a test and a commit
message.

 t/t7508-status.sh | 11 +++++++++++
 wt-status.c       |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index cdc1d6fcc7..abad229e9d 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -717,6 +717,17 @@ test_expect_success TTY 'status -s with color.status' '
 
 '
 
+test_expect_success TTY 'status -s keeps colors with -z' '
+	test_when_finished "rm -f output.*" &&
+	test_terminal git status -s -z >output.raw &&
+	# convert back to newlines to avoid portability issues with
+	# test_decode_color and test_cmp, and to let us use the same expected
+	# output as earlier tests
+	tr "\0" "\n" <output.raw >output.nl &&
+	test_decode_color <output.nl >output &&
+	test_cmp expect output
+'
+
 cat >expect <<\EOF
 ## <YELLOW>main<RESET>...<CYAN>upstream<RESET> [ahead <YELLOW>1<RESET>, behind <CYAN>2<RESET>]
  <RED>M<RESET> dir1/modified
diff --git a/wt-status.c b/wt-status.c
index 8ffe6d3988..e12adb26b9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2042,13 +2042,13 @@ static void wt_shortstatus_status(struct string_list_item *it,
 static void wt_shortstatus_other(struct string_list_item *it,
 				 struct wt_status *s, const char *sign)
 {
+	color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "%s", sign);
 	if (s->null_termination) {
-		fprintf(s->fp, "%s %s%c", sign, it->string, 0);
+		fprintf(s->fp, " %s%c", it->string, 0);
 	} else {
 		struct strbuf onebuf = STRBUF_INIT;
 		const char *one;
 		one = quote_path(it->string, s->prefix, &onebuf, QUOTE_PATH_QUOTE_SP);
-		color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "%s", sign);
 		fprintf(s->fp, " %s\n", one);
 		strbuf_release(&onebuf);
 	}
-- 
2.51.0.717.g1fc658c4b9

