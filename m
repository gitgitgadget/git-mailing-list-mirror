From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH] fsck: do not canonicalize modes in trees we are checking
Date: Tue, 23 Sep 2014 11:47:51 -0400
Message-ID: <20140923154751.GA19319@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Kirill Smelkov <kirr@mns.spb.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 17:48:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWSJs-0004V9-3Z
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 17:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558AbaIWPr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 11:47:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:50956 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752169AbaIWPrz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 11:47:55 -0400
Received: (qmail 25843 invoked by uid 102); 23 Sep 2014 15:47:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Sep 2014 10:47:54 -0500
Received: (qmail 28997 invoked by uid 107); 23 Sep 2014 15:48:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Sep 2014 11:48:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Sep 2014 11:47:51 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257422>

Doing so means that we do not actually get to see bogus
modes; they are converted into one of our known-good modes
by decode_tree_entry. We want to see the raw data so that we
can complain about it.

Signed-off-by: Jeff King <peff@peff.net>
---
As far as I can tell, fsck's mode-checking has been totally broken
basically forever. Which makes me a little nervous to fix it. :)
linux.git does have some bogus modes, but they are 100664, which is
specifically ignored here unless "fsck --strict" is in effect.

The implementation feels a bit hacky. The global is ugly, but it avoids
having to pass options all through the call chain of init_tree_entry,
update_tree_entry, etc.

Another option would be to have decode_tree_entry leave the raw mode in
the tree_desc, and only canonicalize it during tree_entry_extract (and
teach fsck to look at the raw data, not _extract). That would mean
reverting 7146e66 (tree-walk: finally switch over tree descriptors to
contain a pre-parsed entry, 2014-02-06). That commit says there's no
real benefit at the time, but that future code might benefit. I don't
know if that future code ever materialized (Kirill cc'd).

I thought at first that commit might have been responsible for this
breakage, but I don't think so. The canonicalization has happened in
tree_entry_extract since at least 2006, and we have always called that
function in fsck.

 fsck.c          |  2 ++
 t/t1450-fsck.sh | 21 +++++++++++++++++++++
 tree-walk.c     |  4 +++-
 tree-walk.h     |  3 +++
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index 56156ff..ef79396 100644
--- a/fsck.c
+++ b/fsck.c
@@ -153,6 +153,7 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 	unsigned o_mode;
 	const char *o_name;
 
+	decode_tree_raw = 1;
 	init_tree_desc(&desc, item->buffer, item->size);
 
 	o_mode = 0;
@@ -213,6 +214,7 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 		o_name = name;
 	}
 
+	decode_tree_raw = 0;
 	retval = 0;
 	if (has_null_sha1)
 		retval += error_func(&item->object, FSCK_WARN, "contains entries pointing to null sha1");
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index b52397a..ba40c6f 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -176,6 +176,27 @@ test_expect_success 'malformatted tree object' '
 	grep "error in tree .*contains duplicate file entries" out
 '
 
+# Basically an 8-bit clean version of sed 's/$1/$2/g'.
+munge_tree_bytes () {
+	perl -e '
+		binmode(STDIN); binmode(STDOUT);
+		$_ = do { local $/; <STDIN> };
+		s/$ARGV[0]/$ARGV[1]/g;
+		print
+	' "$@"
+}
+
+test_expect_success 'bogus mode in tree' '
+	test_when_finished "remove_object \$T" &&
+	T=$(
+		git cat-file tree HEAD >good &&
+		munge_tree_bytes 100644 123456 <good >bad &&
+		git hash-object -w -t tree bad
+	) &&
+	git fsck 2>out &&
+	grep "warning.*contains bad file modes" out
+'
+
 test_expect_success 'tag pointing to nonexistent' '
 	cat >invalid-tag <<-\EOF &&
 	object ffffffffffffffffffffffffffffffffffffffff
diff --git a/tree-walk.c b/tree-walk.c
index 5dd9a71..baca766 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -5,6 +5,8 @@
 #include "tree.h"
 #include "pathspec.h"
 
+int decode_tree_raw;
+
 static const char *get_mode(const char *str, unsigned int *modep)
 {
 	unsigned char c;
@@ -37,7 +39,7 @@ static void decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned
 
 	/* Initialize the descriptor entry */
 	desc->entry.path = path;
-	desc->entry.mode = canon_mode(mode);
+	desc->entry.mode = decode_tree_raw ? mode : canon_mode(mode);
 	desc->entry.sha1 = (const unsigned char *)(path + len);
 }
 
diff --git a/tree-walk.h b/tree-walk.h
index ae7fb3a..9f78e85 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -25,6 +25,9 @@ static inline int tree_entry_len(const struct name_entry *ne)
 	return (const char *)ne->sha1 - ne->path - 1;
 }
 
+/* If set, do not canonicalize modes in tree entries. */
+extern int decode_tree_raw;
+
 void update_tree_entry(struct tree_desc *);
 void init_tree_desc(struct tree_desc *desc, const void *buf, unsigned long size);
 
-- 
2.1.1.496.g1ba8081
