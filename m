From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Teach git-checkout-index to read filenames from stdin.
Date: Tue, 28 Feb 2006 21:43:33 -0500
Message-ID: <20060301024333.GB21186@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Mar 01 04:06:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEHey-00042h-Ar
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 04:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWCADFt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 22:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWCADFt
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 22:05:49 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:9625 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964833AbWCADFs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 22:05:48 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FEHeo-0004qf-KA
	for git@vger.kernel.org; Tue, 28 Feb 2006 22:05:42 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2438120FB93; Tue, 28 Feb 2006 21:43:33 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16961>

Since git-checkout-index is often used from scripts which
may have a stream of filenames they wish to checkout it is
more convenient to use --stdin than xargs.  On platforms
where fork performance is currently sub-optimal and
the length of a command line is limited (*cough* Cygwin
*cough*) running a single git-checkout-index process for
a large number of files beats spawning it multiple times
from xargs.

File names are still accepted on the command line if
--stdin is not supplied.  Nothing is performed if no files
are supplied on the command line or by stdin.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---
 I wonder if Linus will stop using

   find ... -print0 | xargs -0 git-checkout-index --

 with this option available.

 Eh, probably not as xargs requires less typing than -z --stdin.

 Documentation/git-checkout-index.txt |   20 +++++++++++++++--
 checkout-index.c                     |   41 ++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 2 deletions(-)

base 84434f9549d56e522a2eb4de370100f0a6e5e041
last df23c1119d0af1fbac6b8afd296113e155d9a878
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index 2a1e526..b0b6588 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -10,7 +10,9 @@ SYNOPSIS
 --------
 [verse]
 'git-checkout-index' [-u] [-q] [-a] [-f] [-n] [--prefix=<string>]
-		   [--stage=<number>] [--] <file>...
+		   [--stage=<number>]
+		   [-z] [--stdin]
+		   [--] [<file>]\*
 
 DESCRIPTION
 -----------
@@ -45,6 +47,15 @@ OPTIONS
 	Instead of checking out unmerged entries, copy out the
 	files from named stage.  <number> must be between 1 and 3.
 
+--stdin::
+	Instead of taking list of paths from the command line,
+	read list of paths from the standard input.  Paths are
+	separated by LF (i.e. one path per line) by default.
+
+-z::
+	Only meaningful with `--stdin`; paths are separated with
+	NUL character instead of LF.
+
 --::
 	Do not interpret any more arguments as options.
 
@@ -64,7 +75,12 @@ $ find . -name '*.h' -print0 | xargs -0 
 
 which will force all existing `*.h` files to be replaced with their
 cached copies. If an empty command line implied "all", then this would
-force-refresh everything in the index, which was not the point.
+force-refresh everything in the index, which was not the point.  But
+since git-checkout-index accepts --stdin it would be faster to use:
+
+----------------
+$ find . -name '*.h' -print0 | git-checkout-index -f -z --stdin
+----------------
 
 The `--` is just a good idea when you know the rest will be filenames;
 it will prevent problems with a filename of, for example,  `-a`.
diff --git a/checkout-index.c b/checkout-index.c
index 957b4a8..f54c606 100644
--- a/checkout-index.c
+++ b/checkout-index.c
@@ -22,6 +22,10 @@
  *
  *	find . -name '*.h' -print0 | xargs -0 git-checkout-index -f --
  *
+ * or:
+ *
+ *	find . -name '*.h' -print0 | git-checkout-index -f -z --stdin
+ *
  * which will force all existing *.h files to be replaced with
  * their cached copies. If an empty command line implied "all",
  * then this would force-refresh everything in the cache, which
@@ -33,6 +37,8 @@
  * but get used to it in scripting!).
  */
 #include "cache.h"
+#include "strbuf.h"
+#include "quote.h"
 
 static const char *prefix;
 static int prefix_length;
@@ -114,6 +120,8 @@ int main(int argc, char **argv)
 	int i;
 	int newfd = -1;
 	int all = 0;
+	int read_from_stdin = 0;
+	int line_termination = '\n';
 
 	prefix = setup_git_directory();
 	git_config(git_default_config);
@@ -156,6 +164,17 @@ int main(int argc, char **argv)
 				die("cannot open index.lock file.");
 			continue;
 		}
+		if (!strcmp(arg, "-z")) {
+			line_termination = 0;
+			continue;
+		}
+		if (!strcmp(arg, "--stdin")) {
+			if (i != argc - 1)
+				die("--stdin must be at the end");
+			read_from_stdin = 1;
+			i++; /* do not consider arg as a file name */
+			break;
+		}
 		if (!strncmp(arg, "--prefix=", 9)) {
 			state.base_dir = arg+9;
 			state.base_dir_len = strlen(state.base_dir);
@@ -191,9 +210,31 @@ int main(int argc, char **argv)
 
 		if (all)
 			die("git-checkout-index: don't mix '--all' and explicit filenames");
+		if (read_from_stdin)
+			die("git-checkout-index: don't mix '--stdin' and explicit filenames");
 		checkout_file(prefix_path(prefix, prefix_length, arg));
 	}
 
+	if (read_from_stdin) {
+		struct strbuf buf;
+		if (all)
+			die("git-checkout-index: don't mix '--all' and '--stdin'");
+		strbuf_init(&buf);
+		while (1) {
+			char *path_name;
+			read_line(&buf, stdin, line_termination);
+			if (buf.eof)
+				break;
+			if (line_termination && buf.buf[0] == '"')
+				path_name = unquote_c_style(buf.buf, NULL);
+			else
+				path_name = buf.buf;
+			checkout_file(prefix_path(prefix, prefix_length, path_name));
+			if (path_name != buf.buf)
+				free(path_name);
+		}
+	}
+
 	if (all)
 		checkout_all();
 
-- 
1.2.3.gdf23c
