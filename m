Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A71405C1
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709406245; cv=none; b=MgvjmQzJ8HQxJhV7XepYzTzLxhZoIxRagZiUgaxLC2vrWjofUnFBAgn192CBemiYtpcSQ+sgTHlmAbieXVk9BUchEigTrNVAuhmaZTbKavpAOB5nlGg9Rz5RhVk4Vf0Y2CldMIp/6RV5y/oX1BDxVW6lqX8+0cgNhNj/TUsPhBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709406245; c=relaxed/simple;
	bh=CwQVLntrmP1QgaXyDDBt9GN1JKuKD6IDErSQMiU3Lrg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrPzxviHjxIaD/WC3/JpyaPJ4pmogngl7AW4dSKtpmjiEaKD9TJmX1HCsr1frVTNLTk19cpZ4Y45jcEiQkaT7ZBzcWOqJ0wJtz0bYvba6dMO8eGpVi2xZFIxSVLDBNGv3VlBzoBdAc6hSI802T66TSDlgk2dpPExKTexa4ov5hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yH9dsOEU; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yH9dsOEU"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 64A211E214B;
	Sat,  2 Mar 2024 14:03:57 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=CwQVLntrmP1QgaXyDDBt9GN1J
	KuKD6IDErSQMiU3Lrg=; b=yH9dsOEUofdokYiZu/P2cu02lflMv0tymuR5ZlWPd
	9T/a7FOWCFBV43vGOC7gfh6Yb98QbzBF3OTmn2Gzw1YjnnVL/SZaVNamgEeRSqMW
	icT+K49hUehpqafh/bym33YcPUZGLBoJjUoDDf7UwnvGhf1pFe+xUB7CHGnbOZZB
	Ok=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C1191E214A;
	Sat,  2 Mar 2024 14:03:57 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BCD471E2148;
	Sat,  2 Mar 2024 14:03:56 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/3] sideband: avoid short write(2)
Date: Sat,  2 Mar 2024 11:03:47 -0800
Message-ID: <20240302190348.3946569-3-gitster@pobox.com>
X-Mailer: git-send-email 2.44.0-84-gb387623c12
In-Reply-To: <20240302190348.3946569-1-gitster@pobox.com>
References: <20240302190348.3946569-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 9EB5E15C-D8C7-11EE-947D-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

The sideband demultiplexor writes the data it receives on sideband
with xwrite().  We can lose data if the underlying write(2) results
in a short write.

If they are limited to unimportant bytes like eye-candy progress
meter, it may be OK to lose them, but lets be careful and ensure
that we use write_in_full() instead.  Note that the original does
not check for errors, and this rewrite does not check for one.  At
least not yet.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sideband.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sideband.c b/sideband.c
index 266a67342b..5d8907151f 100644
--- a/sideband.c
+++ b/sideband.c
@@ -220,7 +220,7 @@ int demultiplex_sideband(const char *me, int status,
 			}
=20
 			strbuf_addch(scratch, *brk);
-			xwrite(2, scratch->buf, scratch->len);
+			write_in_full(2, scratch->buf, scratch->len);
 			strbuf_reset(scratch);
=20
 			b =3D brk + 1;
@@ -247,7 +247,7 @@ int demultiplex_sideband(const char *me, int status,
 		die("%s", scratch->buf);
 	if (scratch->len) {
 		strbuf_addch(scratch, '\n');
-		xwrite(2, scratch->buf, scratch->len);
+		write_in_full(2, scratch->buf, scratch->len);
 	}
 	strbuf_release(scratch);
 	return 1;
--=20
2.44.0-84-gb387623c12

