Received: from coleridge.oriole.systems (coleridge.oriole.systems [89.238.76.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961AD212F1E
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.76.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729102898; cv=none; b=BNTHTBa76LQw7FKjUctD6bV7x6HLRNMCWtGum90Ipx8sJInGMcVRxnvvUcoC6OLUMHvgFSr1oqcKyyFKGLILrBRh4xkZVLaTw5/tL6XRkpEKgCANVhHVZyGl425UAoKA6T7VADmKBV67UZ74iScW9zY1jWhWz0sxBaz24nDi4NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729102898; c=relaxed/simple;
	bh=wx9+KTLKgsrrmY+SkGzslzmn8zrokRzQCrDMBrT1jBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IYUI/VbdgmXGudO1usLksg9tHSexcrRmFrLpCVJIEZKtSnpc50s6ZO/lIFDAFT0tiSVtl0NJNfCTj0wfTe15hiMad9dnUaAhwQBo0VI1rTfTmUMc0HbGodI5TqhquqbKeplEZMObguuyvqEOVpD4QkmUqpKJ0IwwM7Ryj/1aeTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems; spf=pass smtp.mailfrom=oriole.systems; dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b=KBw/z88V; arc=none smtp.client-ip=89.238.76.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oriole.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b="KBw/z88V"
From: =?UTF-8?q?Wolfgang=20M=C3=BCller?= <wolf@oriole.systems>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oriole.systems;
	s=canary-202303; t=1729102894;
	bh=wx9+KTLKgsrrmY+SkGzslzmn8zrokRzQCrDMBrT1jBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:From:Sender:
	 Reply-To:Subject:Date:Message-Id:To:Cc:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:In-Reply-To:References;
	b=KBw/z88Vv9zSNSn1aH/+n/NcoPIy/w8tl43QNfJ7pDRAxfBUZyvcbcD4J/oiyGfTC
	 ZVJfkHgbVtvm4K45geVqW67naNVoFKWcfXILP3IPGIQLT3JUEk1RpLBivb0l3S4fGF
	 L6jO8gfhFWK4VDPB2OlyjKxugcQMipHbuNphkeiZgo9u7AtuG4VNsbXDtZArwf+dsP
	 E1KpcZ9tWEs/k8huiTBGvz1CuuahZHN3+eOS1Gt0sNTEON93n2NB84pXCSUsaQWPq1
	 AC/YOJWJO2s3MEIz116TjKnc0nzvf5SEvwgMdCEdUNP6wmNwiCG++alG/BxYnoPPDa
	 xzF6LAzF6UdLA==
To: git@vger.kernel.org
Cc: =?UTF-8?q?Wolfgang=20M=C3=BCller?= <wolf@oriole.systems>
Subject: [PATCH v3 2/2] shortlog: Test reading a log from a SHA256 repo in a non-git directory
Date: Wed, 16 Oct 2024 20:21:24 +0200
Message-ID: <20241016182124.48148-3-wolf@oriole.systems>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016182124.48148-1-wolf@oriole.systems>
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241016182124.48148-1-wolf@oriole.systems>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

git-shortlog(1) might be used outside of a git repository to process a
log obtained from a repository initialized with --object-format=sha256.
Since git-shortlog(1) has no information on the hash algorithm, make
sure that it can still successfully process the log regardless.

Signed-off-by: Wolfgang Müller <wolf@oriole.systems>
Thanks-to: Patrick Steinhardt <ps@pks.im>
---
 t/t4201-shortlog.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 0cc2aa5089..50d987cbe4 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -147,6 +147,14 @@ fuzz()
 	echo | nongit git shortlog --author=author
 '
 
+test_expect_success 'shortlog from non-git directory reads log from SHA256 repository' '
+	test_when_finished "rm -rf repo" &&
+	git init --object-format=sha256 repo &&
+	test_commit -C repo initial &&
+	git -C repo log HEAD >log &&
+	nongit git shortlog <log
+'
+
 test_expect_success 'shortlog should add newline when input line matches wraplen' '
 	cat >expect <<\EOF &&
 A U Thor (2):
-- 
2.47.0

