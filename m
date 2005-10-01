From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Destructive side-effect of "cg-status"
Date: Sat, 1 Oct 2005 13:24:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510011303560.3378@g5.osdl.org>
References: <20051001194216.EE3E5353D8E@atlas.denx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Oct 01 22:25:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELnuc-0002xf-OR
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 22:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVJAUYi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Oct 2005 16:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVJAUYi
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Oct 2005 16:24:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26766 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750833AbVJAUYh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Oct 2005 16:24:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j91KOS4s008522
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 1 Oct 2005 13:24:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j91KORvM028696;
	Sat, 1 Oct 2005 13:24:27 -0700
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20051001194216.EE3E5353D8E@atlas.denx.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9603>



On Sat, 1 Oct 2005, Wolfgang Denk wrote:
> 
> The "error: open failed" should at leats include the  file  name  and
> the  errno/strerror  message.  Same  for  the "read_cache: Permission
> denied" - of course, if you knot the git internals you will know what
> this means, but the average user has no idea that he should check the
> permissions of .git/index.

Agreed.

Something like this would seem sane.

		Linus

---
Subject: Better error reporting for "git status"

Instead of "git status" ignoring (and hiding) potential errors from the 
"git-update-index" call, make it exit if it fails, and show the error.

In order to do this, use the "-q" flag (to ignore not-up-to-date files) 
and add a new "--unmerged" flag that allows unmerged entries in the index
without any errors.

This also avoids marking the index "changed" if an entry isn't actually 
modified, and makes sure that we exit with an understandable error message 
if the index is corrupt or unreadable. "read_cache()" no longer returns an 
error for the caller to check.

Finally, make die() and usage() exit with recognizable error codes, if we
ever want to check the failure reason in scripts.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/git-status.sh b/git-status.sh
--- a/git-status.sh
+++ b/git-status.sh
@@ -37,7 +37,7 @@ refs/heads/master) ;;
 *)	echo "# On branch $branch" ;;
 esac
 
-git-update-index --refresh >/dev/null 2>&1
+git-update-index -q --unmerged --refresh || exit
 
 if test -f "$GIT_DIR/HEAD"
 then
diff --git a/read-cache.c b/read-cache.c
--- a/read-cache.c
+++ b/read-cache.c
@@ -464,11 +464,15 @@ int read_cache(void)
 
 	errno = EBUSY;
 	if (active_cache)
-		return error("more than one cachefile");
+		return active_nr;
+
 	errno = ENOENT;
 	fd = open(get_index_file(), O_RDONLY);
-	if (fd < 0)
-		return (errno == ENOENT) ? 0 : error("open failed");
+	if (fd < 0) {
+		if (errno == ENOENT)
+			return 0;
+		die("index file open failed (%s)", strerror(errno));
+	}
 
 	size = 0; // avoid gcc warning
 	map = MAP_FAILED;
@@ -480,7 +484,7 @@ int read_cache(void)
 	}
 	close(fd);
 	if (map == MAP_FAILED)
-		return error("mmap failed");
+		die("index file mmap failed (%s)", strerror(errno));
 
 	hdr = map;
 	if (verify_hdr(hdr, size) < 0)
@@ -501,7 +505,7 @@ int read_cache(void)
 unmap:
 	munmap(map, size);
 	errno = EINVAL;
-	return error("verify header failed");
+	die("index file corrupt");
 }
 
 #define WRITE_BUFFER_SIZE 8192
diff --git a/update-index.c b/update-index.c
--- a/update-index.c
+++ b/update-index.c
@@ -13,7 +13,7 @@
  * like "git-update-index *" and suddenly having all the object
  * files be revision controlled.
  */
-static int allow_add = 0, allow_remove = 0, allow_replace = 0, not_new = 0, quiet = 0, info_only = 0;
+static int allow_add = 0, allow_remove = 0, allow_replace = 0, allow_unmerged = 0, not_new = 0, quiet = 0, info_only = 0;
 static int force_remove;
 
 /* Three functions to allow overloaded pointer return; see linux/err.h */
@@ -135,7 +135,7 @@ static struct cache_entry *refresh_entry
 
 	changed = ce_match_stat(ce, &st);
 	if (!changed)
-		return ce;
+		return NULL;
 
 	if (ce_modified(ce, &st))
 		return ERR_PTR(-EINVAL);
@@ -156,16 +156,20 @@ static int refresh_cache(void)
 		struct cache_entry *ce, *new;
 		ce = active_cache[i];
 		if (ce_stage(ce)) {
-			printf("%s: needs merge\n", ce->name);
-			has_errors = 1;
 			while ((i < active_nr) &&
 			       ! strcmp(active_cache[i]->name, ce->name))
 				i++;
 			i--;
+			if (allow_unmerged)
+				continue;
+			printf("%s: needs merge\n", ce->name);
+			has_errors = 1;
 			continue;
 		}
 
 		new = refresh_entry(ce);
+		if (!new)
+			continue;
 		if (IS_ERR(new)) {
 			if (not_new && PTR_ERR(new) == -ENOENT)
 				continue;
@@ -335,6 +339,10 @@ int main(int argc, const char **argv)
 				allow_remove = 1;
 				continue;
 			}
+			if (!strcmp(path, "--unmerged")) {
+				allow_unmerged = 1;
+				continue;
+			}
 			if (!strcmp(path, "--refresh")) {
 				has_errors |= refresh_cache();
 				continue;
diff --git a/usage.c b/usage.c
--- a/usage.c
+++ b/usage.c
@@ -15,7 +15,7 @@ static void report(const char *prefix, c
 void usage(const char *err)
 {
 	fprintf(stderr, "usage: %s\n", err);
-	exit(1);
+	exit(129);
 }
 
 void die(const char *err, ...)
@@ -25,7 +25,7 @@ void die(const char *err, ...)
 	va_start(params, err);
 	report("fatal: ", err, params);
 	va_end(params);
-	exit(1);
+	exit(128);
 }
 
 int error(const char *err, ...)
