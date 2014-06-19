From: Jeff King <peff@peff.net>
Subject: [PATCH 17/16] http-push: refactor parsing of remote object names
Date: Thu, 19 Jun 2014 17:58:10 -0400
Message-ID: <20140619215810.GA29685@sigill.intra.peff.net>
References: <20140618194117.GA22269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 23:58:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxkLZ-0006zA-8g
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 23:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965489AbaFSV6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 17:58:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:47827 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965317AbaFSV6M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 17:58:12 -0400
Received: (qmail 18753 invoked by uid 102); 19 Jun 2014 21:58:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jun 2014 16:58:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jun 2014 17:58:10 -0400
Content-Disposition: inline
In-Reply-To: <20140618194117.GA22269@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252196>

We get loose object names like "objects/??/..." from the
remote side, and need to convert them to their hex
representation.

The code to do so is rather hard to follow, as it uses some
calculated lengths whose origins are hard to understand and
verify (e.g., the path must be exactly 49 characters long.
why? Why doesn't the strcpy overflow obj_hex, which is the
same length as path?).

We can simplify this a bit by using skip_prefix, using standard
40- and 20-character buffers for hex and binary sha1s, and
adding some comments.

We also drop a totally bogus comment that claims strlcpy
cannot be used because "path" is not NUL-terminated. Right
between a call to strlen(path) and strcpy(path).

Signed-off-by: Jeff King <peff@peff.net>
---
I found this one while doing the xstrfmt series, but it actually doesn't
need xstrfmt, and does need skip_prefix, so it probably goes better on
the skip-prefix topic.

It's still a little more magical than I would like, but I think this is
the best we can do while still building on get_sha1_hex. Parsing it
left-to-right would be better, but we would essentially end up
reimplementing get_sha1_hex.

 http-push.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/http-push.c b/http-push.c
index 26dfa67..c5c95e8 100644
--- a/http-push.c
+++ b/http-push.c
@@ -719,14 +719,10 @@ static int fetch_indices(void)
 	return ret;
 }
 
-static void one_remote_object(const char *hex)
+static void one_remote_object(const unsigned char *sha1)
 {
-	unsigned char sha1[20];
 	struct object *obj;
 
-	if (get_sha1_hex(hex, sha1) != 0)
-		return;
-
 	obj = lookup_object(sha1);
 	if (!obj)
 		obj = parse_object(sha1);
@@ -1020,26 +1016,38 @@ static void remote_ls(const char *path, int flags,
 		      void (*userFunc)(struct remote_ls_ctx *ls),
 		      void *userData);
 
+/* extract hex from sharded "xx/x{40}" filename */
+static int get_sha1_hex_from_objpath(const char *path, unsigned char *sha1)
+{
+	char hex[40];
+
+	if (strlen(path) != 41)
+		return -1;
+
+	memcpy(hex, path, 2);
+	path += 2;
+	path++; /* skip '/' */
+	memcpy(hex, path, 38);
+
+	return get_sha1_hex(hex, sha1);
+}
+
 static void process_ls_object(struct remote_ls_ctx *ls)
 {
 	unsigned int *parent = (unsigned int *)ls->userData;
-	char *path = ls->dentry_name;
-	char *obj_hex;
+	const char *path = ls->dentry_name;
+	unsigned char sha1[20];
 
 	if (!strcmp(ls->path, ls->dentry_name) && (ls->flags & IS_DIR)) {
 		remote_dir_exists[*parent] = 1;
 		return;
 	}
 
-	if (strlen(path) != 49)
+	if (!skip_prefix(path, "objects/", &path) ||
+	    get_sha1_hex_from_objpath(path, sha1))
 		return;
-	path += 8;
-	obj_hex = xmalloc(strlen(path));
-	/* NB: path is not null-terminated, can not use strlcpy here */
-	memcpy(obj_hex, path, 2);
-	strcpy(obj_hex + 2, path + 3);
-	one_remote_object(obj_hex);
-	free(obj_hex);
+
+	one_remote_object(sha1);
 }
 
 static void process_ls_ref(struct remote_ls_ctx *ls)
-- 
2.0.0.566.gfe3e6b2
