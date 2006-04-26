From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] revision parsing: make "rev -- paths" checks stronger.
Date: Wed, 26 Apr 2006 15:22:14 -0700
Message-ID: <7vmze8m0yx.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vzmidkjbq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604220921430.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 27 00:22:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYsOo-00026S-Vb
	for gcvg-git@gmane.org; Thu, 27 Apr 2006 00:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWDZWWQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 18:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWDZWWQ
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 18:22:16 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:40598 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964854AbWDZWWP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Apr 2006 18:22:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060426222215.QYQR4388.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Apr 2006 18:22:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604220921430.3701@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 22 Apr 2006 09:30:29 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19220>

If you don't have a "--" marker, then:

 - all of the arguments we are going to assume are pathspecs
   must exist in the working tree.

 - none of the arguments we parsed as revisions could be
   interpreted as a filename.

so that there really isn't any possibility of confusion in case
somebody does have a revision that looks like a pathname too.

The former rule has been in effect; this implements the latter.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I did not understand 'if you have a pathspec, but' part, and
   'none of the paths are "--"' part of your rules, so this
   might probably be a bit different from what you had in
   mind.

   The patch, lacking the "if you have a pathspec" part of the
   rule, would make this complain:

   	$ >v1.0.0
        $ git show v1.0.0

   BTW, this would silently do what you would not find
   interesting, with or without the patch:

       $ >v2.9.6
	 ... long time later after you forget you had such a
	 ... bogus file
       $ git show v2.9.6

  Linus Torvalds <torvalds@osdl.org> writes:

  > ... I was going to say that if you have a pathspec, 
  > but don't have a "--" marker, then we'd additionally check:
  >
  >  - none of the arguments we parsed as revisions could be interpreted as a 
  >    filename.
  >
  >  - none of the paths are "--" 
  >
  > so that there really isn't...



 cache.h    |    1 +
 revision.c |   14 +++++++++++++-
 setup.c    |   24 ++++++++++++++++++++++--
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 4d8fabc..a4f253e 100644
--- a/cache.h
+++ b/cache.h
@@ -135,6 +135,7 @@ extern const char *setup_git_directory(v
 extern const char *prefix_path(const char *prefix, int len, const char *path);
 extern const char *prefix_filename(const char *prefix, int len, const char *path);
 extern void verify_filename(const char *prefix, const char *name);
+extern void verify_non_filename(const char *prefix, const char *name);
 
 #define alloc_nr(x) (((x)+16)*3/2)
 
diff --git a/revision.c b/revision.c
index f2a9f25..b6ed014 100644
--- a/revision.c
+++ b/revision.c
@@ -740,6 +740,11 @@ int setup_revisions(int argc, const char
 				include = get_reference(revs, next, sha1, flags);
 				if (!exclude || !include)
 					die("Invalid revision range %s..%s", arg, next);
+
+				if (!seen_dashdash) {
+					*dotdot = '.';
+					verify_non_filename(revs->prefix, arg);
+				}
 				add_pending_object(revs, exclude, this);
 				add_pending_object(revs, include, next);
 				continue;
@@ -757,13 +762,20 @@ int setup_revisions(int argc, const char
 			if (seen_dashdash || local_flags)
 				die("bad revision '%s'", arg);
 
-			/* If we didn't have a "--", all filenames must exist */
+			/* If we didn't have a "--":
+			 * (1) all filenames must exist;
+			 * (2) all rev-args must not be interpretable
+			 *     as a valid filename.
+			 * but the latter we have checked in the main loop.
+			 */
 			for (j = i; j < argc; j++)
 				verify_filename(revs->prefix, argv[j]);
 
 			revs->prune_data = get_pathspec(revs->prefix, argv + i);
 			break;
 		}
+		if (!seen_dashdash)
+			verify_non_filename(revs->prefix, arg);
 		object = get_reference(revs, arg, sha1, flags ^ local_flags);
 		add_pending_object(revs, object, arg);
 	}
diff --git a/setup.c b/setup.c
index cce9bb8..fe7f884 100644
--- a/setup.c
+++ b/setup.c
@@ -80,11 +80,31 @@ void verify_filename(const char *prefix,
 	if (!lstat(name, &st))
 		return;
 	if (errno == ENOENT)
-		die("ambiguous argument '%s': unknown revision or filename\n"
-		    "Use '--' to separate filenames from revisions", arg);
+		die("ambiguous argument '%s': unknown revision or path not in the working tree.\n"
+		    "Use '--' to separate paths from revisions", arg);
 	die("'%s': %s", arg, strerror(errno));
 }
 
+/*
+ * Opposite of the above: the command line did not have -- marker
+ * and we parsed the arg as a refname.  It should not be interpretable
+ * as a filename.
+ */
+void verify_non_filename(const char *prefix, const char *arg)
+{
+	const char *name;
+	struct stat st;
+
+	if (*arg == '-')
+		return; /* flag */
+	name = prefix ? prefix_filename(prefix, strlen(prefix), arg) : arg;
+	if (!lstat(name, &st))
+		die("ambiguous argument '%s': both revision and filename\n"
+		    "Use '--' to separate filenames from revisions", arg);
+	if (errno != ENOENT)
+		die("'%s': %s", arg, strerror(errno));
+}
+
 const char **get_pathspec(const char *prefix, const char **pathspec)
 {
 	const char *entry = *pathspec;
-- 
1.3.1.ga6c7
