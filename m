Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0555157487
	for <git@vger.kernel.org>; Fri, 31 May 2024 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154877; cv=none; b=p/E3RH4WuHbyJHoH0fNmBxh7bdIDkMSiyxlKWsKy1LgBxnKUQtH53sOvJPZTHvhXWUxjv4GQBM5kkbF2CnpmbOUHFiH98Kfw5ve7wYZ73nkqqGKg+bO9xCORrT4dWxrfzop7EVGRCvsAw4PCLsubCab3vBspU90KnN4r+mkiV/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154877; c=relaxed/simple;
	bh=gM6q7GC6w5vrFHDKLfU8JmQgSXO1+9nVZgaA96Gy7OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMin1JnCwlB6vrBk7G4Ppv+ye61vA9wp8gOP92Y7lxhge9/8tRXWzwEYGz8WQ8Cw6Ine8d8H23VvsLiPkUlEhMtvnhe4G/olHqxijzgAwGqjvjgIWhrTTyPRwqTskvRJhU+iqMvvJmDCMFlLdm5rW05agzB+U03Lc6YYo6K/UsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22726 invoked by uid 109); 31 May 2024 11:27:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 May 2024 11:27:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9259 invoked by uid 111); 31 May 2024 11:27:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 May 2024 07:27:54 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 31 May 2024 07:27:53 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 04/13] sparse-checkout: clear patterns when init() sees
 existing sparse file
Message-ID: <20240531112753.GD428814@coredump.intra.peff.net>
References: <20240531112433.GA428583@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240531112433.GA428583@coredump.intra.peff.net>

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
2.45.1.727.ge984192922

