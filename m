From: Jeff King <peff@peff.net>
Subject: [PATCH 16/16] write_sha1_file: freshen existing objects
Date: Fri, 3 Oct 2014 16:41:10 -0400
Message-ID: <20141003204110.GP16293@peff.net>
References: <20141003202045.GA15205@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 22:41:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa9fA-0006d4-UX
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 22:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbaJCUlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 16:41:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:54881 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750832AbaJCUlM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 16:41:12 -0400
Received: (qmail 3662 invoked by uid 102); 3 Oct 2014 20:41:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 15:41:12 -0500
Received: (qmail 15313 invoked by uid 107); 3 Oct 2014 20:41:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 16:41:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Oct 2014 16:41:10 -0400
Content-Disposition: inline
In-Reply-To: <20141003202045.GA15205@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257869>

When we try to write a loose object file, we first check
whether that object already exists. If so, we skip the
write as an optimization. However, this can interfere with
prune's strategy of using mtimes to mark files in progress.

For example, if a branch contains a particular tree object
and is deleted, that tree object may become unreachable, and
have an old mtime. If a new operation then tries to write
the same tree, this ends up as a noop; we notice we
already have the object and do nothing. A prune running
simultaneously with this operation will see the object as
old, and may delete it.

We can solve this by "freshening" objects that we avoid
writing by updating their mtime. The algorithm for doing so
is essentially the same as that of has_sha1_file. Therefore
we provide a new (static) interface "check_and_freshen",
which finds and optionally freshens the object. It's trivial
to implement freshening and simple checking by tweaking a
single parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c                | 51 +++++++++++++++++++++++++++++++++++++++-------
 t/t6501-freshen-objects.sh | 27 ++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index d017289..d263b38 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -442,27 +442,53 @@ void prepare_alt_odb(void)
 	read_info_alternates(get_object_directory(), 0);
 }
 
-static int has_loose_object_local(const unsigned char *sha1)
+static int freshen_file(const char *fn)
 {
-	return !access(sha1_file_name(sha1), F_OK);
+	struct utimbuf t;
+	t.actime = t.modtime = time(NULL);
+	return utime(fn, &t);
 }
 
-int has_loose_object_nonlocal(const unsigned char *sha1)
+static int check_and_freshen_file(const char *fn, int freshen)
+{
+	if (access(fn, F_OK))
+		return 0;
+	if (freshen && freshen_file(fn))
+		return 0;
+	return 1;
+}
+
+static int check_and_freshen_local(const unsigned char *sha1, int freshen)
+{
+	return check_and_freshen_file(sha1_file_name(sha1), freshen);
+}
+
+static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
 {
 	struct alternate_object_database *alt;
 	prepare_alt_odb();
 	for (alt = alt_odb_list; alt; alt = alt->next) {
 		fill_sha1_path(alt->name, sha1);
-		if (!access(alt->base, F_OK))
+		if (check_and_freshen_file(alt->base, freshen))
 			return 1;
 	}
 	return 0;
 }
 
+static int check_and_freshen(const unsigned char *sha1, int freshen)
+{
+	return check_and_freshen_local(sha1, freshen) ||
+	       check_and_freshen_nonlocal(sha1, freshen);
+}
+
+int has_loose_object_nonlocal(const unsigned char *sha1)
+{
+	return check_and_freshen_nonlocal(sha1, 0);
+}
+
 static int has_loose_object(const unsigned char *sha1)
 {
-	return has_loose_object_local(sha1) ||
-	       has_loose_object_nonlocal(sha1);
+	return check_and_freshen(sha1, 0);
 }
 
 static unsigned int pack_used_ctr;
@@ -2949,6 +2975,17 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	return move_temp_to_file(tmp_file, filename);
 }
 
+static int freshen_loose_object(const unsigned char *sha1)
+{
+	return check_and_freshen(sha1, 1);
+}
+
+static int freshen_packed_object(const unsigned char *sha1)
+{
+	struct pack_entry e;
+	return find_pack_entry(sha1, &e) && freshen_file(e.p->pack_name);
+}
+
 int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
 {
 	unsigned char sha1[20];
@@ -2961,7 +2998,7 @@ int write_sha1_file(const void *buf, unsigned long len, const char *type, unsign
 	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
 	if (returnsha1)
 		hashcpy(returnsha1, sha1);
-	if (has_sha1_file(sha1))
+	if (freshen_loose_object(sha1) || freshen_packed_object(sha1))
 		return 0;
 	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
 }
diff --git a/t/t6501-freshen-objects.sh b/t/t6501-freshen-objects.sh
index e25c47d..157f3f9 100755
--- a/t/t6501-freshen-objects.sh
+++ b/t/t6501-freshen-objects.sh
@@ -100,6 +100,33 @@ for repack in '' true; do
 	test_expect_success "repository passes fsck ($title)" '
 		git fsck
 	'
+
+	test_expect_success "abandon objects again ($title)" '
+		git reset --hard HEAD^ &&
+		find .git/objects -type f |
+		xargs test-chmtime -v -86400
+	'
+
+	test_expect_success "start writing new commit with same tree ($title)" '
+		tree=$(
+			GIT_INDEX_FILE=index.tmp &&
+			export GIT_INDEX_FILE &&
+			git read-tree HEAD &&
+			add abandon &&
+			add unrelated &&
+			git write-tree
+		)
+	'
+
+	test_expect_success "simultaneous gc ($title)" '
+		git gc --prune=12.hours.ago
+	'
+
+	# tree should have been refreshed by write-tree
+	test_expect_success "finish writing out commit ($title)" '
+		commit=$(echo foo | git commit-tree -p HEAD $tree) &&
+		git update-ref HEAD $commit
+	'
 done
 
 test_done
-- 
2.1.1.566.gdb1f904
