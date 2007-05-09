From: Theodore Tso <tytso@mit.edu>
Subject: [PATCH] Add --aggressive option to 'git gc'
Date: Wed, 9 May 2007 15:48:39 -0400
Message-ID: <20070509194839.GB10280@thunk.org>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net> <11786309073709-git-send-email-tytso@mit.edu> <11786309072612-git-send-email-tytso@mit.edu> <11786309071033-git-send-email-tytso@mit.edu> <Pine.LNX.4.64.0705090056231.18541@iabervon.org> <7v3b26xvjo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 21:49:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hls9e-0006d9-S4
	for gcvg-git@gmane.org; Wed, 09 May 2007 21:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbXEITst (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 15:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754718AbXEITst
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 15:48:49 -0400
Received: from thunk.org ([69.25.196.29]:45004 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbXEITss (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 15:48:48 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HlsGJ-0002oG-3t; Wed, 09 May 2007 15:55:47 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1Hls9P-0004uO-Lg; Wed, 09 May 2007 15:48:39 -0400
Content-Disposition: inline
In-Reply-To: <7v3b26xvjo.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46772>

On Wed, May 09, 2007 at 01:15:07AM -0700, Junio C Hamano wrote:
> > Maybe git-gc should have an option for "compress hard"? It seems to me 
> > like a two-sizes-fit-all solution would be good here; "git gc" for daily 
> > use, and "git gc --squeeze" for when you want to make the result as small 
> > as possible, with compute time not being a major factor.
> 
> I think that sounds saner and more user friendly than specific
> knob to tune "window", "depth" and friends which are too
> technical.  It has an added attraction that we can redefine what
> exactly "hard" means later.

OK, here's a patch that does exactly that.  I choose git-gc
--aggressive, since I thought that was more descriptive than --hard or
--squeeze.  Junio, would you be willing to apply this?

					- Ted

=== Cut here ===

Add --aggressive option to 'git gc'

This option causes 'git gc' to more aggressively optimize the
repository at the cost of taking much more wall clock and CPU time.

Today this option causes git-pack-objects to use --no-use-delta
option, and it allows the --window parameter to be set via the
gc.aggressiveWindow configuration parameter.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 Documentation/config.txt |    5 +++++
 Documentation/git-gc.txt |   16 +++++++++++++++-
 builtin-gc.c             |   35 +++++++++++++++++++++++++++++++++--
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ea434af..efcf301 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -384,6 +384,11 @@ format.suffix::
 	`.patch`. Use this variable to change that suffix (make sure to
 	include the dot if you want it).
 
+gc.aggressiveWindow::
+	The window size parameter used in the delta compression
+	algorithm used by 'git gc --aggressive'.  This defaults
+	to 10.
+
 gc.packrefs::
 	`git gc` does not run `git pack-refs` in a bare repository by
 	default so that older dumb-transport clients can still fetch
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index bc16584..56575e8 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -8,7 +8,7 @@ git-gc - Cleanup unnecessary files and optimize the local repository
 
 SYNOPSIS
 --------
-'git-gc' [--prune]
+'git-gc' [--prune] [--aggressive]
 
 DESCRIPTION
 -----------
@@ -35,6 +35,13 @@ OPTIONS
 	repository at the same time (e.g. never use this option
 	in a cron script).
 
+--aggressive::
+	Usually 'git-gc' runs very quickly while providing good disk
+	space utilization and performance.   This option will cause
+	git-gc to more aggressive optimize the repository at the expense
+	of taking much more time.  The effects of this optimization are
+	persistent, so this option only needs to be sporadically; every
+	few hundred changesets or so.
 
 Configuration
 -------------
@@ -67,6 +74,13 @@ The optional configuration variable 'gc.packrefs' determines if
 is not run in bare repositories by default, to allow older dumb-transport
 clients fetch from the repository,  but this will change in the future.
 
+The optional configuration variable 'gc.aggressiveWindow' controls how
+much time is spent optimizing the delta compression of the objects in
+the repository when the --aggressive option is specified.  The larger
+the value, the more time is spent optimizing the delta compression.  See
+the documentation for the --window' option in gitlink:git-repack[1] for
+more details.  This defaults to 10.
+
 See Also
 --------
 gitlink:git-prune[1]
diff --git a/builtin-gc.c b/builtin-gc.c
index 3b1f8c2..10f92f1 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -15,13 +15,15 @@
 
 #define FAILED_RUN "failed to run %s"
 
-static const char builtin_gc_usage[] = "git-gc [--prune]";
+static const char builtin_gc_usage[] = "git-gc [--prune] [--aggressive]";
 
 static int pack_refs = -1;
+static int aggressive_window = -1;
 
+#define MAX_ADD 10
 static const char *argv_pack_refs[] = {"pack-refs", "--prune", NULL};
 static const char *argv_reflog[] = {"reflog", "expire", "--all", NULL};
-static const char *argv_repack[] = {"repack", "-a", "-d", "-l", NULL};
+static const char *argv_repack[MAX_ADD] = {"repack", "-a", "-d", "-l", NULL};
 static const char *argv_prune[] = {"prune", NULL};
 static const char *argv_rerere[] = {"rerere", "gc", NULL};
 
@@ -34,13 +36,34 @@ static int gc_config(const char *var, const char *value)
 			pack_refs = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "gc.aggressiveWindow")) {
+		aggressive_window = git_config_int(var, value);
+		printf("aggressive_window = %d\n", aggressive_window);
+		return 0;
+	}
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
 	int prune = 0;
+	char buf[80];
 
 	git_config(gc_config);
 
@@ -53,6 +76,14 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			prune = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--aggressive")) {
+			append_option(argv_repack, "-f", MAX_ADD);
+			if (aggressive_window > 0) {
+				sprintf(buf, "--window=%d", aggressive_window);
+				append_option(argv_repack, buf, MAX_ADD);
+			}
+			continue;
+		}
 		/* perhaps other parameters later... */
 		break;
 	}
-- 
1.5.2.rc2.22.ga39d
