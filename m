From: Linus Torvalds <torvalds@osdl.org>
Subject: git-fetch-pack: avoid unnecessary zero packing
Date: Tue, 18 Oct 2005 10:45:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510181032400.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Oct 18 19:47:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERvWs-0000YF-Ff
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 19:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbVJRRpY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 13:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbVJRRpY
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 13:45:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37811 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750791AbVJRRpX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2005 13:45:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9IHjHFC000959
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Oct 2005 10:45:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9IHjHdk022085;
	Tue, 18 Oct 2005 10:45:17 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10218>


If everything is up-to-date locally, we don't need to even ask for a 
pack-file from the remote, or try to unpack it.

This is especially important for tags - since the pack-file common commit 
logic is based purely on the commit history, it will never be able to find 
a common tag, and will thus always end up re-fetching them.

Especially notably, if the tag points to a non-commit (eg a tagged tree), 
the pack-file would be unnecessarily big, just because it cannot any most 
recent common point between commits for pruning.

Short-circuiting the case where we already have that reference means that 
we avoid a lot of these in the common case.

NOTE! This only matches remote ref names against the same local name, 
which works well for tags, but is not as generic as it could be. If we 
ever need to, we could match against _any_ local ref (if we have it, we 
have it), but this "match against same name" is simpler and more 
efficient, and covers the common case.

Renaming of refs is common for branch heads, but since those are always 
commits, the pack-file generation can optimize that case.

In some cases we might still end up fetching pack-files unnecessarily, but 
this at least avoids the re-fetching of tags over and over if you use a 
regular

	git fetch --tags ...

which was the main reason behind the change.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/fetch-pack.c b/fetch-pack.c
index 953c0cf..cf21c34 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -12,6 +12,7 @@ static const char *exec = "git-upload-pa
 static int find_common(int fd[2], unsigned char *result_sha1,
 		       struct ref *refs)
 {
+	int fetching;
 	static char line[1000];
 	int count = 0, flushes = 0, retval;
 	FILE *revs;
@@ -20,16 +21,19 @@ static int find_common(int fd[2], unsign
 	if (!revs)
 		die("unable to run 'git-rev-list'");
 
-	while (refs) {
+	fetching = 0;
+	for ( ; refs ; refs = refs->next) {
 		unsigned char *remote = refs->old_sha1;
-		if (verbose)
-			fprintf(stderr,
-				"want %s (%s)\n", sha1_to_hex(remote),
-				refs->name);
+		unsigned char *local = refs->new_sha1;
+
+		if (!memcmp(remote, local, 20))
+			continue;
 		packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
-		refs = refs->next;
+		fetching++;
 	}
 	packet_flush(fd[1]);
+	if (!fetching)
+		return 1;
 	flushes = 1;
 	retval = -1;
 	while (fgets(line, sizeof(line), revs) != NULL) {
@@ -74,6 +78,37 @@ static int find_common(int fd[2], unsign
 	return retval;
 }
 
+static int everything_local(struct ref *refs)
+{
+	int retval;
+
+	for (retval = 1; refs ; refs = refs->next) {
+		const unsigned char *remote = refs->old_sha1;
+		unsigned char local[20];
+
+		if (read_ref(git_path("%s", refs->name), local) < 0)
+			continue;
+
+		if (memcmp(remote, local, 20)) {
+			retval = 0;
+			if (!verbose)
+				continue;
+			fprintf(stderr,
+				"want %s (%s)\n", sha1_to_hex(remote),
+				refs->name);
+			continue;
+		}
+
+		memcpy(refs->new_sha1, local, 20);
+		if (!verbose)
+			continue;
+		fprintf(stderr,
+			"already have %s (%s)\n", sha1_to_hex(remote),
+			refs->name);
+	}
+	return retval;
+}
+
 static int fetch_pack(int fd[2], int nr_match, char **match)
 {
 	struct ref *ref;
@@ -86,6 +121,10 @@ static int fetch_pack(int fd[2], int nr_
 		packet_flush(fd[1]);
 		die("no matching remote head");
 	}
+	if (everything_local(ref)) {
+		packet_flush(fd[1]);
+		goto all_done;
+	}
 	if (find_common(fd, sha1, ref) < 0)
 		fprintf(stderr, "warning: no common commits\n");
 	pid = fork();
@@ -109,6 +148,7 @@ static int fetch_pack(int fd[2], int nr_
 		int code = WEXITSTATUS(status);
 		if (code)
 			die("git-unpack-objects died with error code %d", code);
+all_done:
 		while (ref) {
 			printf("%s %s\n",
 			       sha1_to_hex(ref->old_sha1), ref->name);
