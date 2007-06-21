From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH 2/2] Teach git-blame --gui how to start git-gui blame
Date: Thu, 21 Jun 2007 00:53:33 -0400
Message-ID: <20070621045333.GB13977@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 06:54:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1EgM-0002zy-N6
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 06:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbXFUExj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 00:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbXFUExi
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 00:53:38 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37373 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbXFUExh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 00:53:37 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I1Efm-000212-Vh; Thu, 21 Jun 2007 00:53:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C18F020FBAE; Thu, 21 Jun 2007 00:53:33 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50592>

Jakub Narebski proposed the idea of having a new --gui option for
git-blame that would start `git gui blame` with the arguments that
were given to git-blame on the command line.  This actually makes
a lot of sense, as some users may first reach for `git blame` and
find the handy `--gui` option, rather than looking for the blame
subcommand of `git gui`.

To keep things really simple in git-blame we require that the new
--gui option be the first argument on the command line, and cannot
be combined with any other option.  If it is the first argument
then we punt our entire command line as-is into `git gui blame`,
where that program's option parser will handle selecting out the
revision and path, if present.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 From Jakub Narebski <jnareb@gmail.com>:
 > or have "git blame --gui" invoke "git gui blame"

 Not a bad idea.  Here's an implementation that does that.
 Its simple and not very intrusive, but has the odd behavior that
 no option (like --contents) can be used along with it, because
 git-gui's own blame subcommand doesn't recognize them.  On the
 other hand it is a useful DWIMery for `git gui blame`.


 Documentation/git-blame.txt |    8 ++++++++
 builtin-blame.c             |   12 +++++++++++-
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 66f1203..96ff02d 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git-blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-p] [-w] [--incremental] [-L n,m]
             [-S <revs-file>] [-M] [-C] [-C] [--since=<date>]
+            [--gui]
             [<rev> | --contents <file>] [--] <file>
 
 DESCRIPTION
@@ -67,6 +68,13 @@ include::blame-options.txt[]
 	Ignore whitespace when comparing parent's version and
 	child's to find where the lines came from.
 
+--gui::
+	Instead of displaying the blame output on the text console,
+	start git-gui's graphical blame viewer.  This option must
+	be the first option supplied, and cannot be combined with
+	any other option described here, except the optional <rev>
+	and the required <file> arguments.
+
 
 THE PORCELAIN FORMAT
 --------------------
diff --git a/builtin-blame.c b/builtin-blame.c
index f7e2c13..2f50a4a 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -18,9 +18,10 @@
 #include "cache-tree.h"
 #include "path-list.h"
 #include "mailmap.h"
+#include "exec_cmd.h"
 
 static char blame_usage[] =
-"git-blame [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-p] [-w] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [--contents <filename>] [--incremental] [commit] [--] file\n"
+"git-blame [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-p] [-w] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [--contents <filename>] [--incremental] [--gui] [commit] [--] file\n"
 "  -c                  Use the same output mode as git-annotate (Default: off)\n"
 "  -b                  Show blank SHA-1 for boundary commits (Default: off)\n"
 "  -l                  Show long commit SHA1 (Default: off)\n"
@@ -34,6 +35,7 @@ static char blame_usage[] =
 "  -L n,m              Process only line range n,m, counting from 1\n"
 "  -M, -C              Find line movements within and across files\n"
 "  --incremental       Show blame entries as we find them, incrementally\n"
+"  --gui               Use git-gui's graphical blame viewer\n"
 "  --contents file     Use <file>'s contents as the final image\n"
 "  -S revs-file        Use revisions from revs-file instead of calling git-rev-list\n";
 
@@ -2137,6 +2139,12 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	const char *contents_from = NULL;
 
 	cmd_is_annotate = !strcmp(argv[0], "annotate");
+	if (!cmd_is_annotate && argc > 1 && !strcmp(argv[1], "--gui")) {
+		argv[0] = "gui";
+		argv[1] = "blame";
+		execv_git_cmd(argv);
+		die("Cannot execute git-gui blame: %s", strerror(errno));
+	}
 
 	git_config(git_blame_config);
 	save_commit_buffer = 0;
@@ -2214,6 +2222,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		else if (!strcmp("-p", arg) ||
 			 !strcmp("--porcelain", arg))
 			output_option |= OUTPUT_PORCELAIN;
+		else if (!strcmp("--gui", arg))
+			die("Cannot combine --gui with %s", argv[i - 1]);
 		else if (!strcmp("--", arg)) {
 			seen_dashdash = 1;
 			i++;
-- 
1.5.2.2.1050.g51a8b
