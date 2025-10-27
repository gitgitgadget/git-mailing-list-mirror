Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A74830E85F
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 00:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761525877; cv=none; b=XMSLSLGl+Ewa57AqspcDSoDB7AHVvci+Umad3cQHBx1pGO0X7N6UKs3rqc/VSEjNq7mITdlx4WeMOtTh9GfMy4jN2sEOvi+auTR3DZ6qqIqcHm9WEDpdOrWKJtT+68OEnS+qLiLMgygACBecBGEUKfJtV1eTXtv0kv5wLCOHbNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761525877; c=relaxed/simple;
	bh=E6d+0SRE1ZySshhzlc+8uYc5dZkOEozQzAo+itH6lko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZEEFKe6jGlK39JjohK+CJ/e3lQ2XZq7uLf0CSohDG8+gXhIIjnsbUxCWtMFKYxfcKihC1iusMW3X+xTPnYWokSlGKOxBe0yEzRr8kYuROwJL9wQuWNQcQA1DhHTGGduWeyfcEmQRcMEnky0KNafCmXEl4qx0vrqX5zsCE1gNTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=p17dtPQZ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="p17dtPQZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761525867;
	bh=E6d+0SRE1ZySshhzlc+8uYc5dZkOEozQzAo+itH6lko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=p17dtPQZyVHn+2GR33Jy/PdZpe3cWtmn3UD3s9E58fqM7MB9BE87M2M535hq5mvG6
	 PYsFbzHFpejvzEDncZ0/XnexXYC+T4hkpkDpTe3E7Fa4jxY2byGLExPqj1m4LyeLRV
	 NIMfeg/Qphh7cFkgr6uGnOUNDJBuqgw0Pnjel9+ftRxxWB13mb72Vg909DJSVi2Huu
	 sdRRc0w+im2ISD4y+qOqiydO4BDfAaOWZM3xccTn6GOiLSO2UdONsNa3QyCU5iU0jp
	 3dy8BV6IZWSLhHuAJchy76HawxnDV845UEQ6rSXUOWANSifBVypU590J63Gc2FGnjR
	 fUM5Xr/d0mr54gjhQxGNBHrq9mrAOqSro8+K4xTfhxYwX4aKGOjdJ+m0qedMDWP1RD
	 hk19XmvGDJuE4LMcaZ1b8EcN7xe8lq20iv2EdODQqjHmhAWRrBdNVIe7aMfLaJs/Fx
	 QbHtFoReGMEAMvQMlanYtMKvPOXXsss2HrKzZ1Mm+Qnsx+LXnqK
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5675:b769:afe:3fa2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id AC96E2019E;
	Mon, 27 Oct 2025 00:44:27 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH 05/14] rust: add a hash algorithm abstraction
Date: Mon, 27 Oct 2025 00:43:55 +0000
Message-ID: <20251027004404.2152927-6-sandals@crustytoothpaste.net>
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

This works very similarly to the existing one in C except that it
doesn't provide any functionality to hash an object.  We don't currently
need that right now, but the use of those function pointers do make it
substantially more difficult to write a bit-for-bit identical structure
across the C/Rust interface, so omit them for now.

Instead of the more customary "&self", use "self", because the former is
the size of a pointer and the latter is the size of an integer on most
systems.  Don't define an unknown value but use an Option for that
instead.

Update the object ID structure to allow slicing the data appropriately
for the algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 src/hash.rs | 142 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/src/hash.rs b/src/hash.rs
index 0219391820..1b9f07489e 100644
--- a/src/hash.rs
+++ b/src/hash.rs
@@ -19,3 +19,145 @@ pub struct ObjectID {
     pub hash: [u8; GIT_MAX_RAWSZ],
     pub algo: u32,
 }
+
+#[allow(dead_code)]
+impl ObjectID {
+    pub fn as_slice(&self) -> &[u8] {
+        match HashAlgorithm::from_u32(self.algo) {
+            Some(algo) => &self.hash[0..algo.raw_len()],
+            None => &self.hash,
+        }
+    }
+
+    pub fn as_mut_slice(&mut self) -> &mut [u8] {
+        match HashAlgorithm::from_u32(self.algo) {
+            Some(algo) => &mut self.hash[0..algo.raw_len()],
+            None => &mut self.hash,
+        }
+    }
+}
+
+/// A hash algorithm,
+#[repr(C)]
+#[derive(Debug, Copy, Clone, Ord, PartialOrd, Eq, PartialEq)]
+pub enum HashAlgorithm {
+    SHA1 = 1,
+    SHA256 = 2,
+}
+
+#[allow(dead_code)]
+impl HashAlgorithm {
+    const SHA1_NULL_OID: ObjectID = ObjectID {
+        hash: [0u8; 32],
+        algo: Self::SHA1 as u32,
+    };
+    const SHA256_NULL_OID: ObjectID = ObjectID {
+        hash: [0u8; 32],
+        algo: Self::SHA256 as u32,
+    };
+
+    const SHA1_EMPTY_TREE: ObjectID = ObjectID {
+        hash: *b"\x4b\x82\x5d\xc6\x42\xcb\x6e\xb9\xa0\x60\xe5\x4b\xf8\xd6\x92\x88\xfb\xee\x49\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00",
+        algo: Self::SHA1 as u32,
+    };
+    const SHA256_EMPTY_TREE: ObjectID = ObjectID {
+        hash: *b"\x6e\xf1\x9b\x41\x22\x5c\x53\x69\xf1\xc1\x04\xd4\x5d\x8d\x85\xef\xa9\xb0\x57\xb5\x3b\x14\xb4\xb9\xb9\x39\xdd\x74\xde\xcc\x53\x21",
+        algo: Self::SHA256 as u32,
+    };
+
+    const SHA1_EMPTY_BLOB: ObjectID = ObjectID {
+        hash: *b"\xe6\x9d\xe2\x9b\xb2\xd1\xd6\x43\x4b\x8b\x29\xae\x77\x5a\xd8\xc2\xe4\x8c\x53\x91\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00",
+        algo: Self::SHA1 as u32,
+    };
+    const SHA256_EMPTY_BLOB: ObjectID = ObjectID {
+        hash: *b"\x47\x3a\x0f\x4c\x3b\xe8\xa9\x36\x81\xa2\x67\xe3\xb1\xe9\xa7\xdc\xda\x11\x85\x43\x6f\xe1\x41\xf7\x74\x91\x20\xa3\x03\x72\x18\x13",
+        algo: Self::SHA256 as u32,
+    };
+
+    /// Return a hash algorithm based on the internal integer ID used by Git.
+    ///
+    /// Returns `None` if the algorithm doesn't indicate a valid algorithm.
+    pub const fn from_u32(algo: u32) -> Option<HashAlgorithm> {
+        match algo {
+            1 => Some(HashAlgorithm::SHA1),
+            2 => Some(HashAlgorithm::SHA256),
+            _ => None,
+        }
+    }
+
+    /// Return a hash algorithm based on the internal integer ID used by Git.
+    ///
+    /// Returns `None` if the algorithm doesn't indicate a valid algorithm.
+    pub const fn from_format_id(algo: u32) -> Option<HashAlgorithm> {
+        match algo {
+            0x73686131 => Some(HashAlgorithm::SHA1),
+            0x73323536 => Some(HashAlgorithm::SHA256),
+            _ => None,
+        }
+    }
+
+    /// The name of this hash algorithm as a string suitable for the configuration file.
+    pub const fn name(self) -> &'static str {
+        match self {
+            HashAlgorithm::SHA1 => "sha1",
+            HashAlgorithm::SHA256 => "sha256",
+        }
+    }
+
+    /// The format ID of this algorithm for binary formats.
+    ///
+    /// Note that when writing this to a data format, it should be written in big-endian format
+    /// explicitly.
+    pub const fn format_id(self) -> u32 {
+        match self {
+            HashAlgorithm::SHA1 => 0x73686131,
+            HashAlgorithm::SHA256 => 0x73323536,
+        }
+    }
+
+    /// The length of binary object IDs in this algorithm in bytes.
+    pub const fn raw_len(self) -> usize {
+        match self {
+            HashAlgorithm::SHA1 => 20,
+            HashAlgorithm::SHA256 => 32,
+        }
+    }
+
+    /// The length of object IDs in this algorithm in hexadecimal characters.
+    pub const fn hex_len(self) -> usize {
+        self.raw_len() * 2
+    }
+
+    /// The number of bytes which is processed by one iteration of this algorithm's compression
+    /// function.
+    pub const fn block_size(self) -> usize {
+        match self {
+            HashAlgorithm::SHA1 => 64,
+            HashAlgorithm::SHA256 => 64,
+        }
+    }
+
+    /// The object ID representing the empty blob.
+    pub const fn empty_blob(self) -> &'static ObjectID {
+        match self {
+            HashAlgorithm::SHA1 => &Self::SHA1_EMPTY_BLOB,
+            HashAlgorithm::SHA256 => &Self::SHA256_EMPTY_BLOB,
+        }
+    }
+
+    /// The object ID representing the empty tree.
+    pub const fn empty_tree(self) -> &'static ObjectID {
+        match self {
+            HashAlgorithm::SHA1 => &Self::SHA1_EMPTY_TREE,
+            HashAlgorithm::SHA256 => &Self::SHA256_EMPTY_TREE,
+        }
+    }
+
+    /// The object ID which is all zeros.
+    pub const fn null_oid(self) -> &'static ObjectID {
+        match self {
+            HashAlgorithm::SHA1 => &Self::SHA1_NULL_OID,
+            HashAlgorithm::SHA256 => &Self::SHA256_NULL_OID,
+        }
+    }
+}
