Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A30C8C4
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 01:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707270509; cv=none; b=DCyCRyE4NBSUlzHMpwJtvsClYHzzwrvuKS2vrPVYB9hcCcl+83gzxU9S2M8vUFP4XR5LDm17PcrmHoMIzKDqVN9JEcs9dTb2OPN/sXXNaeBXa4JbSOgToa6U4RAZeKgSzpk9q6jULdd1xXgC25g0vQGAt+kHSj1nYlUtaMXWaXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707270509; c=relaxed/simple;
	bh=BeNbZvPsGv2ERPgqw0iQKemP47xMgFiI3k2tA8puB2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eC/uiTB6L+Q6pp8sUylrQfY3f2eJhZhwAzzfdD/Od3c02hhbHxIvNBEPzRWI8D6yCdUCMWBsmCtav5Ck7AGkxKzJrjR/hU1IXHiBudjWXw2H3VAB4WA1umpZGA+ANE0Hpt6BK1PcQVf+JyhyiCq7q4JaWqPHZlPyJPKxkBYBDPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3896 invoked by uid 109); 7 Feb 2024 01:48:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Feb 2024 01:48:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14236 invoked by uid 111); 7 Feb 2024 01:48:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Feb 2024 20:48:21 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 6 Feb 2024 20:48:19 -0500
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im,
	phillip.wood123@gmail.com
Subject: Re: [PATCH v3 1/4] refs: introduce `is_pseudoref()` and
 `is_headref()`
Message-ID: <20240207014819.GA1399428@coredump.intra.peff.net>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240129113527.607022-1-karthik.188@gmail.com>
 <20240129113527.607022-2-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129113527.607022-2-karthik.188@gmail.com>

On Mon, Jan 29, 2024 at 12:35:24PM +0100, Karthik Nayak wrote:

> +int is_pseudoref(struct ref_store *refs, const char *refname)
> [...]
> +	if (ends_with(refname, "_HEAD")) {
> +		 read_ref_full(refname, RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
> +		      &oid, NULL);
> +		 return !is_null_oid(&oid);
> +	}

I was going to prepare a patch on top, but since it looks like this was
reverted out of 'next' to be revamped, I thought I'd mention it now:
-Wunused-parameter notices that we never use the "refs" parameter to the
function. And indeed it looks like a (possible) bug, since
read_ref_full() is going to use the_repository to find the ref store.

I think you'd want something like this squashed in (note that it also
fixes a slight indent problem in the first block):

diff --git a/refs.c b/refs.c
index 3190df8d81..0d65c31117 100644
--- a/refs.c
+++ b/refs.c
@@ -875,15 +875,17 @@ int is_pseudoref(struct ref_store *refs, const char *refname)
 		return 0;
 
 	if (ends_with(refname, "_HEAD")) {
-		 read_ref_full(refname, RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-		      &oid, NULL);
-		 return !is_null_oid(&oid);
+		refs_resolve_ref_unsafe(refs, refname,
+					RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+					&oid, NULL);
+		return !is_null_oid(&oid);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(irregular_pseudorefs); i++)
 		if (!strcmp(refname, irregular_pseudorefs[i])) {
-			read_ref_full(refname, RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-						  &oid, NULL);
+			refs_resolve_ref_unsafe(refs, refname,
+						RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+						&oid, NULL);
 			return !is_null_oid(&oid);
 		}
 

-Peff
