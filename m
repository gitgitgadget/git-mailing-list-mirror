Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A9A1863F
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378985; cv=none; b=ZHDfZ71/4Hd1tivLw6GPdhYbW7vzqgFvyfDj9/8t62pGv3b7ypoJsvhqEXKNpY/4TpOwBLmFDUxBRIpGIeLNOXwCRtAYSJqHcpiVo4P+OFfl94e3NsW7njPckKewGlVTAiGVlFy4RfQbwV7W/enY8FLyzJzHYvvrqWIfTQn3KWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378985; c=relaxed/simple;
	bh=rmx5PhbYobdDWAXNGp0JUMblTdX6Pzq3nWsOFFzpilQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kKrZK4kP3ED8LPrhKaJs0dmztJr0N0gJcBYGsGZzsHuoTHKOlTpXAaJFODEErpIF4h+ZTEVOeh5avfFKr7nt2L4VreD2/sPfK+AlMzaijoMpKx78pXXJH3trbnqKxwKdO6gqlAeTD6U58lOiuzbiwTIZXmB84cPfmOgswytY2GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20204 invoked by uid 109); 29 Apr 2024 08:23:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Apr 2024 08:23:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26846 invoked by uid 111); 29 Apr 2024 08:23:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Apr 2024 04:23:07 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 29 Apr 2024 04:23:02 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 4/8] refs: disallow dash in pseudoref syntax
Message-ID: <20240429082302.GC233423@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Our is_pseudoref_syntax() function allows upper-case letters, underscore
("_") and dash ("-"). Our glossary definition is vague on the allowed
punctuation, but I don't think we have ever used a pseudoref with
anything but an underscore. And the existing open-coded syntax check in
refname_is_safe() allows only underscores.

The logic comes from 266b18273a (refs: add ref_type function,
2015-07-31), but I couldn't find any comment on the dash in the commit
message or the list discussion. It's used mostly for is_pseudoref(),
which further requires that the name either end in "_HEAD" or be one of
a specific set of "irregular" pseudorefs.

So I don't think we'd ever see a dash in the real world (you'd need
to have "FOO-BAR_HEAD"). Let's tighten this up now so that the function
is consistent with (and can be used in) other spots.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index d3d21ecd43..b202dca904 100644
--- a/refs.c
+++ b/refs.c
@@ -169,7 +169,7 @@ static int is_pseudoref_syntax(const char *refname)
 	const char *c;
 
 	for (c = refname; *c; c++) {
-		if (!isupper(*c) && *c != '-' && *c != '_')
+		if (!isupper(*c) && *c != '_')
 			return 0;
 	}
 
-- 
2.45.0.rc1.416.gbe2a76c799

