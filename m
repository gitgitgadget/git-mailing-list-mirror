Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E6127FD48
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 05:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768800029; cv=none; b=iO3hHE6rMhE71JTgmSyq2PWdYigv5gQMea5GoGzRvUGXSoI52wGPIVyiXxDNzozt71vKIGiseVSJ8IhiUCygMSPCISP4w1wRa4U7TE13uUqlkODvN3aSm/pBGA3T4NDFDLhQQVVb9wgKc+WremG4hFqf1WzbJ6DdHn7pGlLLd00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768800029; c=relaxed/simple;
	bh=9KNuld+QhpPVeUvgdtcr+nmmI4LZwWP5QSTNKCWhanQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAqqtNgPepFt8OJhkl+LXXpHHq+w1YwvA0vQfXAlMlKuxto2eaOI6VIZotrzQd+JJDUZkKPiTd7rR33+Rp8mQhggU59WstUXVOC0Azb50g7MfKYLi/Eu49/GLOFPXB7WauRUE6Y9NLuGizyEloykNWetB07PNxYjsgwFlM3aCC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Sg5c950F; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Sg5c950F"
Received: (qmail 94401 invoked by uid 109); 19 Jan 2026 05:20:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=9KNuld+QhpPVeUvgdtcr+nmmI4LZwWP5QSTNKCWhanQ=; b=Sg5c950Fz8H+65vBIiTJw9C0x7DVov6XSMqOypoza12yhRgwcrttRHXQrywc+QC0kB2mZRqF54xwEtCXMFFuRjRmc2LAj20a5Gs61ZF7wie3HQcwe3f6plgLzusRS4dvGwEwjj2d9nij9hg6uLQPyadhDSytm63ZbtmAxryTjiuGzWiDE70c95Arefa86X345KrxLqk3IpO1uIu2y4j7VTwBeyhLcjZr5F+VhOCy/DsBOX4kjpfx1/INlaaLN3dg7D6Ag2OkAkUWIjFGV4MfM5CWpcXNTaR1LYfhfRXbukCx1/IyNT4iNxBnK8xY57Gj9MKDduyxReFsEfCgJbeZYg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 Jan 2026 05:20:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 153871 invoked by uid 111); 19 Jan 2026 05:20:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Jan 2026 00:20:30 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 19 Jan 2026 00:20:26 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH 2/4] remote: drop const return of tracking_for_push_dest()
Message-ID: <20260119052026.GB1991523@coredump.intra.peff.net>
References: <20260119051858.GA1991308@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119051858.GA1991308@coredump.intra.peff.net>

The string returned from tracking_for_push_dest() comes from
apply_refspec(), and thus is always an allocated string (or NULL). We
should return a non-const pointer so that the caller knows that
ownership of the string is being transferred.

This goes back to the function's origin in e291c75a95 (remote.c: add
branch_get_push, 2015-05-21). It never really mattered because our
return is just forwarded through branch_get_push_1(), which returns a
const string as part of an intentionally hacky memory management scheme
(see that commit for details).

As the first step of untangling that hackery, let's drop the extra const
from this helper function (and from the variables that store its
result). There should be no functional change (yet).

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index 3dc100be83..5de9619bc7 100644
--- a/remote.c
+++ b/remote.c
@@ -1869,9 +1869,9 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
 	return branch->merge[0]->dst;
 }
 
-static const char *tracking_for_push_dest(struct remote *remote,
-					  const char *refname,
-					  struct strbuf *err)
+static char *tracking_for_push_dest(struct remote *remote,
+				    const char *refname,
+				    struct strbuf *err)
 {
 	char *ret;
 
@@ -1899,7 +1899,7 @@ static const char *branch_get_push_1(struct repository *repo,
 
 	if (remote->push.nr) {
 		char *dst;
-		const char *ret;
+		char *ret;
 
 		dst = apply_refspecs(&remote->push, branch->refname);
 		if (!dst)
@@ -1929,7 +1929,8 @@ static const char *branch_get_push_1(struct repository *repo,
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
 		{
-			const char *up, *cur;
+			const char *up;
+			char *cur;
 
 			up = branch_get_upstream(branch, err);
 			if (!up)
-- 
2.53.0.rc0.338.g08aa8a9473

