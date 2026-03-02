Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C21199FBA
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 03:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772421681; cv=none; b=lERwojATjQ9o0LRcnErLr8vV44rIE4YhzO4K1UrJOqpi5ZQSm+dzS9Qn1WsZzN0BlfJUv3V/YKdnkg+wdXZ/HERelhzfWhYu55/w3EtIvCWjg/tj4GEO0BmRDe/XCtNlSlGlD9wV2IIf3sbVH+VtddDmp9cICBeO5arDb456nXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772421681; c=relaxed/simple;
	bh=3b+qoSCza6KDt6e5gLAniXzAIKAq13rCF5aDe2azTFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hco0/sCkv7paUNvkU+r8uu4146lWKuBts0UmZ0o4qdkonL8yevq6+pscHedlONDlxOdi/nC5ZIAZeHMr5iuza1oCm2j1n2/xS9E4k+DfzszbqszKwjEDjE8gkTBwqOfcLDY1N8kowkBezJSIYF8mmEvz5CdJgD1ZDGurlow53+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=jXjHHSGi; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="jXjHHSGi"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 16B1B1D490;
	Mon,  2 Mar 2026 03:21:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 16B1B1D490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1772421672; bh=3b+qoSCza6KDt6e5gLAniXzAIKAq13rCF5aDe2azTFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jXjHHSGiYaMFsSYiiG81WNQ1c4RhVZGFcCCvNlebK3hrgk7JbGVmovHM2mnT1vxD4
	 /sHuFuh2szeW5vuWyN0VaAcBZCPbH94fgb4dFIbOGtkdDr1jH1ZMDsq286oGheYN/6
	 okPRu8D0VPZFIhXHgApGMsyVYBZedExPuOKWT+sU=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id TNW0LCcCpWl8sAAA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Mon, 02 Mar 2026 03:21:11 +0000
From: David Timber <dxdt@dev.snart.me>
To: git@vger.kernel.org
Cc: David Timber <dxdt@dev.snart.me>
Subject: [PATCH v2 0/1] send-email: add client certificate options
Date: Mon,  2 Mar 2026 12:16:40 +0900
Message-ID: <20260302032048.260209-1-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
In-Reply-To: <xmqqo6lb4fuy.fsf@gitster.g>
References: <xmqqo6lb4fuy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm sorry that I missed last week's submission deadline.

On 2/21/26 01:35, Junio C Hamano wrote:
> Shouldn't there be a word "require" somewhere in the above to
> clarify why a user may want to use this option?  A server may
> optionally verify a certificate only when it is given one, but if it
> lets us do what we want without such verification, we do not have
> much incentive to give them a certificate.

RFC 8446 section 4.3.2:
> The client MUST send a Certificate message if and only if the server
> has requested client authentication via a CertificateRequest message
> (Section 4.3.2).

In other words, the client won't send its cert to the server unless
requested by the server. So, the client presenting its cert to the
server in the client hello from the get-go is in violation of this
requirement. I reflected that in the reroll.

Also, removed the `$ret{SSL_use_cert} = 1;` line in the code to be in
line with the requirement. That line was confusing and unnecessary in
the first place. Whether to use a client cert or not should be up to
the underlying implementation to decide.

Removed the whole PKCS#12 vs PEM debacle in the change as I reckon it's
a behaviour that could change overnight without a warning. Feels kind
of defensive, but a reasonable change all things considered. Users
affected by such library behaviour change can always refer to the
manual.

David Timber (1):
  send-email: add client certificate options

 Documentation/config/sendemail.adoc | 16 ++++++++++
 Documentation/git-send-email.adoc   | 19 ++++++++++++
 git-send-email.perl                 | 47 ++++++++++++++++++++++-------
 3 files changed, 71 insertions(+), 11 deletions(-)

-- 
2.53.0.1.ga224b40d3f.dirty

