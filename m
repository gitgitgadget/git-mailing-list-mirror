From: Vicent Marti <tanoku@gmail.com>
Subject: [PATCH 09/16] documentation: add documentation for the bitmap format
Date: Tue, 25 Jun 2013 01:23:06 +0200
Message-ID: <1372116193-32762-10-git-send-email-tanoku@gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Cc: Vicent Marti <tanoku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 25 01:24:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrG7G-0003Il-So
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 01:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129Ab3FXXYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 19:24:05 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:33639 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab3FXXX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 19:23:59 -0400
Received: by mail-wg0-f42.google.com with SMTP id z11so231478wgg.5
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 16:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=QMXoqKuXKONfkFl/zPC6kgbiuzbOfunjlnFPh1jPlf8=;
        b=aof/U7Fbbaa25nAj4OSJk/ns4VMxPHCCgeb2UiIiXSKl3lfqRDCQ9CTIc7Yy+yyUUT
         JOoISGSJS4GQMN5Dzmve55Oteidu9gM8Sq1X828nw1btaQCcDkMorYIWOWR5QJPXbuDG
         oRxiJWMdJR+uhm1dwGneITzuHI1T2trqMs5HAr8y/Q6mB4slOOXGH+ghHiiW++qkAOhg
         qsfglbA99+wQFDjfXwjy5SS9WyvIyPzPlG6dsKkNdQV4wH641BtBCg+IH+Z14cFhoZy1
         sM9yzUGYxiVHfWeWbVouO6DkyNUKdZblhX9zD4g+cn0ifCFhweyT2rjlJDYg2nrf5Ufv
         LfOA==
X-Received: by 10.180.109.48 with SMTP id hp16mr7385728wib.24.1372116238367;
        Mon, 24 Jun 2013 16:23:58 -0700 (PDT)
Received: from localhost.localdomain (212.Red-81-32-36.dynamicIP.rima-tde.net. [81.32.36.212])
        by mx.google.com with ESMTPSA id x13sm593766wib.3.2013.06.24.16.23.56
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 16:23:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228927>

This is the technical documentation and design rationale for the new
Bitmap v2 on-disk format.
---
 Documentation/technical/bitmap-format.txt |  235 +++++++++++++++++++++++++++++
 1 file changed, 235 insertions(+)
 create mode 100644 Documentation/technical/bitmap-format.txt

diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
new file mode 100644
index 0000000..5400082
--- /dev/null
+++ b/Documentation/technical/bitmap-format.txt
@@ -0,0 +1,235 @@
+GIT bitmap v2 format & rationale
+================================
+
+	- A header appears at the beginning, using the same format
+	as JGit's original bitmap indexes.
+
+		4-byte signature: {'B', 'I', 'T', 'M'}
+
+		2-byte version number (network byte order)
+			The current implementation only supports version 2
+			of the bitmap index. The rationale for this is explained
+			in this document.
+
+		2-byte flags (network byte order)
+
+			The folowing flags are supported:
+
+			- BITMAP_OPT_FULL_DAG (0x1) REQUIRED
+			This flag must always be present. It implies that the bitmap
+			index has been generated for a packfile with full closure
+			(i.e. where every single object in the packfile can find
+			 its parent links inside the same packfile). This is a
+			requirement for the bitmap index format, also present in JGit,
+			that greatly reduces the complexity of the implementation.
+
+			- BITMAP_OPT_LE_BITMAPS (0x2)
+			If present, this implies that that the EWAH bitmaps in this
+			index has been serialized to disk in little-endian byte order.
+			Note that this only applies to the actual bitmaps, not to the
+			Git data structures in the index, which are always in Network
+			Byte order as it's costumary.
+
+			- BITMAP_OPT_BE_BITMAPS (0x4)
+			If present, this implies that the EWAH bitmaps have been serialized
+			using big-endian byte order (NWO). If the flag is missing, **the
+			default is to assume that the bitmaps are in big-endian**.
+
+			- BITMAP_OPT_HASH_CACHE (0x8)
+			If present, a hash cache for finding delta bases will be available
+			right after the header block in this index. See the following
+			section for details.
+
+		4-byte entry count (network byte order)
+
+			The total count of entries (bitmapped commits) in this bitmap index.
+
+		20-byte checksum
+
+			The SHA1 checksum of the pack this bitmap index belongs to.
+
+	- An OPTIONAL delta cache follows the header.
+
+		The cache is formed by `n` 4-byte hashes in a row, where `n` is
+		the amount of objects in the indexed packfile. Note that this amount
+		is the **total number of objects** and is not related to the
+		number of commits that have been selected and indexed in the
+		bitmap index.
+
+		The hashes are stored in Network Byte Order and they are the same
+		values generated by a normal revision walk during the `pack-objects`
+		phase.
+
+		The `n`nth hash in the cache is the name hash for the `n`th object
+		in the index for the indexed packfile.
+
+		[RATIONALE]:
+
+		The bitmap index allows us to skip the Counting Objects phase
+		during `pack-objects` and yield all the OIDs that would be reachable
+		("WANTS") when generating the pack.
+
+		This optimization, however, means that we're adding objects to the
+		packfile straight from the packfile index, and hence we are lacking
+		path information for the objects that would normally be generated
+		during the "Counting Objects" phase.
+
+		This path information for each object is hashed and used as a very
+		effective way to find good delta bases when compressing the packfile;
+		without these hashes, the resulting packfiles are much less optimal.
+
+		By storing all the hashes in a cache together with the bitmapsin
+		the bitmap index, we can yield not only the SHA1 of all the reachable
+		objects, but also their hashes, and allow Git to be much smarter when
+		finding delta bases for packing.
+
+		If the delta cache is not available, the bitmap index will obviously
+		be smaller in disk, but the packfiles generated using this index will
+		be between 20% and 30% bigger, because of the lack of name/path
+		information when finding delta bases.
+
+	- 4 EWAH bitmaps that act as type indexes
+
+		Type indexes are serialized after the hash cache in the shape
+		of four EWAH bitmaps stored consecutively (see Appendix A for
+		the serialization format of an EWAH bitmap).
+
+		There is a bitmap for each Git object type, stored in the following
+		order:
+
+			- Commits
+			- Trees
+			- Blobs
+			- Tags
+
+		In each bitmap, the `n`th bit is set to true if the `n`th object
+		in the packfile index is of that type.
+
+		The obvious consequence is that the XOR of all 4 bitmaps will result
+		in a full set (all bits sets), and the AND of all 4 bitmaps will
+		result in an empty bitmap (no bits set).
+
+	- N EWAH bitmaps, one for each indexed commit
+
+		Where `N` is the total amount of entries in this bitmap index.
+		See Appendix A for the serialization format of an EWAH bitmap.
+
+	- An entry index with `N` entries for the indexed commits
+
+		Index entries are stored consecutively, and each entry has the
+		following format:
+
+		- 20-byte SHA1
+			The SHA1 of the commit that this bitmap indexes
+
+		- 4-byte offset (Network Byte Order)
+			The offset **from the beginning of the file** where the
+			bitmap for this commit is stored.
+
+		- 1-byte XOR-offset
+			The xor offset used to compress this bitmap. For an entry
+			in position `x`, a XOR offset of `y` means that the actual
+			bitmap representing for this commit is composed by XORing the
+			bitmap for this entry with the bitmap in entry `x-y` (i.e.
+			the bitmap `y` entries before this one).
+
+			Note that this compression can be recursive. In order to
+			XOR this entry with a previous one, the previous entry needs
+			to be decompressed first, and so on.
+
+			The hard-limit for this offset is 160 (an entry can only be
+			xor'ed against one of the 160 entries preceding it). This
+			number is always positivea, and hence entries are always xor'ed
+			with **previous** bitmaps, not bitmaps that will come afterwards
+			in the index.
+
+		- 1-byte flags for this bitmap
+			At the moment the only available flag is `0x1`, which hints
+			that this bitmap can be re-used when rebuilding bitmap indexes
+			for the repository.
+
+		- 2 bytes of RESERVED data (used right now for better packing).
+
+== Rationale for changes from the Bitmap Format v1
+
+- Serialized EWAH bitmaps can be stored in Little-Endian byte order,
+  if defined by the BITMAP_OPT_LE_BITMAPS flag in the header.
+
+  The original JGit implementation stored bitmaps in Big-Endian byte
+  order (NWO) because it was unable to `mmap` the serialized format,
+  and hence always required a full parse of the bitmap index to memory,
+  where the BE->LE conversion could be performed.
+
+  This full parse, however, requires prohibitive loading times in LE
+  machines (i.e. all modern server hardware): a repository like
+  `torvalds/linux` can have about 8mb of bitmap indexes, resulting
+  in roughly 400ms of parse time.
+
+  This is not an issue in JGit, which is capable of serving repositories
+  from a single-process daemon running on the JVM, but `git-daemon` in
+  git has been implemented with a process-based design (a new
+  `pack-objects` is spawned for each request), and the boot times
+  of parsing the bitmap index every time `pack-objects` is spawned can
+  seriously slow down requests (particularly for small fetches, where we'd
+  spend about 1.5s booting up and 300ms performing the Counting Objects
+  phase).
+
+  By storing the bitmaps in Little-Endian, we're able to `mmap` their
+  compressed data straight in memory without parsing it beforehand, and
+  since most queries don't require accessing all the serialized bitmaps,
+  we'll only page in the minimal amount of bitmaps necessary to perform
+  the reachability analysis as they are accessed.
+
+- An index of all the bitmapped commits is written at the end of the packfile,
+  instead of interpersed with the serialized bitmaps in the middle of the
+  file.
+
+  Again, the old design implied a full parse of the whole bitmap index
+  (which JGit can afford because its daemon is single-process), but it made
+  impossible `mmaping` the bitmap index file and accessing only the parts
+  required to actually solve the query.
+
+  With an index at the end of the file, we can load only this index in memory,
+  allowing for very efficient access to all the available bitmaps lazily (we
+  have their offsets in the mmaped file).
+
+- The ordering of the objects in each bitmap has changed from
+  packfile-order (the nth bit in the bitmap is the nth object in the
+  packfile) to index-order (the nth bit in the bitmap is the nth object
+  in the INDEX of the packfile).
+
+  There is not a noticeable performance difference when actually converting
+  from bitmap position to SHA1 and from SHA1 to bitmap position, but when
+  using packfile ordering like JGit does, queries need to go through the
+  reverse index (pack-revindex.c).
+
+  Generating this reverse index at runtime is **not** free (around 900ms
+  generation time for a repository like `torvalds/linux`), and once again,
+  this generation time needs to happen every time `pack-objects` is
+  spawned.
+
+  With index-ordering, the only requirement for SHA1 -> Bitmap conversions
+  is the packfile index, which we essentially load for free.
+
+
+== Appendix A: Serialization format for an EWAH bitmap
+
+Ewah bitmaps are serialized in the protocol as the JAVAEWAH
+library, making them backwards compatible with the JGit
+implementation:
+
+	- 4-byte number of bits of the resulting UNCOMPRESSED bitmap
+
+	- 4-byte number of words of the COMPRESSED bitmap, when stored
+
+	- N x 8-byte words, as specified by the previous field
+
+		This is the actual content of the compressed bitmap.
+
+	- 4-byte position of the current RLW for the compressed
+		bitmap
+
+Note that the byte order for this serialization is not defined by
+default. The byte order for all the content in a serialized EWAH
+bitmap can be known by the byte order flags in the header of the
+bitmap index file.
-- 
1.7.9.5
