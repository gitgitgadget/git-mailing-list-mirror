From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add git-local-pull.
Date: Sun, 01 May 2005 17:11:26 -0700
Message-ID: <7vis22qyfl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 02:07:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSOSb-0008Af-3B
	for gcvg-git@gmane.org; Mon, 02 May 2005 02:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVEBAMP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 20:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVEBAMP
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 20:12:15 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:35316 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261529AbVEBAL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 20:11:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050502001127.KHP26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 20:11:27 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds the git-local-pull command as a smaller brother of
http-pull and rpull.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Makefile     |    3 +
local-pull.c |  110 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
2 files changed, 112 insertions(+), 1 deletion(-)

# - [PATCH] Do not pollute work tree in git-merge-one-file-script
# + [PATCH] Add local pull.
--- k/Makefile
+++ l/Makefile
@@ -21,7 +21,7 @@ PROG=   git-update-cache git-diff-files 
 	git-check-files git-ls-tree git-merge-base git-merge-cache \
 	git-unpack-file git-export git-diff-cache git-convert-cache \
 	git-http-pull git-rpush git-rpull git-rev-list git-mktag \
-	git-diff-tree-helper git-tar-tree git-write-blob
+	git-diff-tree-helper git-tar-tree git-write-blob git-local-pull
 
 all: $(PROG)
 
@@ -87,6 +87,7 @@ git-export: export.c
 git-diff-cache: diff-cache.c
 git-convert-cache: convert-cache.c
 git-http-pull: http-pull.c pull.c
+git-local-pull: local-pull.c pull.c
 git-rpush: rsh.c
 git-rpull: rsh.c pull.c
 git-rev-list: rev-list.c
# - date handling: handle "AM"/"PM" on time
# + [PATCH] Add local pull.
Created: local-pull.c (mode:100644)
--- /dev/null
+++ l/local-pull.c
@@ -0,0 +1,110 @@
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdlib.h>
+#include "cache.h"
+#include "commit.h"
+#include <errno.h>
+#include <stdio.h>
+#include "pull.h"
+
+static int use_link = 0;
+static int use_symlink = 0;
+static int verbose = 0;
+
+static char *path;
+
+static void say(const char *fmt, const char *hex) {
+	if (verbose)
+		fprintf(stderr, fmt, hex);
+}
+
+int fetch(unsigned char *sha1)
+{
+	static int object_name_start = -1;
+	static char filename[PATH_MAX];
+	char *hex = sha1_to_hex(sha1);
+	const char *dest_filename = sha1_file_name(sha1);
+	int ifd, ofd, status;
+	struct stat st;
+	void *map;
+
+	if (object_name_start < 0) {
+		strcpy(filename, path); /* e.g. git.git */
+		strcat(filename, "/objects/");
+		object_name_start = strlen(filename);
+	}
+	filename[object_name_start+0] = hex[0];
+	filename[object_name_start+1] = hex[1];
+	filename[object_name_start+2] = '/';
+	strcpy(filename + object_name_start + 3, hex + 2);
+	if (use_link && !link(filename, dest_filename)) {
+		say("Hardlinked %s.\n", hex);
+		return 0;
+	}
+	if (use_symlink && !symlink(filename, dest_filename)) {
+		say("Symlinked %s.\n", hex);
+		return 0;
+	}
+	ifd = open(filename, O_RDONLY);
+	if (ifd < 0 || fstat(ifd, &st) < 0) {
+		close(ifd);
+		fprintf(stderr, "Cannot open %s\n", filename);
+		return -1;
+	}
+	map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, ifd, 0);
+	close(ifd);
+	if (-1 == (int)(long)map) {
+		fprintf(stderr, "Cannot mmap %s\n", filename);
+		return -1;
+	}
+	ofd = open(dest_filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
+	status = ((ofd < 0) || (write(ofd, map, st.st_size) != st.st_size));
+	munmap(map, st.st_size);
+	close(ofd);
+	if (status)
+		fprintf(stderr, "Cannot write %s (%ld bytes)\n",
+			dest_filename, st.st_size);
+	else
+		say("Copied %s.\n", hex);
+	return status;
+}
+
+static const char *local_pull_usage = 
+"git-local-pull [-c] [-t] [-a] [-l] [-s] [-v] commit-id path";
+
+int main(int argc, char **argv)
+{
+	char *commit_id;
+	int arg = 1;
+
+	while (arg < argc && argv[arg][0] == '-') {
+		if (argv[arg][1] == 't')
+			get_tree = 1;
+		else if (argv[arg][1] == 'c')
+			get_history = 1;
+		else if (argv[arg][1] == 'a') {
+			get_all = 1;
+			get_tree = 1;
+			get_history = 1;
+		}
+		else if (argv[arg][1] == 'l')
+			use_link = 1;
+		else if (argv[arg][1] == 's')
+			use_symlink = 1;
+		else if (argv[arg][1] == 'v')
+			verbose = 1;
+		else
+			usage(local_pull_usage);
+		arg++;
+	}
+	if (argc < arg + 2)
+		usage(local_pull_usage);
+	commit_id = argv[arg];
+	path = argv[arg + 1];
+
+	if (pull(commit_id))
+		return 1;
+
+	return 0;
+}

