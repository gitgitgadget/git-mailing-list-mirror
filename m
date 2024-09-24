Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B488A42A8F
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215473; cv=none; b=kM+r0+rGteFnm/SBotjrniEo5BDy7Qg/l/tNdNm6E7+LDD1MlOkAx3B9qXidNOycO1L/oE9ghDJdHLpPYh+n1WwmdMhKTuHJ6+msJIiW2m4l3TP24eQu42rQu3ZoqLmTPMHlPx7iVTLfhP/KQLsgMEwc4M2TRtenvHxjQUGd1GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215473; c=relaxed/simple;
	bh=O4PVEIYSjjKMV+GBLyOZNCSDWsZPY9T3UEJvuinv1Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeXsjsRMqmzn5FgCnHJm3HldI4dfeyaawJ83Av8NvP3xNBSB6mGcz9VZ8fAsiyPyB28WDOfj9aNgIkJY0wa4bIIa7g+eRgke9cmgJS2YgdCnOJGqB6Vs/UraWp+bfiaj8cLi0tyCfWuvemal/b292yAiI8iImvn0hua2uz5ykN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15570 invoked by uid 109); 24 Sep 2024 22:04:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 22:04:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18745 invoked by uid 111); 24 Sep 2024 22:04:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 18:04:30 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 18:04:30 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 19/28] http-push: clear refspecs before exiting
Message-ID: <20240924220430.GS1143820@coredump.intra.peff.net>
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

We parse the command-line arguments into a refspec struct, but we never
free them. We should do so before exiting to avoid triggering the
leak-checker.

This triggers in t5540 many times (basically every invocation of
http-push).

Signed-off-by: Jeff King <peff@peff.net>
---
 http-push.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/http-push.c b/http-push.c
index 7196ffa525..f60b2ceba5 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1983,5 +1983,7 @@ int cmd_main(int argc, const char **argv)
 		request = next_request;
 	}
 
+	refspec_clear(&rs);
+
 	return rc;
 }
-- 
2.46.2.1011.gf1f9323e02

