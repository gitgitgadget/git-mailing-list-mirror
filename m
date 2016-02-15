From: Jeff King <peff@peff.net>
Subject: [PATCH 11/18] fetch-pack: simplify add_sought_entry
Date: Mon, 15 Feb 2016 16:54:57 -0500
Message-ID: <20160215215457.GK10287@sigill.intra.peff.net>
References: <20160215214516.GA4015@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 22:55:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVR6o-00038k-IV
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 22:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbcBOVzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 16:55:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:42501 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752608AbcBOVzA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 16:55:00 -0500
Received: (qmail 2653 invoked by uid 102); 15 Feb 2016 21:55:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 16:55:00 -0500
Received: (qmail 12538 invoked by uid 107); 15 Feb 2016 21:55:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 16:55:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 16:54:57 -0500
Content-Disposition: inline
In-Reply-To: <20160215214516.GA4015@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286267>

We have two variants of this function, one that takes a
string and one that takes a ptr/len combo. But we only call
the latter with the length of a NUL-terminated string, so
our first simplification is to drop it in favor of the
string variant.

Since we know we have a string, we can also replace the
manual memory computation with a call to alloc_ref().

Furthermore, we can rely on get_oid_hex() to complain if it
hits the end of the string. That means we can simplify the
check for "<sha1> <ref>" versus just "<ref>". Rather than
manage the ptr/len pair, we can just bump the start of our
string forward. The original code over-allocated based on
the original "namelen" (which wasn't _wrong_, but was simply
wasteful and confusing).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch-pack.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 9b2a514..79a611f 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -10,33 +10,24 @@ static const char fetch_pack_usage[] =
 "[--include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] "
 "[--no-progress] [--diag-url] [-v] [<host>:]<directory> [<refs>...]";
 
-static void add_sought_entry_mem(struct ref ***sought, int *nr, int *alloc,
-				 const char *name, int namelen)
+static void add_sought_entry(struct ref ***sought, int *nr, int *alloc,
+			     const char *name)
 {
-	struct ref *ref = xcalloc(1, sizeof(*ref) + namelen + 1);
+	struct ref *ref;
 	struct object_id oid;
-	const int chunksz = GIT_SHA1_HEXSZ + 1;
 
-	if (namelen > chunksz && name[chunksz - 1] == ' ' &&
-		!get_oid_hex(name, &oid)) {
-		oidcpy(&ref->old_oid, &oid);
-		name += chunksz;
-		namelen -= chunksz;
-	}
+	if (!get_oid_hex(name, &oid) && name[GIT_SHA1_HEXSZ] == ' ')
+		name += GIT_SHA1_HEXSZ + 1;
+	else
+		oidclr(&oid);
 
-	memcpy(ref->name, name, namelen);
-	ref->name[namelen] = '\0';
+	ref = alloc_ref(name);
+	oidcpy(&ref->old_oid, &oid);
 	(*nr)++;
 	ALLOC_GROW(*sought, *nr, *alloc);
 	(*sought)[*nr - 1] = ref;
 }
 
-static void add_sought_entry(struct ref ***sought, int *nr, int *alloc,
-			     const char *string)
-{
-	add_sought_entry_mem(sought, nr, alloc, string, strlen(string));
-}
-
 int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, ret;
-- 
2.7.1.572.gf718037
