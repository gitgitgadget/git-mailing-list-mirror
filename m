Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C5DF1FC96
	for <e@80x24.org>; Sun, 27 Nov 2016 04:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753295AbcK0EbR (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Nov 2016 23:31:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:47487 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753190AbcK0EbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2016 23:31:16 -0500
Received: (qmail 23701 invoked by uid 109); 27 Nov 2016 04:31:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 27 Nov 2016 04:31:15 +0000
Received: (qmail 25483 invoked by uid 111); 27 Nov 2016 04:31:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 26 Nov 2016 23:31:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Nov 2016 23:31:13 -0500
Date:   Sat, 26 Nov 2016 23:31:13 -0500
From:   Jeff King <peff@peff.net>
To:     Mike Galbraith <umgwanakikbuti@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] common-main: stop munging argv[0] path
Message-ID: <20161127043113.opirwcpda6lboxmi@sigill.intra.peff.net>
References: <1480169028.3830.24.camel@gmail.com>
 <20161126170933.6tge6j5etuchqy33@sigill.intra.peff.net>
 <1480182671.3830.38.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1480182671.3830.38.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 26, 2016 at 06:51:11PM +0100, Mike Galbraith wrote:

> > On the other hand, I am sympathetic that something used to work and now
> > doesn't. It probably wouldn't be that hard to work around it.
> > 
> > The reason for the behavior change is that one of the cmd_main()
> > functions was relying on the basename side-effect of the
> > extract_argv0_path function, so 650c449250d7 just feeds the munged
> > argv[0] to all of the programs. The cleanest fix would probably be
> > something like:
> 
> That did fix it up, thanks.  I'll try twiddling the script instead.

Thanks for confirming. Here it is, with a commit message and a little
bit of polish.

-- >8 --
Subject: [PATCH] common-main: stop munging argv[0] path

Since 650c44925 (common-main: call git_extract_argv0_path(),
2016-07-01), the argv[0] that is seen in cmd_main() of
individual programs is always the basename of the
executable, as common-main strips off the full path. This
can produce confusing results for git-daemon, which wants to
re-exec itself.

For instance, if the program was originally run as
"/usr/lib/git/git-daemon", it will try just re-execing
"git-daemon", which will find the first instance in $PATH.
If git's exec-path has not been prepended to $PATH, we may
find the git-daemon from a different version (or no
git-daemon at all).

Normally this isn't a problem. Git commands are run as "git
daemon", the git wrapper puts the exec-path at the front of
$PATH, and argv[0] is already "daemon" anyway. But running
git-daemon via its full exec-path, while not really a
recommended method, did work prior to 650c44925. Let's make
it work again.

The real goal of 650c44925 was not to munge argv[0], but to
reliably set the argv0_path global. The only reason it
munges at all is that one caller, the git.c wrapper,
piggy-backed on that computation to find the command
basename.  Instead, let's leave argv[0] untouched in
common-main, and have git.c do its own basename computation.

While we're at it, let's drop the return value from
git_extract_argv0_path(). It was only ever used in this one
callsite, and its dual purposes is what led to this
confusion in the first place.

Note that by changing the interface, the compiler can
confirm for us that there are no other callers storing the
return value. But the compiler can't tell us whether any of
the cmd_main() functions (besides git.c) were relying on the
basename munging. However, we can observe that prior to
650c44925, no other cmd_main() functions did that munging,
and no new cmd_main() functions have been introduced since
then. So we can't be regressing any of those cases.

Signed-off-by: Jeff King <peff@peff.net>
---
 common-main.c |  2 +-
 exec_cmd.c    | 10 +++-------
 exec_cmd.h    |  2 +-
 git.c         |  5 +++++
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/common-main.c b/common-main.c
index 44a29e8b1..c654f9555 100644
--- a/common-main.c
+++ b/common-main.c
@@ -33,7 +33,7 @@ int main(int argc, const char **argv)
 
 	git_setup_gettext();
 
-	argv[0] = git_extract_argv0_path(argv[0]);
+	git_extract_argv0_path(argv[0]);
 
 	restore_sigpipe_to_default();
 
diff --git a/exec_cmd.c b/exec_cmd.c
index 9d5703a15..19ac2146d 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -38,21 +38,17 @@ char *system_path(const char *path)
 	return strbuf_detach(&d, NULL);
 }
 
-const char *git_extract_argv0_path(const char *argv0)
+void git_extract_argv0_path(const char *argv0)
 {
 	const char *slash;
 
 	if (!argv0 || !*argv0)
-		return NULL;
+		return;
 
 	slash = find_last_dir_sep(argv0);
 
-	if (slash) {
+	if (slash)
 		argv0_path = xstrndup(argv0, slash - argv0);
-		return slash + 1;
-	}
-
-	return argv0;
 }
 
 void git_set_argv_exec_path(const char *exec_path)
diff --git a/exec_cmd.h b/exec_cmd.h
index 1f6b43378..ff0b48048 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -4,7 +4,7 @@
 struct argv_array;
 
 extern void git_set_argv_exec_path(const char *exec_path);
-extern const char *git_extract_argv0_path(const char *path);
+extern void git_extract_argv0_path(const char *path);
 extern const char *git_exec_path(void);
 extern void setup_path(void);
 extern const char **prepare_git_cmd(struct argv_array *out, const char **argv);
diff --git a/git.c b/git.c
index e8b2baf2d..dce529fcb 100644
--- a/git.c
+++ b/git.c
@@ -654,6 +654,11 @@ int cmd_main(int argc, const char **argv)
 	cmd = argv[0];
 	if (!cmd)
 		cmd = "git-help";
+	else {
+		const char *slash = find_last_dir_sep(cmd);
+		if (slash)
+			cmd = slash + 1;
+	}
 
 	trace_command_performance(argv);
 
-- 
2.11.0.rc3.313.g1055eca

