From: Jeff King <peff@peff.net>
Subject: [PATCH 45/68] enter_repo: convert fixed-size buffers to strbufs
Date: Thu, 24 Sep 2015 17:07:45 -0400
Message-ID: <20150924210745.GP30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:08:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDkO-00028o-Kg
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111AbbIXVHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:07:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:36001 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753669AbbIXVHr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:07:47 -0400
Received: (qmail 12082 invoked by uid 102); 24 Sep 2015 21:07:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:07:47 -0500
Received: (qmail 29386 invoked by uid 107); 24 Sep 2015 21:07:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:07:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:07:45 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278595>

We use two PATH_MAX-sized buffers to represent the repo
path, and must make sure not to overflow them. We do take
care to check the lengths, but the logic is rather hard to
follow, as we use several magic numbers (e.g., "PATH_MAX -
10"). And in fact you _can_ overflow the buffer if you have
a ".git" file with an extremely long path in it.

By switching to strbufs, these problems all go away. We do,
however, retain the check that the initial input we get is
no larger than PATH_MAX. This function is an entry point for
untrusted repo names from the network, and it's a good idea
to keep a sanity check (both to avoid allocating arbitrary
amounts of memory, and also as a layer of defense against
any downstream users of the names).

Signed-off-by: Jeff King <peff@peff.net>
---
 path.c | 57 +++++++++++++++++++++++++++++----------------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/path.c b/path.c
index 46a4d27..60e0390 100644
--- a/path.c
+++ b/path.c
@@ -391,8 +391,8 @@ return_null:
  */
 const char *enter_repo(const char *path, int strict)
 {
-	static char used_path[PATH_MAX];
-	static char validated_path[PATH_MAX];
+	static struct strbuf validated_path = STRBUF_INIT;
+	static struct strbuf used_path = STRBUF_INIT;
 
 	if (!path)
 		return NULL;
@@ -407,46 +407,47 @@ const char *enter_repo(const char *path, int strict)
 		while ((1 < len) && (path[len-1] == '/'))
 			len--;
 
+		/*
+		 * We can handle arbitrary-sized buffers, but this remains as a
+		 * sanity check on untrusted input.
+		 */
 		if (PATH_MAX <= len)
 			return NULL;
-		strncpy(used_path, path, len); used_path[len] = 0 ;
-		strcpy(validated_path, used_path);
 
-		if (used_path[0] == '~') {
-			char *newpath = expand_user_path(used_path);
-			if (!newpath || (PATH_MAX - 10 < strlen(newpath))) {
-				free(newpath);
+		strbuf_reset(&used_path);
+		strbuf_reset(&validated_path);
+		strbuf_add(&used_path, path, len);
+		strbuf_add(&validated_path, path, len);
+
+		if (used_path.buf[0] == '~') {
+			char *newpath = expand_user_path(used_path.buf);
+			if (!newpath)
 				return NULL;
-			}
-			/*
-			 * Copy back into the static buffer. A pity
-			 * since newpath was not bounded, but other
-			 * branches of the if are limited by PATH_MAX
-			 * anyway.
-			 */
-			strcpy(used_path, newpath); free(newpath);
+			strbuf_attach(&used_path, newpath, strlen(newpath),
+				      strlen(newpath));
 		}
-		else if (PATH_MAX - 10 < len)
-			return NULL;
-		len = strlen(used_path);
 		for (i = 0; suffix[i]; i++) {
 			struct stat st;
-			strcpy(used_path + len, suffix[i]);
-			if (!stat(used_path, &st) &&
+			size_t baselen = used_path.len;
+			strbuf_addstr(&used_path, suffix[i]);
+			if (!stat(used_path.buf, &st) &&
 			    (S_ISREG(st.st_mode) ||
-			    (S_ISDIR(st.st_mode) && is_git_directory(used_path)))) {
-				strcat(validated_path, suffix[i]);
+			    (S_ISDIR(st.st_mode) && is_git_directory(used_path.buf)))) {
+				strbuf_addstr(&validated_path, suffix[i]);
 				break;
 			}
+			strbuf_setlen(&used_path, baselen);
 		}
 		if (!suffix[i])
 			return NULL;
-		gitfile = read_gitfile(used_path) ;
-		if (gitfile)
-			strcpy(used_path, gitfile);
-		if (chdir(used_path))
+		gitfile = read_gitfile(used_path.buf) ;
+		if (gitfile) {
+			strbuf_reset(&used_path);
+			strbuf_addstr(&used_path, gitfile);
+		}
+		if (chdir(used_path.buf))
 			return NULL;
-		path = validated_path;
+		path = validated_path.buf;
 	}
 	else if (chdir(path))
 		return NULL;
-- 
2.6.0.rc3.454.g204ad51
