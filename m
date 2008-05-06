From: Jeff King <peff@peff.net>
Subject: Re: To page or not to page
Date: Tue, 6 May 2008 01:51:28 -0400
Message-ID: <20080506055128.GA26311@sigill.intra.peff.net>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org> <20080502054508.GA28506@sigill.intra.peff.net> <20080502060930.GA1079@sigill.intra.peff.net> <7vd4o5xm62.fsf@gitster.siamese.dyndns.org> <20080502125553.GB2923@sigill.intra.peff.net> <7v1w4ky3hh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 07:52:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtG66-0007ga-SG
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 07:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbYEFFv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 01:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753917AbYEFFv3
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 01:51:29 -0400
Received: from peff.net ([208.65.91.99]:3062 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751521AbYEFFv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 01:51:27 -0400
Received: (qmail 28726 invoked by uid 111); 6 May 2008 05:51:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 06 May 2008 01:51:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 May 2008 01:51:28 -0400
Content-Disposition: inline
In-Reply-To: <7v1w4ky3hh.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81331>

On Fri, May 02, 2008 at 11:18:02AM -0700, Junio C Hamano wrote:

> Hmm. How about doing things this way?
> 
>  - at the beginning of handle_options() remember argv[0]
> 
>  - restructure handle_options() so that it does not run setup_pager() and
>    setenv("GIT_PAGER", "cat", 1) inside the loop, but instead remember
>    what we had on the command line;
> 
>  - after the handle_options() loop, if we saw an explicit --pager,
>    --no-pager, that's the decision;

This is actually a bit tricky, since there are two code paths; builtins
called as git-foo never even go to handle_options, but they can still
look up the config value.

So how about this:

 - keep a global use_pager = { 0 (explicit no), 1 (explicit yes), -1
   (unknown) }

 - if git-foo, lookup config for pager.foo

 - otherwise we have "git [options] foo"; look for -p / --no-pager; if
   none found, then lookup config for "foo"

 - before proceeding further, "commit" the pager choice by running it
   (if 1), munging GIT_PAGER=cat (if 0), or doing nothing (if -1)

 - before handling an internal command, if use_pager is -1 and the
   command defaults to a pager, we run it then

The patch below implements this.

It would be nice to actually defer running the pager until we are about
to run a git command. I.e., never "commit" to the pager until we are
actually running an internal command or exec'ing an external command.
That way it would be safe to make an alias that called "--no-pager"
(which is currently disallowed).

That works for internal commands, since we know we are going to run one,
and if it fails, we die.  However, for external commands, we just exec
and hope it works. So if we run the pager beforehand, we are now
committed to it, and a further alias cannot set --no-pager. We could
alternatively run it after deciding that running the command is what
we'll do, but then we have to do the PATH lookup ourselves.

So anyway, here is the less invasive version.

---
 git.c |   48 ++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/git.c b/git.c
index 89b431f..dadca41 100644
--- a/git.c
+++ b/git.c
@@ -6,12 +6,46 @@
 const char git_usage_string[] =
 	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
 
+static int use_pager = -1;
+static const char *pager_command_key;
+static int pager_command_value;
+
+int pager_command_config(const char *var, const char *value)
+{
+	if (!prefixcmp(var, "pager.") && !strcmp(var + 6, pager_command_key))
+		pager_command_value = git_config_bool(var, value);
+	return 0;
+}
+
+/* returns 0 for "no pager", 1 for "use pager", and -1 for "not specified" */
+int check_pager_config(const char *cmd)
+{
+	pager_command_key = cmd;
+	pager_command_value = -1;
+	git_config(pager_command_config);
+	return pager_command_value;
+}
+
+static void commit_pager_choice(void) {
+	switch (use_pager) {
+	case 0:
+		setenv("GIT_PAGER", "cat", 1);
+		break;
+	case 1:
+		setup_pager();
+		break;
+	default:
+		break;
+	}
+}
+
 static int handle_options(const char*** argv, int* argc, int* envchanged)
 {
 	int handled = 0;
+	const char *cmd = NULL;
 
 	while (*argc > 0) {
-		const char *cmd = (*argv)[0];
+		cmd = (*argv)[0];
 		if (cmd[0] != '-')
 			break;
 
@@ -35,9 +69,9 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
 				exit(0);
 			}
 		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
-			setup_pager();
+			use_pager = 1;
 		} else if (!strcmp(cmd, "--no-pager")) {
-			setenv("GIT_PAGER", "cat", 1);
+			use_pager = 0;
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--git-dir")) {
@@ -84,6 +118,9 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
 		(*argc)--;
 		handled++;
 	}
+
+	if (use_pager == -1 && cmd)
+		use_pager = check_pager_config(cmd);
 	return handled;
 }
 
@@ -239,7 +276,7 @@ static int run_command(struct cmd_struct *p, int argc, const char **argv)
 	prefix = NULL;
 	if (p->option & RUN_SETUP)
 		prefix = setup_git_directory();
-	if (p->option & USE_PAGER)
+	if (use_pager == -1 && p->option & USE_PAGER)
 		setup_pager();
 	if (p->option & NEED_WORK_TREE)
 		setup_work_tree();
@@ -411,6 +448,8 @@ int main(int argc, const char **argv)
 	if (!prefixcmp(cmd, "git-")) {
 		cmd += 4;
 		argv[0] = cmd;
+		use_pager = check_pager_config(cmd);
+		commit_pager_choice();
 		handle_internal_command(argc, argv);
 		die("cannot handle %s internally", cmd);
 	}
@@ -419,6 +458,7 @@ int main(int argc, const char **argv)
 	argv++;
 	argc--;
 	handle_options(&argv, &argc, NULL);
+	commit_pager_choice();
 	if (argc > 0) {
 		if (!prefixcmp(argv[0], "--"))
 			argv[0] += 2;
-- 
1.5.5.1.244.g148a.dirty
