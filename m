From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] hard-code the empty tree object
Date: Thu, 14 Feb 2008 05:32:56 -0500
Message-ID: <20080214103256.GA17951@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kate Rhodes <masukomi@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 11:33:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPbPM-0004FV-UN
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 11:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567AbYBNKdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 05:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753495AbYBNKdA
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 05:33:00 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4042 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753270AbYBNKc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 05:32:59 -0500
Received: (qmail 4159 invoked by uid 111); 14 Feb 2008 10:32:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 14 Feb 2008 05:32:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2008 05:32:56 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73870>

This maps sha1 4b825dc642cb6eb9a060e54bf8d69288fbee4904 to
the empty tree object, whether such an object exists in the
object database or not. The empty tree is useful for showing
some specialized diffs, especially for initial commits.

We also hard-code the special ref '{}' as an alias for the
empty tree. Users may refer to the empty tree by its
sha1 or by '{}'.

Thanks to Johannes Schindelin for the '{}' syntax and
implementation.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a cleaned-up version of what's in pu, along with the magic ref
syntax from Johannes (2/2 will have the fixes to "git add -i").

 cache.h     |    5 +++++
 sha1_file.c |    9 +++++++++
 sha1_name.c |    5 +++++
 3 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 3867ba7..e3abbe1 100644
--- a/cache.h
+++ b/cache.h
@@ -253,6 +253,11 @@ static inline enum object_type object_type(unsigned int mode)
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
 
+/* empty tree sha1: 4b825dc642cb6eb9a060e54bf8d69288fbee4904 */
+#define EMPTY_TREE_SHA1 \
+	"\x4b\x82\x5d\xc6\x42\xcb\x6e\xb9\xa0\x60" \
+	"\xe5\x4b\xf8\xd6\x92\x88\xfb\xee\x49\x04"
+
 extern int is_bare_repository_cfg;
 extern int is_bare_repository(void);
 extern int is_inside_git_dir(void);
diff --git a/sha1_file.c b/sha1_file.c
index 66a4e00..8068a4b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1845,6 +1845,13 @@ static struct cached_object {
 } *cached_objects;
 static int cached_object_nr, cached_object_alloc;
 
+static struct cached_object empty_tree = {
+	EMPTY_TREE_SHA1,
+	OBJ_TREE,
+	"",
+	0
+};
+
 static struct cached_object *find_cached_object(const unsigned char *sha1)
 {
 	int i;
@@ -1854,6 +1861,8 @@ static struct cached_object *find_cached_object(const unsigned char *sha1)
 		if (!hashcmp(co->sha1, sha1))
 			return co;
 	}
+	if (!hashcmp(sha1, empty_tree.sha1))
+		return &empty_tree;
 	return NULL;
 }
 
diff --git a/sha1_name.c b/sha1_name.c
index be8489e..165aa7d 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -716,5 +716,10 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 			return get_tree_entry(tree_sha1, cp+1, sha1,
 					      mode);
 	}
+	if (ret && !strcmp(name, "{}")) {
+		*mode = 0755;
+		hashcpy(sha1, (unsigned char *)EMPTY_TREE_SHA1);
+		ret = 0;
+	}
 	return ret;
 }
-- 
1.5.4.1.123.ge4e8d-dirty
