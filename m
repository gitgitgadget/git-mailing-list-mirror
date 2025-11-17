Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9608E321434
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417791; cv=none; b=PJtYVL4iS4UsLfzFG02ESkEbcCgijc53q5Y1T/Ct9LZQrIysf5NgfX6wWPd18bEvgxUnz5emyUo2SurdAdyD6GFl2H1VPRZTdYpC1ZUCeJb8A4s6TSJTO3gLKdJ4nT+C3w3tu0U7wDzTIQrrMQO/HsrQJPyCH+bR/E+ravKlYPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417791; c=relaxed/simple;
	bh=DyU5uCnUSeaUsKC+LFDuYKvsfEjOqPY27OMGiLkS5Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJgc/V/dGhtgnRhpe9vTHeMgXcMmboQPX8gHIoSQIjIBs9SZIwkSQ1WuFMkm09lY6Dsp5B9STSszgxvYvFZmiGhQZUh5t0xUicp4joiGTOYSwr2muA0WcJG7t6t2fwbIDrODJOBzizizqeHtydWykEPlOeYT4C5pvxfFJazKH1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=fJEtDqKY; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fJEtDqKY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763417786;
	bh=DyU5uCnUSeaUsKC+LFDuYKvsfEjOqPY27OMGiLkS5Fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=fJEtDqKY5DkQBzx8HAx3sV5tvxQBya4E5/g5ihG7KgLgF/uG1VpAN1D8xSmEDNcOW
	 uDDqV+WQnmSdxO53xPShBKooWinddabjwl7J0q8HvwLR1GEX74AxbBJHrn10T2F6Fv
	 +YZlVQFV0Afd+Sc98BoSic9kENvnoHAVsSxcM8AaIjzWYzlE9kNcbL/QggLK9zt0jO
	 h5qjXq+76rbHeegeSJbA4mxTeFgAGldc66QhJCp75UWSRvJ303y+Jsojh9rcAhjQ0P
	 5RBbN+DkaANj1L2AlHKTJ6WexZK5kZblp+Hzl7ClB35bQaBvJ2hi0/VZAnyXmoNMKv
	 PEOw2Kc9g6v3rdfzY7tde5XDLk9G2ebpEqaiVwtK1xoXr++iK5ayB1cg18jDahvr9d
	 NZ3ZLb/umseBn3ebdtzJOft5OmvenYh2Rpuq3iIGbYWjPzO0uL9XaMzB6FDcG3qoEK
	 zph+l3shfXbqw/60cVuHQt5lbM+iI0sZXl/nfvZTDPFUQfJ5GWH
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b6c6:bf88:c872:dae4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 207A525529;
	Mon, 17 Nov 2025 22:16:26 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH v2 05/15] rust: add a hash algorithm abstraction
Date: Mon, 17 Nov 2025 22:16:11 +0000
Message-ID: <20251117221621.2863243-6-sandals@crustytoothpaste.net>
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
 src/hash.rs | 159 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/src/hash.rs b/src/hash.rs
index 0219391820..0ec0ab0490 100644
--- a/src/hash.rs
+++ b/src/hash.rs
@@ -10,8 +10,25 @@
 // You should have received a copy of the GNU General Public License along
 // with this program; if not, see <https://www.gnu.org/licenses/>.
 
+use std::error::Error;
+use std::fmt::{self, Debug, Display};
+
 pub const GIT_MAX_RAWSZ: usize = 32;
 
+/// An error indicating an invalid hash algorithm.
+///
+/// The contained `u32` is the same as the `algo` field in `ObjectID`.
+#[derive(Debug, Copy, Clone)]
+pub struct InvalidHashAlgorithm(pub u32);
+
+impl Display for InvalidHashAlgorithm {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        write!(f, "invalid hash algorithm {}", self.0)
+    }
+}
+
+impl Error for InvalidHashAlgorithm {}
+
 /// A binary object ID.
 #[repr(C)]
 #[derive(Debug, Clone, Ord, PartialOrd, Eq, PartialEq)]
@@ -19,3 +36,145 @@ pub struct ObjectID {
     pub hash: [u8; GIT_MAX_RAWSZ],
     pub algo: u32,
 }
+
+#[allow(dead_code)]
+impl ObjectID {
+    pub fn as_slice(&self) -> Result<&[u8], InvalidHashAlgorithm> {
+        match HashAlgorithm::from_u32(self.algo) {
+            Some(algo) => Ok(&self.hash[0..algo.raw_len()]),
+            None => Err(InvalidHashAlgorithm(self.algo)),
+        }
+    }
+
+    pub fn as_mut_slice(&mut self) -> Result<&mut [u8], InvalidHashAlgorithm> {
+        match HashAlgorithm::from_u32(self.algo) {
+            Some(algo) => Ok(&mut self.hash[0..algo.raw_len()]),
+            None => Err(InvalidHashAlgorithm(self.algo)),
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
