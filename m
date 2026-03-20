Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201AE175A81
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 00:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773967739; cv=none; b=Y4tkLikNftsX9FTV0gl9X+h3HoSqXzqrRNIOjC02Z3i/1HjO/bIJdql4v53tWwJQ1EQoY5fLPdcLWDEdI4i41oqvW1isPIjxqGqyKHscYq06WulBtlW+EfqzToLW+lR7/EihufjaMMmCzzOC8N8IfELbyyLUYwg8ryxoGfRmxso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773967739; c=relaxed/simple;
	bh=XrYHKBXx8vD+MpdMfqt4TDfMTu/TyusG+FFKTnv/ve8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuMhDQF22Y6t40kpSoXO1nttUacxEDvONpqVoqaZTjrLclbTqBvwlvwkSTf9ksM8m3BR4sTdPGurJH4/3uCQ+7Q0lHrQme9xd2mEiBDUA5u2wfcl+J8W4WSYBuK51LFG8/m8cQnj6SMU5cNd3lbTeA7xEFJQCySEt47rR1cC6xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NdIqCagV; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NdIqCagV"
Received: (qmail 62508 invoked by uid 106); 20 Mar 2026 00:48:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=XrYHKBXx8vD+MpdMfqt4TDfMTu/TyusG+FFKTnv/ve8=; b=NdIqCagVP/RyxqctAQipZEpWdIPVzvLP5oQcDcJZIUpgN2T8ZYK7Ek5CgpcWvwwpsuRqL37hHkW3qN8vGyqxWLFFEnIQkJvQrmSevlXnjW6tNOjhEleWJ9L4UR8ecnVo7b927hFI8+3u4/rmBcGGvtor+Mp6c+vIROO7l5Ey6rdszsBIQLTpICxOeeyWBtV9vurxcDJ/IcLa+dpXpaw6hvHX76xqO+AFBN0cKHcfajLZDL3vYaywfpGLx94Sj0O2Ubok00PQjRutolzXBpW8rNBfsTIxixLngSxZNQa1mhhftyre4sDYbrq6r1QaL5BVvP5zG60msVxdoShsi9rKpQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Mar 2026 00:48:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 91749 invoked by uid 111); 20 Mar 2026 00:48:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2026 20:48:56 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 19 Mar 2026 20:48:56 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Scott Baker <scott@perturb.org>
Subject: [PATCH 8/8] diff-highlight: fetch all config with one process
Message-ID: <20260320004856.GH3654226@coredump.intra.peff.net>
References: <20260320004138.GA3653623@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320004138.GA3653623@coredump.intra.peff.net>

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
 contrib/diff-highlight/DiffHighlight.pm | 26 ++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
index 96369eadf9..a22ba7a851 100644
--- a/contrib/diff-highlight/DiffHighlight.pm
+++ b/contrib/diff-highlight/DiffHighlight.pm
@@ -131,8 +131,20 @@ sub highlight_stdin {
 # of it being used in other settings. Let's handle our own
 # fallback, which means we will work even if git can't be run.
 sub color_config {
+	our $cached_config;
 	my ($key, $default) = @_;
-	my $s = `git config --get-color $key 2>$NULL`;
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
 	return length($s) ? $s : $default;
 }
 
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
2.53.0.945.ge67b727e8d
