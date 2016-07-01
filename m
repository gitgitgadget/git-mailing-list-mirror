Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0AC21FE4E
	for <e@80x24.org>; Fri,  1 Jul 2016 06:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbcGAGFe (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 02:05:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:38731 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751508AbcGAGFe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 02:05:34 -0400
Received: (qmail 24069 invoked by uid 102); 1 Jul 2016 06:04:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 02:04:09 -0400
Received: (qmail 13588 invoked by uid 107); 1 Jul 2016 06:04:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 02:04:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 02:04:04 -0400
Date:	Fri, 1 Jul 2016 02:04:04 -0400
From:	Jeff King <peff@peff.net>
To:	"dmh@ucar.edu" <dmh@ucar.edu>
Cc:	git@vger.kernel.org
Subject: [PATCH 2/5] common-main: call git_extract_argv0_path()
Message-ID: <20160701060404.GB4593@sigill.intra.peff.net>
References: <20160701055532.GA4488@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160701055532.GA4488@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Every program which links against libgit.a must call this
function, or risk hitting an assert() in system_path() that
checks whether we have configured argv0_path (though only
when RUNTIME_PREFIX is defined, so essentially only on
Windows).

Looking at the diff, you can see that putting it into the
common main() saves us having to do it individually in each
of the external commands. But what you can't see are the
cases where we _should_ have been doing so, but weren't
(e.g., git-credential-store, and all of the t/helper test
programs).

This has been an accident-waiting-to-happen for a long time,
but wasn't triggered until recently because it involves one
of those programs actually calling system_path(). That
happened with git-credential-store in v2.8.0 with ae5f677
(lazily load core.sharedrepository, 2016-03-11). The
program:

  - takes a lock file, which...

  - opens a tempfile, which...

  - calls adjust_shared_perm to fix permissions, which...

  - lazy-loads the config (as of ae5f677), which...

  - calls system_path() to find the location of
    /etc/gitconfig

On systems with RUNTIME_PREFIX, this means credential-store
reliably hits that assert() and cannot be used.

We never noticed in the test suite, because we set
GIT_CONFIG_NOSYSTEM there, which skips the system_path()
lookup entirely.  But if we were to tweak git_config() to
find /etc/gitconfig even when we aren't going to open it,
then the test suite shows multiple failures (for
credential-store, and for some other test helpers). I didn't
include that tweak here because it's way too specific to
this particular call to be worth carrying around what is
essentially dead code.

The implementation is fairly straightforward, with one
exception: there is exactly one caller (git.c) that actually
cares about the result of the function, and not the
side-effect of setting up argv0_path. We can accommodate
that by simply replacing the value of argv[0] in the array
we hand down to cmd_main().

Signed-off-by: Jeff King <peff@peff.net>
---
 common-main.c    | 3 +++
 daemon.c         | 3 ---
 fast-import.c    | 3 ---
 git.c            | 2 +-
 http-backend.c   | 1 -
 http-fetch.c     | 2 --
 http-push.c      | 2 --
 imap-send.c      | 2 --
 remote-curl.c    | 1 -
 remote-testsvn.c | 1 -
 shell.c          | 2 --
 upload-pack.c    | 1 -
 12 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/common-main.c b/common-main.c
index 2b96bbf..57c912a 100644
--- a/common-main.c
+++ b/common-main.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "exec_cmd.h"
 
 int main(int argc, char **av)
 {
@@ -8,5 +9,7 @@ int main(int argc, char **av)
 	 */
 	const char **argv = (const char **)av;
 
+	argv[0] = git_extract_argv0_path(argv[0]);
+
 	return cmd_main(argc, argv);
 }
diff --git a/daemon.c b/daemon.c
index 4326cd0..d33ee5a 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,6 +1,5 @@
 #include "cache.h"
 #include "pkt-line.h"
-#include "exec_cmd.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "string-list.h"
@@ -1204,8 +1203,6 @@ int cmd_main(int argc, const char **argv)
 
 	git_setup_gettext();
 
-	git_extract_argv0_path(argv[0]);
-
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		const char *v;
diff --git a/fast-import.c b/fast-import.c
index 7cb7434..f12cd00 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -164,7 +164,6 @@ Format of STDIN stream:
 #include "refs.h"
 #include "csum-file.h"
 #include "quote.h"
-#include "exec_cmd.h"
 #include "dir.h"
 #include "run-command.h"
 
@@ -3449,8 +3448,6 @@ int cmd_main(int argc, const char **argv)
 {
 	unsigned int i;
 
-	git_extract_argv0_path(argv[0]);
-
 	git_setup_gettext();
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
diff --git a/git.c b/git.c
index e244404..3b4e12d 100644
--- a/git.c
+++ b/git.c
@@ -635,7 +635,7 @@ int cmd_main(int argc, const char **argv)
 	const char *cmd;
 	int done_help = 0;
 
-	cmd = git_extract_argv0_path(argv[0]);
+	cmd = argv[0];
 	if (!cmd)
 		cmd = "git-help";
 
diff --git a/http-backend.c b/http-backend.c
index 411c835..5375cbc 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -642,7 +642,6 @@ int cmd_main(int argc, const char **argv)
 
 	git_setup_gettext();
 
-	git_extract_argv0_path(argv[0]);
 	set_die_routine(die_webcgi);
 	set_die_is_recursing_routine(die_webcgi_recursing);
 
diff --git a/http-fetch.c b/http-fetch.c
index eb559eb..244cd0d 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -24,8 +24,6 @@ int cmd_main(int argc, const char **argv)
 
 	git_setup_gettext();
 
-	git_extract_argv0_path(argv[0]);
-
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
 			get_tree = 1;
diff --git a/http-push.c b/http-push.c
index df20e44..3a5fecf 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1711,8 +1711,6 @@ int cmd_main(int argc, const char **argv)
 
 	git_setup_gettext();
 
-	git_extract_argv0_path(argv[0]);
-
 	repo = xcalloc(1, sizeof(*repo));
 
 	argv++;
diff --git a/imap-send.c b/imap-send.c
index 890e1cb..125b218 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1500,8 +1500,6 @@ int cmd_main(int argc, const char **argv)
 	int total;
 	int nongit_ok;
 
-	git_extract_argv0_path(argv[0]);
-
 	git_setup_gettext();
 
 	setup_git_directory_gently(&nongit_ok);
diff --git a/remote-curl.c b/remote-curl.c
index a068340..d39f4cf 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -991,7 +991,6 @@ int cmd_main(int argc, const char **argv)
 
 	git_setup_gettext();
 
-	git_extract_argv0_path(argv[0]);
 	setup_git_directory_gently(&nongit);
 	if (argc < 2) {
 		error("remote-curl: usage: git remote-curl <remote> [<url>]");
diff --git a/remote-testsvn.c b/remote-testsvn.c
index 32631eb..f87bf85 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -292,7 +292,6 @@ int cmd_main(int argc, const char **argv)
 	static struct remote *remote;
 	const char *url_in;
 
-	git_extract_argv0_path(argv[0]);
 	setup_git_directory();
 	if (argc < 2 || argc > 3) {
 		usage("git-remote-svn <remote-name> [<url>]");
diff --git a/shell.c b/shell.c
index 3dd7fdc..ca00807 100644
--- a/shell.c
+++ b/shell.c
@@ -147,8 +147,6 @@ int cmd_main(int argc, const char **argv)
 
 	git_setup_gettext();
 
-	git_extract_argv0_path(argv[0]);
-
 	/*
 	 * Always open file descriptors 0/1/2 to avoid clobbering files
 	 * in die().  It also avoids messing up when the pipes are dup'ed
diff --git a/upload-pack.c b/upload-pack.c
index 80dda75..681fd2f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -839,7 +839,6 @@ int cmd_main(int argc, const char **argv)
 	git_setup_gettext();
 
 	packet_trace_identity("upload-pack");
-	git_extract_argv0_path(argv[0]);
 	check_replace_refs = 0;
 
 	argc = parse_options(argc, argv, NULL, options, upload_pack_usage, 0);
-- 
2.9.0.317.g65b4e7c

