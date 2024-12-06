Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD2281AD7
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 05:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733463743; cv=none; b=XTnl2xraFCTK2gPToTHPBm8TSUcAf/Z5sWwIbHHp4wJjIqy0Yw9AAbyYtDnQ38MjCVKTuUQ20H8/iIzJacE5dJG7cC51JlgDrQYGGSZQ4m6T89zVuUGZNlXch16yssnx3g6J2Pp1JD2AEfCqzLz8WE94A5eOum3y26jsX16R45Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733463743; c=relaxed/simple;
	bh=eYdRuKqcuqZYaXoRJ1KWARV9gK7220iW5/EuLnrwICg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awVQbRsFnrez2kXm/LVuKSR7LOWjidgHF6PncCVDQ0CQfqV3vPvyZ4LwDhInQLgIp+uixtAndjF8dP6HMORt2qhcPgIme8iQwy5StFTiMkh/KAdByVrsIu52rc90/5/S/EBDwv6fKVjExq3E0XsbCR3meZ1V2U++8KerdgY2JVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=O/GSuDwy; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="O/GSuDwy"
Received: (qmail 5363 invoked by uid 109); 6 Dec 2024 05:42:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=eYdRuKqcuqZYaXoRJ1KWARV9gK7220iW5/EuLnrwICg=; b=O/GSuDwyuiwNEtiFSxMRayOy4ijrSCxjXqTqLXepoWglOdrp/b3Wy0yW+qspxSdZfCo0TK/W5LXPXIqzYZXnVwBiuAB4TL7pRFhb9460EsFiEW5sRV4PTwQXWyaljWzDjd826khaNl98sqBLDqxWrpa814vS5rL7jLALucaUml0BRSxBGkDBfJ8AmOcOay35ujZBycLslg1JXJ9JUDX/6t+bcp1wJkJIJlvWhnXA9TrgFaCbQ1rzxg1CwbhcAD254b18ZdHpNV+jJ36VcfPtNm4JDqYdY7dC193zYygltC7qL/w7nbyh7ZGlhdFNhMUNJ9UW53CxfHD7JaLbTCoV9g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Dec 2024 05:42:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14733 invoked by uid 111); 6 Dec 2024 05:42:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Dec 2024 00:42:19 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 6 Dec 2024 00:42:18 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	benno.martin.evers@gmail.com, benno@bmevers.de, ravi@prevas.dk,
	jpoimboe@kernel.org, masahiroy@kernel.org
Subject: [PATCH] describe: split "found all tags" and max_candidates logic
Message-ID: <20241206054218.GA3203047@coredump.intra.peff.net>
References: <20241106211717.GD956383@coredump.intra.peff.net>
 <00270315b83b585f7d62ad1204ca1df93a668791.1733354035.git.steadmon@google.com>
 <20241204232750.GA1460551@coredump.intra.peff.net>
 <20241205201449.GA2635755@coredump.intra.peff.net>
 <xmqqser1zf8q.fsf@gitster.g>
 <20241206032807.GA3176362@coredump.intra.peff.net>
 <xmqq1pylzbmv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1pylzbmv.fsf@gitster.g>

On Fri, Dec 06, 2024 at 01:19:36PM +0900, Junio C Hamano wrote:

> My gut reaction is that it is wrong not to give the abbreviated
> object name in this case, but the price to do so shouldn't be to
> change the behaviour when --exact-match was requested the the user.

I think this is where we differ. You call it a price, but to me it is a
bonus. ;)

> Loosening the interaction between the two options, when both were
> given explicitly, may be an improvement, but I think that should be
> treated as a separate topic, with its merit justified independently,
> since the command has been behaving this way from fairly early
> version, possibly the one that had both of the options for the first
> time.
> 
>   $ rungit v2.20.0 describe --exact-match HEAD
>   fatal: No names found, cannot describe anything.
>   $ rungit v2.20.0 describe --exact-match --always HEAD
>   fatal: no tag exactly matches '13a3dd7fe014658da465e9621ec3651f5473041e'
>   $ rungit v2.20.0 describe --exact-match --candidate=0 HEAD
>   fatal: No names found, cannot describe anything.

OK. That's certainly the more conservative approach, since it reduces
the change of behavior from previous versions.

Here's a replacement patch (again, on top of jk/describe-perf).

-- >8 --
Subject: [PATCH] describe: split "found all tags" and max_candidates logic

Commit a30154187a (describe: stop traversing when we run out of names,
2024-10-31) taught git-describe to automatically reduce the
max_candidates setting to match the total number of possible names. This
lets us break out of the traversal rather than fruitlessly searching for
more candidates when there are no more to be found.

However, setting max_candidates to 0 (e.g., if the repo has no tags)
overlaps with the --exact-match option, which explicitly uses the same
value. And this causes a regression with --always, which is ignored in
exact-match mode. We used to get this in a repo with no tags:

  $ git describe --always HEAD
  b2f0a7f

and now we get:

  $ git describe --always HEAD
  fatal: no tag exactly matches 'b2f0a7f47f5f2aebe1e7fceff19a57de20a78c06'

The reason is that we bail early in describe_commit() when
max_candidates is set to 0. This logic goes all the way back to
2c33f75754 (Teach git-describe --exact-match to avoid expensive tag
searches, 2008-02-24).

We should obviously fix this regression, but there are two paths,
depending on what you think:

  $ git describe --always --exact-match

and

  $ git describe --always --candidates=0

should do. Since the "--always" option was added, it has always been
ignored in --exact-match (or --candidates=0) mode. I.e., we treat
--exact-match as a true exact match of a tag, and never fall back to
using --always, even if it was requested.

If we think that's a bug (or at least a misfeature), then the right
solution is to fix it by removing the early bail-out from 2c33f75754,
letting the noop algorithm run and then hitting the --always fallback
output. And then our regression naturally goes away, because it follows
the same path.

If we think that the current "--exact-match --always" behavior is the
right thing, then we have to differentiate the case where we
automatically reduced max_candidates to 0 from the case where the user
asked for it specifically. That's possible to do with a flag, but we can
also just reimplement the logic from a30154187a to explicitly break out
of the traversal when we run out of candidates (rather than relying on
the existing max_candidates check).

My gut feeling is along the lines of option 1 (it's a bug, and people
would be happy for "--exact-match --always" to give the fallback rather
than ignoring "--always"). But the documentation can be interpreted in
the other direction, and we've certainly lived with the existing
behavior for many years. So it's possible that changing it now is the
wrong thing.

So this patch fixes the regression by taking the second option,
retaining the "--exact-match" behavior as-is. There are two new tests.
The first shows that the regression is fixed (we don't even need a new
repo without tags; a restrictive --match is enough to create the
situation that there are no candidate names).

The second test confirms that the "--exact-match --always" behavior
remains unchanged and continues to die when there is no tag pointing at
the specified commit. It's possible we may reconsider this in the
future, but this shows that the approach described above is implemented
faithfully.

We can also run the perf tests in p6100 to see that we've retained the
speedup that a30154187a was going for:

  Test                                           HEAD^             HEAD
  --------------------------------------------------------------------------------------
  6100.2: describe HEAD                          0.72(0.64+0.07)   0.72(0.66+0.06) +0.0%
  6100.3: describe HEAD with one max candidate   0.01(0.00+0.00)   0.01(0.00+0.00) +0.0%
  6100.4: describe HEAD with one tag             0.01(0.01+0.00)   0.01(0.01+0.00) +0.0%

Reported-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/describe.c  |  5 ++---
 t/t6120-describe.sh | 10 ++++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 8ec3be87df..a6ef8af32a 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -367,7 +367,8 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 
 		seen_commits++;
 
-		if (match_cnt == max_candidates) {
+		if (match_cnt == max_candidates ||
+		    match_cnt == hashmap_get_size(&names)) {
 			gave_up_on = c;
 			break;
 		}
@@ -667,8 +668,6 @@ int cmd_describe(int argc,
 			     NULL);
 	if (!hashmap_get_size(&names) && !always)
 		die(_("No names found, cannot describe anything."));
-	if (hashmap_get_size(&names) < max_candidates)
-		max_candidates = hashmap_get_size(&names);
 
 	if (argc == 0) {
 		if (broken) {
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 5633b11d01..3f6160d702 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -715,4 +715,14 @@ test_expect_success 'describe --broken --dirty with a file with changed stat' '
 	)
 '
 
+test_expect_success '--always with no refs falls back to commit hash' '
+	git rev-parse HEAD >expect &&
+	git describe --no-abbrev --always --match=no-such-tag >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--exact-match does not show --always fallback' '
+	test_must_fail git describe --exact-match --always
+'
+
 test_done
-- 
2.47.1.734.g721956425b

