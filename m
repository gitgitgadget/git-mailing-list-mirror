Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8136035F8A8
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 04:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103304; cv=none; b=Bwzz2OtqJFS1CoVy4Qtk1aLHnHuxBElEkDIXwugevP/HVuS+tK7Mk01wfJlXz7KPxfCb/O1Lo+D85QitO2WodfCZG53zlK9jWmiDe84/+Z9Jhr2fnAteS/1SV2Xz4qcqqeatDP8BQp3AKlzI7Bgf8vcVDdobT48ZxdFYdZ+JlEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103304; c=relaxed/simple;
	bh=AUVVV/lSGbMOL6gxWYEb69WoxpNn92YznQzXtZaF0dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1LdpopajMTQXlNwaOgNA+kgDyqIAIlMNBUQqydbMG8h7Nqi5G1MdpDEBrwmF33OCXcPNHg/aHmpdWItecyNjZ2JgFqjAXIXPF5dIGf/cgZijE9KA9Kix6J8tIiOqofxS8ZLdftmmy1AyExI/uOxDqkyM/UgD61NxqcLL4sJvgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TSgFnFpM; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TSgFnFpM"
Received: (qmail 218838 invoked by uid 106); 2 Apr 2026 04:15:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=AUVVV/lSGbMOL6gxWYEb69WoxpNn92YznQzXtZaF0dU=; b=TSgFnFpMzDNVldvnK0lQQ6SpRqWLmPo+Gf/wJPaRP7Enp27lgifcG+VcvZ85jvFnjHqK1BHfwfrmnnIZViAPFWf6ypnA6JECLGfgcKF8TxBkdUsgMRkzlvA8eftXlwDtItsTLDTAwuIiYpbKpHYjCiJSeB5j8NXwRzGLMIZoJGm4kgTWgapyoec+ehCA5ud6WG0OK2BjKguiOxFy8lZXxwyslgY0P5Q8uA/CFENhsZhzZTxb8C6Wd3e/VFB5102KIMF1LjmVd3vmQJKJZ82ShBgvgZ+0UPqG9cW3n9glm6SSmyYan9w22FanK1ZAlTh4g/tkKLMMTyv5V8hkXgL/Hg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Apr 2026 04:15:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 349738 invoked by uid 111); 2 Apr 2026 04:15:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Apr 2026 00:15:01 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Apr 2026 00:15:01 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Collin Funk <collin.funk1@gmail.com>,
	Michael J Gruber <git@grubix.eu>
Subject: [PATCH v2 05/12] run-command: explicitly cast away constness when
 assigning to void
Message-ID: <20260402041501.GE3501239@coredump.intra.peff.net>
References: <20260402041433.GA3501120@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402041433.GA3501120@coredump.intra.peff.net>

We do this:

  char *equals = strchr(*e, '=');

which implicitly removes the constness from "*e" and cause the compiler
to complain. We never write to "equals", but later assign it to a
string_list util field, which is defined as non-const "void *".

We have to cast somewhere, but doing so at the assignment to util is the
least-bad place, since that is the source of the confusion. Sadly we are
still open to accidentally writing to the string via the util pointer,
but that is the cost of using void pointers, which lose all type
information.

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index 32c290ee6a..d6980c79b3 100644
--- a/run-command.c
+++ b/run-command.c
@@ -604,11 +604,11 @@ static void trace_add_env(struct strbuf *dst, const char *const *deltaenv)
 	/* Last one wins, see run-command.c:prep_childenv() for context */
 	for (e = deltaenv; e && *e; e++) {
 		struct strbuf key = STRBUF_INIT;
-		char *equals = strchr(*e, '=');
+		const char *equals = strchr(*e, '=');
 
 		if (equals) {
 			strbuf_add(&key, *e, equals - *e);
-			string_list_insert(&envs, key.buf)->util = equals + 1;
+			string_list_insert(&envs, key.buf)->util = (void *)(equals + 1);
 		} else {
 			string_list_insert(&envs, *e)->util = NULL;
 		}
-- 
2.53.0.1172.ge9e20b5838

