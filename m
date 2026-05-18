Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650993932F9
	for <git@vger.kernel.org>; Mon, 18 May 2026 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135922; cv=none; b=tFwlz1IDtgoCq59fdO2kbsX8ecXAkaJyLb+i67COOdy8bPpOXDG7dKS/GftCoBQOfRHrqUrHEj8Pe85wxp53ZnG2KH/Apga/TIEox4yxfCicPFznPzIvtc2OqBJTgz97oexaD5c34lZPJVNZsDpBUle6Co0w+8lac+S5T7tKt+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135922; c=relaxed/simple;
	bh=lr59gU1TaipUJ1IxAAGtAczXU1CA0JlaC/nM8lKntYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+/sn1csZtGthap8Fcyb16hSdL1VD+S+K3PkV+VLYgLXY9R2CH2AxW0EPyUj+EgyZa82+LUSxqlU5bPGqB4V0BSK6+G3wpwvQmScYT0zp3bqkDnK6MnundjQxL7D03ONTFBzkA/3cFu7KFYn99OvxK8vWoUYpl0bux+LYKFDPoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=waVGWu+0; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="waVGWu+0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1779135908; x=1779740708; i=l.s.r@web.de;
	bh=i+BhiVy4mkKRne3GVEZWP0rRm3V4JKkGwL1CvX6ydVA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=waVGWu+0Q5woLPa+R/d5d1mbvy9WpwnyDsT8BGBstkALQnldYw8ZEuDHGpnmNpp5
	 74lg9a2nXXUIRUZDkv05AotdujfMvQA3oxJG77ZexGUNSYaEpckK7IU3qqdIyow20
	 ndxsbPRpugAcDZQEqe666P40AguVPedBs8eafasZxoKtrobYui1Hub4AIcdhjuLIw
	 VMksQpaEr2LonnGrJjyTGATX7+F9VHPb5ARPUubxOQcC9j39gi7/mjLHyERA5vGAG
	 rDkYQrfGNqFPsalZyX3T/GLa+94/+uTYRIr6YIb05QpEmrXUrt2DmWnGk/cArXon9
	 Xv+y2qhrUCCQU2vqyQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiMEM-1x3KxW02li-00k9PZ; Mon, 18
 May 2026 22:25:08 +0200
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] strbuf: use st_add3() in strbuf_grow()
Date: Mon, 18 May 2026 22:25:01 +0200
Message-ID: <20260518202502.25682-2-l.s.r@web.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518202502.25682-1-l.s.r@web.de>
References: <c6e9b337-c4fc-4cbd-ac32-e8d3814749b0@web.de>
 <20260518202502.25682-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uPpcHlnDvDczpsfBmt7QCqkL/gUv0M4RdV8X2f8sYi3cnzztkgw
 gAH6Qij8leZfM9OA/IWvPqq7nrEUTiwxd1bdi3OrDlbh3vudB2xu/KTHS3zd1FCrNnyCaUH
 dEtn1cIzeCf5elSrMol8DZluZh54jsGIVMk6g09hh27kzzHV2d3j+f6UBtDNrdOZmoW9BkB
 LwjMMGgrlcM6y+LWHzG1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5rBUohsyJeY=;CO+khzMIGu3nsir0dt3nDYvVMH6
 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

Simplify the code by calling st_add3() to do overflow checks instead of
open-coding it.  This changes the error message to include the offending
summands, which can be helpful when tracking down the cause.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 strbuf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 3e04addc22..8610965d53 100644
=2D-- a/strbuf.c
+++ b/strbuf.c
@@ -106,12 +106,10 @@ void strbuf_attach(struct strbuf *sb, void *buf, siz=
e_t len, size_t alloc)
 void strbuf_grow(struct strbuf *sb, size_t extra)
 {
 	int new_buf =3D !sb->alloc;
-	if (unsigned_add_overflows(extra, 1) ||
-	    unsigned_add_overflows(sb->len, extra + 1))
-		die("you want to use way too much memory");
+	size_t new_len =3D st_add3(sb->len, extra, 1);
 	if (new_buf)
 		sb->buf =3D NULL;
-	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
+	ALLOC_GROW(sb->buf, new_len, sb->alloc);
 	if (new_buf)
 		sb->buf[0] =3D '\0';
 }
=2D-=20
2.54.0

