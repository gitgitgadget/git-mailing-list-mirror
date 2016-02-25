From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] nth_packed_object_offset: bounds-check extended offset
Date: Thu, 25 Feb 2016 09:22:52 -0500
Message-ID: <20160225142252.GB17811@sigill.intra.peff.net>
References: <20160225142004.GA17678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacek Wielemborek <d33tah@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 15:23:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYwom-0003p4-29
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 15:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760265AbcBYOW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 09:22:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:49131 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759878AbcBYOWz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 09:22:55 -0500
Received: (qmail 6652 invoked by uid 102); 25 Feb 2016 14:22:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 09:22:55 -0500
Received: (qmail 21407 invoked by uid 107); 25 Feb 2016 14:23:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 09:23:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Feb 2016 09:22:52 -0500
Content-Disposition: inline
In-Reply-To: <20160225142004.GA17678@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287392>

If a pack .idx file has a corrupted offset for an object, we
may try to access an offset in the .idx or .pack file that
is larger than the file's size.  For the .pack case, we have
use_pack() to protect us, which realizes the access is out
of bounds. But if the corrupted value asks us to look in the
.idx file's secondary 64-bit offset table, we blindly add it
to the mmap'd index data and access arbitrary memory.

We can fix this with a simple bounds-check compared to the
size we found when we opened the .idx file.

Note that there's similar code in index-pack that is
triggered only during "index-pack --verify". To support
both, we pull the bounds-check into a separate function,
which dies when it sees a corrupted file.

It would be nice if we could return an error, so that the
pack code could try to find a good copy of the object
elsewhere. Currently nth_packed_object_offset doesn't have
any way to return an error, but it could probably use "0" as
a sentinel value (since no object can start there). This is
the minimal fix, and we can improve the resilience later on
top.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c          |  1 +
 cache.h                       | 10 ++++++++++
 sha1_file.c                   | 15 +++++++++++++++
 t/t5313-pack-bounds-checks.sh |  2 +-
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 6a01509..ad6a1d7 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1514,6 +1514,7 @@ static void read_v2_anomalous_offsets(struct packed_git *p,
 		if (!(off & 0x80000000))
 			continue;
 		off = off & 0x7fffffff;
+		check_pack_index_ptr(p, &idx2[off * 2]);
 		if (idx2[off * 2])
 			continue;
 		/*
diff --git a/cache.h b/cache.h
index 83b688c..25a7040 100644
--- a/cache.h
+++ b/cache.h
@@ -1370,6 +1370,16 @@ extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
 
 /*
+ * Make sure that a pointer access into an mmap'd index file is within bounds,
+ * and can provide at least 8 bytes of data.
+ *
+ * Note that this is only necessary for variable-length segments of the file
+ * (like the 64-bit extended offset table), as we compare the size to the
+ * fixed-length parts when we open the file.
+ */
+extern void check_pack_index_ptr(const struct packed_git *p, const void *ptr);
+
+/*
  * Return the SHA-1 of the nth object within the specified packfile.
  * Open the index if it is not already open.  The return value points
  * at the SHA-1 within the mmapped index.  Return NULL if there is an
diff --git a/sha1_file.c b/sha1_file.c
index aab1872..d2ffd92 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2446,6 +2446,20 @@ const unsigned char *nth_packed_object_sha1(struct packed_git *p,
 	}
 }
 
+void check_pack_index_ptr(const struct packed_git *p, const void *vptr)
+{
+	const unsigned char *ptr = vptr;
+	const unsigned char *start = p->index_data;
+	const unsigned char *end = start + p->index_size;
+	if (ptr < start)
+		die("offset before start of pack index for %s (corrupt index?)",
+		    p->pack_name);
+	/* No need to check for underflow; .idx files must be at least 8 bytes */
+	if (ptr >= end - 8)
+		die("offset beyond end of pack index for %s (truncated index?)",
+		    p->pack_name);
+}
+
 off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 {
 	const unsigned char *index = p->index_data;
@@ -2459,6 +2473,7 @@ off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 		if (!(off & 0x80000000))
 			return off;
 		index += p->num_objects * 4 + (off & 0x7fffffff) * 8;
+		check_pack_index_ptr(p, index);
 		return (((uint64_t)ntohl(*((uint32_t *)(index + 0)))) << 32) |
 				   ntohl(*((uint32_t *)(index + 4)));
 	}
diff --git a/t/t5313-pack-bounds-checks.sh b/t/t5313-pack-bounds-checks.sh
index efc5197..0717746 100755
--- a/t/t5313-pack-bounds-checks.sh
+++ b/t/t5313-pack-bounds-checks.sh
@@ -128,7 +128,7 @@ test_expect_success 'bogus object offset (v2, no msb)' '
 	test_must_fail git index-pack --verify $pack
 '
 
-test_expect_failure 'bogus offset into v2 extended table' '
+test_expect_success 'bogus offset into v2 extended table' '
 	do_pack $object --index-version=2 &&
 	munge $idx $(ofs_table 1) "\377\0\0\0" &&
 	clear_base &&
-- 
2.7.2.695.gf3fde8e
