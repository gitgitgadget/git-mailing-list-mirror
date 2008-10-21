From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] rm: loosen safety valve for empty files
Date: Mon, 20 Oct 2008 20:37:12 -0400
Message-ID: <20081021003712.GB32569@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 02:38:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks5Ga-0001YS-HP
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 02:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037AbYJUAhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 20:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754930AbYJUAhQ
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 20:37:16 -0400
Received: from peff.net ([208.65.91.99]:3211 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754840AbYJUAhP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 20:37:15 -0400
Received: (qmail 17065 invoked by uid 111); 21 Oct 2008 00:37:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 20 Oct 2008 20:37:13 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Oct 2008 20:37:12 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98750>

If a file is different between the working tree copy, the
index, and the HEAD, then we do not allow it to be deleted
without --force.

However, this is overly tight in the face of "git add
--intent-to-add":

  $ git add --intent-to-add file
  $ : oops, I don't actually want to stage that yet
  $ git rm --cached file
  error: 'file' has staged content different from both the
  file and the HEAD (use -f to force removal)
  $ git rm -f --cached file

This patch loosens the safety valve to allow the deletion
only if we are deleting the cached entry and the cached
content is empty.

This covers the intent-to-add situation, and presumably
there is little harm in not protecting users who have
legitimately added an empty file. In many cases, the file
will still be empty, in which case the safety valve does not
trigger anyway (since the content remains untouched in the
working tree). Otherwise, we do remove the fact that no
content was staged, but given that the content is by
definition empty, it is not terribly difficult for a user to
recreate it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-rm.c  |    3 ++-
 cache.h       |    1 +
 read-cache.c  |    2 +-
 t/t3600-rm.sh |    7 +++++++
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin-rm.c b/builtin-rm.c
index e06640c..b7126e3 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -79,7 +79,8 @@ static int check_local_mod(unsigned char *head, int index_only)
 		     || hashcmp(ce->sha1, sha1))
 			staged_changes = 1;
 
-		if (local_changes && staged_changes)
+		if (local_changes && staged_changes &&
+		    !(index_only && is_empty_blob_sha1(ce->sha1)))
 			errs = error("'%s' has staged content different "
 				     "from both the file and the HEAD\n"
 				     "(use -f to force removal)", name);
diff --git a/cache.h b/cache.h
index ae6647e..7141705 100644
--- a/cache.h
+++ b/cache.h
@@ -517,6 +517,7 @@ static inline void hashclr(unsigned char *hash)
 {
 	memset(hash, 0, 20);
 }
+extern int is_empty_blob_sha1(const unsigned char *sha1);
 
 int git_mkstemp(char *path, size_t n, const char *template);
 
diff --git a/read-cache.c b/read-cache.c
index 780f2c7..d624cb3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -160,7 +160,7 @@ static int ce_modified_check_fs(struct cache_entry *ce, struct stat *st)
 	return 0;
 }
 
-static int is_empty_blob_sha1(const unsigned char *sha1)
+int is_empty_blob_sha1(const unsigned char *sha1)
 {
 	static const unsigned char empty_blob_sha1[20] = {
 		0xe6,0x9d,0xe2,0x9b,0xb2,0xd1,0xd6,0x43,0x4b,0x8b,
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 66aca99..88ae672 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -187,6 +187,13 @@ test_expect_success 'but with -f it should work.' '
 	test_must_fail git ls-files --error-unmatch baz
 '
 
+test_expect_success 'ok to remove cached empty file' '
+	touch empty &&
+	git add empty &&
+	echo content >empty &&
+	git rm --cached empty
+'
+
 test_expect_success 'Recursive test setup' '
 	mkdir -p frotz &&
 	echo qfwfq >frotz/nitfol &&
-- 
1.6.0.2.770.gb4241.dirty
