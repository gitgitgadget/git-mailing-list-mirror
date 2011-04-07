From: Jeff King <peff@peff.net>
Subject: Re: Bug Report: git add
Date: Wed, 6 Apr 2011 21:48:19 -0400
Message-ID: <20110407014819.GA12730@sigill.intra.peff.net>
References: <4D9BA35E.6040204@dcook.org>
 <20110407005750.GC28813@sigill.intra.peff.net>
 <7vbp0ihnou.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Darren Cook <darren@dcook.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 03:48:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7eKj-00009R-C9
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 03:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757321Ab1DGBsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 21:48:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46855
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754665Ab1DGBsW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 21:48:22 -0400
Received: (qmail 13291 invoked by uid 107); 7 Apr 2011 01:49:08 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Apr 2011 21:49:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Apr 2011 21:48:19 -0400
Content-Disposition: inline
In-Reply-To: <7vbp0ihnou.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171040>

On Wed, Apr 06, 2011 at 06:09:37PM -0700, Junio C Hamano wrote:

> > If you do "git add settings" (without the slash) it will add the
> > repository as a submodule.  Which is not the behavior you asked for, but
> > is at least reasonable. So the real bug seems to me the fact that "git
> > add settings/" and "git add settings" behave differently.
> 
> Also if "git add settings/x" does not complain, that would be a bigger
> issue, whose solution would probably be in the same area.
> 
> It may finally be the time to rename has_symlink_leading_path() function
> and enhance its feature.  It happens to check leading symlinks, but its
> real purpose is to check if the given path is outside the working tree,
> and a path that is in a subdirectory with its own .git repository
> certainly is outside the working tree.  The callers should be able to say
> what check is being asked for by naming the _purpose_ of the test ("is
> this path outside the working tree?"), not the mechanics ("does the path
> have a symlink that points outside?").

So here's a quick-and-dirty, "this is the first time I've ever looked at
this code" patch that catches this behavior. It doesn't do any renaming,
and it does an ugly job of exposing the flag constants.

Interestingly, builtin/add.c also has treat_gitlinks which specifically
bails on trying to add something in a submodule. But it misses this
case, because its test is to check the index for gitlink entries.

diff --git a/builtin/add.c b/builtin/add.c
index 024aae4..5754863 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -202,9 +202,15 @@ static const char **validate_pathspec(int argc, const char **argv, const char *p
 	if (pathspec) {
 		const char **p;
 		for (p = pathspec; *p; p++) {
-			if (has_symlink_leading_path(*p, strlen(*p))) {
+			int r = has_symlink_leading_path(*p, strlen(*p));
+			if (r) {
 				int len = prefix ? strlen(prefix) : 0;
-				die(_("'%s' is beyond a symbolic link"), *p + len);
+				if (r & FL_SYMLINK)
+					die(_("'%s' is beyond a symbolic link"), *p + len);
+				else if (r & FL_GITREPO)
+					die(_("'%s' is inside a submodule"), *p + len);
+				die("BUG: '%s' ignored for unknown reason %d",
+				    *p + len, r);
 			}
 		}
 	}
diff --git a/cache.h b/cache.h
index 21bcc52..2784f67 100644
--- a/cache.h
+++ b/cache.h
@@ -880,6 +880,8 @@ struct cache_def {
 	int prefix_len_stat_func;
 };
 
+#define FL_SYMLINK  (1 << 2)
+#define FL_GITREPO  (1 << 6)
 extern int has_symlink_leading_path(const char *name, int len);
 extern int threaded_has_symlink_leading_path(struct cache_def *, const char *, int);
 extern int check_leading_path(const char *name, int len);
diff --git a/symlinks.c b/symlinks.c
index 034943b..22152fd 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -47,7 +47,6 @@ static inline void reset_lstat_cache(struct cache_def *cache)
 
 #define FL_DIR      (1 << 0)
 #define FL_NOENT    (1 << 1)
-#define FL_SYMLINK  (1 << 2)
 #define FL_LSTATERR (1 << 3)
 #define FL_ERR      (1 << 4)
 #define FL_FULLPATH (1 << 5)
@@ -92,7 +91,7 @@ static int lstat_cache_matchlen(struct cache_def *cache,
 		match_len = last_slash =
 			longest_path_match(name, len, cache->path, cache->len,
 					   &previous_slash);
-		*ret_flags = cache->flags & track_flags & (FL_NOENT|FL_SYMLINK);
+		*ret_flags = cache->flags & track_flags & (FL_NOENT|FL_SYMLINK|FL_GITREPO);
 
 		if (!(track_flags & FL_FULLPATH) && match_len == len)
 			match_len = last_slash = previous_slash;
@@ -139,8 +138,21 @@ static int lstat_cache_matchlen(struct cache_def *cache,
 			if (errno == ENOENT)
 				*ret_flags |= FL_NOENT;
 		} else if (S_ISDIR(st.st_mode)) {
-			last_slash_dir = last_slash;
-			continue;
+			struct stat junk;
+			struct strbuf gitdir = STRBUF_INIT;
+			strbuf_add(&gitdir, cache->path, match_len);
+			strbuf_addstr(&gitdir, "/.git");
+			if (lstat(gitdir.buf, &junk) < 0) {
+				if (errno == ENOENT) {
+					last_slash_dir = last_slash;
+					strbuf_release(&gitdir);
+					continue;
+				}
+				*ret_flags = FL_LSTATERR;
+			}
+			else
+				*ret_flags = FL_GITREPO;
+			strbuf_release(&gitdir);
 		} else if (S_ISLNK(st.st_mode)) {
 			*ret_flags = FL_SYMLINK;
 		} else {
@@ -154,7 +166,7 @@ static int lstat_cache_matchlen(struct cache_def *cache,
 	 * path types, FL_NOENT, FL_SYMLINK and FL_DIR, can be cached
 	 * for the moment!
 	 */
-	save_flags = *ret_flags & track_flags & (FL_NOENT|FL_SYMLINK);
+	save_flags = *ret_flags & track_flags & (FL_NOENT|FL_SYMLINK|FL_GITREPO);
 	if (save_flags && last_slash > 0 && last_slash <= PATH_MAX) {
 		cache->path[last_slash] = '\0';
 		cache->len = last_slash;
@@ -197,7 +209,7 @@ static int lstat_cache(struct cache_def *cache, const char *name, int len,
  */
 int threaded_has_symlink_leading_path(struct cache_def *cache, const char *name, int len)
 {
-	return lstat_cache(cache, name, len, FL_SYMLINK|FL_DIR, USE_ONLY_LSTAT) & FL_SYMLINK;
+	return lstat_cache(cache, name, len, FL_SYMLINK|FL_DIR|FL_GITREPO, USE_ONLY_LSTAT) & (FL_SYMLINK|FL_GITREPO);
 }
 
 /*
