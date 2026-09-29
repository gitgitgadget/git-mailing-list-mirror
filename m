Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D6F3BE632
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 05:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790658778; cv=none; b=i0WgnyGkRiBkzrVy/+cCXKkjFu9VutH0fEx3Blgi1jqaqzHK4Y4DUh7q9oCR0EkgEpIhz77rlBdsxWejiImaOQg058mFWhX8WmH1Co9o7vteabtXi17Bn/eBxr9VclFT+xsvlimiEpjTK1+boHyNZ81MgrIzgp1aoOlzY/Hnsd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790658778; c=relaxed/simple;
	bh=g9JGKpiarTe3kDis+GVkEDtzmDaeQR1sdf5aEPRNGpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jc+CVGWSkVoS9KMuQ7ddavF2wlyc5V8rXpfAFrwolb7M3uI81DaEQP2p79Blruu1uUsuuX9MESQ3JBDWiKLklJaX5tjSGnUa4J6oJYGsre3e0YTYvteSj6LCyN6KO1cR0sKHRWF+zK3eOKmDKCfYxx1tRKVrYSfiynFBiVT9YSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MrA+pHYU; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MrA+pHYU"
Received: (qmail 69132 invoked by uid 106); 29 Sep 2026 05:12:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=g9JGKpiarTe3kDis+GVkEDtzmDaeQR1sdf5aEPRNGpw=; b=MrA+pHYU4HGCB7+CZiAW/Ja/4U9ezPaRxX54zM4nwOSKsienRkg2JfPMEqu7ks+p4uQ6sDhet81aIW+6Sv+IMbHe70jQxUHSMlpYuerMfxfn2qFloa1iaAHIukN0ZklRCLKCSrC6yAD/0dyqEbgpXZQzjL0q+z3H6aHME4FcKsUBDBJ9Ko5ySErkgArVdE65EjMnKdFLipbQhYLSA4Rvx40jY+m4lmJH6mFipN7rJbHcjT+jaOIS4HvpZw0k+8/UYbCgvkpBr9zxyr//loCbOzKAjFWWG7OQp3dAd9m7xI2MvvD0UosIV5jJ2AN6cbQe2BKr/wFXBsW7v+eKDIwlPw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Sep 2026 05:12:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 288266 invoked by uid 111); 29 Sep 2026 05:12:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Sep 2026 01:12:55 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Sep 2026 01:12:54 -0400
From: Jeff King <peff@peff.net>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: git@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
	Elijah Newren <newren@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 1/2] merge-ll: catch close() errors when writing external
 tempfiles
Message-ID: <20260929051254.GA1100669@coredump.intra.peff.net>
References: <20260929051200.GA1100000@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929051200.GA1100000@coredump.intra.peff.net>

When writing out tempfiles for an external merge driver, we catch the
case that write() fails, but not the follow-up close(). This close()
would usually succeed, but the system could report a delayed write error
(e.g., on a network file system).

Since we're adding a new error message here, we'll also make the
existing one match it: mark it for translation and mention the actual
path. The exact wording here was picked to match some existing
translated messages.

Signed-off-by: Jeff King <peff@peff.net>
---
Since v2, this is hopefully written in a more obviously-correct way,
rather than the short-circuit OR.

 merge-ll.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/merge-ll.c b/merge-ll.c
index ef5287dee8..62d402199d 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -181,8 +181,9 @@ static void create_temp(mmfile_t *src, char *path, size_t len)
 	xsnprintf(path, len, ".merge_file_XXXXXX");
 	fd = xmkstemp(path);
 	if (write_in_full(fd, src->ptr, src->size) < 0)
-		die_errno("unable to write temp-file");
-	close(fd);
+		die_errno(_("unable to write %s"), path);
+	if (close(fd) < 0)
+		die_errno(_("unable to close %s"), path);
 }
 
 /*
-- 
2.56.0.rc2.338.gcaacf6bdf7

