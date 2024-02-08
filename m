Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE8F67C40
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 05:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707370147; cv=none; b=XkUhzo9g3xWnFgJdsXK4l37ekDwZFgH69P4n5ZFtD/eip5enZzESRmq3wRJqqcF3SrDDjv/y+B4dMYpATFTymMng6IzQuNYMTG1MfGs61iLNwil8iwTTq8Z5fZQmMexXLZi8+glXOSq902IUt6GUgwiLi2e/3eQ/9/Utx3Mcrbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707370147; c=relaxed/simple;
	bh=1bbhiFgT1gTISA/hJCqV30EebBmiEILja75rblYWf2U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ns0jvfuxco1oy7XeL1kHIZy0yhfNfU68aXbSLtKpPKn+h1KukmnAdgoGABL7LSH7X+MWNw0HPm1eUfrjlVQ7LyUQJClwiSKxn6fY6gm4GSgbTSlAM8jcNXH+RHgzIWL71+PsqvBT5cA6pmHqUFNKNVF3pGxF1rxMGUulzyWoGJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LyF7CqLN; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LyF7CqLN"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6EDBD32362;
	Thu,  8 Feb 2024 00:29:05 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1bbhiFgT1gTISA/hJCqV30EebBmiEILja75rbl
	YWf2U=; b=LyF7CqLNDMXPTkKZURpYGdaN57kGRs6HOIzCgbVeKxq8dwhQs7iOV+
	BJj7nX1X1lknMulo8BWU6NDYQNM9WEzVFNu+270r/nJ64j9v6kj+1TNz89NvOHLl
	fo9O+m7kFt91BjntAnhe4NE385WSRyNrR6N4FP4v1QmPlz4T6mCkQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 59BFF32361;
	Thu,  8 Feb 2024 00:29:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D72D83235F;
	Thu,  8 Feb 2024 00:29:01 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Sergey Kosukhin <skosukhin@gmail.com>
Subject: Re: [PATCH] tag: fix sign_buffer() call to create a signed tag
In-Reply-To: <xmqq5xyzr6tm.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	07 Feb 2024 19:08:37 -0800")
References: <xmqq4jek9ko1.fsf@gitster.g>
	<20240208004757.GA1059751@coredump.intra.peff.net>
	<xmqq5xyzr6tm.fsf@gitster.g>
Date: Wed, 07 Feb 2024 21:29:00 -0800
Message-ID: <xmqqv86zplr7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F79508B2-C642-11EE-8A1C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> We could do belt and suspenders by tightening the other callers to
> only expect negative for errors (but then what should they do when
> they receive non-zero positive?  Should they BUG() out???) while
> teaching sign_buffer_ssh() that our convention is to return negative
> for an error, of course, but I am not sure if it that is worth it.

Actually, we could loosen the caller(s) while tightening the
callee(s), which is the more usual approach we would take in a
situation like this.  Here is what I am tempted to pile on top of
the patch.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] ssh signing: signal an error with a negative return value

The other backend for the sign_buffer() function followed our usual
"an error is signalled with a negative return" convention, but the
SSH signer did not.  Even though we already fixed the caller that
assumed only a negative return value is an error, tighten the callee
to signal an error with a negative return as well.  This way, the
callees will be strict on what they produce, while the callers will
be lenient in what they accept.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 gpg-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 48f43c5a21..e19a69c400 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1088,7 +1088,7 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 		if (strstr(signer_stderr.buf, "usage:"))
 			error(_("ssh-keygen -Y sign is needed for ssh signing (available in openssh version 8.2p1+)"));
 
-		error("%s", signer_stderr.buf);
+		ret = error("%s", signer_stderr.buf);
 		goto out;
 	}
 
-- 
2.43.0-561-g235986be82

