Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB831C8634
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788552; cv=none; b=JtSQRXs6Qs2mciPqQ5QDg9FJ/NztYwy8nX/2SuouHv1Ux4qxBOPLXkxCvQrqA51ollbLPWozHSi0/PzuHuyZuiYu1zSLvoIL7NgovHYMeOsx9O2+h3s8UcDSnn8Uog31JTJiCINvxfY7p5CoHx8rkd3WzVdArwCaKS0AnOpbUtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788552; c=relaxed/simple;
	bh=Pko79modXKXf5rr9zleeqWZ8AFwnyzCUJVJLsTkaki0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HNS2AI4XWBzRqeYR5SdNXebDsR6idqgYTewmEVrWHUwEg4a75NAUVnGKR+RAt8XY7W2TKccoY2lth/cktvpuN6HfQRXFhO34Jhzk7pT9L5F3Zu2NjHtW5ZuuVB826phaKJgnT8R4Sy+qo1cpl2P6+8uJtP5jyZl6wCP8HIrD+08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=c7E8kBXO; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="c7E8kBXO"
Received: (qmail 34850 invoked by uid 106); 17 Mar 2026 23:02:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=Pko79modXKXf5rr9zleeqWZ8AFwnyzCUJVJLsTkaki0=; b=c7E8kBXOv7qXlaBUlRPWej+6d4gF9hS+wCAz66GZFoYU3fr61TkqhYRIWl5upYbQuHjYKj2Ecy2nbjCFshyEOxwI2vZxlopQbWNffuIwzgvfMblL6bz2eY8xLCLp4gtGFkkPYeVTyAaKIdu8AVC+kKSZ1Pm6qHtkyjdkW2cW7RUvY1TKILD82zc6Ni8ObonIUDJZqBFkmmD9JSVNEh6Efadw2tgsOmgtMu6lHZ1fmYotmqRDcgLtWa9+Vod7jLm6BVIyfcwb5x+Stn0ccLFTQustzG/rwV1x3RYvZ94yG145PU8H8P7d3AbbrIpn2jS7iqMmnJc1dYHQs4SrJ4ZkPg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Mar 2026 23:02:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 52330 invoked by uid 111); 17 Mar 2026 23:02:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Mar 2026 19:02:23 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 17 Mar 2026 19:02:23 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Scott Baker <scott@perturb.org>
Subject: [PATCH] contrib/diff-highlight: do not highlight identical pairs
Message-ID: <20260317230223.GA716496@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

We pair lines for highlighting based on their position in the hunk. So
we should never see two identical lines paired, like:

  -one
  -two
  +one
  +something else

which would pair -one/+one, because that implies that the diff could
easily be shrunk by turning line "one" into context.

But there is (at least) one exception: removing a newline at the end of
a file will produce a diff like:

  -foo
  +foo
  \No newline at end of file

And we will pair those two lines. As a result, we end up marking the
whole line, including the newline, as the shared prefix. And there's an
empty suffix.

The most obvious bug here is that when we try to print the highlighted
lines, we remove the trailing newline from the suffix, but do not bother
with the prefix (under the assumption that there had to be a difference
_somewhere_ in the line, and thus the prefix would not eat all the way
up to the newline). And so you get an extra line like:

  -foo

  +foo

  \No newline at end of file

This is obviously ugly, but also causes interactive.diffFilter to
(rightly) complain that the input and output do not match their lines
1-to-1.

This could easily be fixed by chomping the prefix, too, but I think the
problem is deeper. For one, I suspect some of the other logic gets
confused by forming an array with zero-indexed element "3" in a
3-element array. But more importantly, we try not to highlight whole
lines, as there's nothing interesting to show there. So let's catch this
early in is_pair_interesting() and bail to our usual passthrough
strategy.

Reported-by: Scott Baker <scott@perturb.org>
Signed-off-by: Jeff King <peff@peff.net>
---
It would perhaps make more sense for diff-highlight to chomp all
incoming lines, then do its comparisons, and then add a newline back on
output. That's a bigger change, so I punted on it for now.

 contrib/diff-highlight/DiffHighlight.pm          | 12 ++++++++++++
 contrib/diff-highlight/t/t9400-diff-highlight.sh | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
index 3d061bc0b7..f0607a4b68 100644
--- a/contrib/diff-highlight/DiffHighlight.pm
+++ b/contrib/diff-highlight/DiffHighlight.pm
@@ -273,6 +273,18 @@ sub highlight_line {
 # or suffix (disregarding boring bits like whitespace and colorization).
 sub is_pair_interesting {
 	my ($a, $pa, $sa, $b, $pb, $sb) = @_;
+
+	# We hit this case if the prefix consumed the entire line, meaning
+	# that two lines are identical. This generally shouldn't happen,
+	# since it implies the diff isn't minimal (you could shrink the hunk by
+	# making this a context line). But you can see it when the line
+	# content is the same, but the trailing newline is dropped, like:
+	#
+	#   -foo
+	#   +foo
+	#   \No newline at end of file
+	return 0 if $pa == @$a || $pb == @$b;
+
 	my $prefix_a = join('', @$a[0..($pa-1)]);
 	my $prefix_b = join('', @$b[0..($pb-1)]);
 	my $suffix_a = join('', @$a[($sa+1)..$#$a]);
diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
index dee296739c..2a9b68cf3b 100755
--- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -340,4 +340,15 @@ test_expect_success 'diff-highlight handles --graph with leading dash' '
 	test_cmp expect actual
 '
 
+test_expect_success 'highlight diff that removes final newline' '
+	printf "content\n" >a &&
+	printf "content" >b &&
+	dh_test a b <<-\EOF
+	@@ -1 +1 @@
+	-content
+	+content
+	\ No newline at end of file
+	EOF
+'
+
 test_done
-- 
2.53.0.930.g4fb07a7d1b
