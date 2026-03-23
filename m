Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E3B28690
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 06:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774245741; cv=none; b=NfIdnErGYtphI46CvOhulw4byD2CWhJ/Em/eygL1n4cJCsG8bQyaIkHqcUEtGOHFzDeO29vJQBtMbQyBKvXuOgrkJ6yZ8w0Acr/OsMmu9YkBzq4q9qWQwO9wnqtrPef31XGE8I40+lNGehaOedOu6sG1gEOhfFqi+DuAuxa/Ius=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774245741; c=relaxed/simple;
	bh=RGne4TalWf++mJefvFm0TAsH+MbpQNiqUEn8P3iYiG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PP76BPBsvy/6CoJNimF1nYHr/Aytrf2fJywr9UKr/tKhKqOJigrH4Rw5a+MbOm6oVDrbKDLyewWLgO5z0KjbgLjtWrxNLqejJQPD/GFCYgIoCrIVBBChzbMv1cJQZHTMhMhnqebUIVztS/dpqMHCD6DDRoVOOTHCX9c1xSPczZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=S+UmQW39; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="S+UmQW39"
Received: (qmail 110228 invoked by uid 106); 23 Mar 2026 06:02:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=RGne4TalWf++mJefvFm0TAsH+MbpQNiqUEn8P3iYiG0=; b=S+UmQW39P54+nkA5H4yR3Jvsl0jvimMJhSZR76ND/qWrEZr6vpejLf7UCHZ1yUrl3qaF74+kO2U5EIpATpCP4xmof8RSgxtc5BoX65UNITbM2eM2IYyTOtKjMN+lH+IpGyqEUzTdq6ZYyS8n00Us3iZeTloel5x47YGWP27dMi/xuFJunG0PZAZBscRKlBPKOG9ObZFZeOiiskfHtLWDzKyiR6f/o8GjGvlRsL+z2AKEFEBXnixT09s8GNG+PzXd61/kf+wUfZ0FUCzU1Jxc5Hj1yOGwieF8m1lSwsM1/g/HovwCI/61QwPWtK31vtvbbv19O2IelUmn17+mby5Bfg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Mar 2026 06:02:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 147015 invoked by uid 111); 23 Mar 2026 06:02:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Mar 2026 02:02:18 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Mar 2026 02:02:18 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Tian Yuchen <a3205153416@gmail.com>, Scott Baker <scott@perturb.org>
Subject: [PATCH v2 8/8] diff-highlight: fetch all config with one process
Message-ID: <20260323060218.GH10482@coredump.intra.peff.net>
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

When diff-highlight was written, there was no way to fetch multiple
config keys _and_ have them interpreted as colors. So we were stuck
with either invoking git-config once for each config key, or fetching
them all and converting human-readable color names into ANSI codes
ourselves.

I chose the former, but it means that diff-highlight kicks off 6
git-config processes (even if you haven't configured anything, it has to
check each one).

But since Git 2.18.0, we can do:

   git config --type=color --get-regexp=^color\.diff-highlight\.

to get all of them in one shot.

Note that any callers which pass in colors directly to the module via
@OLD_HIGHLIGHT and @NEW_HIGHLIGHT (like diff-so-fancy plans to do) are
unaffected; those colors suppress any config lookup we'd do ourselves.

You can see the effect like:

  # diff-highlight suppresses git-config's stderr, so dump
  # trace through descriptor 3
  git show d1f33c753d | GIT_TRACE=3 diff-highlight 3>&2 >/dev/null

which drops from 6 lines down to 1.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/diff-highlight/DiffHighlight.pm | 28 ++++++++++++++++++-------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
index 96369eadf9..abe457882e 100644
--- a/contrib/diff-highlight/DiffHighlight.pm
+++ b/contrib/diff-highlight/DiffHighlight.pm
@@ -131,9 +131,21 @@ sub highlight_stdin {
 # of it being used in other settings. Let's handle our own
 # fallback, which means we will work even if git can't be run.
 sub color_config {
+	our $cached_config;
 	my ($key, $default) = @_;
-	my $s = `git config --get-color $key 2>$NULL`;
-	return length($s) ? $s : $default;
+
+	if (!defined $cached_config) {
+		$cached_config = {};
+		my $data = `git config --type=color --get-regexp '^color\.diff-highlight\.' 2>$NULL`;
+		for my $line (split /\n/, $data) {
+			my ($key, $color) = split ' ', $line, 2;
+			$key =~ s/^color\.diff-highlight\.// or next;
+			$cached_config->{$key} = $color;
+		}
+	}
+
+	my $s = $cached_config->{$key};
+	return defined($s) ? $s : $default;
 }
 
 sub show_hunk {
@@ -172,16 +184,16 @@ sub load_color_config {
 	# always be set if you want highlighting to do anything.
 	if (!defined $OLD_HIGHLIGHT[1]) {
 		@OLD_HIGHLIGHT = (
-			color_config('color.diff-highlight.oldnormal'),
-			color_config('color.diff-highlight.oldhighlight', "\x1b[7m"),
-			color_config('color.diff-highlight.oldreset', "\x1b[27m")
+			color_config('oldnormal'),
+			color_config('oldhighlight', "\x1b[7m"),
+			color_config('oldreset', "\x1b[27m")
 		);
 	}
 	if (!defined $NEW_HIGHLIGHT[1]) {
 		@NEW_HIGHLIGHT = (
-			color_config('color.diff-highlight.newnormal', $OLD_HIGHLIGHT[0]),
-			color_config('color.diff-highlight.newhighlight', $OLD_HIGHLIGHT[1]),
-			color_config('color.diff-highlight.newreset', $OLD_HIGHLIGHT[2])
+			color_config('newnormal', $OLD_HIGHLIGHT[0]),
+			color_config('newhighlight', $OLD_HIGHLIGHT[1]),
+			color_config('newreset', $OLD_HIGHLIGHT[2])
 		);
 	};
 }
-- 
2.53.0.1051.ga14e96f895
