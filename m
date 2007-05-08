From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] Add --no-reuse-delta, --window, and --depth options to git-gc
Date: Mon, 07 May 2007 22:54:34 -0400
Message-ID: <E1HlFqU-0002ir-GK@candygram.thunk.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 08 04:54:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlFqf-0004Vd-NU
	for gcvg-git@gmane.org; Tue, 08 May 2007 04:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967609AbXEHCyl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 22:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967610AbXEHCyl
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 22:54:41 -0400
Received: from THUNK.ORG ([69.25.196.29]:58850 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967609AbXEHCyk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 22:54:40 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HlFxM-0000Cr-LR; Mon, 07 May 2007 23:01:41 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HlFqU-0002ir-GK; Mon, 07 May 2007 22:54:34 -0400
Full-Name: Theodore Ts'o
Phone: (781) 391-3464
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46519>

Sometimes users might want to use more aggressive packing options
when doing a git-gc.  This allows them to do so without having
to use the low-level plumbing commands.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 Documentation/git-gc.txt           |    3 ++-
 Documentation/git-pack-objects.txt |   19 +------------------
 Documentation/pack-options.txt     |   18 ++++++++++++++++++
 builtin-gc.c                       |   30 ++++++++++++++++++++++++++++--
 4 files changed, 49 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/pack-options.txt

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index bc16584..3c807c2 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -8,7 +8,7 @@ git-gc - Cleanup unnecessary files and optimize the local repository
 
 SYNOPSIS
 --------
-'git-gc' [--prune]
+'git-gc' [--prune] [--no-reuse-delta] [--window=N] [--depth=N]
 
 DESCRIPTION
 -----------
@@ -35,6 +35,7 @@ OPTIONS
 	repository at the same time (e.g. never use this option
 	in a cron script).
 
+include::pack-options.txt[]
 
 Configuration
 -------------
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index d9e11c6..aac71f6 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -73,18 +73,6 @@ base-name::
 	as if all refs under `$GIT_DIR/refs` are specified to be
 	included.
 
---window=[N], --depth=[N]::
-	These two options affect how the objects contained in
-	the pack are stored using delta compression.  The
-	objects are first internally sorted by type, size and
-	optionally names and compared against the other objects
-	within --window to see if using delta compression saves
-	space.  --depth limits the maximum delta depth; making
-	it too deep affects the performance on the unpacker
-	side, because delta data needs to be applied that many
-	times to get to the necessary object.
-	The default value for both --window and --depth is 10.
-
 --incremental::
 	This flag causes an object already in a pack ignored
 	even if it appears in the standard input.
@@ -120,12 +108,7 @@ base-name::
 	This flag makes the command not to report its progress
 	on the standard error stream.
 
---no-reuse-delta::
-	When creating a packed archive in a repository that
-	has existing packs, the command reuses existing deltas.
-	This sometimes results in a slightly suboptimal pack.
-	This flag tells the command not to reuse existing deltas
-	but compute them from scratch.
+include::pack-options.txt[]
 
 --delta-base-offset::
 	A packed archive can express base object of a delta as
diff --git a/Documentation/pack-options.txt b/Documentation/pack-options.txt
new file mode 100644
index 0000000..7b0ae5f
--- /dev/null
+++ b/Documentation/pack-options.txt
@@ -0,0 +1,18 @@
+--window=[N], --depth=[N]::
+	These two options affect how the objects contained in
+	the pack are stored using delta compression.  The
+	objects are first internally sorted by type, size and
+	optionally names and compared against the other objects
+	within --window to see if using delta compression saves
+	space.  --depth limits the maximum delta depth; making
+	it too deep affects the performance on the unpacker
+	side, because delta data needs to be applied that many
+	times to get to the necessary object.
+	The default value for both --window and --depth is 10.
+
+--no-reuse-delta::
+	When creating a packed archive in a repository that
+	has existing packs, the command reuses existing deltas.
+	This sometimes results in a slightly suboptimal pack.
+	This flag tells the command not to reuse existing deltas
+	but compute them from scratch.
diff --git a/builtin-gc.c b/builtin-gc.c
index 3b1f8c2..7e7775d 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -15,13 +15,15 @@
 
 #define FAILED_RUN "failed to run %s"
 
-static const char builtin_gc_usage[] = "git-gc [--prune]";
+static const char builtin_gc_usage[] = "git-gc [--prune] [--no-reuse-delta] [--window=N] [--depth=N]";
 
 static int pack_refs = -1;
 
+#define MAX_ADD 10
+
 static const char *argv_pack_refs[] = {"pack-refs", "--prune", NULL};
 static const char *argv_reflog[] = {"reflog", "expire", "--all", NULL};
-static const char *argv_repack[] = {"repack", "-a", "-d", "-l", NULL};
+static const char *argv_repack[MAX_ADD] = {"repack", "-a", "-d", "-l", NULL};
 static const char *argv_prune[] = {"prune", NULL};
 static const char *argv_rerere[] = {"rerere", "gc", NULL};
 
@@ -37,6 +39,21 @@ static int gc_config(const char *var, const char *value)
 	return git_default_config(var, value);
 }
 
+static append_option(const char **cmd, const char *opt, int max_length)
+{
+	int	i;
+
+	for (i=0; cmd[i]; i++)
+		;
+
+	if (i+2 >= max_length) {
+		fprintf(stderr, "Too many options specified\n");
+		exit(1);
+	}
+	cmd[i++] = opt;
+	cmd[i] = 0;
+}
+
 int cmd_gc(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -53,6 +70,15 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			prune = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--no-reuse-delta")) {
+			append_option(argv_repack, "-f", MAX_ADD);
+			continue;
+		}
+		if (!strncmp(arg, "--window", 8) ||
+		    !strncmp(arg, "--depth", 7)) {
+			append_option(argv_repack, arg, MAX_ADD);
+			continue;
+		}
 		/* perhaps other parameters later... */
 		break;
 	}
-- 
1.5.2.rc1.20.g86b9-dirty
