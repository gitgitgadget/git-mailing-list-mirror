Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF18712FB37
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723882946; cv=none; b=KS9UxIOVsniOND23XlKHDzKuoEbQ0C9WspRrt0D0G+0AmVqK38LUvhT27tq04Zy1U0OKiq8+ULyyAfGFFocagOjDH7LKzWnHer1Vk/bhqyZR1Yhvie0uEibRqxgwI0j8Uez0iZt6YUNXgAyLbVbccDuO8W8YWt6WaEBa6WZVOpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723882946; c=relaxed/simple;
	bh=bT1Q/yoNzwMVG4uBHGXHgjmUee4G59zWxiNumrk9P6I=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/3H+W0IpU4RkX0XdYERUS3afg6GXts9EI2vc9XGuDCWLCo2u3WLY2MmxUoyAaDBD650vJ/xxY+STG7ojPJHMu3pyEuex7PpKlrwakwosogfjaGM5KgbZ8O2sPSXB6ks5iRMOFw/ntlVu4IwpD4nJ1ABVnRoszVK8FLvLdkewTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24685 invoked by uid 109); 17 Aug 2024 08:22:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 08:22:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27941 invoked by uid 111); 17 Aug 2024 08:22:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 04:22:28 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 04:22:22 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 04/15] refs: mark unused parameters in
 do_for_each_reflog_helper()
Message-ID: <20240817082222.GD10287@coredump.intra.peff.net>
References: <20240817082101.GA6761@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240817082101.GA6761@coredump.intra.peff.net>

This is an each_ref_fn callback, so it has to match that interface. We
marked most of these in 63e14ee2d6 (refs: mark unused each_ref_fn
parameters, 2022-08-19), but in this case:

  - this function was created in 31f898397b (refs: drop unused params
    from the reflog iterator callback, 2024-02-21), and most of the
    arguments were correctly mark as UNUSED, but "flags" was missed.

  - commit e8207717f1 (refs: add referent to each_ref_fn, 2024-08-09)
    added a new argument to the each_ref_fn callback. In most callbacks
    it added an UNUSED annotation, but it missed one case.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 74de3d3009..584674520e 100644
--- a/refs.c
+++ b/refs.c
@@ -2390,9 +2390,10 @@ struct do_for_each_reflog_help {
 	void *cb_data;
 };
 
-static int do_for_each_reflog_helper(const char *refname, const char *referent,
+static int do_for_each_reflog_helper(const char *refname,
+				     const char *referent UNUSED,
 				     const struct object_id *oid UNUSED,
-				     int flags,
+				     int flags UNUSED,
 				     void *cb_data)
 {
 	struct do_for_each_reflog_help *hp = cb_data;
-- 
2.46.0.585.gd6679c16d8

