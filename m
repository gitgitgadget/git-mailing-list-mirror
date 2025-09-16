Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB801FDA61
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053765; cv=none; b=b23gseD1izGLSXGhAXDGzozFCqKlTpkNphxLS1XWR8mHLfCPmBZdWx42pdAhqprpcKfG8TqDYeyL+8rEQT7kxurbZ2sOqhuswa8ZcTx+AArN24ppIGJUWMy3CbqZ+4Rtg28HIgAjJY7CugQKl1cuwnWgI7BnO6vCdOAHg+fuv6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053765; c=relaxed/simple;
	bh=KZsL7H6B8lb8vn/XzeievRofsU3digg9zVUzOxCmb8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHhHH5s8aTgEvAQdG2Fdl+i69YJ0xn/TDpjHDRNzIqZZxQD2RnNlGFP96IHjh3mxwM5ChHEkxJlSbS8raiyictes2gCyIEfgHetvc9suBTEFlwpF8puOC8y75DXUUbxd4WrIwrmWy+fOFY/mUQUualGqu+x641DMep+bae7LbVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ObnoDVzr; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ObnoDVzr"
Received: (qmail 102302 invoked by uid 109); 16 Sep 2025 20:16:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=KZsL7H6B8lb8vn/XzeievRofsU3digg9zVUzOxCmb8Q=; b=ObnoDVzrxbRJIwh9+efqo7nwbtsNWSJWJyQD/pFUb41YC0zK2/c92QmSQ6I4PaOcHdbz11DlX2ViqmlnwXVhSUBtnuElbYhafo+Icjl1G88BNpWhbj0LlTu5X5pmuv5OL5yeft7saPESScTtMZaV1wbbhjNg3oQpAYo0Es6N43ypHDwsv3mugJxTe66QyTT19W19A/eVO/nN5fMuz+qcXw7aEUZayhNymVY6xaKMgnD0boTNhtyjn4LqB1v4sbEUyVTzJk6P+vnayh1W/6UmE0u+zGGLCDHNzFLNFDMU6p4hEaTHVhEdXnZgB+bkOuL70vMts1J9W2e6WOm2gHDmOg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Sep 2025 20:16:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 166167 invoked by uid 111); 16 Sep 2025 20:16:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Sep 2025 16:16:00 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Sep 2025 16:16:00 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 03/13] grep: don't treat grep_opt.color as a strict bool
Message-ID: <20250916201600.GC612873@coredump.intra.peff.net>
References: <20250916201036.GA612463@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250916201036.GA612463@coredump.intra.peff.net>

In show_line(), we check to see if colors are desired with just:

  if (opt->color)
     ...we want colors...

But this is incorrect. The color field here is really a git_colorbool,
so it may be "true" for GIT_COLOR_UNKNOWN or GIT_COLOR_AUTO. Either of
those _might_ end up true eventually (once we apply default fallbacks
and check stdout's tty), but they may not. E.g.:

  git grep foo | cat

will enter the conditional even though we're not going to show colors.
We should collapse it into a true boolean by calling want_color().

It turns out that this does not produce a user-visible bug. We do some
extra processing to isolate the matched portion of the line in order to
colorize it, but ultimately we pass it to our output_color() helper,
which does correctly check want_color(). So we end up with no colors.

But dropping the extra processing saves a measurable amount of time. For
example, running under hyperfine (which redirects to /dev/null, and thus
does not colorize):

  Benchmark 1: ./git.old grep a
    Time (mean ± σ):      58.7 ms ±   3.5 ms    [User: 580.6 ms, System: 74.3 ms]
    Range (min … max):    53.5 ms …  67.1 ms    48 runs

  Benchmark 2: ./git.new grep a
    Time (mean ± σ):      35.5 ms ±   0.9 ms    [User: 276.8 ms, System: 73.8 ms]
    Range (min … max):    34.3 ms …  39.3 ms    79 runs

  Summary
    ./git.new grep a ran
      1.65 ± 0.11 times faster than ./git.old grep a

That's a fairly extreme benchmark, just because it will come up with a
ton of small matches, but it shows that this really does matter.

Signed-off-by: Jeff King <peff@peff.net>
---
If you really want to cheat on the benchmark, grep for a single space,
which is even more common.

 grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index 932647e4a6..c7e1dc1e0e 100644
--- a/grep.c
+++ b/grep.c
@@ -1263,12 +1263,12 @@ static void show_line(struct grep_opt *opt,
 		 */
 		show_line_header(opt, name, lno, cno, sign);
 	}
-	if (opt->color || opt->only_matching) {
+	if (want_color(opt->color) || opt->only_matching) {
 		regmatch_t match;
 		enum grep_context ctx = GREP_CONTEXT_BODY;
 		int eflags = 0;
 
-		if (opt->color) {
+		if (want_color(opt->color)) {
 			if (sign == ':')
 				match_color = opt->colors[GREP_COLOR_MATCH_SELECTED];
 			else
-- 
2.51.0.527.g34bc42dacd

