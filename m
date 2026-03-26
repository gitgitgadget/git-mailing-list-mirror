Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C5332AAA0
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 19:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552401; cv=none; b=GL4TtJEKF3yFohoR3JVsSV+t7S7X6k36md7vkEG0U2Rl+bTFzDgfD8NmVOs2bhd3R9mBU66+3D9esHdgnIbCDt/Xx8+urtFDTaihz1PT8JOYOJTsZ+mN1NFQws9+jKVscaGV0q5i25CKtFzFnYHw3bwkTzmCoNtRQgB1EzgXSyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552401; c=relaxed/simple;
	bh=LwZiWnTjTROlgxIQSE6i+46IScuKQ0dHazlw4SV0UlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLz+DsQoI8AENrF/ma0vCjf3/RZSkJhu5lSojB5+jVRVfaKusmF3+Lgir+vuQ58kvX5O8jci6GUl/Ej0KUzAQ0kyorLQLWm6/exB6PULDoXsi+u1g7iVioRGyYydqbhYB3a1RS+aagGP+gXpS2F27SMKcVaKwwIhzIsGGceadF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=StNDVGVK; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="StNDVGVK"
Received: (qmail 155640 invoked by uid 106); 26 Mar 2026 19:13:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LwZiWnTjTROlgxIQSE6i+46IScuKQ0dHazlw4SV0UlM=; b=StNDVGVKQgY4b5dt2HHSrIDyxSgfdQi8leYaoDXqWYQYhK9BfIADvXYqofi5e/LdPOnht25aMU1gopit29jFRjophTRri0h43FClqsgsg4i1jiujUZ2IDHH/ioMgTTM0hrW7tnSKr6/xI40UntX9BkNDIr+yPZWiM8V31s0ea8e1/fzqdY+KNKh+lDZv47gXRw79lHKMWoK2ZG1R+FeeOUXGWoQYzaem/WzR09gMh1isAr4OfOsQuu7WylyKuAxlb2ZOIXEkuiJB9av3urpniTK+tbdQh3LH3u9YRAkRwLBfCrJJlQG5bgnwkeCdQUSDj7YEsthucvqGPWbUqxQNKQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Mar 2026 19:13:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 215885 invoked by uid 111); 26 Mar 2026 19:13:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2026 15:13:19 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Mar 2026 15:13:18 -0400
From: Jeff King <peff@peff.net>
To: Michael J Gruber <git@grubix.eu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 3/4] revision: avoid writing to const string for parent marks
Message-ID: <20260326191318.GC415796@coredump.intra.peff.net>
References: <20260326190243.GA412983@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260326190243.GA412983@coredump.intra.peff.net>

We take in a "const char *", but may write a NUL into it when parsing
parent marks like "foo^-", since we want to isolate "foo" as a string
for further parsing. This is usually OK, as our "const" strings are
often actually argv strings which are technically writeable, but we'd
segfault with a string literal like:

  handle_revision_arg("HEAD^-", &revs, 0, 0);

Similar to how we handled dotdot in a previous commit, we can avoid this
by making a temporary copy of the left-hand side of the string. The cost
should negligible compared to the rest of the parsing (like actually
parsing commits to create their parent linked-lists).

There is one slightly tricky thing, though. We parse some of the marks
progressively, so that if we see "foo^!" for example, we'll strip that
down to "foo" not just for calling add_parents_only(), but also for the
rest of the function. That makes sense since we eventually want to pass
"foo" to get_oid_with_context(). But it also means that we'll keep
looking for other marks. In particular, "foo^-^!" is valid, though oddly
"foo^!^-" would ignore the "^-". I'm not sure if this is a weird
historical artifact of the implementation, or if there are important
corner cases.

So I've left the behavior unchanged. Each mark we find allocates a
string with the mark stripped, which means we could allocate multiple
times (and carry a free-able pointer for each to the end). But in
practice we won't, because of the three marks, "^@" jumps immediately to
the end without further parsing, and "^-^!" is nonsense that nobody
would pass. So you'd get one allocation in general, and never more than
two.

Another obvious option would be to just copy "arg" up front and be OK
with munging it. But that means we pay the cost even when we find no
marks. We could make a single copy upon finding a mark and then munge,
but that adds extra code to each site (checking whether somebody else
allocated, and if not, adjusting our "mark" pointer to be relative to
the copied string).

I aimed for something that was clear and obvious, if a bit verbose.

Signed-off-by: Jeff King <peff@peff.net>
---
Also one other weirdness I noticed while proof-reading: if we
successfully parse a mark, we never restore the original string! So if
you call:

  char buf[] = "foo^!";
  handle_revision_arg(buf, &revs, 0, 0);

Then "buf" would have "foo\0!" after it returns. I guess no callers
care, because they only look at the arg again if there was an error.
But it incidentally is fixed by this patch.

 revision.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/revision.c b/revision.c
index f61262436f..fda405bf65 100644
--- a/revision.c
+++ b/revision.c
@@ -2147,7 +2147,10 @@ static int handle_dotdot(const char *arg,
 static int handle_revision_arg_1(const char *arg_, struct rev_info *revs, int flags, unsigned revarg_opt)
 {
 	struct object_context oc = {0};
-	char *mark;
+	const char *mark;
+	char *arg_minus_at = NULL;
+	char *arg_minus_excl = NULL;
+	char *arg_minus_dash = NULL;
 	struct object *object;
 	struct object_id oid;
 	int local_flags;
@@ -2174,18 +2177,17 @@ static int handle_revision_arg_1(const char *arg_, struct rev_info *revs, int fl
 
 	mark = strstr(arg, "^@");
 	if (mark && !mark[2]) {
-		*mark = 0;
-		if (add_parents_only(revs, arg, flags, 0)) {
+		arg_minus_at = xmemdupz(arg, mark - arg);
+		if (add_parents_only(revs, arg_minus_at, flags, 0)) {
 			ret = 0;
 			goto out;
 		}
-		*mark = '^';
 	}
 	mark = strstr(arg, "^!");
 	if (mark && !mark[2]) {
-		*mark = 0;
-		if (!add_parents_only(revs, arg, flags ^ (UNINTERESTING | BOTTOM), 0))
-			*mark = '^';
+		arg_minus_excl = xmemdupz(arg, mark - arg);
+		if (add_parents_only(revs, arg_minus_excl, flags ^ (UNINTERESTING | BOTTOM), 0))
+			arg = arg_minus_excl;
 	}
 	mark = strstr(arg, "^-");
 	if (mark) {
@@ -2199,9 +2201,9 @@ static int handle_revision_arg_1(const char *arg_, struct rev_info *revs, int fl
 			}
 		}
 
-		*mark = 0;
-		if (!add_parents_only(revs, arg, flags ^ (UNINTERESTING | BOTTOM), exclude_parent))
-			*mark = '^';
+		arg_minus_dash = xmemdupz(arg, mark - arg);
+		if (add_parents_only(revs, arg_minus_dash, flags ^ (UNINTERESTING | BOTTOM), exclude_parent))
+			arg = arg_minus_dash;
 	}
 
 	local_flags = 0;
@@ -2236,6 +2238,9 @@ static int handle_revision_arg_1(const char *arg_, struct rev_info *revs, int fl
 
 out:
 	object_context_release(&oc);
+	free(arg_minus_at);
+	free(arg_minus_excl);
+	free(arg_minus_dash);
 	return ret;
 }
 
-- 
2.53.0.1081.gf77a8b8145

