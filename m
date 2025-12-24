Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC72430DEAD
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766595817; cv=none; b=W50mIyVnVYzfZ9ULdAeleHJjRofd/qN4UAjM9iZO1xH939SSRqhQyg89TykxYRDJkN5LhscHw4UHF7Z0Wk23e/imWY2uT4Z6kS543cPPOVhA8X2VrvRpMotmk6EXpHIJZLP4ZJbcjkKqSLW3DXMCtfUD1O6Ltcau/XxHyjZraT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766595817; c=relaxed/simple;
	bh=FvJ3BCcoKIwkgQLW3caf3s+270L10cFs/PEnrloQpzM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BjO0+Vu5SJBloVv5HMvWCCTDIEArIoC1XlU9dtfUatHL14n5yDLHwUQqipMnOwoKBF1XAGchEEdgq8YYWNC0O5PGD8E0FLdEBwsM5fZxsq2Z0O0ZOE6ILiHlhR8RH+qmoUz8dIO4Aj20e3alyQlofT3+KXeTvdhtzQdS0xvhwUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Dl3SX6xL; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Dl3SX6xL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766595809; x=1767200609; i=l.s.r@web.de;
	bh=eo0fdjDuhPoqwkR6w29vTwik78ZWsOFTglywIXJB8io=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Dl3SX6xLoYzJtvCbAKb6KW71vLFDJhMUFmMwd7mda+d5YcspH0tMP6RXCG7HzC1G
	 5VZVU1+jWvrbLihTinvwMEBlFswChgusMXcfsPoGxNn/UptogV/RME1YoSWBljUkQ
	 4MX0pfFkeqICbcbX6wfq8NJu4QaeAnFn+uXCKzYjj9ASmMZja9Yto/zgE8y59MOWo
	 p2PqdoDb0TDcEC/UpIEYhP4bPKkJOqnCIMBN25veI3LMif0SfFeHgQM6WtQwTepJm
	 CsajvFFCqJEWcvhF138k4PsBC4eTFxPJTNwpE8aLIAUxHqhKzyIrMHkbW9gEYmv71
	 6/1x8IG317jxk4dRQA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.30.2]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MECGX-1vgSc02ECL-008xXi for <git@vger.kernel.org>; Wed, 24 Dec 2025 18:03:29
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 12/14] commit: add commit_stack_grow()
Date: Wed, 24 Dec 2025 18:03:25 +0100
Message-ID: <20251224170327.68049-13-l.s.r@web.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224170327.68049-1-l.s.r@web.de>
References: <20251224170327.68049-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HwWB9eHWMKxeFvVR5cU064FHmRCKfi+pEbvFRgbYslt6fArhLyV
 YaOW7TNOAofQfUAp0wGRnyPKd3b9ImRYzgSTj6pz/Pf+2n0L3trgErk3MGdLbshR8wsVjX1
 xsax8oRbB0943IPZ9YhHza4Iu9u6W69yHdRerb5HmVYFxtdPET2VSCtCr2xjGaKf6jLb1jg
 PNpvLtjh5wEMBc493qInQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wKh6Bq0HLcY=;V0YFs574DmjhW+oQvhP0ibAKOt7
 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

Add a function for increasing the capacity of a commit_stack.  It is
useful for reducing reallocations when the target size is known in
advance.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 commit.c | 7 ++++++-
 commit.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 55b1c8d2f8..28bb5ce029 100644
=2D-- a/commit.c
+++ b/commit.c
@@ -1988,9 +1988,14 @@ void commit_stack_init(struct commit_stack *stack)
 	stack->nr =3D stack->alloc =3D 0;
 }
=20
+void commit_stack_grow(struct commit_stack *stack, size_t extra)
+{
+	ALLOC_GROW(stack->items, st_add(stack->nr, extra), stack->alloc);
+}
+
 void commit_stack_push(struct commit_stack *stack, struct commit *commit)
 {
-	ALLOC_GROW(stack->items, stack->nr + 1, stack->alloc);
+	commit_stack_grow(stack, 1);
 	stack->items[stack->nr++] =3D commit;
 }
=20
diff --git a/commit.h b/commit.h
index 7c01a76425..79a761c37d 100644
=2D-- a/commit.h
+++ b/commit.h
@@ -388,6 +388,7 @@ struct commit_stack {
 #define COMMIT_STACK_INIT { 0 }
=20
 void commit_stack_init(struct commit_stack *);
+void commit_stack_grow(struct commit_stack *, size_t);
 void commit_stack_push(struct commit_stack *, struct commit *);
 struct commit *commit_stack_pop(struct commit_stack *);
 void commit_stack_clear(struct commit_stack *);
=2D-=20
2.52.0

