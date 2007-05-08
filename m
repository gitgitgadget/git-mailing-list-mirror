From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] Add --no-reuse-delta option to git-gc
Date: Tue,  8 May 2007 09:28:27 -0400
Message-ID: <11786309071033-git-send-email-tytso@mit.edu>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
 <11786309073709-git-send-email-tytso@mit.edu>
 <11786309072612-git-send-email-tytso@mit.edu>
Cc: Git Mailing List <git@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 08 15:28:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlPkD-0008S8-B4
	for gcvg-git@gmane.org; Tue, 08 May 2007 15:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934660AbXEHN2i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 09:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934738AbXEHN2i
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 09:28:38 -0400
Received: from THUNK.ORG ([69.25.196.29]:60765 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934660AbXEHN2g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 09:28:36 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HlPqo-0002Rt-TF; Tue, 08 May 2007 09:35:35 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HlPjv-0007qP-Dy; Tue, 08 May 2007 09:28:27 -0400
X-Mailer: git-send-email 1.5.2.rc2.22.ga39d
In-Reply-To: <11786309072612-git-send-email-tytso@mit.edu>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46576>

This allows the user to regenerate the deltas in packs while doing
a git-gc.  The user could just run git-repack -a -d -f -l after
running git-gc, but then the first git-repack run by git-gc is
a bit of waste.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 Documentation/git-gc.txt |    7 ++++++-
 builtin-gc.c             |   24 ++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index bc16584..0493d06 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -8,7 +8,7 @@ git-gc - Cleanup unnecessary files and optimize the local repository
 
 SYNOPSIS
 --------
-'git-gc' [--prune]
+'git-gc' [--prune] [--no-reuse-delta]
 
 DESCRIPTION
 -----------
@@ -35,6 +35,11 @@ OPTIONS
 	repository at the same time (e.g. never use this option
 	in a cron script).
 
+--no-reuse-delta::
+	This causes deltas in existing packs to be recalculated instead
+	of reusing the existing deltas.  This can save disk space at
+	the cost of taking more time to recalculate them from scratch.
+
 
 Configuration
 -------------
diff --git a/builtin-gc.c b/builtin-gc.c
index 3b1f8c2..5cb7ffd 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -15,13 +15,14 @@
 
 #define FAILED_RUN "failed to run %s"
 
-static const char builtin_gc_usage[] = "git-gc [--prune]";
+static const char builtin_gc_usage[] = "git-gc [--prune] [--no-reuse-delta]";
 
 static int pack_refs = -1;
 
+#define MAX_ADD 10
 static const char *argv_pack_refs[] = {"pack-refs", "--prune", NULL};
 static const char *argv_reflog[] = {"reflog", "expire", "--all", NULL};
-static const char *argv_repack[] = {"repack", "-a", "-d", "-l", NULL};
+static const char *argv_repack[MAX_ADD] = {"repack", "-a", "-d", "-l", NULL};
 static const char *argv_prune[] = {"prune", NULL};
 static const char *argv_rerere[] = {"rerere", "gc", NULL};
 
@@ -37,6 +38,21 @@ static int gc_config(const char *var, const char *value)
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
@@ -53,6 +69,10 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			prune = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--no-reuse-delta")) {
+			append_option(argv_repack, "-f", MAX_ADD);
+			continue;
+		}
 		/* perhaps other parameters later... */
 		break;
 	}
-- 
1.5.2.rc2.22.ga39d
