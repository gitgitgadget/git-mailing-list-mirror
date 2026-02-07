Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDE63382D6
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770494705; cv=none; b=XMQ/2G3iOwFRSxljOg1cI0/GALDs9CqfHRo6a5r2WfV1N3nIiZFMI7AhFOPQ+uFk5MWJBfB9eJ70k3opF2vdEkvCzC8StPjcCr9em10Y3F2ayct3tyD/IJWAOr3NUkwqNkDn7fYLR99atvIUN+BgoAojZ+MdMIzQ5cBlzkyXgb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770494705; c=relaxed/simple;
	bh=1kooiSFhArRKoUd5STIzI7jcBfOjjGOmqM/SUxdbA1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9vFPCuPCm7pwt7kmuIK7N7zdnPVGC94w5FiSfWQeX0rd7XAiOf6u8Pmxi/IGT4+BakO+j9O2rk5wLS49kFWlgmyFAxJtAMjKYv10d7BHYyCF3IZhnLq88yUxt90G6mnkFk5RD/Y0qxo31o0NVrtpnUkUOzs51kbdXtfgCA5Qy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=VJK7Z8gq; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="VJK7Z8gq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1770494697;
	bh=1kooiSFhArRKoUd5STIzI7jcBfOjjGOmqM/SUxdbA1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=VJK7Z8gqVphJbRp2mkpU4B01AXYsOG3M7Ara8Ah9rwevB5qfsrFsWIeGlQasDdwNs
	 uinwvJdA3ixOkLLKetYfdj659MpGgU6gY2PaPnEyBIcMXNKKivocRRuWsXS6m9BPca
	 XAxQFrPtF+2oZ7apHF9VqZbGuvATiAcsH4/Ij0dpYpCxAn1vo5AN8odQy17E0SWkT1
	 h4y5SKAI2eekLFh9cQuBTYoRf2jSIEzcAJyvsBiB+r7Ya8SzmY6OQJlSBWCabvD4VV
	 ++elGNrx4kBPBaPTwsYcB35Ol4Db8mMO7Tbe7W2GCPE1X45q2gMDX9gKArqoo3RMvG
	 f/gF/ZS7d0KFJv9mzqiRal9NvCg142G83m+pa8G3F5yf6USy1CLZvMx6FObWQPOrYa
	 b5qGybl7l+4Vx6w0LPymQwjIl8tz2POv/jeN5HWGtrufxJNKJBVxNEwGqb6TsY+5Z6
	 6iyzGhJzyUtoYvwFCzTnzt4178NGujjr4ERoRYaUORg1eGwXqDR
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9a58:ad83:8db9:6f4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B4F2F243C9;
	Sat,  7 Feb 2026 20:04:57 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 09/16] write-or-die: add an fsync component for the object map
Date: Sat,  7 Feb 2026 20:04:39 +0000
Message-ID: <20260207200446.2837699-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20260207200446.2837699-1-sandals@crustytoothpaste.net>
References: <20251117221621.2863243-1-sandals@crustytoothpaste.net>
 <20260207200446.2837699-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll soon be writing out an object map using the hashfile code. Add an
fsync component to allow us to handle fsyncing it correctly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 write-or-die.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/write-or-die.h b/write-or-die.h
index 65a5c42a47..ff0408bd84 100644
--- a/write-or-die.h
+++ b/write-or-die.h
@@ -21,6 +21,7 @@ enum fsync_component {
 	FSYNC_COMPONENT_COMMIT_GRAPH		= 1 << 3,
 	FSYNC_COMPONENT_INDEX			= 1 << 4,
 	FSYNC_COMPONENT_REFERENCE		= 1 << 5,
+	FSYNC_COMPONENT_OBJECT_MAP		= 1 << 6,
 };
 
 #define FSYNC_COMPONENTS_OBJECTS (FSYNC_COMPONENT_LOOSE_OBJECT | \
@@ -44,7 +45,8 @@ enum fsync_component {
 			      FSYNC_COMPONENT_PACK_METADATA | \
 			      FSYNC_COMPONENT_COMMIT_GRAPH | \
 			      FSYNC_COMPONENT_INDEX | \
-			      FSYNC_COMPONENT_REFERENCE)
+			      FSYNC_COMPONENT_REFERENCE | \
+			      FSYNC_COMPONENT_OBJECT_MAP)
 
 #ifndef FSYNC_COMPONENTS_PLATFORM_DEFAULT
 #define FSYNC_COMPONENTS_PLATFORM_DEFAULT FSYNC_COMPONENTS_DEFAULT
