From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] index-pack: optionally reject packs with duplicate
 objects
Date: Wed, 21 Aug 2013 16:52:20 -0400
Message-ID: <20130821205220.GB28165@sigill.intra.peff.net>
References: <20130821204955.GA28025@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 21 22:52:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCFOF-0001Fa-Cw
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 22:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018Ab3HUUwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 16:52:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:49722 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752790Ab3HUUwX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 16:52:23 -0400
Received: (qmail 11642 invoked by uid 102); 21 Aug 2013 20:52:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 Aug 2013 15:52:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Aug 2013 16:52:20 -0400
Content-Disposition: inline
In-Reply-To: <20130821204955.GA28025@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232733>

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
---
 builtin/index-pack.c              | 10 ++++++++++
 pack-write.c                      | 23 +++++++++++++++++++++++
 pack.h                            |  5 +++++
 t/t5308-pack-detect-duplicates.sh |  8 ++++++++
 4 files changed, 46 insertions(+)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9c1cfac..83fd3bb 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1369,6 +1369,16 @@ static int git_index_pack_config(const char *k, const char *v, void *cb)
 #endif
 		return 0;
 	}
+	if (!strcmp(k, "pack.indexduplicates")) {
+		int boolval = git_config_maybe_bool(k, v);
+		if (boolval > 0 || !strcmp(v, "ignore"))
+			opts->duplicates = WRITE_IDX_DUPLICATES_IGNORE;
+		else if (boolval == 0 || !strcmp(v, "reject"))
+			opts->duplicates = WRITE_IDX_DUPLICATES_REJECT;
+		else
+			die("unknown value for pack.indexduplicates: %s", v);
+		return 0;
+	}
 	return git_default_config(k, v, cb);
 }
 
diff --git a/pack-write.c b/pack-write.c
index ca9e63b..542b081 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -37,6 +37,19 @@ static int need_large_offset(off_t offset, const struct pack_idx_option *opts)
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
@@ -68,6 +81,16 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 	else
 		sorted_by_sha = list = last = NULL;
 
+	if (opts->duplicates == WRITE_IDX_DUPLICATES_REJECT) {
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
index aa6ee7d..cd4b536 100644
--- a/pack.h
+++ b/pack.h
@@ -44,6 +44,11 @@ struct pack_idx_option {
 	uint32_t version;
 	uint32_t off32_limit;
 
+	enum {
+		WRITE_IDX_DUPLICATES_IGNORE = 0,
+		WRITE_IDX_DUPLICATES_REJECT
+	} duplicates;
+
 	/*
 	 * List of offsets that would fit within off32_limit but
 	 * need to be written out as 64-bit entity for byte-for-byte
diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
index 4800379..0f2d928 100755
--- a/t/t5308-pack-detect-duplicates.sh
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -94,4 +94,12 @@ test_expect_success 'lookup in duplicated pack (GIT_USE_LOOKUP)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'index-pack can reject packs with duplicates' '
+	clear_packs &&
+	create_pack 2 >dups.pack &&
+	test_must_fail \
+		git -c pack.indexDuplicates=0 index-pack --stdin <dups.pack &&
+	test_expect_code 1 git cat-file -e $LO_SHA1
+'
+
 test_done
-- 
1.8.4.rc2.28.g6bb5f3f
