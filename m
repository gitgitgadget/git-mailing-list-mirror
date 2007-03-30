From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] Rename warn() to warning() to fix symbol conflicts on BSD and Mac OS
Date: Fri, 30 Mar 2007 19:07:05 -0400
Message-ID: <11752960251394-git-send-email-tytso@mit.edu>
Cc: git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 31 01:08:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXQCk-00019E-Nt
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 01:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933026AbXC3XIB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 19:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933020AbXC3XIA
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 19:08:00 -0400
Received: from thunk.org ([69.25.196.29]:51485 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933004AbXC3XH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 19:07:59 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HXQIP-0006tS-J8; Fri, 30 Mar 2007 19:14:13 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HXQBW-0002Aq-0K; Fri, 30 Mar 2007 19:07:06 -0400
X-Mailer: git-send-email 1.5.1.rc3.20.gaa453
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43507>

This fixes a problem reported by Randal Schwartz:

>I finally tracked down all the (albeit inconsequential) errors I was getting
>on both OpenBSD and OSX.  It's the warn() function in usage.c.  There's
>warn(3) in BSD-style distros.  It'd take a "great rename" to change it, but if
>someone with better C skills than I have could do that, my linker and I would
>appreciate it.

It was annoying to me, too, when I was doing some mergetool testing on
Mac OS X, so here's a fix.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>
---
 builtin-bundle.c  |    4 ++--
 fast-import.c     |    2 +-
 git-compat-util.h |    2 +-
 revision.c        |    2 +-
 usage.c           |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 0a9b738..d1635a0 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -87,7 +87,7 @@ static int read_header(const char *path, struct bundle_header *header) {
 		if (buffer[len - 1] == '\n')
 			buffer[len - 1] = '\0';
 		if (get_sha1_hex(buffer + offset, sha1)) {
-			warn("unrecognized header: %s", buffer);
+			warning("unrecognized header: %s", buffer);
 			continue;
 		}
 		delim = buffer[40 + offset];
@@ -268,7 +268,7 @@ static int create_bundle(struct bundle_header *header, const char *path,
 		 * from getting output.
 		 */
 		if (!(e->item->flags & SHOWN)) {
-			warn("ref '%s' is excluded by the rev-list options",
+			warning("ref '%s' is excluded by the rev-list options",
 				e->name);
 			continue;
 		}
diff --git a/fast-import.c b/fast-import.c
index bea1215..cdd629d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1312,7 +1312,7 @@ static int update_branch(struct branch *b)
 
 		if (!in_merge_bases(old_cmit, &new_cmit, 1)) {
 			unlock_ref(lock);
-			warn("Not updating %s"
+			warning("Not updating %s"
 				" (new tip %s does not contain %s)",
 				b->name, sha1_to_hex(b->sha1), sha1_to_hex(old_sha1));
 			return -1;
diff --git a/git-compat-util.h b/git-compat-util.h
index 7534db1..139fc19 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -87,7 +87,7 @@
 extern void usage(const char *err) NORETURN;
 extern void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
 extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
-extern void warn(const char *err, ...) __attribute__((format (printf, 1, 2)));
+extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
 extern void set_usage_routine(void (*routine)(const char *err) NORETURN);
 extern void set_die_routine(void (*routine)(const char *err, va_list params) NORETURN);
diff --git a/revision.c b/revision.c
index f23c1d5..486393c 100644
--- a/revision.c
+++ b/revision.c
@@ -486,7 +486,7 @@ static void handle_one_reflog_commit(unsigned char *sha1, void *cb_data)
 			add_pending_object(cb->all_revs, o, "");
 		}
 		else if (!cb->warned_bad_reflog) {
-			warn("reflog of '%s' references pruned commits",
+			warning("reflog of '%s' references pruned commits",
 				cb->name_for_errormsg);
 			cb->warned_bad_reflog = 1;
 		}
diff --git a/usage.c b/usage.c
index 4dc5c77..f5e652c 100644
--- a/usage.c
+++ b/usage.c
@@ -86,7 +86,7 @@ int error(const char *err, ...)
 	return -1;
 }
 
-void warn(const char *warn, ...)
+void warning(const char *warn, ...)
 {
 	va_list params;
 
-- 
1.5.1.rc3.20.gaa453
