From: Brent Goodrick <bgoodr@gmail.com>
Subject: [PATCH/RFC] Add progress options
Date: Sun, 8 Feb 2009 20:54:08 -0800
Message-ID: <18831.46833.862.196815@hungover.brentg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 05:55:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWOBM-0002vo-Rf
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 05:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833AbZBIEyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 23:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754490AbZBIEyQ
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 23:54:16 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:52437 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbZBIEyN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 23:54:13 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1638906rvb.1
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 20:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:mime-version
         :content-type:content-transfer-encoding:message-id:date:to:subject
         :x-mailer;
        bh=3LSMGp3IVN2G//55sH6mmMEOPqZUkvP0I9CwAsrZVrY=;
        b=K2e2pAOKKlnhuHGU1/kTPfqbfHwFs9iUUw/r0WfMtAc3SL9k0tWTgS9p8FIUxMCGq8
         hNPUFvl0FQtISlmYFd0zHFomXaZ9Y4IGmMdUGBd2oI55TuVYnihDv/iTihfEDjf7ff0L
         UgmBjfU098LNdDTkJgaXe1QoTkzEBYWiX21rI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:mime-version:content-type:content-transfer-encoding:message-id
         :date:to:subject:x-mailer;
        b=pJb4k5mvJtR+x9/2k380H65cjlEe4wI3zrYpKCXofIcPc1RwZ9cTm5oLpCRuQctN6n
         1LV27ceeHDsomLtoJL+xoN3h1JpsLDtTDM3vpSh8l5KdS52+aAvVDEXgGrRttnzjo4gD
         GHY/4Ci6ZcdxJvCZxJ6ikksWV1tWu2Kd/QjyU=
Received: by 10.141.153.16 with SMTP id f16mr1009123rvo.1.1234155252225;
        Sun, 08 Feb 2009 20:54:12 -0800 (PST)
Received: from hungover.brentg.com.thisisbogus.com ([76.14.208.3])
        by mx.google.com with ESMTPS id l31sm14393221rvb.4.2009.02.08.20.54.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Feb 2009 20:54:11 -0800 (PST)
X-Mailer: VM viewmail-609 under 23.0.60.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109043>


Add --progress, --no-progress, and --progress-verbose options, which
correspond to the GIT_PROGRESS environment variable setting of "1",
"0", and "verbose", respectively.

Signed-off-by: Brent Goodrick <bgoodr@gmail.com>
---

In reference to the "CR codes from git commands" thread, specifically
http://marc.info/?l=git&m=123273617713654&w=2 where Dscho kindly gave
me an outline on how to get started, which I reiterate below to show
where I felt I had to deviate:

Dscho> 	
Dscho> Hi,
Dscho> 
Dscho> On Fri, 23 Jan 2009, Brent Goodrick wrote:
Dscho> 
Dscho> >  - Bare minimum: Add a new --no-cr option
Dscho> 
Dscho> I do not see any value of this over "--progress | tr '\r' '\n'".  (The
Dscho> --progress option being the natural counterpart to --no-progress,
Dscho> _forcing_ the display of the progress.)
Dscho> 
Dscho> And I disagree that --no-progress would be hard to implement.  Just have a
Dscho> look at 7d1864c(Introduce is_bare_repository() and core.bare configuration
Dscho> variable).
Dscho> 
Dscho> Basically, you'll have to
Dscho> 
Dscho> - introduce a global variable to both environment.c and
Dscho> cache.h,
Dscho> 
Dscho> - set it to -1 by default,

I ended up having to rely exclusively upon an environment variable for
this state (indicated by GIT_PROGRESS_ENVIRONMENT in my patch which is
defined to be "GIT_PROGRESS") since parts of the code are in different
processes. This turned out to be a nice side-effect since I plan on
setting "GIT_PROGRESS" in my shell startup environment to be
"verbose", as for my work, I do indeed want to see all progress, but
just not all of the CR codes.

Dscho> 
Dscho> - handle a "--progress" and "--no-progress" option in git.c, setting the
Dscho>  global variable git_show_progress to 1 or 0, respectively,
Dscho> 
Dscho> - teach start_progress_delay() to return NULL if
Dscho> git_show_progress == 0,

I tried that, but then I got a worse condition of not seeing any
messaging at all for long-running processing. This might lead people
to think that something is hung up, and then CTRL-C'ing out, leaving
the repo in a bad state. What I thought we really needed instead is
just the final "done" messages, but not the intervening progress
messages such as percentage complete messages. To that end, I allowed
progress.c to continue to create the SIGALRM handler and logic as
before, but modify its output ever so slightly.

Dscho> 
Dscho> - modify all users of start_progress*() to respect git_show_progress == 1,
Dscho>  which probably means to look for "isatty" in builtin-pack-objects.c and
Dscho>  builtin-unpack-objects.c

I ended up not having to mess with isatty logic at all since only the
lines that are emitted with the CR codes had to be addressed.

Dscho> 
Dscho> - add documentation to Documentation/git.txt what --progress and
Dscho>  --no-progress do,
Dscho> 
Dscho> - add a simple test script to t/ (maybe t/t0005-progress.sh) that tests
Dscho>  that --progress works -- maybe you find a clever way to test
Dscho>  --no-progress, too, but that would be harder, as the progress is turned
Dscho>  off by default for the scripts anyway...)

I did not at this point attempt to write the test as a shell script,
but had to manually test it via my FSF Emacs session. There might be a
way to test this out via some elisp code in FSF Emacs, but I doubt we
want to do that since that would create a dependency on Emacs in the
git test suite.

Note that I found that the CR codes show up in git clone output in the
Emacs compile mode (M-x compile) which are displayed as "^M", but not
in the shell buffers (M-x shell).

I had sent a question to the mailing list about this specific issue
but got no answer, so I concluded to just proceed with the PATCH/RFC
first to see what folks say to the changes.

Thanks,
bgoodr

 Documentation/git.txt                  |   15 +++++++++++++++
 builtin-pack-objects.c                 |    2 +-
 cache.h                                |    1 +
 contrib/completion/git-completion.bash |    3 +++
 git.c                                  |   10 ++++++++--
 progress.c                             |   31 ++++++++++++++++++++++++++-----
 sideband.c                             |   29 +++++++++++++++++++++++++----
 7 files changed, 79 insertions(+), 12 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 0c7bba3..2f9d4e8 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git' [--version] [--exec-path[=GIT_EXEC_PATH]]
     [-p|--paginate|--no-pager]
+    [--progress|--no-progress|--progress-verbose]
     [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]
     [--help] COMMAND [ARGS]
 
@@ -179,6 +180,20 @@ help ...`.
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
index 2d889de..6246fce 100644
--- a/cache.h
+++ b/cache.h
@@ -371,6 +371,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
+#define GIT_PROGRESS_ENVIRONMENT "GIT_PROGRESS"
 #define GIT_NOTES_REF_ENVIRONMENT "GIT_NOTES_REF"
 #define GIT_NOTES_DEFAULT_REF "refs/notes/commits"
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 307bf5d..ca8b2d9 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1723,6 +1723,9 @@ _git ()
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
index c2b181e..0409471 100644
--- a/git.c
+++ b/git.c
@@ -5,7 +5,7 @@
 #include "run-command.h"
 
 const char git_usage_string[] =
-	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
+	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate|--no-pager] [--progress|--no-progress|--progress-verbose] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
 
 const char git_more_info_string[] =
 	"See 'git help COMMAND' for more information on a specific command.";
@@ -116,7 +116,13 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
 			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 0);
 			if (envchanged)
 				*envchanged = 1;
-		} else {
+		} else if (!strcmp(cmd, "--progress"))
+			setenv(GIT_PROGRESS_ENVIRONMENT, "1", 1);
+		else if (!strcmp(cmd, "--no-progress"))
+			setenv(GIT_PROGRESS_ENVIRONMENT, "0", 1);
+		else if (!strcmp(cmd, "--progress-verbose"))
+			setenv(GIT_PROGRESS_ENVIRONMENT, "verbose", 1);
+		else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
 		}
diff --git a/progress.c b/progress.c
index 55a8687..c96d594 100644
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
@@ -90,15 +93,22 @@ static int display(struct progress *progress, unsigned n, const char *done)
 
 	progress->last_value = n;
 	tp = (progress->throughput) ? progress->throughput->display : "";
-	eol = done ? done : "   \r";
+	/* When show_progress_verbose is true, put each progress message on a
+	 * separate line: */
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
@@ -206,6 +216,17 @@ struct progress *start_progress_delay(const char *title, unsigned total,
 				       unsigned percent_treshold, unsigned delay)
 {
 	struct progress *progress = malloc(sizeof(*progress));
+	const char * show_progress_env = getenv(GIT_PROGRESS_ENVIRONMENT);
+	if (show_progress_env) {
+		if (!strcmp(show_progress_env, "true"))
+			show_progress_env = "1";
+		if (!strcmp(show_progress_env, "false"))
+			show_progress_env = "0";
+		if (!strcmp(show_progress_env, "verbose"))
+			show_progress_verbose = 1;
+		else if (!strcmp(show_progress_env, "0"))
+			show_progress = 0;
+	}
 	if (!progress) {
 		/* unlikely, but here's a good fallback */
 		fprintf(stderr, "%s...\n", title);
diff --git a/sideband.c b/sideband.c
index cca3360..4bfb206 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,5 +1,6 @@
 #include "pkt-line.h"
 #include "sideband.h"
+#include "cache.h"
 
 /*
  * Receive multiplexed output stream over git native protocol.
@@ -26,7 +27,19 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
 	char buf[LARGE_PACKET_MAX + 2*FIX_SIZE];
 	char *suffix, *term;
 	int skip_pf = 0;
-
+	int show_progress = 1;
+	int show_progress_verbose = 0;
+	const char * show_progress_env = getenv(GIT_PROGRESS_ENVIRONMENT);
+	if (show_progress_env) {
+		if (!strcmp(show_progress_env, "true"))
+			show_progress_env = "1";
+		if (!strcmp(show_progress_env, "false"))
+			show_progress_env = "0";
+		if (!strcmp(show_progress_env, "0"))
+			show_progress = 0;
+		else if (!strcmp(show_progress_env, "verbose"))
+			show_progress_verbose = 1;
+	}
 	memcpy(buf, PREFIX, pf);
 	term = getenv("TERM");
 	if (term && strcmp(term, "dumb"))
@@ -58,6 +71,7 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
 			do {
 				char *b = buf;
 				int brk = 0;
+				int cr = 0;
 
 				/*
 				 * If the last buffer didn't end with a line
@@ -78,9 +92,14 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
 						brk = 0;
 						break;
 					}
-					if (b[brk-1] == '\n' ||
-					    b[brk-1] == '\r')
+					if (b[brk-1] == '\n')
 						break;
+					else if (b[brk-1] == '\r') {
+						if (show_progress_verbose)
+							b[brk-1] = '\n';
+						cr = 1;
+						break;
+					}
 				}
 
 				/*
@@ -95,7 +114,9 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
 					memcpy(save, b + brk, sf);
 					b[brk + sf - 1] = b[brk - 1];
 					memcpy(b + brk - 1, suffix, sf);
-					safe_write(err, b, brk + sf);
+					/* Progress messages are those that end in CR codes */
+					if (show_progress || !cr)
+						safe_write(err, b, brk + sf);
 					memcpy(b + brk, save, sf);
 					len -= brk;
 				} else {
-- 
1.6.2.rc0.3.ge80f6
