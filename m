Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1F583CD5
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215063; cv=none; b=pTLR83MUwM2ogx3f3FfI53op6FzJ9wqsa85VbzJf3s2iZFYZq1a8IYABHYdMjxuqZm959+QTxJKbxphVZx3EXVAXEv8rytouU1x6GtatlJyvW1rQwn3nCwRDFknwp/qfVXu9u8uAzcB8rpyre31fVTsnfFXN2WJNka6iQZ2X3Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215063; c=relaxed/simple;
	bh=9tQaFjr84FV2JD2MxbzIKFGSxPCyaZr8Qa/9m+aVZCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNGLn+Y0W0f1olBmJs78CoNEBNOjsL+cIn194vCvzSukjpMqQltUBA9TdXokPkUALP55Gqa9QcnGxgXpsP56KxO7uDVUuhQrsAFTcxwXqVeDld7EEkRfCzicfKzhGYX+ynF0W1ISNUomThzrNqV0fC6UunC9jxi8blvaNYp4h18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15476 invoked by uid 109); 24 Sep 2024 21:57:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 21:57:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18597 invoked by uid 111); 24 Sep 2024 21:57:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 17:57:41 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 17:57:40 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 10/28] fetch: free "raw" string when shrinking refspec
Message-ID: <20240924215740.GJ1143820@coredump.intra.peff.net>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924214930.GA1143523@coredump.intra.peff.net>

The "--prefetch" option to git-fetch modifies the default refspec,
including eliminating some entries entirely. When we drop an entry we
free the strings in the refspec_item, but we forgot to free the matching
string in the "raw" array of the refspec struct. There's no behavioral
bug here (since we correctly shrink the raw array, too), but we're
leaking the allocated string.

Let's add in the leak-fix, and while we're at it drop "const" from
the type of the raw string array. These strings are always allocated by
refspec_append(), etc, and this makes the memory ownership more clear.

This is all a bit more intimate with the refspec code than I'd like, and
I suspect it would be better if each refspec_item held on to its own raw
string, we had a single array, and we could use refspec_item_clear() to
clean up everything. But that's a non-trivial refactoring, since
refspec_item structs can be held outside of a "struct refspec", without
having a matching raw string at all. So let's leave that for now and
just fix the leak in the most immediate way.

This lets us mark t5582 as leak-free.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c                   | 1 +
 refspec.c                         | 2 +-
 refspec.h                         | 2 +-
 t/t5582-fetch-negative-refspec.sh | 1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c900f57721..80a64d0d26 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -456,6 +456,7 @@ static void filter_prefetch_refspec(struct refspec *rs)
 
 			free(rs->items[i].src);
 			free(rs->items[i].dst);
+			free(rs->raw[i]);
 
 			for (j = i + 1; j < rs->nr; j++) {
 				rs->items[j - 1] = rs->items[j];
diff --git a/refspec.c b/refspec.c
index ec90ab349a..c3cf003443 100644
--- a/refspec.c
+++ b/refspec.c
@@ -225,7 +225,7 @@ void refspec_clear(struct refspec *rs)
 	rs->nr = 0;
 
 	for (i = 0; i < rs->raw_nr; i++)
-		free((char *)rs->raw[i]);
+		free(rs->raw[i]);
 	FREE_AND_NULL(rs->raw);
 	rs->raw_alloc = 0;
 	rs->raw_nr = 0;
diff --git a/refspec.h b/refspec.h
index 754be45cee..3760fdaf2b 100644
--- a/refspec.h
+++ b/refspec.h
@@ -43,7 +43,7 @@ struct refspec {
 	int alloc;
 	int nr;
 
-	const char **raw;
+	char **raw;
 	int raw_alloc;
 	int raw_nr;
 
diff --git a/t/t5582-fetch-negative-refspec.sh b/t/t5582-fetch-negative-refspec.sh
index 7a80e47c2b..7fa54a4029 100755
--- a/t/t5582-fetch-negative-refspec.sh
+++ b/t/t5582-fetch-negative-refspec.sh
@@ -8,6 +8,7 @@ test_description='"git fetch" with negative refspecs.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
-- 
2.46.2.1011.gf1f9323e02

