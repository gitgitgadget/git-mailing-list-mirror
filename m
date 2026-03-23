Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3210228690
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 06:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774245738; cv=none; b=jYT4Ni5yMw2dQWxDtJIBkvPp7MZb0xS58z/dXG6pdD2/OfMJiExtG6AaXgEfe0Dsxyzl1LsS0BAiPYFglW7Z1FEcXT00S4lZW5xmNseWvw56JiOAmAZLoHk8q6Wr0sYas+p8hVnxtpASYZ6bVEGYU21Vwj/ORJI8PXZBoQAb22o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774245738; c=relaxed/simple;
	bh=uLm252pRzmQta2wlMLfjbWxI/wEH8w4CIn0361sWNlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XP1GcxvQ0ZS2zZ0x+9uQ6DWgPqrN91UH2PmJG5cRjYbDccxqX6Lpy1Kp6cC0gvY0s/JyXkODk0mWk4N5LM0RuygBua2oV7KvwF9akcwqJ78NT5j0fPmtjsZE+mvuL8sB1qLI7Ghr5h5JienPjNQMROBkOpAG2alqEjLCsUSKN1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=O8Ds6Ed8; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="O8Ds6Ed8"
Received: (qmail 110218 invoked by uid 106); 23 Mar 2026 06:02:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=uLm252pRzmQta2wlMLfjbWxI/wEH8w4CIn0361sWNlU=; b=O8Ds6Ed8Gck1ihdpGW8YTBWpiYz5LhoZMtxuw3FpprkRi4EWJ3khS3EBy1e0b0fw2wc+q3DWpkTfFrp72WbbCFnBvo7FGfAWfuPRuprX+SLu8Ep6TzsBBULf9KckYOzwm8JqcGP1WfsrZTgyudu4/h7XsmTM5RY7E9guQiAdAIRNoSSskHO0pBaarZh1yxAzuinRAGGqt+3ZZZGI83r67qP/Xk9YpXKjRnsWKAvbCyF29gttNKByXc1mLulULOT5NnhdOeSQjIYbcaPhB3cJanDxCvrTa/Kefoz7PPr8pN3XkPo1MG2gHCecYU6JQiiROqktRN3hu1ky/x1CaEo1Bg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Mar 2026 06:02:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 147010 invoked by uid 111); 23 Mar 2026 06:02:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Mar 2026 02:02:16 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Mar 2026 02:02:15 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Tian Yuchen <a3205153416@gmail.com>, Scott Baker <scott@perturb.org>
Subject: [PATCH v2 7/8] diff-highlight: allow module callers to pass in color
 config
Message-ID: <20260323060215.GG10482@coredump.intra.peff.net>
References: <20260323060139.GA10215@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323060139.GA10215@coredump.intra.peff.net>

From: Scott Baker <scott@perturb.org>

Users of the module may want to pass in their own color config for a few
obvious reasons:

  - they are pulling the config from different variables than
    diff-highlight itself uses

  - they are loading the config in a more efficient way (say, by parsing
    git-config --list) and don't want to incur the six (!) git-config
    calls that DiffHighlight.pm runs to check all config

Let's allow users of the module to pass in the color config, and
lazy-load it when needed if they haven't.

Signed-off-by: Scott Baker <scott@perturb.org>
Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/diff-highlight/DiffHighlight.pm | 41 +++++++++++++++++--------
 contrib/diff-highlight/README           |  6 ++++
 2 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
index a5e5de3b18..96369eadf9 100644
--- a/contrib/diff-highlight/DiffHighlight.pm
+++ b/contrib/diff-highlight/DiffHighlight.pm
@@ -9,18 +9,11 @@ package DiffHighlight;
 
 my $NULL = File::Spec->devnull();
 
-# Highlight by reversing foreground and background. You could do
-# other things like bold or underline if you prefer.
-my @OLD_HIGHLIGHT = (
-	color_config('color.diff-highlight.oldnormal'),
-	color_config('color.diff-highlight.oldhighlight', "\x1b[7m"),
-	color_config('color.diff-highlight.oldreset', "\x1b[27m")
-);
-my @NEW_HIGHLIGHT = (
-	color_config('color.diff-highlight.newnormal', $OLD_HIGHLIGHT[0]),
-	color_config('color.diff-highlight.newhighlight', $OLD_HIGHLIGHT[1]),
-	color_config('color.diff-highlight.newreset', $OLD_HIGHLIGHT[2])
-);
+# The color theme is initially set to nothing here to allow outside callers
+# to set the colors for their application. If nothing is sent in we use
+# colors from git config in load_color_config().
+our @OLD_HIGHLIGHT = ();
+our @NEW_HIGHLIGHT = ();
 
 my $RESET = "\x1b[m";
 my $COLOR = qr/\x1b\[[0-9;]*m/;
@@ -170,6 +163,29 @@ sub show_hunk {
 	$line_cb->(@queue);
 }
 
+sub load_color_config {
+	# If the colors were NOT set from outside this module we load them on-demand
+	# from the git config. Note that only one of elements 0 and 2 in each
+	# array is used (depending on whether you are doing set/unset on an
+	# attribute, or specifying normal vs highlighted coloring). So we use
+	# element 1 as our check for whether colors were passed in; it should
+	# always be set if you want highlighting to do anything.
+	if (!defined $OLD_HIGHLIGHT[1]) {
+		@OLD_HIGHLIGHT = (
+			color_config('color.diff-highlight.oldnormal'),
+			color_config('color.diff-highlight.oldhighlight', "\x1b[7m"),
+			color_config('color.diff-highlight.oldreset', "\x1b[27m")
+		);
+	}
+	if (!defined $NEW_HIGHLIGHT[1]) {
+		@NEW_HIGHLIGHT = (
+			color_config('color.diff-highlight.newnormal', $OLD_HIGHLIGHT[0]),
+			color_config('color.diff-highlight.newhighlight', $OLD_HIGHLIGHT[1]),
+			color_config('color.diff-highlight.newreset', $OLD_HIGHLIGHT[2])
+		);
+	};
+}
+
 sub highlight_pair {
 	my @a = split_line(shift);
 	my @b = split_line(shift);
@@ -218,6 +234,7 @@ sub highlight_pair {
 	}
 
 	if (is_pair_interesting(\@a, $pa, $sa, \@b, $pb, $sb)) {
+		load_color_config();
 		return highlight_line(\@a, $pa, $sa, \@OLD_HIGHLIGHT),
 		       highlight_line(\@b, $pb, $sb, \@NEW_HIGHLIGHT);
 	}
diff --git a/contrib/diff-highlight/README b/contrib/diff-highlight/README
index 9c89146fb0..ed8d876a18 100644
--- a/contrib/diff-highlight/README
+++ b/contrib/diff-highlight/README
@@ -138,6 +138,12 @@ Your script may set up one or more of the following variables:
     processing a logical chunk of input). The default function flushes
     stdout.
 
+  - @DiffHighlight::OLD_HIGHLIGHT and @DiffHighlight::NEW_HIGHLIGHT - these
+    arrays specify the normal, highlighted, and reset colors (in that order)
+    for old/new lines. If unset, values will be retrieved by calling `git
+    config` (see "Color Config" above). Note that these should be the literal
+    color bytes (starting with an ANSI escape code), not color names.
+
 The script may then feed lines, one at a time, to DiffHighlight::handle_line().
 When lines are done processing, they will be fed to $line_cb. Note that
 DiffHighlight may queue up many input lines (to analyze a whole hunk)
-- 
2.53.0.1051.ga14e96f895

