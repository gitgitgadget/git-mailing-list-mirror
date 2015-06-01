From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] add quieter versions of parse_{tree,commit}
Date: Mon, 1 Jun 2015 05:56:26 -0400
Message-ID: <20150601095625.GA31389@peff.net>
References: <20150601095410.GA16976@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 11:56:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzMSd-0002oP-4J
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 11:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbbFAJ4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 05:56:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:38662 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752823AbbFAJ43 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 05:56:29 -0400
Received: (qmail 22704 invoked by uid 102); 1 Jun 2015 09:56:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 04:56:28 -0500
Received: (qmail 27717 invoked by uid 107); 1 Jun 2015 09:56:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 05:56:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Jun 2015 05:56:26 -0400
Content-Disposition: inline
In-Reply-To: <20150601095410.GA16976@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270385>

When we call parse_commit, it will complain to stderr if the
object does not exist or cannot be read. This means that we
may produce useless error messages if this situation is
expected (e.g., because the object is marked UNINTERESTING,
or because revs->ignore_missing_links is set).

We can fix this by adding a new "parse_X_gently" form that
takes a flag to suppress the messages. The existing
"parse_X" form is already gentle in the sense that it
returns an error rather than dying, and we could in theory
just add a "quiet" flag to it (with existing callers passing
"0"). But doing it this way means we do not have to disturb
existing callers.

Note also that the new flag is "quiet_on_missing", and not
just "quiet". We could add a flag to suppress _all_ errors,
but besides being a more invasive change (we would have to
pass the flag down to sub-functions, too), there is a good
reason not to: we would never want to use it. Missing a
linked object is expected in some circumstances, but it is
never expected to have a malformed commit, or to get a tree
when we wanted a commit.  We should always complain about
these corruptions.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c | 5 +++--
 commit.h | 6 +++++-
 tree.c   | 5 +++--
 tree.h   | 6 +++++-
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index 2d9de80..6e2103c 100644
--- a/commit.c
+++ b/commit.c
@@ -357,7 +357,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 	return 0;
 }
 
-int parse_commit(struct commit *item)
+int parse_commit_gently(struct commit *item, int quiet_on_missing)
 {
 	enum object_type type;
 	void *buffer;
@@ -370,7 +370,8 @@ int parse_commit(struct commit *item)
 		return 0;
 	buffer = read_sha1_file(item->object.sha1, &type, &size);
 	if (!buffer)
-		return error("Could not read %s",
+		return quiet_on_missing ? -1 :
+			error("Could not read %s",
 			     sha1_to_hex(item->object.sha1));
 	if (type != OBJ_COMMIT) {
 		free(buffer);
diff --git a/commit.h b/commit.h
index ed3a1d5..9a1fa96 100644
--- a/commit.h
+++ b/commit.h
@@ -59,7 +59,11 @@ struct commit *lookup_commit_reference_by_name(const char *name);
 struct commit *lookup_commit_or_die(const unsigned char *sha1, const char *ref_name);
 
 int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size);
-int parse_commit(struct commit *item);
+int parse_commit_gently(struct commit *item, int quiet_on_missing);
+static inline int parse_commit(struct commit *item)
+{
+	return parse_commit_gently(item, 0);
+}
 void parse_commit_or_die(struct commit *item);
 
 /*
diff --git a/tree.c b/tree.c
index 58ebfce..413a5b1 100644
--- a/tree.c
+++ b/tree.c
@@ -204,7 +204,7 @@ int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
 	return 0;
 }
 
-int parse_tree(struct tree *item)
+int parse_tree_gently(struct tree *item, int quiet_on_missing)
 {
 	 enum object_type type;
 	 void *buffer;
@@ -214,7 +214,8 @@ int parse_tree(struct tree *item)
 		return 0;
 	buffer = read_sha1_file(item->object.sha1, &type, &size);
 	if (!buffer)
-		return error("Could not read %s",
+		return quiet_on_missing ? -1 :
+			error("Could not read %s",
 			     sha1_to_hex(item->object.sha1));
 	if (type != OBJ_TREE) {
 		free(buffer);
diff --git a/tree.h b/tree.h
index d24125f..d24786c 100644
--- a/tree.h
+++ b/tree.h
@@ -16,7 +16,11 @@ struct tree *lookup_tree(const unsigned char *sha1);
 
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size);
 
-int parse_tree(struct tree *tree);
+int parse_tree_gently(struct tree *tree, int quiet_on_missing);
+static inline int parse_tree(struct tree *tree)
+{
+	return parse_tree_gently(tree, 0);
+}
 void free_tree_buffer(struct tree *tree);
 
 /* Parses and returns the tree in the given ent, chasing tags and commits. */
-- 
2.4.2.690.g2a79674
