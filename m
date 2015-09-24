From: Jeff King <peff@peff.net>
Subject: [PATCH 26/68] replace trivial malloc + sprintf / strcpy calls with
 xstrfmt
Date: Thu, 24 Sep 2015 17:07:03 -0400
Message-ID: <20150924210702.GW30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:07:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDjY-0001n6-Tb
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190AbbIXVHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:07:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:35964 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752930AbbIXVHF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:07:05 -0400
Received: (qmail 11952 invoked by uid 102); 24 Sep 2015 21:07:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:07:05 -0500
Received: (qmail 29199 invoked by uid 107); 24 Sep 2015 21:07:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:07:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:07:03 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278584>

It's a common pattern to do:

  foo = xmalloc(strlen(one) + strlen(two) + 1 + 1);
  sprintf(foo, "%s %s", one, two);

(or possibly some variant with strcpy()s or a more
complicated length computation).  We can switch these to use
xstrfmt, which is shorter, involves less error-prone manual
computation, and removes many sprintf and strcpy calls which
make it harder to audit the code for real buffer overflows.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/apply.c     |  5 +----
 builtin/ls-remote.c |  8 ++------
 builtin/name-rev.c  | 13 +++++--------
 environment.c       |  7 ++-----
 imap-send.c         |  5 ++---
 reflog-walk.c       |  7 +++----
 remote.c            |  7 +------
 setup.c             | 12 +++---------
 unpack-trees.c      |  4 +---
 9 files changed, 20 insertions(+), 48 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 4aa53f7..094a20f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -698,10 +698,7 @@ static char *find_name_common(const char *line, const char *def,
 	}
 
 	if (root) {
-		char *ret = xmalloc(root_len + len + 1);
-		strcpy(ret, root);
-		memcpy(ret + root_len, start, len);
-		ret[root_len + len] = '\0';
+		char *ret = xstrfmt("%s%.*s", root, len, start);
 		return squash_slash(ret);
 	}
 
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 4554dbc..5b6d679 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -93,12 +93,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	if (argv[i]) {
 		int j;
 		pattern = xcalloc(argc - i + 1, sizeof(const char *));
-		for (j = i; j < argc; j++) {
-			int len = strlen(argv[j]);
-			char *p = xmalloc(len + 3);
-			sprintf(p, "*/%s", argv[j]);
-			pattern[j - i] = p;
-		}
+		for (j = i; j < argc; j++)
+			pattern[j - i] = xstrfmt("*/%s", argv[j]);
 	}
 	remote = remote_get(dest);
 	if (!remote) {
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 248a3eb..8a3a0cd 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -56,19 +56,16 @@ copy_data:
 			parents = parents->next, parent_number++) {
 		if (parent_number > 1) {
 			int len = strlen(tip_name);
-			char *new_name = xmalloc(len +
-				1 + decimal_length(generation) +  /* ~<n> */
-				1 + 2 +				  /* ^NN */
-				1);
+			char *new_name;
 
 			if (len > 2 && !strcmp(tip_name + len - 2, "^0"))
 				len -= 2;
 			if (generation > 0)
-				sprintf(new_name, "%.*s~%d^%d", len, tip_name,
-						generation, parent_number);
+				new_name = xstrfmt("%.*s~%d^%d", len, tip_name,
+						   generation, parent_number);
 			else
-				sprintf(new_name, "%.*s^%d", len, tip_name,
-						parent_number);
+				new_name = xstrfmt("%.*s^%d", len, tip_name,
+						   parent_number);
 
 			name_rev(parents->item, new_name, 0,
 				distance + MERGE_TRAVERSAL_WEIGHT, 0);
diff --git a/environment.c b/environment.c
index a533aed..c5b65f5 100644
--- a/environment.c
+++ b/environment.c
@@ -143,11 +143,8 @@ static char *git_path_from_env(const char *envvar, const char *git_dir,
 			       const char *path, int *fromenv)
 {
 	const char *value = getenv(envvar);
-	if (!value) {
-		char *buf = xmalloc(strlen(git_dir) + strlen(path) + 2);
-		sprintf(buf, "%s/%s", git_dir, path);
-		return buf;
-	}
+	if (!value)
+		return xstrfmt("%s/%s", git_dir, path);
 	if (fromenv)
 		*fromenv = 1;
 	return xstrdup(value);
diff --git a/imap-send.c b/imap-send.c
index 37ac4aa..e9faaea 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -889,9 +889,8 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
 	}
 
 	/* response: "<user> <digest in hex>" */
-	resp_len = strlen(user) + 1 + strlen(hex) + 1;
-	response = xmalloc(resp_len);
-	sprintf(response, "%s %s", user, hex);
+	response = xstrfmt("%s %s", user, hex);
+	resp_len = strlen(response) + 1;
 
 	response_64 = xmalloc(ENCODED_SIZE(resp_len) + 1);
 	encoded_len = EVP_EncodeBlock((unsigned char *)response_64,
diff --git a/reflog-walk.c b/reflog-walk.c
index f8e743a..85b8a54 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -56,12 +56,11 @@ static struct complete_reflogs *read_complete_reflog(const char *ref)
 		}
 	}
 	if (reflogs->nr == 0) {
-		int len = strlen(ref);
-		char *refname = xmalloc(len + 12);
-		sprintf(refname, "refs/%s", ref);
+		char *refname = xstrfmt("refs/%s", ref);
 		for_each_reflog_ent(refname, read_one_reflog, reflogs);
 		if (reflogs->nr == 0) {
-			sprintf(refname, "refs/heads/%s", ref);
+			free(refname);
+			refname = xstrfmt("refs/heads/%s", ref);
 			for_each_reflog_ent(refname, read_one_reflog, reflogs);
 		}
 		free(refname);
diff --git a/remote.c b/remote.c
index 26504b7..5ab0f7f 100644
--- a/remote.c
+++ b/remote.c
@@ -65,7 +65,6 @@ static int valid_remote(const struct remote *remote)
 static const char *alias_url(const char *url, struct rewrites *r)
 {
 	int i, j;
-	char *ret;
 	struct counted_string *longest;
 	int longest_i;
 
@@ -86,11 +85,7 @@ static const char *alias_url(const char *url, struct rewrites *r)
 	if (!longest)
 		return url;
 
-	ret = xmalloc(r->rewrite[longest_i]->baselen +
-		     (strlen(url) - longest->len) + 1);
-	strcpy(ret, r->rewrite[longest_i]->base);
-	strcpy(ret + r->rewrite[longest_i]->baselen, url + longest->len);
-	return ret;
+	return xstrfmt("%s%s", r->rewrite[longest_i]->base, url + longest->len);
 }
 
 static void add_push_refspec(struct remote *remote, const char *ref)
diff --git a/setup.c b/setup.c
index a17c51e..2b64cbb 100644
--- a/setup.c
+++ b/setup.c
@@ -99,10 +99,7 @@ char *prefix_path_gently(const char *prefix, int len,
 			return NULL;
 		}
 	} else {
-		sanitized = xmalloc(len + strlen(path) + 1);
-		if (len)
-			memcpy(sanitized, prefix, len);
-		strcpy(sanitized + len, path);
+		sanitized = xstrfmt("%.*s%s", len, prefix, path);
 		if (remaining_prefix)
 			*remaining_prefix = len;
 		if (normalize_path_copy_len(sanitized, sanitized, remaining_prefix)) {
@@ -468,11 +465,8 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 
 	if (!is_absolute_path(dir) && (slash = strrchr(path, '/'))) {
 		size_t pathlen = slash+1 - path;
-		size_t dirlen = pathlen + len - 8;
-		dir = xmalloc(dirlen + 1);
-		strncpy(dir, path, pathlen);
-		strncpy(dir + pathlen, buf + 8, len - 8);
-		dir[dirlen] = '\0';
+		dir = xstrfmt("%.*s%.*s", (int)pathlen, path,
+			      (int)(len - 8), buf + 8);
 		free(buf);
 		buf = dir;
 	}
diff --git a/unpack-trees.c b/unpack-trees.c
index f932e80..8e2032f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1350,9 +1350,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	 * Then we need to make sure that we do not lose a locally
 	 * present file that is not ignored.
 	 */
-	pathbuf = xmalloc(namelen + 2);
-	memcpy(pathbuf, ce->name, namelen);
-	strcpy(pathbuf+namelen, "/");
+	pathbuf = xstrfmt("%.*s/", namelen, ce->name);
 
 	memset(&d, 0, sizeof(d));
 	if (o->dir)
-- 
2.6.0.rc3.454.g204ad51
