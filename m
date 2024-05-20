Received: from impout002.msg.chrl.nc.charter.net (impout002aa.msg.chrl.nc.charter.net [47.43.20.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A5F137934
	for <git@vger.kernel.org>; Mon, 20 May 2024 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716231810; cv=none; b=pnMXCP3MRdScgx3DGrEpZcKr073PPQF8+lK94GfKy7pMnWeLtgm9t5wtMR58wO6QH+3VS+AJnp40RNOveR/iTnvf2kwrw8clGM04dKLHb6nv5MmsEfnPAhOEiF04fO55zV6W6cFoK8pW0oB8Ch9n5/s85h8v3anrN23i8yjwrbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716231810; c=relaxed/simple;
	bh=PhT1GKfLAYuqDL9SaIHsap2paeQLI2MIOMmieSmq5YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txQZR//o6wll/g/podG5DUoCBXE0c+MCKfb2dqpZDBXJsXJE9jztH1QYk6oM6Js0eR69Mo4JCPF/NXZenw4Q78ioVWl1b76EH8cyLf+8sV6uRnXrGPrKNg3SwG3ihYoy/e5HNBXGD+gLtrS6z36QNSD78nn+7IhIbYij4l9X/oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=mlsslvPv; arc=none smtp.client-ip=47.43.20.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="mlsslvPv"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id 98GYsTho2i0hy98GdsQjRt; Mon, 20 May 2024 19:01:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1716231711;
	bh=PhT1GKfLAYuqDL9SaIHsap2paeQLI2MIOMmieSmq5YE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mlsslvPvL+Qbi6tDnVT1zFunV6BZdDTCx7+SPPDYO6uF+wPn5MwNEsEYnO/07kTAB
	 VsKzv2EkUxMmI/uPbmkblEBO4LAOA/jURTTFmd+ecY4v1GONJ3ll8XaDpF9+mPtJfK
	 pkiPWJe02OrsHLz6vzVEOXk46K4AA08ulmXpaW6HF+3pQymPAkquPioQCKtSPrFASH
	 o8nXyX9coOL6ssCrDhN1MIoafEpOHbFRLRjVEO1cPhp4xGvv0sZtWfjp4eRiw7bG6A
	 HjK50EyGrs9RxSbF6a9E2ZteeVNfxs26pCzPwGHUbi2DSGRfIgFybHF+oIQWH9Bk24
	 cGtfX9Nl82pQw==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=Wf8KaVhX c=1 sm=1 tr=0 ts=664b9e1f
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=FEFd8Tinf7kf2AkxOVsA:9
 a=jYKBPJSq9nmHKCndOPe9:22 a=AjGcO6oz07-iQ99wixmX:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/3] chainlint.pl: make CPU count computation more robust
Date: Mon, 20 May 2024 15:01:29 -0400
Message-ID: <20240520190131.94904-2-ericsunshine@charter.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520190131.94904-1-ericsunshine@charter.net>
References: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de>
 <20240520190131.94904-1-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOmijoj/6CdUaPFXhSUgYYnYPQSqroei4wjBGUvv3VXroIbeoZyoBKHHFDO0rJ5p/P5Gl/2850lole7wmV7SI2aOWxzlaarIY2svGYV4rGI0uOtLT59A
 VhLyJ8FPe3zcPpXH4yFltBo7jLUXBm0EU1ne7qHOLGtes9A7BJ1BR7ecZDNsL4CRjkOZkyVCgQS4sO6l1AC5fKySEBECdVuy0ET8Xpz7aOZsjTyb0/RhoMpJ
 cb1LaBvo6jqer8uZE97JNFrclZqv/N3CnKj6wwRrATOfQtEVsMcAlQe4ycbxcaXduYlYR2vyxA6hUa+5cI7uKQ==

From: Eric Sunshine <sunshine@sunshineco.com>

There have been reports[1,2] of chainlint.pl failing to produce output
when output is expected. In fact, the underlying problem is more severe:
in these cases, it isn't doing any work at all, thus not checking Git
tests for semantic problems. In the reported cases, the problem was
tracked down to ncores() returning 0 for the CPU count, which resulted
in chainlint.pl not performing any work (since it thought it had no
cores on which to process).

In the reported cases, the reason for the failure was that the regular
expression counting the number of processors reported by /proc/cpuinfo
failed to find any matches, hence it counted 0 processors. Although
fixing each case as it is reported allows chaining.pl to work correctly
on that architecture, it does nothing to improve the overall robustness
of the core count computation which may still return 0 on some yet
untested architecture.

Address this shortcoming by ensuring that ncores() returns a sensible
fallback value in all cases.

[1]: https://lore.kernel.org/git/pull.1385.git.git.1669148861635.gitgitgadget@gmail.com/
[2]: https://lore.kernel.org/git/8baa12f8d044265f1ddeabd64209e7ac0d3700ae.camel@physik.fu-berlin.de/

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 556ee91a15..d9a2691889 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -716,11 +716,22 @@ sub fd_colors {
 
 sub ncores {
 	# Windows
-	return $ENV{NUMBER_OF_PROCESSORS} if exists($ENV{NUMBER_OF_PROCESSORS});
+	if (exists($ENV{NUMBER_OF_PROCESSORS})) {
+		my $ncpu = $ENV{NUMBER_OF_PROCESSORS};
+		return $ncpu > 0 ? $ncpu : 1;
+	}
 	# Linux / MSYS2 / Cygwin / WSL
-	do { local @ARGV='/proc/cpuinfo'; return scalar(grep(/^processor[\s\d]*:/, <>)); } if -r '/proc/cpuinfo';
+	if (open my $fh, '<', '/proc/cpuinfo') {
+		my $cpuinfo = do { local $/; <$fh> };
+		close($fh);
+		my @matches = ($cpuinfo =~ /^processor[\s\d]*:/mg);
+		return @matches ? scalar(@matches) : 1;
+	}
 	# macOS & BSD
-	return qx/sysctl -n hw.ncpu/ if $^O =~ /(?:^darwin$|bsd)/;
+	if ($^O =~ /(?:^darwin$|bsd)/) {
+		my $ncpu = qx/sysctl -n hw.ncpu/;
+		return $ncpu > 0 ? $ncpu : 1;
+	}
 	return 1;
 }
 
-- 
2.45.1

