Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB0F381B0
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 05:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706593139; cv=none; b=epxJG3sbh4ofb7vdaJE/vqTtXocny/QxlK+IRUDa+CMLl4/ToiD9gCmut1lzkGw02Hbem8HS4MgU1hjzjMqBiMzBCzaNXNxoneq9veAf81qlk18nHOYG8kFBqYnx+4FMZ27rICVH4vFchUmUVRtH3KMD/DEzOmxh1XddRHabGWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706593139; c=relaxed/simple;
	bh=sSpjyuAa8PT163VefM9hMO+wlS12osGa26NgGbu6pN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0lbQUMed7wju2QK/e9RO2N7pVsmUBVc1bcvAplwrYFqIGZ+BW2LieSkFi2awni/Oeqi4EB7JeQwaJO5Z/i4k8+gsPk9+jftEkkSWnP7TvzYgqLVFVAjqcKiIy7oITzvzLp7syTXHSRws7Wi5R9JpU0P3qZgdzaFcNBfu3Uvqu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8662 invoked by uid 109); 30 Jan 2024 05:38:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jan 2024 05:38:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29101 invoked by uid 111); 30 Jan 2024 05:38:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jan 2024 00:38:58 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jan 2024 00:38:56 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Adam Dinwoodie <adam@dinwoodie.org>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: [PATCH v2 2/3] Makefile: remove UNIT_TEST_BIN directory with "make
 clean"
Message-ID: <20240130053856.GB166699@coredump.intra.peff.net>
References: <20240130053714.GA165967@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240130053714.GA165967@coredump.intra.peff.net>

We remove $(UNIT_TEST_PROGS), but that leaves the automatically
generated "bin" dir they reside in. And once we start cleaning that,
there is no point in removing the individual programs, as they'll by
wiped out by the recurse "rm".

Signed-off-by: Jeff King <peff@peff.net>
---
The layout of the clean rule is kind of weird, in that we put only
sort-of related things together on their own $(RM) line. I suspect a lot
more of this could be lumped together, reducing the total number of
shells and rm invocations needed, but I guess nobody really cares that
much about the runtime cost of "make clean".

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 228f34a3fe..b5ae34ea7b 100644
--- a/Makefile
+++ b/Makefile
@@ -3680,14 +3680,14 @@ cocciclean:
 	$(RM) contrib/coccinelle/*.cocci.patch
 
 clean: profile-clean coverage-clean cocciclean
-	$(RM) -r .build
+	$(RM) -r .build $(UNIT_TEST_BIN)
 	$(RM) po/git.pot po/git-core.pot
 	$(RM) git.res
 	$(RM) $(OBJECTS)
 	$(RM) headless-git.o
 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
-	$(RM) $(TEST_PROGRAMS) $(UNIT_TEST_PROGS)
+	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
 	$(RM) $(SP_OBJ)
 	$(RM) $(HCC)
-- 
2.43.0.797.g29b680fc68

