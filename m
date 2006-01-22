From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Add git-pack-ls-objects tool
Date: Sun, 22 Jan 2006 03:27:11 +0100
Message-ID: <20060122022711.16333.93404.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 22 03:25:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0UvJ-0000XY-Ay
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 03:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWAVCZl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 21:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWAVCZl
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 21:25:41 -0500
Received: from w241.dkm.cz ([62.24.88.241]:32694 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750768AbWAVCZl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 21:25:41 -0500
Received: (qmail 16359 invoked from network); 22 Jan 2006 03:27:12 +0100
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 22 Jan 2006 03:27:12 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15033>

This tool takes pack index on stdin and produces the list of indexed
objects on stdout.

Very simple, but I've been always somewhat nervous that I cannot list
all (even unreferenced) objects in a repository, and in a given pack in
particular. The immediate use will be in the git-count-objects script,
but I can imagine it being useful also in various troubleshooting
situations.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-pack-ls-objects.txt |   32 ++++++++++++++++++++++++++++++++
 Makefile                              |    2 +-
 pack-ls-objects.c                     |   31 +++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-pack-ls-objects.txt b/Documentation/git-pack-ls-objects.txt
new file mode 100644
index 0000000..bf2a4a4
--- /dev/null
+++ b/Documentation/git-pack-ls-objects.txt
@@ -0,0 +1,32 @@
+git-pack-ls-objects(1)
+======================
+
+NAME
+----
+git-pack-ls-objects - List objects in a pack based on its index
+
+
+SYNOPSIS
+--------
+'git-pack-ls-objects' < pack-index
+
+
+DESCRIPTION
+-----------
+Reads a packed archive index (.idx) from its standard input and
+produces the list of indexed objects (that is, the objects packed
+in the corresponding .pack file) on its standard output.
+
+
+Author
+------
+Written by Petr Baudis <pasky@suse.cz>
+
+Documentation
+-------------
+Documentation by Petr Baudis
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
diff --git a/Makefile b/Makefile
index a291bb1..7c54507 100644
--- a/Makefile
+++ b/Makefile
@@ -143,7 +143,7 @@ PROGRAMS = \
 	git-upload-pack$X git-verify-pack$X git-write-tree$X \
 	git-update-ref$X git-symbolic-ref$X git-check-ref-format$X \
 	git-name-rev$X git-pack-redundant$X git-repo-config$X git-var$X \
-	git-describe$X
+	git-describe$X git-pack-ls-objects$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
diff --git a/pack-ls-objects.c b/pack-ls-objects.c
new file mode 100644
index 0000000..caee59c
--- /dev/null
+++ b/pack-ls-objects.c
@@ -0,0 +1,31 @@
+/*
+ * GIT - The information manager from hell
+ *
+ * Copyright (C) Petr Baudis, 2006
+ */
+
+#include <stdio.h>
+#include "cache.h"
+
+static const char pack_usage[] = "git-pack-ls-objects < pack-idx";
+
+int main(int argc, char **argv)
+{
+	unsigned char buf[1024];
+	unsigned char entry[24];
+
+	if (argc > 1)
+		usage(pack_usage);
+
+	/* We are doing these charades because we do not want to print
+	 * the last sha1. */
+
+	if (!fread(buf, 256 * 4, 1, stdin) || !fread(entry, 24, 1, stdin))
+		die("invalid pack index");
+
+	while (fread(buf, 24, 1, stdin)) {
+		printf("%s\n", sha1_to_hex(entry + 4));
+		memcpy(entry, buf, 24);
+	}
+	return 0;
+}
