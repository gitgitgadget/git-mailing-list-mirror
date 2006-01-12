From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] convert-packs: futureproofing.
Date: Wed, 11 Jan 2006 16:05:15 -0800
Message-ID: <7voe2ijop0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 12 01:05:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewpy7-0002Bo-F0
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 01:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWALAFT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 19:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWALAFT
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 19:05:19 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:25798 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964799AbWALAFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 19:05:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060112000423.KIUU15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 Jan 2006 19:04:23 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14531>

Names of packfiles are informally expected to be of the form
"pack-[0-9a-f]{40}.pack", with corresponding .idx file (the
core-level only requires the files are named ".pack" and ".idx"
respectively).

The hexadecimal part should be what git-pack-objects computed
when the pack was created originally, and it is the SHA1 sum
over sorted object names (i.e. 20-byte binary SHA1 checksum
each).  However, git-pack-objects before v0.99.9 computed a
checksum over object names without sorting (i.e. the order
git-rev-list fed the object names), just to make pack names
unlikely to collide.  The current git-pack-objects computes the
checksum differently, so that two packfiles that contain the
same set of objects are always given the same name.  This was
done so that we can use the filename as an additional way to
verify the integrity of the pack.

Many packfiles in the wild were created with git before v0.99.9,
and they will fail this verification.  The new command
git-convert-packs can be used to rename them to a name that
would have been given by git-pack-objects post v0.99.9.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 * Currently in "pu".

 .gitignore                          |    1 
 Documentation/git-convert-packs.txt |   41 +++++++++++++++++
 Makefile                            |    2 -
 convert-packs.c                     |   86 +++++++++++++++++++++++++++++++++++
 4 files changed, 129 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/git-convert-packs.txt
 create mode 100644 convert-packs.c

004e17155fe0a739857851cffc5efd3407af389c
diff --git a/.gitignore b/.gitignore
index 1a9090b..0d50843 100644
--- a/.gitignore
+++ b/.gitignore
@@ -19,6 +19,7 @@ git-clone-pack
 git-commit
 git-commit-tree
 git-convert-objects
+git-convert-packs
 git-count-objects
 git-cvsexportcommit
 git-cvsimport
diff --git a/Documentation/git-convert-packs.txt b/Documentation/git-convert-packs.txt
new file mode 100644
index 0000000..ba02641
--- /dev/null
+++ b/Documentation/git-convert-packs.txt
@@ -0,0 +1,41 @@
+git-convert-packs(1)
+====================
+
+NAME
+----
+git-convert-packs - Renames packfiles created with pre 0.99.9 GIT
+
+
+SYNOPSIS
+--------
+'git-convert-packs'
+
+DESCRIPTION
+-----------
+Older git-pack-objects named the resulting packfile with an SHA1
+hash of the object names without sorting them first (i.e. random
+unverifiable order), which meant that two packfiles that contain
+the same set of objects can be named differently.  To make
+packfile reliably verifiable, future versions of GIT will
+require that the name of the packfile to match the SHA1 hash of
+the object names contained within, after sorting them, and will
+ignore packfiles whose names do not verify.
+
+This command takes no parameter; it inspects packfiles in the
+local repository, and renames the ones whose names do not match
+their contents.  You need to rename older packfiles using this
+command before GIT starts complaining.
+
+
+Author
+------
+Written by Junio C Hamano <junkio@cox.net>
+
+Documentation
+--------------
+Documentation by the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
diff --git a/Makefile b/Makefile
index fa0cd83..6d5f293 100644
--- a/Makefile
+++ b/Makefile
@@ -123,7 +123,7 @@ SIMPLE_PROGRAMS = \
 PROGRAMS = \
 	git-apply$X git-cat-file$X \
 	git-checkout-index$X git-clone-pack$X git-commit-tree$X \
-	git-convert-objects$X git-diff-files$X \
+	git-convert-objects$X git-convert-packs$X git-diff-files$X \
 	git-diff-index$X git-diff-stages$X \
 	git-diff-tree$X git-fetch-pack$X git-fsck-objects$X \
 	git-hash-object$X git-index-pack$X git-init-db$X \
diff --git a/convert-packs.c b/convert-packs.c
new file mode 100644
index 0000000..754599d
--- /dev/null
+++ b/convert-packs.c
@@ -0,0 +1,86 @@
+#include "cache.h"
+
+static int verify_pack_name(struct packed_git *p)
+{
+	SHA_CTX ctx;
+	unsigned char sha1[20];
+	int i, nr, len, bad;
+	const char *hex;
+	char *base_name;
+
+	nr = num_packed_objects(p);
+
+	SHA1_Init(&ctx);
+	for (i = 0; i < nr; i++) {
+		unsigned char *ent = (((unsigned char *)p->index_base) +
+				      4*256 + i * 24 + 4);
+		SHA1_Update(&ctx, ent, 20);
+	}
+	SHA1_Final(sha1, &ctx);
+	hex = sha1_to_hex(sha1);
+	
+	base_name = strrchr(p->pack_name, '/');
+	if (base_name)
+		base_name++;
+	else
+		base_name = p->pack_name;
+
+	bad = 0;
+	/* We require "pack-X{40}.pack" these days before mapping
+	 * the idx file, so the first two conditions of the if()
+	 * statement are always false.
+	 */
+	len = strlen(base_name);
+	if ((len != 50) ||
+	    memcmp(base_name, "pack-", 5) ||
+	    memcmp(base_name + 5, hex, 40)) {
+		char *newname;
+		int newlen;
+
+		fprintf(stderr, "pack '%s' does not match contents '%s'\n",
+			base_name, hex);
+		newname = xmalloc(base_name - p->pack_name + 52);
+		if (base_name != p->pack_name)
+			sprintf(newname, "%.*spack-%s.pack",
+				(base_name - p->pack_name), p->pack_name, hex);
+		else
+			sprintf(newname, "pack-%s.pack", hex);
+		newlen = strlen(newname);
+
+		/* Make sure there is no such pack and idx first. */
+		if (!access(newname, F_OK))
+			return error("But there is a pack with that name!");
+
+		memcpy(newname + newlen - 5, ".idx", 5);
+		if (!access(newname, F_OK))
+			return error("But there is an idx with that name!");
+
+		memcpy(newname + newlen - 5, ".pack", 5);
+		if (rename(p->pack_name, newname))
+			return error("But the pack cannot renamed somehow!");
+
+		/* Now we have renamed the pack, so let's rename the index */
+		memcpy(base_name + len - 5, ".idx", 5);
+		memcpy(newname + newlen - 5, ".idx", 5);
+
+		if (!access(newname, F_OK))
+			return error("But there is an idx with that name!");
+		else if (rename(p->pack_name, newname))
+			return error("But the idx cannot be renamed somehow!");
+
+		fprintf(stderr, "... renamed successfully.\n");
+	}
+	return bad;
+}
+
+int main(int ac, char **av)
+{
+	struct packed_git *p;
+
+	setup_git_directory();
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next)
+		if (p->pack_local)
+			verify_pack_name(p);
+	return 0;
+}
-- 
1.1.1-g8ecb
