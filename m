Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8E5143C7B
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496000; cv=none; b=evGx0dFUxSAawsszTXCcYETfPRv0cXnhexB2ASY5/EYllojiQkj+gv/KoQRB4xd5iJbR8h34byVKfkyjVbyxBXI/rtTRyRTiK7knLomBrEscEYxXhNZFRn2C6F2X3cBfA5SciBf/qaBK/Nd14mbXjuGEj0X7BL0EdiPsL4fJGyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496000; c=relaxed/simple;
	bh=rQC/gO4q1pb8NVDNGu86dTI/43gncmPvUr4FpiqNeMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W66HsTOuAPdPNwkRwXtO4URnJRTiqk3W+Ju28qPxZ+wHgivjYRVwYVOfwQIp3ND15FlWmYtxKXz1QlQkvvo6JMIXYfdUYwpEwIu35pW6HuJ4dmy3LElJP0n9A2jhtX1+oik0CVKouUgekn2iVCSj10sHr8wT8ChFcbulOevO/48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21484 invoked by uid 109); 4 Jun 2024 10:13:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Jun 2024 10:13:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18360 invoked by uid 111); 4 Jun 2024 10:13:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Jun 2024 06:13:15 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Jun 2024 06:13:17 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 04/13] sparse-checkout: clear patterns when init() sees
 existing sparse file
Message-ID: <20240604101317.GD1304593@coredump.intra.peff.net>
References: <20240604100814.GA1304520@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240604100814.GA1304520@coredump.intra.peff.net>

In sparse_checkout_init(), we first try to load patterns from an
existing file. If we found any, we return immediately, but end up
leaking the patterns we parsed. Fixing this reduces the number of leaks
in t7002 from 9 down to 5.

Note that there are two other exits from the function, but they don't
need the same treatment:

  - if we can't resolve HEAD, we write out a hard-coded sparse file and
    return. But we know the pattern list is empty there, since we didn't
    find any in the on-disk file and we haven't yet added any of our
    own.

  - otherwise, we do populate the list and then tail-call into
    write_patterns_and_update(). But that function frees the
    pattern_list itself, so we don't need to.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/sparse-checkout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 7c17ed238c..923e6ecc0a 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -472,6 +472,7 @@ static int sparse_checkout_init(int argc, const char **argv, const char *prefix)
 	/* If we already have a sparse-checkout file, use it. */
 	if (res >= 0) {
 		free(sparse_filename);
+		clear_pattern_list(&pl);
 		return update_working_directory(NULL);
 	}
 
-- 
2.45.2.807.g3b5fadc4da

