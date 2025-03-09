Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4F414A85
	for <git@vger.kernel.org>; Sun,  9 Mar 2025 03:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741490523; cv=none; b=LZtT5u2YGPMYTZ7prT1jvPJVoahuPAOXdMIC7xxRX5/QphdliqzOHdLODOofdEW4AEAjxxaCQWJy8TVj/ljzUPrsNQ5NcNQR+c2uIhj3Dq0qD407CziRsXiz7rlKq9xssMhZqMCpD6FrHdD41+Ako1Sjnyf8uRx81hPP/tTeQfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741490523; c=relaxed/simple;
	bh=NhZ/S1hHipKSLMdNB94b5TfoRWwhK80Il9uh/3sM6Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ua1whFL5yZfR0+ynKU5LqIWaPXDsNZytaRROcsiYdhlvdSe3qMi7fbRhAI3aMQc4p836uDFotfXIBGrk+V+JD93WBWtct8PlsquOT/buH4Rye5U1BiRnlycE9cAaKl5gFqBxbiYCrw7QUsJGRGnDw0UBWJmQWX63aiyB1zD5W4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KCIiMSaW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KCIiMSaW"
Received: (qmail 5010 invoked by uid 109); 9 Mar 2025 03:22:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NhZ/S1hHipKSLMdNB94b5TfoRWwhK80Il9uh/3sM6Lw=; b=KCIiMSaWl+LCrVZTQTxbvwlyu65v21AfZWRk0trFHRCRrSz96Ib2ovv2JYOfXojOcqskhX+Uq9R+Bh3IqoWwNDR5YpeoeX7iVJK8NINzbxtQDgj49MPKoeb0V8w3ae7MvE7a8VgfGyOwbqy8bxAlUHplLbw/oVtNQT8IQASdoebkMWmfIPZSEUt3JLMINAIhveCRMMySkiQ9nZyzLbidO01MILIJTXwrVg84xx5uhnmmZrc8nG73/s/eGUjT8gWsS3Er8D+a+88Gyg46RW4Rd1JJTFg/zfS8LuJyYjbvKeB4hLDkBEflIAm87ixWlkSnJCShgw0FtchU7Iu5zUxgdw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 09 Mar 2025 03:22:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5116 invoked by uid 111); 9 Mar 2025 03:22:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Mar 2025 22:22:00 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Mar 2025 22:21:59 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH 9/9] fetch: use ref prefix list to skip ls-refs
Message-ID: <20250309032159.GI2334191@coredump.intra.peff.net>
References: <20250309030101.GA2334064@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309030101.GA2334064@coredump.intra.peff.net>

In git-fetch we have an optimization to avoid issuing an ls-refs command
to the server if we don't care about the value of any refs (e.g.,
because we are fetching exact object ids), saving a round-trip to the
server. This comes from e70a3030e7 (fetch: do not list refs if fetching
only hashes, 2018-09-27).

It uses an explicit flag "must_list_refs" to decide when we need to do
so. That was needed back then, because the list of ref-prefixes was not
always complete. If it was empty, it did not necessarily mean that we
were not interested in any refs). But that is no longer the case; an
empty list of prefixes means that we truly do not care about any refs.

And so rather than an explicit flag, we can just check whether we are
interested in any ref prefixes. This simplifies the code slightly, as
there is now a single source of truth for the decision.

It also fixes a bug in / optimizes a very unlikely case, which is:

  git fetch $remote ^foo $oid

I.e., a negative refspec combined with an exact oid fetch. This is
somewhat nonsense, in that there are no positive refspecs mentioning
refs to countermand with the negative one. But we should be able to do
this without issuing an ls-refs command (excluding "foo" from the empty
set will obviously still be the empty set).

However, the current code does not do so. The negative refspec is not
counted as a noop in un-setting the must_list_refs flag (hardly the
fault of e70a3030e7, as negative refspecs did not appear until much
later). But by using the prefix list as a source of truth, this
naturally just works; the negative refspec does not add a prefix to ask
about, and hence does not trigger the ls-refs call.

This is esoteric enough that I didn't bother adding a test. The real
value here is in the code simplification.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c26866e674..02af505469 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1718,7 +1718,6 @@ static int do_fetch(struct transport *transport,
 	const struct ref *remote_refs;
 	struct transport_ls_refs_options transport_ls_refs_options =
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
-	int must_list_refs = 1;
 	struct fetch_head fetch_head = { 0 };
 	struct strbuf err = STRBUF_INIT;
 
@@ -1737,21 +1736,7 @@ static int do_fetch(struct transport *transport,
 	}
 
 	if (rs->nr) {
-		int i;
-
 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
-
-		/*
-		 * We can avoid listing refs if all of them are exact
-		 * OIDs
-		 */
-		must_list_refs = 0;
-		for (i = 0; i < rs->nr; i++) {
-			if (!rs->items[i].exact_sha1) {
-				must_list_refs = 1;
-				break;
-			}
-		}
 	} else {
 		struct branch *branch = branch_get(NULL);
 
@@ -1776,18 +1761,20 @@ static int do_fetch(struct transport *transport,
 				    "HEAD");
 	}
 
-	if (tags == TAGS_SET || tags == TAGS_DEFAULT) {
-		must_list_refs = 1;
+	if (tags == TAGS_SET || tags == TAGS_DEFAULT)
 		strvec_push(&transport_ls_refs_options.ref_prefixes,
 			    "refs/tags/");
-	}
 
-	if (must_list_refs &&
+	if (transport_ls_refs_options.ref_prefixes.nr &&
 	    uses_remote_tracking(transport, rs))
 		strvec_push(&transport_ls_refs_options.ref_prefixes,
 			    "HEAD");
 
-	if (must_list_refs) {
+	/*
+	 * Only initiate ref listing if we have at least one ref we want to
+	 * know about.
+	 */
+	if (transport_ls_refs_options.ref_prefixes.nr) {
 		trace2_region_enter("fetch", "remote_refs", the_repository);
 		remote_refs = transport_get_remote_refs(transport,
 							&transport_ls_refs_options);
-- 
2.49.0.rc1.381.gc60f5426ff
