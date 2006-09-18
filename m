From: Junio C Hamano <junkio@cox.net>
Subject: [RFC] git-pack-refs --prune
Date: Mon, 18 Sep 2006 00:25:23 -0700
Message-ID: <7vy7shr5zw.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0609111158390.3960@g5.osdl.org>
	<Pine.LNX.4.64.0609111632050.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 09:25:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPDVR-00057V-0T
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 09:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWIRHZZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 03:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWIRHZZ
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 03:25:25 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:58336 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751375AbWIRHZY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 03:25:24 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060918072524.LDSB12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Mon, 18 Sep 2006 03:25:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PjRB1V00C1kojtg0000000
	Mon, 18 Sep 2006 03:25:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609111632050.27779@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 11 Sep 2006 16:37:32 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27239>

"git pack-refs --prune", after successfully packing the existing
refs, removes the loose ref files.  It tries to protect against
race by doing the usual lock_ref_sha1() which makes sure the
contents of the ref has not changed since we last looked at.

I am not sure I got the locking right, hence this RFC.

We would probably need to perform some sort of 'sync' after
closing and renaming the lockfile to its final location before
pruning.  Is there a way cheaper than sync(2) to make sure the
effect of rename(2) hits the disk platter?

---
diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index 0f5d827..2b3a483 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -3,6 +3,15 @@ #include "refs.h"
 
 static FILE *refs_file;
 static const char *result_path, *lock_path;
+static const char builtin_pack_refs_usage[] =
+"git-pack-refs [--prune]";
+
+static int prune;
+struct keepref {
+	struct keepref *next;
+	unsigned char sha1[20];
+	char name[FLEX_ARRAY];
+} *keepref;
 
 static void remove_lock_file(void)
 {
@@ -13,12 +22,50 @@ static void remove_lock_file(void)
 static int handle_one_ref(const char *path, const unsigned char *sha1)
 {
 	fprintf(refs_file, "%s %s\n", sha1_to_hex(sha1), path);
+	if (prune) {
+		int namelen = strlen(path) + 1;
+		struct keepref *n = xcalloc(1, sizeof(*n) + namelen);
+		hashcpy(n->sha1, sha1);
+		strcpy(n->name, path);
+		n->next = keepref;
+		keepref = n;
+	}
 	return 0;
 }
 
+/* make sure nobody touched the ref, and unlink */
+static void prune_ref(struct keepref *r)
+{
+	struct ref_lock *lock = lock_ref_sha1(r->name + 5, r->sha1, 1);
+
+	if (lock) {
+		unlink(git_path(r->name));
+		unlock_ref(lock);
+	}
+}
+
+static void prune_refs(void)
+{
+	struct keepref *r;
+	for (r = keepref; r; r = r->next)
+		prune_ref(r);
+}
+
 int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 {
-	int fd;
+	int fd, i;
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!strcmp(arg, "--prune")) {
+			prune = 1;
+			continue;
+		}
+		/* perhaps other parameters later... */
+		break;
+	}
+	if (i != argc)
+		usage(builtin_pack_refs_usage);
 
 	result_path = xstrdup(git_path("packed-refs"));
 	lock_path = xstrdup(mkpath("%s.lock", result_path));
@@ -37,5 +84,7 @@ int cmd_pack_refs(int argc, const char *
 	if (rename(lock_path, result_path) < 0)
 		die("unable to overwrite old ref-pack file (%s)", strerror(errno));
 	lock_path = NULL;
+	if (prune)
+		prune_refs();
 	return 0;
 }
