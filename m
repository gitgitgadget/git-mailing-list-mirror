Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759AF2A8C1
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 00:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761525878; cv=none; b=tZ46biIlI+FHLrr9hvEfqdU23naNv+O1Zf1tw1qbNhrMQI4oml4xSvjUT2hVkNK5FWBuB4KYfqvvc+KHKcYDds1sY6mewHwZXCs4NuQJilA1FwoSa392OCz2ZkgUXSULDt7PI8VAxC2IvA8zaRIWkUxSkPEKfBfPVvULK1fF6Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761525878; c=relaxed/simple;
	bh=PQ1Km+sjwruAYF8OrtPfhH5zwVv5Gm+vZnoEXlloqeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vmwo4HXDRjTsuZMovv0aamPOjVIb5MyieNV93OMpc5DrYojb9zOKmxITl+ea4PZsba3NGdr4rL9Z/kPLrQsqm3t6yK2YGd4MRDyPFUd6/Tp/slKo9LtircQZnYDf3DykfVuNxqHeEz9pvqDrc7TP/1wQrYHsessanzIvuIpbe2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=N7946bHP; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="N7946bHP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761525867;
	bh=PQ1Km+sjwruAYF8OrtPfhH5zwVv5Gm+vZnoEXlloqeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=N7946bHPsqoI5nFY4AdzC6SCA1b2emveq4qg4y6n5WIp+HKjlEjXdHKAcMVbbuYx5
	 FPZafORd+LDTZQfdOhZnHIGDBuIoDabYNNrw5oTAa6LaXuFps9jCB/miPxOjUq28ct
	 0srROnOhKygP15uqAiZV4DghwU5Q00lckYwfQhU2kFsKIQyIuOS9wICs1nFi9adYDZ
	 /qMOt2XFI+Ytj7+ASplBVamI8XfAa78ESK4xNPTZY3K8akLuDDBdYg9UfJR8Kl+JT7
	 4eY7o118stYtrydftC4KHLbgF/Dd8eA0ur2bFEfB54/S/dDLbJY4+eKIT/EZBd/vuu
	 GbEI0wJ1wiGRSP9KxNPmcdtOGASfWKI8d8p++FWyepCtL4DCKsZ/cEXZkS9EyBr2Mx
	 Nu0BKnYdZuHC5JpxFHsuvaK69AmGsHDAXwHlDqPDQqEqafqiyiyEhSPeU2HDsD5/ID
	 K6ngdN5qxt94SlnC8cesXicCmpGjbznYHq8/PXhoYYMiTE5X26O
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5675:b769:afe:3fa2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C431E201A2;
	Mon, 27 Oct 2025 00:44:27 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH 08/14] write-or-die: add an fsync component for the loose object map
Date: Mon, 27 Oct 2025 00:43:58 +0000
Message-ID: <20251027004404.2152927-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll soon be writing out a loose object map using the hashfile code.
Add an fsync component to allow us to handle fsyncing it correctly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 write-or-die.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/write-or-die.h b/write-or-die.h
index 65a5c42a47..8d5ec23e1f 100644
--- a/write-or-die.h
+++ b/write-or-die.h
@@ -21,6 +21,7 @@ enum fsync_component {
 	FSYNC_COMPONENT_COMMIT_GRAPH		= 1 << 3,
 	FSYNC_COMPONENT_INDEX			= 1 << 4,
 	FSYNC_COMPONENT_REFERENCE		= 1 << 5,
+	FSYNC_COMPONENT_LOOSE_OBJECT_MAP	= 1 << 6,
 };
 
 #define FSYNC_COMPONENTS_OBJECTS (FSYNC_COMPONENT_LOOSE_OBJECT | \
@@ -44,7 +45,8 @@ enum fsync_component {
 			      FSYNC_COMPONENT_PACK_METADATA | \
 			      FSYNC_COMPONENT_COMMIT_GRAPH | \
 			      FSYNC_COMPONENT_INDEX | \
-			      FSYNC_COMPONENT_REFERENCE)
+			      FSYNC_COMPONENT_REFERENCE | \
+			      FSYNC_COMPONENT_LOOSE_OBJECT_MAP)
 
 #ifndef FSYNC_COMPONENTS_PLATFORM_DEFAULT
 #define FSYNC_COMPONENTS_PLATFORM_DEFAULT FSYNC_COMPONENTS_DEFAULT
