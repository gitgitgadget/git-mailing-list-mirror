Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EE637A3C7
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765036; cv=none; b=s6m6gwQJEANpI/AsT4qvhn4OlWvc98L23QBpzXkwsiYTlshhJDMjw2R61oElROV2E3LUS24kelPljbIR6fKl+8yuPE0+cDY3yomwDseCjntcER8+UgMajU7qG7VUQxSJsF2KBdssgj7podO/QinhVsltxAsR5y4ngJqh67LgvrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765036; c=relaxed/simple;
	bh=Uq8L8yTGINOy+1AmITh6QnBEHEu7QGGQJLbNWhU1sF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Av7afiF/4Qp6ONGhUuPSB3M9vE2PcCtwsEaDR+RSewhlBGzsOd15xjY5xrAtBMtYSFsN1afWYUUGexR+Muas99THr2GpqolEtyPwTetZ5UP2g84bERps0Su9xEAvPx2f8RSrUYNX9vbMOPSlS2so9RGRqnli7tKJuYNRzgRmZgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=E5fWwWyS; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="E5fWwWyS"
Received: (qmail 378502 invoked by uid 109); 29 Oct 2025 19:10:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Uq8L8yTGINOy+1AmITh6QnBEHEu7QGGQJLbNWhU1sF4=; b=E5fWwWySDK3wSmpjKBBEt2WhMfzT2M09RoeDNDbohwqUFmOoSCIUOos4JH1h36gXERLVqSxoP4aLVQ96NyhEnCsB7LEHthCwP45OvYvDAHRVD5xEUfzF9AwXRyonk5oB4wIT3FgsBiDJe85IG7NxpAlXNKIjsnYjsW1DnEcizL3nWZzIBVymyZWosCoKG7eN5y+riKmZP3C1ameSll8LH2yeD52BKmgJ0OXiNnmHLfAuKGRrAjE5k05+6VKNAK/jgCMeq2EOrGdYgkLWj63b+QTpBBT63ahOKpGct8S9FEzTOc9UZJ9/LU2o/3zMWmaOzswXF7bO1Is+y/ci0iUHPQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Oct 2025 19:10:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 587802 invoked by uid 111); 29 Oct 2025 19:10:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Oct 2025 15:10:31 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 29 Oct 2025 15:10:31 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: [PATCH] test-tool: fix leak in delete-gpgsig command
Message-ID: <20251029191031.GA1257596@coredump.intra.peff.net>
References: <xmqqh5vibpqg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh5vibpqg.fsf@gitster.g>

On Tue, Oct 28, 2025 at 03:55:51PM -0700, Junio C Hamano wrote:

> * tz/test-prepare-gnupghome (2024-07-03) 2 commits
>  - t/lib-gpg: call prepare_gnupghome() in GPG2 prereq
>  - t/lib-gpg: add prepare_gnupghome() to create GNUPGHOME dir
> 
>  Tests did not set up GNUPGHOME correctly, which is fixed but some
>  flaky tests are exposed in t1016, which needs to be addressed
>  before this topic can move forward.
> 
>  Will merge to 'next'.
>  cf. <ZoV8b2RvYxLOotSJ@teonanacatl.net>
>  cf. <xmqqbjlump3m.fsf@gitster.g>
>  cf. <87frb310d2.fsf_-_@email.froward.int.ebiederm.org>
>  source: <20240703153738.916469-1-tmz@pobox.com>

I noticed jch failing CI. I think we want this on top:

-- >8 --
Subject: [PATCH] test-tool: fix leak in delete-gpgsig command

We read the input into a strbuf, so we must free it. Without this, t1016
complains in SANITIZE=leak mode.

The bug was introduced in 7673ecd2dc (t1016-compatObjectFormat: add
tests to verify the conversion between objects, 2023-10-01). But nobody
seems to have noticed, probably because CI did not run these tests until
the fix in 6cd8369ef3 (t/lib-gpg: call prepare_gnupghome() in GPG2
prereq, 2024-07-03).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-delete-gpgsig.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-delete-gpgsig.c b/t/helper/test-delete-gpgsig.c
index e36831af03..658c7a37f7 100644
--- a/t/helper/test-delete-gpgsig.c
+++ b/t/helper/test-delete-gpgsig.c
@@ -23,8 +23,7 @@ int cmd__delete_gpgsig(int argc, const char **argv)
 	if (!strcmp(pattern, "trailer")) {
 		size_t payload_size = parse_signed_buffer(buf.buf, buf.len);
 		fwrite(buf.buf, 1, payload_size, stdout);
-		fflush(stdout);
-		return 0;
+		goto out;
 	}
 
 	bufptr = buf.buf;
@@ -56,7 +55,9 @@ int cmd__delete_gpgsig(int argc, const char **argv)
 		fwrite(bufptr, 1, (eol - bufptr) + 1, stdout);
 		bufptr = eol + 1;
 	}
-	fflush(stdout);
 
+out:
+	fflush(stdout);
+	strbuf_release(&buf);
 	return 0;
 }
-- 
2.51.2.833.g5cd7b514cb

