From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 5/5] git-pack-refs --prune
Date: Thu, 21 Sep 2006 00:06:06 -0700
Message-ID: <7vhcz1aech.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0609111158390.3960@g5.osdl.org>
	<Pine.LNX.4.64.0609111632050.27779@g5.osdl.org>
	<7vy7shr5zw.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609180934360.4388@g5.osdl.org>
	<7v64fhd7ns.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 09:06:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQIdZ-0004D0-Q2
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 09:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWIUHGP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 03:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWIUHGO
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 03:06:14 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:27846 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750765AbWIUHGH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 03:06:07 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060921070606.KFTT2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Sep 2006 03:06:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qv5s1V0091kojtg0000000
	Thu, 21 Sep 2006 03:05:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27460>

"git pack-refs --prune", after successfully packing the existing
refs, removes the loose ref files.  It tries to protect against
race by doing the usual lock_ref_sha1() which makes sure the
contents of the ref has not changed since we last looked at.

Also we do not bother trying to prune what was already packed, and
we do not try pruning symbolic refs.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-pack-refs.c |   84 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 75 insertions(+), 9 deletions(-)

diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index 0fc8a55..246dd63 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -2,6 +2,20 @@ #include "cache.h"
 #include "refs.h"
 
 static const char *result_path, *lock_path;
+static const char builtin_pack_refs_usage[] =
+"git-pack-refs [--prune]";
+
+struct ref_to_prune {
+	struct ref_to_prune *next;
+	unsigned char sha1[20];
+	char name[FLEX_ARRAY];
+};
+
+struct pack_refs_cb_data {
+	int prune;
+	struct ref_to_prune *ref_to_prune;
+	FILE *refs_file;
+};
 
 static void remove_lock_file(void)
 {
@@ -9,21 +23,70 @@ static void remove_lock_file(void)
 		unlink(lock_path);
 }
 
+static int do_not_prune(int flags)
+{
+	/* If it is already packed or if it is a symref,
+	 * do not prune it.
+	 */
+	return (flags & (REF_ISSYMREF|REF_ISPACKED));
+}
+
 static int handle_one_ref(const char *path, const unsigned char *sha1,
 			  int flags, void *cb_data)
 {
-	FILE *refs_file = cb_data;
+	struct pack_refs_cb_data *cb = cb_data;
 
 	/* Do not pack the symbolic refs */
 	if (!(flags & REF_ISSYMREF))
-		fprintf(refs_file, "%s %s\n", sha1_to_hex(sha1), path);
+		fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(sha1), path);
+	if (cb->prune && !do_not_prune(flags)) {
+		int namelen = strlen(path) + 1;
+		struct ref_to_prune *n = xcalloc(1, sizeof(*n) + namelen);
+		hashcpy(n->sha1, sha1);
+		strcpy(n->name, path);
+		n->next = cb->ref_to_prune;
+		cb->ref_to_prune = n;
+	}
 	return 0;
 }
 
+/* make sure nobody touched the ref, and unlink */
+static void prune_ref(struct ref_to_prune *r)
+{
+	struct ref_lock *lock = lock_ref_sha1(r->name + 5, r->sha1, 1);
+
+	if (lock) {
+		unlink(git_path(r->name));
+		unlock_ref(lock);
+	}
+}
+
+static void prune_refs(struct ref_to_prune *r)
+{
+	while (r) {
+		prune_ref(r);
+		r = r->next;
+	}
+}
+
 int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 {
-	int fd;
-	FILE *refs_file;
+	int fd, i;
+	struct pack_refs_cb_data cbdata;
+
+	memset(&cbdata, 0, sizeof(cbdata));
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!strcmp(arg, "--prune")) {
+			cbdata.prune = 1;
+			continue;
+		}
+		/* perhaps other parameters later... */
+		break;
+	}
+	if (i != argc)
+		usage(builtin_pack_refs_usage);
 
 	result_path = xstrdup(git_path("packed-refs"));
 	lock_path = xstrdup(mkpath("%s.lock", result_path));
@@ -33,14 +96,17 @@ int cmd_pack_refs(int argc, const char *
 		die("unable to create new ref-pack file (%s)", strerror(errno));
 	atexit(remove_lock_file);
 
-	refs_file = fdopen(fd, "w");
-	if (!refs_file)
-		die("unable to create ref-pack file structure (%s)", strerror(errno));
-	for_each_ref(handle_one_ref, refs_file);
+	cbdata.refs_file = fdopen(fd, "w");
+	if (!cbdata.refs_file)
+		die("unable to create ref-pack file structure (%s)",
+		    strerror(errno));
+	for_each_ref(handle_one_ref, &cbdata);
 	fsync(fd);
-	fclose(refs_file);
+	fclose(cbdata.refs_file);
 	if (rename(lock_path, result_path) < 0)
 		die("unable to overwrite old ref-pack file (%s)", strerror(errno));
 	lock_path = NULL;
+	if (cbdata.prune)
+		prune_refs(cbdata.ref_to_prune);
 	return 0;
 }
-- 
1.4.2.1.g4dc7
