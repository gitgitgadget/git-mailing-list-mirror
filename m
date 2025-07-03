Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBA72DE6EE
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751582673; cv=none; b=WDQPC5UUDVjXDmrZ39LVWLJ9CPpqc6tJtMGB5gfxEu1AY2gg26lkLDN8EOCrHtP5uchuAKFOzddl0L5Lj686FqwMC0z330CEolSYYQnblMrRNiSw2xuzZ5D2D2UTjN/ML1x8Jkt2koIdm87K9oa7AKgEoCBBGIr0owG+EYrUSLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751582673; c=relaxed/simple;
	bh=ykXjLnDr4R16P7R1STaCbPIwwouXsCCgl2p8Q4DowbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWbLbQ+Y1ndNB/deyISp3EYseOjpS6Sniu84+yN7VALamIACIMGcPMr5bD5jM9mDR5a2Hnw6EqRskFJpMGOxhLRvsyW2Lo9oY8c+O7ZHXTaz/IV6AZDsGnacdHp5FSObvFbNOOPGeNjAOzEbldCUe+cQkzUTP9XWQcS0rK6hyFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=U6W5k8CH; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="U6W5k8CH"
Received: (qmail 7649 invoked by uid 109); 3 Jul 2025 22:44:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ykXjLnDr4R16P7R1STaCbPIwwouXsCCgl2p8Q4DowbI=; b=U6W5k8CHGvZhP5nXubxDsbO4AfAdiHaNWh99BdoBokYhj80NnnsDssuRTB/sjnLhXT0eRr6lMt45HXVXBzljNthx80Yp995MtwxZ6ROy5edrZBc/v8ogTGXssk6AYNxD0Uf0sCNmA9mCbCduqURGHjuTRsQ5fIiv6guRMcVgdErYZiKusj74fibU9eP+Cz2NI497sZjC42eG5A8KbsRBwkBNXHk7U8emBlDWaUsxPcrC7jwWaOJduBF+gdYmB9vL5ET3CN4KQYMD2Ouv+UoFRJURIZpitMZfF7PZX+CEH2zi15LgOR7ZL5IgiHSMPqIkaGiCihN8ZLLCF/x4Z5swOg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Jul 2025 22:44:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6428 invoked by uid 111); 3 Jul 2025 22:44:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Jul 2025 18:44:31 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 3 Jul 2025 18:44:28 -0400
From: Jeff King <peff@peff.net>
To: Eric Salem <ericsalem@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
Subject: [PATCH] setup_revisions(): turn on diffs for all-negative diff filter
Message-ID: <20250703224428.GB1909836@coredump.intra.peff.net>
References: <64308d3f-281b-49a3-bc10-57878903bf4c@gmail.com>
 <20250703153438.GA1309870@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250703153438.GA1309870@coredump.intra.peff.net>

On Thu, Jul 03, 2025 at 11:34:38AM -0400, Jeff King wrote:

> On Wed, Jul 02, 2025 at 03:28:43PM -0500, Eric Salem wrote:
> 
> > The git log --diff-filter documentation[1] for deleted files says:
> > 
> > > Select only files that are Added (A), Copied (C), Deleted (D)...
> > 
> > > Also, these upper-case letters can be downcased to exclude.
> > > E.g. --diff-filter=ad excludes added and deleted paths.
> > 
> > A simple test:
> > [...]
> > --diff-filter=D behaves as expected, but when using "d" instead, I don't
> > get any output unless I add another option (such as --stat or
> > --name-only).
> 
> Looks like a bug. This used to produce the output I'd expect (i.e.,
> commits "first" and "third", which do not have deletions), but that
> changed in 75408ca949 (diff-filter: be more careful when looking for
> negative bits, 2022-01-28).
> 
> I don't have time to dig into it now, but I've cc'd the author (and left
> your whole reproduction recipe quoted below).

Argh, I forgot to add Johannes to the cc. Fortunately since then I had a
moment to look at this, and the solution is pretty simple. So here it is
as a patch with a test.

-- >8 --
Subject: setup_revisions(): turn on diffs for all-negative diff filter

When the user gives us a diff filter like --diff-filter=D, we need to do
a tree diff even if we're not planning to show the diff result itself,
in order to decide whether to show the commit at all. So there's an
explicit check of revs->diffopt.filter in setup_revisions(), and we set
revs->diff if any bits are set.

Originally that "filter" field covered both positive capital-letter
filters (like "D") and also negative lowercase filters (like "d"), so it
was sufficient for both cases. But later, 75408ca949 (diff-filter: be
more careful when looking for negative bits, 2022-01-28) split the
negative bits out into a "filter_not" field.

We eventually fold those into "filter", but not until diff_setup_done()
is called, which happens after our explicit check. As a result, a purely
negative filter like:

  git log --diff-filter=d

failed to turn on diffs at all. But rather than fail to filter by diff,
because the filter variable is eventually set, we mistakenly show no
commits at all, thinking that the empty diffs were cases where nothing
passed through the filter.

The smallest fix here is to just have our check look for any bits in
either "filter" or "filter_not". I suspect it would also be OK to
reorder the function a bit to call diff_setup_done() earlier, but that
risks violating some other subtle ordering dependency. So I went with
the simple and safe solution here.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c     | 2 +-
 t/t4202-log.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index afee111196..9892d08748 100644
--- a/revision.c
+++ b/revision.c
@@ -3112,7 +3112,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	/* Pickaxe, diff-filter and rename following need diffs */
 	if ((revs->diffopt.pickaxe_opts & DIFF_PICKAXE_KINDS_MASK) ||
-	    revs->diffopt.filter ||
+	    revs->diffopt.filter || revs->diffopt.filter_not ||
 	    revs->diffopt.flags.follow_renames)
 		revs->diff = 1;
 
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 4a6c4dfbf4..05cee9e41b 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -134,6 +134,12 @@ test_expect_success 'diff-filter=D' '
 
 '
 
+test_expect_success 'all-negative filter' '
+	git log --no-renames --format=%s --diff-filter=d HEAD >actual &&
+	printf "%s\n" fifth fourth third second initial >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'diff-filter=R' '
 
 	git log -M --pretty="format:%s" --diff-filter=R HEAD >actual &&
-- 
2.50.0.438.g3b3bebd3e8


