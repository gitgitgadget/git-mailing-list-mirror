From: Jeff King <peff@peff.net>
Subject: [PATCH v2 05/10] use xstrfmt to replace xmalloc + strcpy/strcat
Date: Thu, 19 Jun 2014 17:26:56 -0400
Message-ID: <20140619212656.GE28474@sigill.intra.peff.net>
References: <20140619211659.GA32412@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 23:27:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxjrM-0008Gi-Jy
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 23:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965669AbaFSV1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 17:27:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:47789 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964845AbaFSV06 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 17:26:58 -0400
Received: (qmail 17094 invoked by uid 102); 19 Jun 2014 21:26:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jun 2014 16:26:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jun 2014 17:26:56 -0400
Content-Disposition: inline
In-Reply-To: <20140619211659.GA32412@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252188>

It's easy to get manual allocation calculations wrong, and
the use of strcpy/strcat raise red flags for people looking
for buffer overflows (though in this case each site was
fine).

It's also shorter to use xstrfmt, and the printf-format
tends to be easier for a reader to see what the final string
will look like.

Signed-off-by: Jeff King <peff@peff.net>
---
By the way, I think that the tip_name allocation in name_rev leaks
badly, but it's a little tricky to fix (we sometimes hand off ownership
of the variable, and sometimes not). However, this patch does not make
it any worse, and nobody is complaining, so I left it for now.

 builtin/apply.c    | 4 +---
 builtin/fetch.c    | 9 ++-------
 builtin/name-rev.c | 5 +----
 sha1_name.c        | 5 +----
 shell.c            | 6 +-----
 5 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 9c5724e..b796910 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1281,9 +1281,7 @@ static int parse_git_header(const char *line, int len, unsigned int size, struct
 	 */
 	patch->def_name = git_header_name(line, len);
 	if (patch->def_name && root) {
-		char *s = xmalloc(root_len + strlen(patch->def_name) + 1);
-		strcpy(s, root);
-		strcpy(s + root_len, patch->def_name);
+		char *s = xstrfmt("%s%s", root, patch->def_name);
 		free(patch->def_name);
 		patch->def_name = s;
 	}
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 55f457c..40d989f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1053,16 +1053,11 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 		refs = xcalloc(argc + 1, sizeof(const char *));
 		for (i = 0; i < argc; i++) {
 			if (!strcmp(argv[i], "tag")) {
-				char *ref;
 				i++;
 				if (i >= argc)
 					die(_("You need to specify a tag name."));
-				ref = xmalloc(strlen(argv[i]) * 2 + 22);
-				strcpy(ref, "refs/tags/");
-				strcat(ref, argv[i]);
-				strcat(ref, ":refs/tags/");
-				strcat(ref, argv[i]);
-				refs[j++] = ref;
+				refs[j++] = xstrfmt("refs/tags/%s:refs/tags/%s",
+						    argv[i], argv[i]);
 			} else
 				refs[j++] = argv[i];
 		}
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index c824d4e..3c8f319 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -33,10 +33,7 @@ static void name_rev(struct commit *commit,
 		return;
 
 	if (deref) {
-		char *new_name = xmalloc(strlen(tip_name)+3);
-		strcpy(new_name, tip_name);
-		strcat(new_name, "^0");
-		tip_name = new_name;
+		tip_name = xstrfmt("%s^0", tip_name);
 
 		if (generation)
 			die("generation: %d, but deref?", generation);
diff --git a/sha1_name.c b/sha1_name.c
index 2b6322f..5e95690 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1252,10 +1252,7 @@ static void diagnose_invalid_sha1_path(const char *prefix,
 		die("Path '%s' exists on disk, but not in '%.*s'.",
 		    filename, object_name_len, object_name);
 	if (errno == ENOENT || errno == ENOTDIR) {
-		char *fullname = xmalloc(strlen(filename)
-					     + strlen(prefix) + 1);
-		strcpy(fullname, prefix);
-		strcat(fullname, filename);
+		char *fullname = xstrfmt("%s%s", prefix, filename);
 
 		if (!get_tree_entry(tree_sha1, fullname,
 				    sha1, &mode)) {
diff --git a/shell.c b/shell.c
index 5c0d47a..ace62e4 100644
--- a/shell.c
+++ b/shell.c
@@ -46,11 +46,7 @@ static int is_valid_cmd_name(const char *cmd)
 
 static char *make_cmd(const char *prog)
 {
-	char *prefix = xmalloc((strlen(prog) + strlen(COMMAND_DIR) + 2));
-	strcpy(prefix, COMMAND_DIR);
-	strcat(prefix, "/");
-	strcat(prefix, prog);
-	return prefix;
+	return xstrfmt("%s/%s", COMMAND_DIR, prog);
 }
 
 static void cd_to_homedir(void)
-- 
2.0.0.566.gfe3e6b2
