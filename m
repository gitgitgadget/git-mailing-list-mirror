From: Jeff King <peff@peff.net>
Subject: [PATCH 41/67] apply: convert root string to strbuf
Date: Tue, 15 Sep 2015 11:57:20 -0400
Message-ID: <20150915155720.GO29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:57:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbsbo-00049N-IB
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717AbbIOP5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:57:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:59399 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752393AbbIOP5X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:57:23 -0400
Received: (qmail 13297 invoked by uid 102); 15 Sep 2015 15:57:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:57:22 -0500
Received: (qmail 7555 invoked by uid 107); 15 Sep 2015 15:57:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:57:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:57:20 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277944>

We use manual computation and strcpy to allocate the "root"
variable. This would be much simpler using xstrfmt.  But
since we store the length, too, we can just use a strbuf,
which handles that for us.

Note that we stop distinguishing between "no root" and
"empty root" in some cases, but that's OK; the results are
the same (e.g., inserting an empty string is a noop).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/apply.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 094a20f..1d4d439 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -77,8 +77,7 @@ static enum ws_ignore {
 
 
 static const char *patch_input_file;
-static const char *root;
-static int root_len;
+struct strbuf root = STRBUF_INIT;
 static int read_stdin = 1;
 static int options;
 
@@ -494,8 +493,8 @@ static char *find_name_gnu(const char *line, const char *def, int p_value)
 	}
 
 	strbuf_remove(&name, 0, cp - name.buf);
-	if (root)
-		strbuf_insert(&name, 0, root, root_len);
+	if (root.len)
+		strbuf_insert(&name, 0, root.buf, root.len);
 	return squash_slash(strbuf_detach(&name, NULL));
 }
 
@@ -697,8 +696,8 @@ static char *find_name_common(const char *line, const char *def,
 			return squash_slash(xstrdup(def));
 	}
 
-	if (root) {
-		char *ret = xstrfmt("%s%.*s", root, len, start);
+	if (root.len) {
+		char *ret = xstrfmt("%s%.*s", root.buf, len, start);
 		return squash_slash(ret);
 	}
 
@@ -1274,8 +1273,8 @@ static int parse_git_header(const char *line, int len, unsigned int size, struct
 	 * the default name from the header.
 	 */
 	patch->def_name = git_header_name(line, len);
-	if (patch->def_name && root) {
-		char *s = xstrfmt("%s%s", root, patch->def_name);
+	if (patch->def_name && root.len) {
+		char *s = xstrfmt("%s%s", root.buf, patch->def_name);
 		free(patch->def_name);
 		patch->def_name = s;
 	}
@@ -4498,14 +4497,9 @@ static int option_parse_whitespace(const struct option *opt,
 static int option_parse_directory(const struct option *opt,
 				  const char *arg, int unset)
 {
-	root_len = strlen(arg);
-	if (root_len && arg[root_len - 1] != '/') {
-		char *new_root;
-		root = new_root = xmalloc(root_len + 2);
-		strcpy(new_root, arg);
-		strcpy(new_root + root_len++, "/");
-	} else
-		root = arg;
+	strbuf_reset(&root);
+	strbuf_addstr(&root, arg);
+	strbuf_complete(&root, '/');
 	return 0;
 }
 
-- 
2.6.0.rc2.408.ga2926b9
