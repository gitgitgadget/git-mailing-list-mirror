From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] log-tree: make name_decoration hash static
Date: Tue, 26 Aug 2014 06:23:54 -0400
Message-ID: <20140826102353.GB25687@peff.net>
References: <20140826102051.GA4885@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 12:24:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMDuy-0007Ie-IS
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 12:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934454AbaHZKX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 06:23:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:59061 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932729AbaHZKXz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 06:23:55 -0400
Received: (qmail 9557 invoked by uid 102); 26 Aug 2014 10:23:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Aug 2014 05:23:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2014 06:23:54 -0400
Content-Disposition: inline
In-Reply-To: <20140826102051.GA4885@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255885>

In the previous commit, we made add_name_decoration global
so that adders would not have to access the hash directly.
We now make the hash itself static so that callers _have_ to
add through our function, making sure that all additions go
through a single point.  To do this, we have to add one more
accessor function: a way to lookup entries in the hash.

Since the only caller doesn't actually look at the returned
value, but rather only asks whether there is a decoration or
not, we could provide only a boolean "has_name_decoration".
That would allow us to make "struct name_decoration" local
to log-tree, as well.

However, it's unlikely to cause any maintainability harm
making the actual data public, and this interface is more
flexible if we need to look at decorations from other parts
of the code in the future.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.h   |  2 +-
 log-tree.c | 11 ++++++++---
 revision.c |  2 +-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/commit.h b/commit.h
index 4902f97..263b49e 100644
--- a/commit.h
+++ b/commit.h
@@ -26,7 +26,6 @@ extern int save_commit_buffer;
 extern const char *commit_type;
 
 /* While we can decorate any object with a name, it's only used for commits.. */
-extern struct decoration name_decoration;
 struct name_decoration {
 	struct name_decoration *next;
 	int type;
@@ -44,6 +43,7 @@ enum decoration_type {
 };
 
 void add_name_decoration(enum decoration_type type, const char *name, struct object *obj);
+const struct name_decoration *get_name_decoration(const struct object *obj);
 
 struct commit *lookup_commit(const unsigned char *sha1);
 struct commit *lookup_commit_reference(const unsigned char *sha1);
diff --git a/log-tree.c b/log-tree.c
index a821258..7cbc4ee 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -12,7 +12,7 @@
 #include "sequencer.h"
 #include "line-log.h"
 
-struct decoration name_decoration = { "object names" };
+static struct decoration name_decoration = { "object names" };
 
 static char decoration_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
@@ -83,6 +83,11 @@ void add_name_decoration(enum decoration_type type, const char *name, struct obj
 	res->next = add_decoration(&name_decoration, obj, res);
 }
 
+const struct name_decoration *get_name_decoration(const struct object *obj)
+{
+	return lookup_decoration(&name_decoration, obj);
+}
+
 static int add_ref_decoration(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct object *obj;
@@ -177,13 +182,13 @@ void format_decorations(struct strbuf *sb,
 			int use_color)
 {
 	const char *prefix;
-	struct name_decoration *decoration;
+	const struct name_decoration *decoration;
 	const char *color_commit =
 		diff_get_color(use_color, DIFF_COMMIT);
 	const char *color_reset =
 		decorate_get_color(use_color, DECORATION_NONE);
 
-	decoration = lookup_decoration(&name_decoration, &commit->object);
+	decoration = get_name_decoration(&commit->object);
 	if (!decoration)
 		return;
 	prefix = " (";
diff --git a/revision.c b/revision.c
index 2571ada..5aff2b4 100644
--- a/revision.c
+++ b/revision.c
@@ -473,7 +473,7 @@ static int rev_compare_tree(struct rev_info *revs,
 		 * If we are simplifying by decoration, then the commit
 		 * is worth showing if it has a tag pointing at it.
 		 */
-		if (lookup_decoration(&name_decoration, &commit->object))
+		if (get_name_decoration(&commit->object))
 			return REV_TREE_DIFFERENT;
 		/*
 		 * A commit that is not pointed by a tag is uninteresting
-- 
2.1.0.346.ga0367b9
