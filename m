Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF27234D4E4
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417791; cv=none; b=DktzUbm6A3uASyIik6s9+nwhA6luuhlMqOw3zbAqO0OcgpP1SqeaVK3jymE17VZkstJY2nGFtg5c87uYaNW8pib5QZKJqmjIOD+y0t04yDuSJLKb5LS+YFg2zI7s3aEcXYrelXqaHkMPsLWjRGQWFfQ6FQpTVuFD8B3ccLiNmgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417791; c=relaxed/simple;
	bh=1kooiSFhArRKoUd5STIzI7jcBfOjjGOmqM/SUxdbA1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvDKRyrrD0tTSKjHSmxK49QZABGUyI0mUHBeVMWdoIql6+CR7IvIO3r1fWIEKvJMiHEJvNdGOZxpfR+l579+MwLNIPR0DUCuGlDsYBU3fQhNkX5Jl0rOqwzmy2TKR+KxPbqQN5DOvomtXE+knjhrEeeFpYvBtk+BVlAflvC+R+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=HvadHmvk; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="HvadHmvk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763417786;
	bh=1kooiSFhArRKoUd5STIzI7jcBfOjjGOmqM/SUxdbA1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=HvadHmvk3QMVjwU4tB+d1TEcGkpA410deOdWFjOdjK9YmxfHoLn0g4VZHHwI7EFEm
	 ejRO1FGBFVw0RhcnoNy9DpIuexPKjX6yHBBrOlAa3PT6uLY94vdr7fqFfNZq9XgksV
	 w+qW4nMKpMuB2PALNOzNrOwcBcAo8H/rwDiZfalPh5J6to42JxgYXu04VYWqp33Vk7
	 yYXejFB01G21ATSa1Eo7sCP/NXqrDw6gpz7bBoSgS994Ftv0KF4jJgd7nn+aN1SEgm
	 pxrI57zKwparOQ/slBJBH1qbERIavIDbkre49R1D9qx2GrzjxvbdpoAfiFlwlECtvi
	 hMmmuL+rvxvw1MKyiLHNJUKp9ClXG+L5u74BivOGIWaYNLHj9z1vFm0tcXFD48m34e
	 p7o4GOUnaQqC4frjjvgw8rpWFdTo1ZhJaWJrCQgQ6ZqQ37HVwWvdFRMTbCCXCHFB7i
	 wDlhhm67er5ywJ008ZY6rYEuDNlTyMRJ2UcO/qofqiT5/fcif/J
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b6c6:bf88:c872:dae4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3D62525539;
	Mon, 17 Nov 2025 22:16:26 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH v2 09/15] write-or-die: add an fsync component for the object map
Date: Mon, 17 Nov 2025 22:16:15 +0000
Message-ID: <20251117221621.2863243-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251117221621.2863243-1-sandals@crustytoothpaste.net>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251117221621.2863243-1-sandals@crustytoothpaste.net>
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
