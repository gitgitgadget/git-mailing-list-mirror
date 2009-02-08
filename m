From: Brent Goodrick <bgoodr@gmail.com>
Subject: Trouble testing out a patch on a branch new scratch git.git 
	repository
Date: Sun, 8 Feb 2009 12:56:48 -0800
Message-ID: <e38bce640902081256j3cd84aadn2f0cc863cfca904d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 21:58:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWGjK-00055j-Vb
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 21:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbZBHU4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 15:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbZBHU4w
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 15:56:52 -0500
Received: from mail-gx0-f21.google.com ([209.85.217.21]:64341 "EHLO
	mail-gx0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbZBHU4u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 15:56:50 -0500
Received: by gxk14 with SMTP id 14so1468228gxk.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 12:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=dCVh04Eimy8o6ujtQEv77qdIgZjso4LPoTlTy7LTNFU=;
        b=We63Ac1/2F5m6ZX6kZ4hFZqPwUA2eXh+kqUBwXe/zpVs/QfInj/QNlKlJIWajUbBfO
         L1KeiFzYuCXGjpTr/nF6bRRh+604qWNc7uo2K1pBzvp2zDIjk2lomTFJlLItvPcRAOgm
         t/3uwlQZdFK9ZAn5FjwOXDic12IdE1TVM/4CY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=JUeC3LvkqMkopwPrIbPg10Ii/dhNKDJVEuifnrRf3X2ub1eQMGpvvDEsphwt7c/tkN
         JXo8ih0Z0iCQnWh1dYEBY2P/uJX46SMc9Ke3FawnKehpg+8Wh4HxMUGNk/HfaTwRuaa9
         YSBCem+S3OeORuRwQy1Q8lk/BtRv7vHEc/XxU=
Received: by 10.90.71.16 with SMTP id t16mr850777aga.8.1234126608796; Sun, 08 
	Feb 2009 12:56:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109015>

Hi,

I have a patch ready for my new --progress switch, and am trying to
prepare the PATCH/RFC email.  I am having problems testing out the
patch with get-am.  I suspect if my patch is going to have any hope at
being applied, I have to figure out what is causing git am to fail to
apply the change.

So, here is what I think happened in my repo:

1. A while ago, I made some changes and began testing them out.
2. I committed the change into the first commit (see
e802880bb89524b1f70132f1ca0716624788db3f below)
3. Unfortunately, I then stumbled across the coding guidelines, and
then discovered that my if statements had too many curly braces, and
fixed that with another commit (but I doubt that is the problem here)
4. I did a git pull origin and found a conflict in a file I had
changed in the first commit above into cache.h (I had inserted a line
right where someone else had inserted a line). I probably should have
stopped right then and there and not gone ahead with the merge, but do
something different (but if so, then what should I have done instead?)
:)
5. I manually edited cache.h to resolve the conflict, and then
executed "git add cache.h"
6. Committed the merge with git commit
(78f968776048d6dace68e6367fbd4e7d81041fef below)
7. Ran "git format-patch -M --stdout origin/master" and dumped it to a file.
8. Created a new scratch repository and tried to apply the patch with
this script:

#!/bin/sh
set -x
set -e
cd /tmp
rm -rf checkout_test
mkdir checkout_test
cd checkout_test
git clone git://git.kernel.org/pub/scm/git/git.git
cd git
git am /tmp/patch

And the git am command failed on the cache.h file that had the
conflict I manually fixed. But note also a failure to apply the change
to git.c too (which, BTW, did not require any man-handling during the
merge). The output of that git am command is:

git am /tmp/patch
Applying: Add progress options
error: patch failed: cache.h:371
error: cache.h: patch does not apply
error: patch failed: git.c:4
error: git.c: patch does not apply
Patch failed at 0001 Add progress options
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

Here is a trimmed down git log output showing where my commits stand
w.r.t. the merge and the other commits in between (see <snip> line):


git log -100
commit 78f968776048d6dace68e6367fbd4e7d81041fef
Merge: 44b1f2e... 621f1b4...
Author: Brent Goodrick <brentg@hungover.brentg.com>
Date:   Sun Feb 8 11:03:13 2009 -0800

    Merge branch 'master' of git://git.kernel.org/pub/scm/git/git

    Conflicts:
    	cache.h

commit 44b1f2ecd2dc19ccb04660a730814c7b07b6d838
Author: Brent Goodrick <brentg@hungover.brentg.com>
Date:   Sun Feb 8 10:53:33 2009 -0800

    Conform to git coding standards

    This is a cosmetic change to remove curly braces used if statements
    that have only one statement in the true or false clauses.

<snip>... many other commits here </snip>

commit e802880bb89524b1f70132f1ca0716624788db3f
Author: Brent Goodrick <brentg@hungover.brentg.com>
Date:   Mon Feb 2 19:34:56 2009 -0800

    Add progress options

    Add --progress, --no-progress, and --progress-verbose options, which
    correspond to the GIT_PROGRESS environment variable setting of "1",
    "0", and "verbose", respectively.

    Signed-off-by: Brent Goodrick <bgoodr@gmail.com>


Any ideas as to what I need to do next here?  Even if this patch gets
rejected from being put into git.git, I still would like to know what
I did wrong.

Thanks,
bgoodr

P.S., For everyone's reference, the rest of this message contains a
raw dump of the "git format-patch -M --stdout origin/master" command
showing my work in progress that I would like to somehow reform into
an eventual PATCH/RFC email.

P.S.S. Please also reply while CCing me as I have hence had to take
myself off of the mailing list (I can't process 100+ messages per
day). 8)





--- cut here ---
From e802880bb89524b1f70132f1ca0716624788db3f Mon Sep 17 00:00:00 2001
From: Brent Goodrick <brentg@hungover.brentg.com>
Date: Mon, 2 Feb 2009 19:34:56 -0800
Subject: [PATCH 1/2] Add progress options

Add --progress, --no-progress, and --progress-verbose options, which
correspond to the GIT_PROGRESS environment variable setting of "1",
"0", and "verbose", respectively.

Signed-off-by: Brent Goodrick <bgoodr@gmail.com>
---
 Documentation/git.txt                  |   15 +++++++++++++
 builtin-pack-objects.c                 |    2 +-
 cache.h                                |    1 +
 contrib/completion/git-completion.bash |    3 ++
 git.c                                  |    8 ++++++-
 progress.c                             |   33 ++++++++++++++++++++++++----
 sideband.c                             |   36 ++++++++++++++++++++++++++++---
 7 files changed, 87 insertions(+), 11 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 17dc8b2..158b313 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git' [--version] [--exec-path[=GIT_EXEC_PATH]]
     [-p|--paginate|--no-pager]
+    [--progress|--no-progress|--progress-verbose]
     [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]
     [--help] COMMAND [ARGS]

@@ -176,6 +177,20 @@ help ...`.
 --no-pager::
 	Do not pipe git output into a pager.

+--progress::
+	Show progress for long-running processing. This corresponds to
+	setting the GIT_PROGRESS environment variable to 1. This is
+	the default.
+
+--no-progress::
+	Instead of showing intermediate progress, just show
+	completion of major steps in processing. This corresponds to
+	setting the GIT_PROGRESS environment variable to 0.
+
+--progress-verbose::
+	Enable progress and show intermediate progress results as one
+	per line.
+
 --git-dir=<path>::
 	Set the path to the repository. This can also be controlled by
 	setting the GIT_DIR environment variable. It can be an absolute
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index cb51916..7ba5268 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -81,7 +81,7 @@ static int depth = 50;
 static int delta_search_threads;
 static int pack_to_stdout;
 static int num_preferred_base;
-static struct progress *progress_state;
+static struct progress *progress_state = NULL;
 static int pack_compression_level = Z_DEFAULT_COMPRESSION;
 static int pack_compression_seen;

diff --git a/cache.h b/cache.h
index 8d965b8..ecfda5a 100644
--- a/cache.h
+++ b/cache.h
@@ -371,6 +371,7 @@ static inline enum object_type
object_type(unsigned int mode)
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
+#define GIT_PROGRESS_ENVIRONMENT "GIT_PROGRESS"

 extern int is_bare_repository_cfg;
 extern int is_bare_repository(void);
diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index 81f70ec..a555241 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1701,6 +1701,9 @@ _git ()
 		--*)   __gitcomp "
 			--paginate
 			--no-pager
+			--progress
+			--no-progress
+			--progress-verbose
 			--git-dir=
 			--bare
 			--version
diff --git a/git.c b/git.c
index ecc8fad..166a201 100644
--- a/git.c
+++ b/git.c
@@ -4,7 +4,7 @@
 #include "quote.h"

 const char git_usage_string[] =
-	"git [--version] [--exec-path[=GIT_EXEC_PATH]]
[-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR]
[--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
+	"git [--version] [--exec-path[=GIT_EXEC_PATH]]
[-p|--paginate|--no-pager]
[--progress|--no-progress|--progress-verbose] [--bare]
[--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND
[ARGS]";

 const char git_more_info_string[] =
 	"See 'git help COMMAND' for more information on a specific command.";
@@ -115,6 +115,12 @@ static int handle_options(const char*** argv,
int* argc, int* envchanged)
 			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 0);
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "--progress")) {
+			setenv(GIT_PROGRESS_ENVIRONMENT, "1", 1);
+		} else if (!strcmp(cmd, "--no-progress")) {
+			setenv(GIT_PROGRESS_ENVIRONMENT, "0", 1);
+		} else if (!strcmp(cmd, "--progress-verbose")) {
+			setenv(GIT_PROGRESS_ENVIRONMENT, "verbose", 1);
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
diff --git a/progress.c b/progress.c
index 55a8687..f92eaaa 100644
--- a/progress.c
+++ b/progress.c
@@ -10,6 +10,7 @@

 #include "git-compat-util.h"
 #include "progress.h"
+#include "cache.h"

 #define TP_IDX_MAX      8

@@ -36,6 +37,8 @@ struct progress {
 };

 static volatile sig_atomic_t progress_update;
+static int show_progress = 1;
+static int show_progress_verbose = 0;

 static void progress_interval(int signum)
 {
@@ -90,15 +93,20 @@ static int display(struct progress *progress,
unsigned n, const char *done)

 	progress->last_value = n;
 	tp = (progress->throughput) ? progress->throughput->display : "";
-	eol = done ? done : "   \r";
+	eol = done ? done : (show_progress_verbose ? "   \n" : "   \r");
 	if (progress->total) {
 		unsigned percent = n * 100 / progress->total;
 		if (percent != progress->last_percent || progress_update) {
 			progress->last_percent = percent;
-			fprintf(stderr, "%s: %3u%% (%u/%u)%s%s",
-				progress->title, percent, n,
-				progress->total, tp, eol);
-			fflush(stderr);
+			/* Show progress everytime if specified. But if progress is turned
+			 * off, only show the last message (when done is non-NULL) as a
+			 * summary: */
+			if (show_progress || done) {
+				fprintf(stderr, "%s: %3u%% (%u/%u)%s%s",
+						progress->title, percent, n,
+						progress->total, tp, eol);
+				fflush(stderr);
+			}
 			progress_update = 0;
 			return 1;
 		}
@@ -206,6 +214,21 @@ struct progress *start_progress_delay(const char
*title, unsigned total,
 				       unsigned percent_treshold, unsigned delay)
 {
 	struct progress *progress = malloc(sizeof(*progress));
+	const char * show_progress_env = getenv(GIT_PROGRESS_ENVIRONMENT);
+	if (show_progress_env) {
+		if (!strcmp(show_progress_env, "true")) {
+			show_progress_env = "1";
+		}
+		if (!strcmp(show_progress_env, "false")) {
+			show_progress_env = "0";
+		}
+		if (!strcmp(show_progress_env, "verbose")) {
+			/* Show progress, but use LF codes in the output and not CR codes: */
+			show_progress_verbose = 1;
+		} else if (!strcmp(show_progress_env, "0")) {
+			show_progress = 0;
+		}
+	}
 	if (!progress) {
 		/* unlikely, but here's a good fallback */
 		fprintf(stderr, "%s...\n", title);
diff --git a/sideband.c b/sideband.c
index cca3360..21766a4 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,5 +1,6 @@
 #include "pkt-line.h"
 #include "sideband.h"
+#include "cache.h"

 /*
  * Receive multiplexed output stream over git native protocol.
@@ -26,7 +27,24 @@ int recv_sideband(const char *me, int in_stream,
int out, int err)
 	char buf[LARGE_PACKET_MAX + 2*FIX_SIZE];
 	char *suffix, *term;
 	int skip_pf = 0;
-
+	int show_progress = 1;
+	int show_progress_verbose = 0;
+	const char * show_progress_env = getenv(GIT_PROGRESS_ENVIRONMENT);
+	if (show_progress_env) {
+		if (!strcmp(show_progress_env, "true")) {
+			show_progress_env = "1";
+		}
+		if (!strcmp(show_progress_env, "false")) {
+			show_progress_env = "0";
+		}
+		if (!strcmp(show_progress_env, "0")) {
+			show_progress = 0;
+		}
+		else if (!strcmp(show_progress_env, "verbose")) {
+			/* Show progress, but use LF codes in the output and not CR codes: */
+			show_progress_verbose = 1;
+		}
+	}
 	memcpy(buf, PREFIX, pf);
 	term = getenv("TERM");
 	if (term && strcmp(term, "dumb"))
@@ -58,6 +76,7 @@ int recv_sideband(const char *me, int in_stream, int
out, int err)
 			do {
 				char *b = buf;
 				int brk = 0;
+				int cr = 0;

 				/*
 				 * If the last buffer didn't end with a line
@@ -78,9 +97,15 @@ int recv_sideband(const char *me, int in_stream,
int out, int err)
 						brk = 0;
 						break;
 					}
-					if (b[brk-1] == '\n' ||
-					    b[brk-1] == '\r')
+					if (b[brk-1] == '\n') {
+						break;
+					} else if (b[brk-1] == '\r') {
+						if (show_progress_verbose) {
+							b[brk-1] = '\n';
+						}
+						cr = 1;
 						break;
+					}
 				}

 				/*
@@ -95,7 +120,10 @@ int recv_sideband(const char *me, int in_stream,
int out, int err)
 					memcpy(save, b + brk, sf);
 					b[brk + sf - 1] = b[brk - 1];
 					memcpy(b + brk - 1, suffix, sf);
-					safe_write(err, b, brk + sf);
+					/* Progress messages are those that end in CR codes */
+					if (show_progress || !cr) {
+						safe_write(err, b, brk + sf);
+					}
 					memcpy(b + brk, save, sf);
 					len -= brk;
 				} else {
-- 
1.6.2.rc0.3.g78f96


>From 44b1f2ecd2dc19ccb04660a730814c7b07b6d838 Mon Sep 17 00:00:00 2001
From: Brent Goodrick <brentg@hungover.brentg.com>
Date: Sun, 8 Feb 2009 10:53:33 -0800
Subject: [PATCH 2/2] Conform to git coding standards

This is a cosmetic change to remove curly braces in if statements
that have only one statement in the true or false clauses.
---
 progress.c |   14 ++++++--------
 sideband.c |   23 ++++++++---------------
 2 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/progress.c b/progress.c
index f92eaaa..c96d594 100644
--- a/progress.c
+++ b/progress.c
@@ -93,6 +93,8 @@ static int display(struct progress *progress,
unsigned n, const char *done)

 	progress->last_value = n;
 	tp = (progress->throughput) ? progress->throughput->display : "";
+	/* When show_progress_verbose is true, put each progress message on a
+	 * separate line: */
 	eol = done ? done : (show_progress_verbose ? "   \n" : "   \r");
 	if (progress->total) {
 		unsigned percent = n * 100 / progress->total;
@@ -216,18 +218,14 @@ struct progress *start_progress_delay(const char
*title, unsigned total,
 	struct progress *progress = malloc(sizeof(*progress));
 	const char * show_progress_env = getenv(GIT_PROGRESS_ENVIRONMENT);
 	if (show_progress_env) {
-		if (!strcmp(show_progress_env, "true")) {
+		if (!strcmp(show_progress_env, "true"))
 			show_progress_env = "1";
-		}
-		if (!strcmp(show_progress_env, "false")) {
+		if (!strcmp(show_progress_env, "false"))
 			show_progress_env = "0";
-		}
-		if (!strcmp(show_progress_env, "verbose")) {
-			/* Show progress, but use LF codes in the output and not CR codes: */
+		if (!strcmp(show_progress_env, "verbose"))
 			show_progress_verbose = 1;
-		} else if (!strcmp(show_progress_env, "0")) {
+		else if (!strcmp(show_progress_env, "0"))
 			show_progress = 0;
-		}
 	}
 	if (!progress) {
 		/* unlikely, but here's a good fallback */
diff --git a/sideband.c b/sideband.c
index 21766a4..4bfb206 100644
--- a/sideband.c
+++ b/sideband.c
@@ -31,19 +31,14 @@ int recv_sideband(const char *me, int in_stream,
int out, int err)
 	int show_progress_verbose = 0;
 	const char * show_progress_env = getenv(GIT_PROGRESS_ENVIRONMENT);
 	if (show_progress_env) {
-		if (!strcmp(show_progress_env, "true")) {
+		if (!strcmp(show_progress_env, "true"))
 			show_progress_env = "1";
-		}
-		if (!strcmp(show_progress_env, "false")) {
+		if (!strcmp(show_progress_env, "false"))
 			show_progress_env = "0";
-		}
-		if (!strcmp(show_progress_env, "0")) {
+		if (!strcmp(show_progress_env, "0"))
 			show_progress = 0;
-		}
-		else if (!strcmp(show_progress_env, "verbose")) {
-			/* Show progress, but use LF codes in the output and not CR codes: */
+		else if (!strcmp(show_progress_env, "verbose"))
 			show_progress_verbose = 1;
-		}
 	}
 	memcpy(buf, PREFIX, pf);
 	term = getenv("TERM");
@@ -97,12 +92,11 @@ int recv_sideband(const char *me, int in_stream,
int out, int err)
 						brk = 0;
 						break;
 					}
-					if (b[brk-1] == '\n') {
+					if (b[brk-1] == '\n')
 						break;
-					} else if (b[brk-1] == '\r') {
-						if (show_progress_verbose) {
+					else if (b[brk-1] == '\r') {
+						if (show_progress_verbose)
 							b[brk-1] = '\n';
-						}
 						cr = 1;
 						break;
 					}
@@ -121,9 +115,8 @@ int recv_sideband(const char *me, int in_stream,
int out, int err)
 					b[brk + sf - 1] = b[brk - 1];
 					memcpy(b + brk - 1, suffix, sf);
 					/* Progress messages are those that end in CR codes */
-					if (show_progress || !cr) {
+					if (show_progress || !cr)
 						safe_write(err, b, brk + sf);
-					}
 					memcpy(b + brk, save, sf);
 					len -= brk;
 				} else {
-- 
1.6.2.rc0.3.g78f96
--- cut here ---
