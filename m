Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F4CD51A
	for <git@vger.kernel.org>; Mon, 13 May 2024 22:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715640095; cv=none; b=sU32CTevyrGt1P1w9y+C2aK4Mme342hcfOJ4HJQWorkBrSh2p0t01qy8W/z4ykZHMkeHmTjMadKWa5A+IDp3uSARsZ2yjOJbBW2CbQRMx9yQnsjrf9jn2KxcjQKIdUhZjU5XDCPcj8rWFPNvRJlvIZl0KeDRELU43IJo+8pwHAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715640095; c=relaxed/simple;
	bh=qL/6q3XsPo23rJAScgUM/+zlV4LSoIKaxjeSn9we2R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dL8vJpTcHk/ENeNQYHYO3npNFYdpZuk65iSK9BHvpUxavxYk/k1ndya9YTaceOx5f2N1y+eQNXXujvAb+CK3zNyJYAX+Bu+5+4gf9OcYsK5bqrfUqB2WlxE4WiYUVjISnSREiSw8smIeNkldXjqbCHpVvR/ROoGfRdjCCCSNTIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z6N0bOFX; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z6N0bOFX"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4015037B72;
	Mon, 13 May 2024 18:41:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qL/6q3XsPo23
	rJAScgUM/+zlV4LSoIKaxjeSn9we2R8=; b=Z6N0bOFXT5V7dZ4MyTEJ1tAio+EI
	xj88CUxgLeWk9ICffcPx17G21ijR44k4SLAZ5DLA1RXnTSqZVLitJFqwFW5WG3vM
	/Blw3wkGaO5Bqx4YZEMAlxHx6jIAvFDvXqCFbYq3Pmur4GIRwI6wlNgr2EcwkIyc
	FING8H4NGPOGQho=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 386C137B71;
	Mon, 13 May 2024 18:41:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9FD3E37B70;
	Mon, 13 May 2024 18:41:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/5] Fix use of uninitialized hash algorithms
Date: Mon, 13 May 2024 15:41:22 -0700
Message-ID: <20240513224127.2042052-1-gitster@pobox.com>
X-Mailer: git-send-email 2.45.0-145-g3e4a232f6e
In-Reply-To: <cover.1715582857.git.ps@pks.im>
References: <cover.1715582857.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID:
 EFFB0FFC-1179-11EF-BB1D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

In this round, the escape hatch is no longer the escape hatch, but
also serves as an end-user knob to specify what hash algorithm to
use when there is no repository to tell us which one to use.

We can see that Patrick's two fixes to patch-id and hash-object, as
well as my fix to apply, correct the breakage as the series
progresses.

Junio C Hamano (3):
  setup: add an escape hatch for "no more default hash algorithm" change
  t1517: test commands that are designed to be run outside repository
  apply: fix uninitialized hash function

Patrick Steinhardt (2):
  builtin/patch-id: fix uninitialized hash function
  builtin/hash-object: fix uninitialized hash function

 builtin/apply.c         |  4 +++
 builtin/hash-object.c   |  3 ++
 builtin/patch-id.c      | 13 +++++++++
 repository.c            | 32 +++++++++++++++++++++
 t/t1007-hash-object.sh  |  6 ++++
 t/t1517-outside-repo.sh | 64 +++++++++++++++++++++++++++++++++++++++++
 t/t4204-patch-id.sh     | 34 ++++++++++++++++++++++
 7 files changed, 156 insertions(+)
 create mode 100755 t/t1517-outside-repo.sh

--=20
2.45.0-145-g3e4a232f6e

