From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Make the pack-refs interfaces usable from outside
Date: Sat, 26 May 2007 09:25:31 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705260919380.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 26 18:25:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrz5L-0007RW-UO
	for gcvg-git@gmane.org; Sat, 26 May 2007 18:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbXEZQZi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 12:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758479AbXEZQZi
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 12:25:38 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:57731 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752885AbXEZQZh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 May 2007 12:25:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4QGPWk7015523
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 26 May 2007 09:25:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4QGPVWj011080;
	Sat, 26 May 2007 09:25:31 -0700
X-Spam-Status: No, hits=-2.479 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48479>


This just basically creates a "pack_refs()" function that could be used by 
anybody. You pass it in the flags you want as a bitmask (PACK_REFS_ALL and 
PACK_REFS_PRUNE), and it will do all the heavy lifting.

Of course, it's still static, and it's all in the builtin-pack-refs.c 
file, so it's not actually visible to the outside, but the next step would 
be to just move it all to a library file (probably refs.c) and expose it.

Then we could easily make "git gc" do this too.

While I did it, I also made it check the return value of the fflush and 
fsync stage, to make sure that we don't overwrite the old packed-refs file 
with something that got truncated due to write errors!

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

It all looks very obvious, and it passed the trivial tests I did, but 
somebody should probably double-check.

Hmm?

		Linus

---
 builtin-pack-refs.c |   66 +++++++++++++++++++++++++++++---------------------
 1 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index d080e30..1952950 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -12,9 +12,11 @@ struct ref_to_prune {
 	char name[FLEX_ARRAY];
 };
 
+#define PACK_REFS_PRUNE	0x0001
+#define PACK_REFS_ALL	0x0002
+
 struct pack_refs_cb_data {
-	int prune;
-	int all;
+	unsigned int flags;
 	struct ref_to_prune *ref_to_prune;
 	FILE *refs_file;
 };
@@ -39,7 +41,7 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
 	is_tag_ref = !prefixcmp(path, "refs/tags/");
 
 	/* ALWAYS pack refs that were already packed or are tags */
-	if (!cb->all && !is_tag_ref && !(flags & REF_ISPACKED))
+	if (!(cb->flags & PACK_REFS_ALL) && !is_tag_ref && !(flags & REF_ISPACKED))
 		return 0;
 
 	fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(sha1), path);
@@ -53,7 +55,7 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
 		}
 	}
 
-	if (cb->prune && !do_not_prune(flags)) {
+	if ((cb->flags & PACK_REFS_PRUNE) && !do_not_prune(flags)) {
 		int namelen = strlen(path) + 1;
 		struct ref_to_prune *n = xcalloc(1, sizeof(*n) + namelen);
 		hashcpy(n->sha1, sha1);
@@ -85,26 +87,51 @@ static void prune_refs(struct ref_to_prune *r)
 
 static struct lock_file packed;
 
-int cmd_pack_refs(int argc, const char **argv, const char *prefix)
+static int pack_refs(unsigned int flags)
 {
-	int fd, i;
+	int fd;
 	struct pack_refs_cb_data cbdata;
 
 	memset(&cbdata, 0, sizeof(cbdata));
+	cbdata.flags = flags;
+
+	fd = hold_lock_file_for_update(&packed, git_path("packed-refs"), 1);
+	cbdata.refs_file = fdopen(fd, "w");
+	if (!cbdata.refs_file)
+		die("unable to create ref-pack file structure (%s)",
+		    strerror(errno));
+
+	/* perhaps other traits later as well */
+	fprintf(cbdata.refs_file, "# pack-refs with: peeled \n");
+
+	for_each_ref(handle_one_ref, &cbdata);
+	if (fflush(cbdata.refs_file) || fsync(fd) || fclose(cbdata.refs_file))
+		die("failed to write ref-pack file (%s)", strerror(errno));
+	if (commit_lock_file(&packed) < 0)
+		die("unable to overwrite old ref-pack file (%s)", strerror(errno));
+	if (cbdata.flags & PACK_REFS_PRUNE)
+		prune_refs(cbdata.ref_to_prune);
+	return 0;
+}
 
-	cbdata.prune = 1;
+int cmd_pack_refs(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	unsigned int flags;
+
+	flags = PACK_REFS_PRUNE;
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--prune")) {
-			cbdata.prune = 1; /* now the default */
+			flags |= PACK_REFS_PRUNE; /* now the default */
 			continue;
 		}
 		if (!strcmp(arg, "--no-prune")) {
-			cbdata.prune = 0;
+			flags &= ~PACK_REFS_PRUNE;
 			continue;
 		}
 		if (!strcmp(arg, "--all")) {
-			cbdata.all = 1;
+			flags |= PACK_REFS_ALL;
 			continue;
 		}
 		/* perhaps other parameters later... */
@@ -113,22 +140,5 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 	if (i != argc)
 		usage(builtin_pack_refs_usage);
 
-	fd = hold_lock_file_for_update(&packed, git_path("packed-refs"), 1);
-	cbdata.refs_file = fdopen(fd, "w");
-	if (!cbdata.refs_file)
-		die("unable to create ref-pack file structure (%s)",
-		    strerror(errno));
-
-	/* perhaps other traits later as well */
-	fprintf(cbdata.refs_file, "# pack-refs with: peeled \n");
-
-	for_each_ref(handle_one_ref, &cbdata);
-	fflush(cbdata.refs_file);
-	fsync(fd);
-	fclose(cbdata.refs_file);
-	if (commit_lock_file(&packed) < 0)
-		die("unable to overwrite old ref-pack file (%s)", strerror(errno));
-	if (cbdata.prune)
-		prune_refs(cbdata.ref_to_prune);
-	return 0;
+	return pack_refs(flags);
 }
