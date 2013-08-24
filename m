From: Jeff King <peff@peff.net>
Subject: [PATCH 5/6] index-pack: optionally reject packs with duplicate
 objects
Date: Fri, 23 Aug 2013 20:02:39 -0400
Message-ID: <20130824000239.GE25833@sigill.intra.peff.net>
References: <20130824000111.GA20255@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 24 02:02:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD1JX-00026y-0T
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 02:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160Ab3HXACn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 20:02:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:41503 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754492Ab3HXACm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 20:02:42 -0400
Received: (qmail 30118 invoked by uid 102); 24 Aug 2013 00:02:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Aug 2013 19:02:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Aug 2013 20:02:39 -0400
Content-Disposition: inline
In-Reply-To: <20130824000111.GA20255@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232847>

Git should never generate packs with duplicate objects.
However, we may see such packs due to bugs in Git or other
implementations (e.g., JGit had such a bug a few years ago).

In theory, such packs should not be a problem for us (we
will simply find one of the instances of the object when
looking in the pack). However, the JGit bug report mentioned
possible infinite loops during repacking due to cycles in
the delta chain.  Though this problem hasn't specifically
been reproduced on modern git, there is no reason not to be
careful with incoming packs, given that only buggy
implementations should be producing such packs, anyway.

This patch introduces the pack.indexDuplicates option to
allow or reject such packs from index-pack. The default
remains to allow it.

Signed-off-by: Jeff King <peff@peff.net>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
---
 builtin/index-pack.c              |  4 ++++
 pack-write.c                      | 24 ++++++++++++++++++++++++
 pack.h                            |  2 ++
 t/t5308-pack-detect-duplicates.sh |  8 ++++++++
 4 files changed, 38 insertions(+)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 79dfe47..72e19a0 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1364,6 +1364,10 @@ static int git_index_pack_config(const char *k, const char *v, void *cb)
 #endif
 		return 0;
 	}
+	if (!strcmp(k, "pack.indexduplicates")) {
+		opts->allow_duplicates = git_config_bool(k, v);
+		return 0;
+	}
 	return git_default_config(k, v, cb);
 }
 
diff --git a/pack-write.c b/pack-write.c
index ca9e63b..da946a7 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -7,6 +7,7 @@ void reset_pack_idx_option(struct pack_idx_option *opts)
 	memset(opts, 0, sizeof(*opts));
 	opts->version = 2;
 	opts->off32_limit = 0x7fffffff;
+	opts->allow_duplicates = 1;
 }
 
 static int sha1_compare(const void *_a, const void *_b)
@@ -37,6 +38,19 @@ static int need_large_offset(off_t offset, const struct pack_idx_option *opts)
 			 sizeof(ofsval), cmp_uint32);
 }
 
+static void *find_duplicate(void *vbase, size_t n, size_t size,
+			    int (*cmp)(const void *, const void *))
+{
+	unsigned char *base = vbase;
+	while (n > 1) {
+		if (!cmp(base, base + size))
+			return base;
+		base += size;
+		n--;
+	}
+	return NULL;
+}
+
 /*
  * On entry *sha1 contains the pack content SHA1 hash, on exit it is
  * the SHA1 hash of sorted object names. The objects array passed in
@@ -68,6 +82,16 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 	else
 		sorted_by_sha = list = last = NULL;
 
+	if (!opts->allow_duplicates) {
+		struct pack_idx_entry **dup;
+
+		dup = find_duplicate(sorted_by_sha, nr_objects,
+				     sizeof(*sorted_by_sha), sha1_compare);
+		if (dup)
+			die("pack has duplicate entries for %s",
+			    sha1_to_hex((*dup)->sha1));
+	}
+
 	if (opts->flags & WRITE_IDX_VERIFY) {
 		assert(index_name);
 		f = sha1fd_check(index_name);
diff --git a/pack.h b/pack.h
index aa6ee7d..45217b6 100644
--- a/pack.h
+++ b/pack.h
@@ -44,6 +44,8 @@ struct pack_idx_option {
 	uint32_t version;
 	uint32_t off32_limit;
 
+	int allow_duplicates;
+
 	/*
 	 * List of offsets that would fit within off32_limit but
 	 * need to be written out as 64-bit entity for byte-for-byte
diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
index 04fe242..97ce2e0 100755
--- a/t/t5308-pack-detect-duplicates.sh
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -70,4 +70,12 @@ test_expect_success 'lookup in duplicated pack (GIT_USE_LOOKUP)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'index-pack can reject packs with duplicates' '
+	clear_packs &&
+	create_pack dups.pack 2 &&
+	test_must_fail \
+		git -c pack.indexDuplicates=0 index-pack --stdin <dups.pack &&
+	test_expect_code 1 git cat-file -e $LO_SHA1
+'
+
 test_done
-- 
1.8.4.rc2.28.g6bb5f3f
