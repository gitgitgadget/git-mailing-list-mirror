Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBFF13A26F
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730927822; cv=none; b=QCMEe/uUx214g1fjsu2lsJgfOSn6AqeXAAnnIIPyeUAXVLGqiVd+cYYeWVDV2gFcu1pvQaRqvC9Q0fEeNSQ8atWBIVt+rMeit1Gc4HBXTJE7+TgJewTaojJdNj81TXRMb9dQylxlxeK09i4SH+vH8CUYXtmZa0b6+jgPl202fso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730927822; c=relaxed/simple;
	bh=RRwV6JXJLRisl2vkgZ1sXl6bIkmSc8im5cOr+Ynybgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0xAT1n8O96RVb+eSy/cEwTqQOikFCt4ayBzXCjGrOC1OyBCGp1waOaN3Sv0MRtTBVcgpNxG1CPgmOh5S6D/OGWJRskaXc5yX4e/mz+c9mNGoY1mG7kBDXDygsHTWwY+y7ENw+lSYL0+egXVousp4APTcDYggz6RMKsRVXFIuPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Lq6KzVVT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Lq6KzVVT"
Received: (qmail 15290 invoked by uid 109); 6 Nov 2024 21:16:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=RRwV6JXJLRisl2vkgZ1sXl6bIkmSc8im5cOr+Ynybgc=; b=Lq6KzVVT0rkH1RdhAFG4jSRrtuZeYgTzPNRuCyVBHHADzQaakKQ3M0UxJ5NTdVgZf58x226uz1twWgFt0SI2m2RDsMFweb4hk3mK31dUaN91+lU7dxMYAnmxAkimsL18wSXvNwIJidAQa3FF6GEmpeJ8guHI57XINstod3JBDuiPluhIR3YLoOExDuo416Ehb/AWEz0cpchO5aKPFpYYh4iK+WXNCjo2F4wg3ha9rAr1LBNozXaJetW6daL9y+cJ9zgQvPbqUCS9aekdJSrhhWyQvurpskd7Zyra6goxcAeN5IE3goacZh6LDuZ0Q5fJBkaDOhqUU/NLmzAtr/W70w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Nov 2024 21:16:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8131 invoked by uid 111); 6 Nov 2024 21:16:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Nov 2024 16:16:58 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Nov 2024 16:16:58 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Benno Evers <benno.martin.evers@gmail.com>,
	Rasmus Villemoes <ravi@prevas.dk>, Benno Evers <benno@bmevers.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/4] t6120: demonstrate weakness in disjoint-root handling
Message-ID: <20241106211658.GA956383@coredump.intra.peff.net>
References: <20241106192236.GC880133@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106192236.GC880133@coredump.intra.peff.net>

Commit 30b1c7ad9d (describe: don't abort too early when searching tags,
2020-02-26) tried to fix a problem that happens when there are disjoint
histories: to accurately compare the counts for different tags, we need
to keep walking the history longer in order to find a common base.

But its fix misses a case: we may still bail early if we hit the
max_candidates limit, producing suboptimal output. You can see this in
action by adding "--candidates=2" to the tests; we'll stop traversing as
soon as we see the second tag and will produce the wrong answer. I hit
this in practice while trying to teach git-describe not to keep looking
for candidates after we've seen all tags in the repo (effectively adding
--candidates=2, since these toy repos have only two tags each).

This is probably fixable by continuing to walk after hitting the
max-candidates limit, all the way down to a common ancestor of all
candidates. But it's not clear in practice what the preformance
implications would be (it would depend on how long the branches that
hold the candidates are).

So I'm punting on that for now, but I'd like to adjust the tests to be
more resilient, and to document the findings. So this patch:

  1. Adds an extra tag at the bottom of history. This shouldn't change
     the output, but does mean we are more resilient to low values of
     --candidates (e.g., if we start reducing it to the total number of
     tags). This is arguably closer to the real world anyway, where
     you're not going to have just 2 tags, but an arbitrarily long
     history going back in time, possibly with multiple irrelevant tags
     in it (I called the new tag "H" here for "history").

  2. Run the same tests with --candidates=2, which shows that even with
     the current code they can fail if we end the traversal early. That
     leaves a trail for anybody interested in trying to improve the
     behavior.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t6120-describe.sh | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 05ed2510d9..69689d2f36 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -19,13 +19,17 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 check_describe () {
 	indir= &&
+	outcome=success &&
 	while test $# != 0
 	do
 		case "$1" in
 		-C)
 			indir="$2"
 			shift
 			;;
+		--expect-failure)
+			outcome=failure
+			;;
 		*)
 			break
 			;;
@@ -36,7 +40,7 @@ check_describe () {
 	expect="$1"
 	shift
 	describe_opts="$@"
-	test_expect_success "describe $describe_opts" '
+	test_expect_${outcome} "describe $describe_opts" '
 		git ${indir:+ -C "$indir"} describe $describe_opts >raw &&
 		sed -e "s/-g[0-9a-f]*\$/-gHASH/" <raw >actual &&
 		echo "$expect" >expect &&
@@ -617,7 +621,7 @@ test_expect_success 'name-rev --annotate-stdin works with commitGraph' '
 
 #               B
 #               o
-#                \
+#  H             \
 #  o-----o---o----x
 #        A
 #
@@ -627,6 +631,7 @@ test_expect_success 'setup: describe commits with disjoint bases' '
 		cd disjoint1 &&
 
 		echo o >> file && git add file && git commit -m o &&
+		git tag H -a -m H &&
 		echo A >> file && git add file && git commit -m A &&
 		git tag A -a -m A &&
 		echo o >> file && git add file && git commit -m o &&
@@ -639,8 +644,9 @@ test_expect_success 'setup: describe commits with disjoint bases' '
 '
 
 check_describe -C disjoint1 "A-3-gHASH" HEAD
+check_describe -C disjoint1 --expect-failure "A-3-gHASH" --candidates=2 HEAD
 
-#           B
+#       H   B
 #   o---o---o------------.
 #                         \
 #                  o---o---x
@@ -658,13 +664,15 @@ test_expect_success 'setup: describe commits with disjoint bases 2' '
 		git checkout --orphan branch &&
 		echo o >> file2 && git add file2 && GIT_COMMITTER_DATE="2020-01-01 15:00" git commit -m o &&
 		echo o >> file2 && git add file2 && GIT_COMMITTER_DATE="2020-01-01 15:01" git commit -m o &&
+		git tag H -a -m H &&
 		echo B >> file2 && git add file2 && GIT_COMMITTER_DATE="2020-01-01 15:02" git commit -m B &&
 		git tag B -a -m B &&
 		git merge --no-ff --allow-unrelated-histories main -m x
 	)
 '
 
 check_describe -C disjoint2 "B-3-gHASH" HEAD
+check_describe -C disjoint2 --expect-failure "B-3-gHASH" --candidates=2 HEAD
 
 test_expect_success 'setup misleading taggerdates' '
 	GIT_COMMITTER_DATE="2006-12-12 12:31" git tag -a -m "another tag" newer-tag-older-commit unique-file~1
-- 
2.47.0.441.g1a09955689

