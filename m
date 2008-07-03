From: Jeff King <peff@peff.net>
Subject: Re: about c8af1de9 (git status uses pager)
Date: Thu, 3 Jul 2008 07:46:57 -0400
Message-ID: <20080703114656.GA15101@sigill.intra.peff.net>
References: <alpine.LNX.1.10.0806212319410.22036@fbirervta.pbzchgretzou.qr> <19f34abd0806211430x3d7195d8idc61b7103f899947@mail.gmail.com> <7vzlpe8nyo.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.10.0806212343560.18093@fbirervta.pbzchgretzou.qr> <alpine.LNX.1.10.0806221107540.15126@fbirervta.pbzchgretzou.qr> <7vtzflolis.fsf@gitster.siamese.dyndns.org> <7vtzfln5zw.fsf@gitster.siamese.dyndns.org> <20080703021541.GK18147@mail.rocksoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 03 13:55:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KENOh-0001Ek-Id
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 13:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbYGCLxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 07:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbYGCLxl
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 07:53:41 -0400
Received: from peff.net ([208.65.91.99]:1726 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbYGCLxk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 07:53:40 -0400
Received: (qmail 2775 invoked by uid 111); 3 Jul 2008 11:46:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 03 Jul 2008 07:46:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jul 2008 07:46:57 -0400
Content-Disposition: inline
In-Reply-To: <20080703021541.GK18147@mail.rocksoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87264>

On Thu, Jul 03, 2008 at 11:45:41AM +0930, Tim Stoakes wrote:

> > Jeff had a patch to allow boolean configuration variable "pager.<command>"
> > to override the built-in pager settings during 1.5.6 cycle, and I think it
> > was a reasonable approach to take.  People who want to page output from
> > git-status can then set "pager.status = true" in their configuration (and
> > then we can revert c8af1de (make git-status use a pager, 2008-04-23)).
> > Alternatively we could keep the current status-quo for the default, and
> > people can say "pager.status = false" in their configuration.
> 
> I'd really like to see this. Setting core.pager to `less -FSRX` or
> similar is not useful for me - I *want* to have -X for eg. `git diff`,
> but I don't want paging at all for status.

OK, here is a revised patch that actually passes the tests. I'm not
incredibly happy with it (see the caveats below), but I think this is
the best we can do without major surgery on the git_dir setup (there
seems to be some nasty interaction between setup_git_env and
setup_git_directory, but several attempts at obvious fixes have left me
pulling my hair out).

-- >8 --
allow per-command pager config

There is great debate over whether some commands should set
up a pager automatically. This patch allows individuals to
set their own pager preferences for each command, overriding
the default. For example, to disable the pager for git
status:

  git config pager.status false

If "--pager" or "--no-pager" is specified on the command
line, it takes precedence over the config option.

There are two caveats:

  - you can turn on the pager for plumbing commands.
    Combined with "core.pager = always", this will probably
    break a lot of things. Don't do it.

  - This only works for builtin commands. The reason is
    somewhat complex:

    Calling git_config before we do setup_git_directory
    has bad side effects, because it wants to know where
    the git_dir is to find ".git/config". Unfortunately,
    we cannot call setup_git_directory indiscriminately,
    because some builtins (like "init") break if we do.

    For builtins, this is OK, since we can just wait until
    after we call setup_git_directory. But for aliases, we
    don't know until we expand (recursively) which command
    we're doing. This should not be a huge problem for
    aliases, which can simply use "--pager" or "--no-pager"
    in the alias as appropriate.

    For external commands, however, we don't know we even
    have an external command until we exec it, and by then
    it is too late to check the config.

    An alternative approach would be to have a config mode
    where we don't bother looking at .git/config, but only
    at the user and system config files. This would make the
    behavior consistent across builtins, aliases, and
    external commands, at the cost of not allowing per-repo
    pager config for at all.
---
 git.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/git.c b/git.c
index 22ac522..426a17f 100644
--- a/git.c
+++ b/git.c
@@ -9,6 +9,43 @@ const char git_usage_string[] =
 const char git_more_info_string[] =
 	"See 'git help COMMAND' for more information on a specific command.";
 
+static int use_pager = -1;
+struct pager_config {
+	const char *cmd;
+	int val;
+};
+
+static int pager_command_config(const char *var, const char *value, void *data)
+{
+	struct pager_config *c = data;
+	if (!prefixcmp(var, "pager.") && !strcmp(var + 6, c->cmd))
+		c->val = git_config_bool(var, value);
+	return 0;
+}
+
+/* returns 0 for "no pager", 1 for "use pager", and -1 for "not specified" */
+int check_pager_config(const char *cmd)
+{
+	struct pager_config c;
+	c.cmd = cmd;
+	c.val = -1;
+	git_config(pager_command_config, &c);
+	return c.val;
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
@@ -38,9 +75,9 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
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
@@ -242,8 +279,13 @@ static int run_command(struct cmd_struct *p, int argc, const char **argv)
 	prefix = NULL;
 	if (p->option & RUN_SETUP)
 		prefix = setup_git_directory();
-	if (p->option & USE_PAGER)
-		setup_pager();
+
+	if (use_pager == -1 && p->option & RUN_SETUP)
+		use_pager = check_pager_config(p->cmd);
+	if (use_pager == -1 && p->option & USE_PAGER)
+		use_pager = 1;
+	commit_pager_choice();
+
 	if (p->option & NEED_WORK_TREE)
 		setup_work_tree();
 
@@ -453,6 +495,7 @@ int main(int argc, const char **argv)
 	argv++;
 	argc--;
 	handle_options(&argv, &argc, NULL);
+	commit_pager_choice();
 	if (argc > 0) {
 		if (!prefixcmp(argv[0], "--"))
 			argv[0] += 2;
-- 
1.5.6.1.158.g8cb5.dirty
