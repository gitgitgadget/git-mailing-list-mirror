Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868E830F93D
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774468557; cv=pass; b=m/tzy8BKfN9hR0Wz57WpEdjFE3sElIMA0E0ZzBeBQuiGiuBjPMCaZvTfHPWlICHqXXSZjFA8MzV4HIoDw0MM/pUIYK4nb+RSdO3KtbXtAkNV7ioYvS3fP5agvlxeabWEyDQKtSdndLISUZI2mE/SXMSfDIhbqvCZyKL03DldK9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774468557; c=relaxed/simple;
	bh=Lg2WK97cEjxZBBoL5VRXWTPKcH49VDIA+vKNVEdHx3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMruECtygSidR57VLxejbs5FR0rbnKAn0PEwhBwhUE87brGCSsUibcum3+BP+r0A7u8lXbl0tO61n2EHW4geQGBaIWzO50dH/qDsszdHU1ugzmCqunHmeii59D9yFrrinBNjS3GEDNo63QbK37ROEN4Q+z3n+m1rLU/3Kz9YUgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=CizrreB1; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="CizrreB1"
ARC-Seal: i=1; a=rsa-sha256; t=1774468543; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=G3xYs+GNOIMo/Kqky4ZkwtEvtlx97+GEvnuytsoRIx7qg2Mfj8tOka01CBaAFQFQHr9P8cVV7A+nevNAAi/ZdFSfneDf2jzvEsbFEbX80A+/4ygk9qLyau2trpu3X+zf2sJe2bZ1QGdzneAvbKj93WvhDpnxqYs05scGR204NME=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774468543; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=glVhIRqpoUFoeopg5sky6ng+YheT240Vr4rTFVEnHyk=; 
	b=IJ2XODVKHvauEhKmY0pG/Zr+azvK7qRdrrDXonm5lzsN++fLijCefpXR0fHGrXHHwYIakj3KSKoDT5IbJywiMNSdczlGSZSzp+n77vr4W5N8PMEbUqnxSigZGrRn47n6KrA8JJVJHlsvE1cWMne1s71VxOHunheZj3zKqY7UTU4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774468543;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=glVhIRqpoUFoeopg5sky6ng+YheT240Vr4rTFVEnHyk=;
	b=CizrreB1dPBY7oR4LR33W75mlMAIzg8dsboHVEzRCLr9xLUJ2Q3QdTh/wYuWuLSA
	7B1ocGfBNNIbFUz40Nsv4+/NvgL3TQ2h0BR0G+ZbilG0IAYzjkyZwib3TAENfSbJm+W
	7WVMMSDijgvzecKJmweuKheRglQD3hr4v943O/RM=
Received: by mx.zohomail.com with SMTPS id 1774468541720565.2405159088335;
	Wed, 25 Mar 2026 12:55:41 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 02/12] builtin/receive-pack: properly init receive_hook strbuf
Date: Wed, 25 Mar 2026 21:54:53 +0200
Message-ID: <20260325195503.1139418-3-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260325195503.1139418-1-adrian.ratiu@collabora.com>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260325195503.1139418-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The run_receive_hook() stack-allocated `struct receive_hook_feed_state`
is a template with initial values for child states allocated on the heap
for each hook process, by calling receive_hook_feed_state_alloc() when
spinning up each hook child.

All these values are already initialized to zero, however I forgot to
properly initialize the strbuf, which I left NULL.

This is more of a code cleanup because in practice it has no effect,
the states used by the children are always initialized, however it's
good to fix in case someone ends up accidentally dereferencing the NULL
pointer in the future.

Reported-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/receive-pack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e34edff406..a1ffe4570f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -963,6 +963,7 @@ static int run_receive_hook(struct command *commands,
 	/* set up stdin callback */
 	feed_init_state.cmd = commands;
 	feed_init_state.skip_broken = skip_broken;
+	strbuf_init(&feed_init_state.buf, 0);
 	opt.feed_pipe_ctx = &feed_init_state;
 	opt.feed_pipe = feed_receive_hook_cb;
 	opt.feed_pipe_cb_data_alloc = receive_hook_feed_state_alloc;
-- 
2.52.0.732.gb351b5166d.dirty

