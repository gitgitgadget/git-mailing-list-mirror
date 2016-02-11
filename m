From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] show_object_with_name: simplify by using path_name()
Date: Thu, 11 Feb 2016 17:24:18 -0500
Message-ID: <20160211222418.GB586@sigill.intra.peff.net>
References: <20160211222314.GA31625@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 23:24:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTzey-0004Lh-S9
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 23:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbcBKWYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 17:24:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:40755 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750765AbcBKWYU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 17:24:20 -0500
Received: (qmail 24450 invoked by uid 102); 11 Feb 2016 22:24:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Feb 2016 17:24:20 -0500
Received: (qmail 11734 invoked by uid 107); 11 Feb 2016 22:24:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Feb 2016 17:24:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Feb 2016 17:24:18 -0500
Content-Disposition: inline
In-Reply-To: <20160211222314.GA31625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286010>

When "git rev-list" shows an object with its associated path
name, it does so by walking the name_path linked list and
printing each component (stopping at any embedded NULs or
newlines).

We'd like to eventually get rid of name_path entirely in
favor of a single buffer, and dropping this custom printing
code is part of that. As a first step, let's use path_name()
to format the list into a single buffer, and print that.
This is strictly less efficient than the original, but it's
a temporary step in the refactoring; our end game will be to
get the fully formatted name in the first place.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c | 40 ++++++----------------------------------
 1 file changed, 6 insertions(+), 34 deletions(-)

diff --git a/revision.c b/revision.c
index f24ead5..6387068 100644
--- a/revision.c
+++ b/revision.c
@@ -49,46 +49,18 @@ char *path_name(const struct name_path *path, const char *name)
 	return n;
 }
 
-static int show_path_component_truncated(FILE *out, const char *name, int len)
-{
-	int cnt;
-	for (cnt = 0; cnt < len; cnt++) {
-		int ch = name[cnt];
-		if (!ch || ch == '\n')
-			return -1;
-		fputc(ch, out);
-	}
-	return len;
-}
-
-static int show_path_truncated(FILE *out, const struct name_path *path)
-{
-	int emitted, ours;
-
-	if (!path)
-		return 0;
-	emitted = show_path_truncated(out, path->up);
-	if (emitted < 0)
-		return emitted;
-	if (emitted)
-		fputc('/', out);
-	ours = show_path_component_truncated(out, path->elem, path->elem_len);
-	if (ours < 0)
-		return ours;
-	return ours || emitted;
-}
-
 void show_object_with_name(FILE *out, struct object *obj,
 			   const struct name_path *path, const char *component)
 {
-	struct name_path leaf;
-	leaf.up = (struct name_path *)path;
-	leaf.elem = component;
-	leaf.elem_len = strlen(component);
+	char *name = path_name(path, component);
+	char *p;
 
 	fprintf(out, "%s ", oid_to_hex(&obj->oid));
-	show_path_truncated(out, &leaf);
+	for (p = name; *p && *p != '\n'; p++)
+		fputc(*p, out);
 	fputc('\n', out);
+
+	free(name);
 }
 
 static void mark_blob_uninteresting(struct blob *blob)
-- 
2.7.1.550.gf5fcbd3
