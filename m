From: Jeff King <peff@peff.net>
Subject: Re: Command specific pager settings
Date: Mon, 4 Oct 2010 09:53:12 -0400
Message-ID: <20101004135312.GA11237@sigill.intra.peff.net>
References: <AANLkTimLt0ERrB5b9p+_7fZBWfK3PHJkydmouiGfnurz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: suvayu ali <fatkasuvayu+linux@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 15:53:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2lTc-0003vd-N1
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 15:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756079Ab0JDNxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 09:53:06 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:50988 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756035Ab0JDNxE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 09:53:04 -0400
Received: (qmail 19515 invoked by uid 111); 4 Oct 2010 13:53:03 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 04 Oct 2010 13:53:03 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Oct 2010 09:53:12 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimLt0ERrB5b9p+_7fZBWfK3PHJkydmouiGfnurz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158051>

On Mon, Oct 04, 2010 at 12:37:29AM -0700, suvayu ali wrote:

> I wanted to set my pager to `less -iRS' when looking at patches (so
> that would mean commands like `git diff'), but would prefer `less
> -iFRS' or even the git default `less -FRSX' for all other things e.g
> `git log'.
> 
> I looked at core.pager and pager.<cmd> but I couldn't understand how I
> could set different pagers for say just one/ a subset of commands (git
> diff in my case).
> 
> Is this possible? If not, would it be a worthwhile feature request?

It's not currently possible, but this patch should do what you want,
like:

  git config core.pager "less -FRSX"
  git config pager.diff "less -iRS"

-- >8 --
Subject: [PATCH] allow command-specific pagers in pager.<cmd>

A user may want different pager settings or even a
different pager for various subcommands (e.g., because they
use different less settings for "log" vs "diff", or because
they have a pager that interprets only log output but not
other commands).

This patch extends the pager.<cmd> syntax to support not
only boolean to-page-or-not-to-page, but also to specify a
pager just for a specific command.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt |   12 +++++++-----
 git.c                    |   21 ++++++++++++++++-----
 t/t7006-pager.sh         |   29 +++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e6d74e6..458d2a4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1527,11 +1527,13 @@ pack.packSizeLimit::
 	supported.
 
 pager.<cmd>::
-	Allows turning on or off pagination of the output of a
-	particular git subcommand when writing to a tty.  If
-	`\--paginate` or `\--no-pager` is specified on the command line,
-	it takes precedence over this option.  To disable pagination for
-	all commands, set `core.pager` or `GIT_PAGER` to `cat`.
+	If the value is boolean, turns on or off pagination of the
+	output of a particular git subcommand when writing to a tty.
+	Otherwise, turns on pagination for the subcommand using the
+	pager specified by the value of `pager.<cmd>`.  If `\--paginate`
+	or `\--no-pager` is specified on the command line, it takes
+	precedence over this option.  To disable pagination for all
+	commands, set `core.pager` or `GIT_PAGER` to `cat`.
 
 pretty.<name>::
 	Alias for a --pretty= format string, as specified in
diff --git a/git.c b/git.c
index 50a1401..7485a2d 100644
--- a/git.c
+++ b/git.c
@@ -19,14 +19,22 @@ static struct startup_info git_startup_info;
 static int use_pager = -1;
 struct pager_config {
 	const char *cmd;
-	int val;
+	int want;
+	char *value;
 };
 
 static int pager_command_config(const char *var, const char *value, void *data)
 {
 	struct pager_config *c = data;
-	if (!prefixcmp(var, "pager.") && !strcmp(var + 6, c->cmd))
-		c->val = git_config_bool(var, value);
+	if (!prefixcmp(var, "pager.") && !strcmp(var + 6, c->cmd)) {
+		int b = git_config_maybe_bool(var, value);
+		if (b >= 0)
+			c->want = b;
+		else {
+			c->want = 1;
+			c->value = xstrdup(value);
+		}
+	}
 	return 0;
 }
 
@@ -35,9 +43,12 @@ int check_pager_config(const char *cmd)
 {
 	struct pager_config c;
 	c.cmd = cmd;
-	c.val = -1;
+	c.want = -1;
+	c.value = NULL;
 	git_config(pager_command_config, &c);
-	return c.val;
+	if (c.value)
+		pager_program = c.value;
+	return c.want;
 }
 
 static void commit_pager_choice(void) {
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index fb744e3..49a6261 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -435,4 +435,33 @@ test_core_pager_subdir    expect_success 'git -p shortlog'
 test_core_pager_subdir    expect_success test_must_fail \
 					 'git -p apply </dev/null'
 
+test_expect_success TTY 'command-specific pager' '
+	unset PAGER GIT_PAGER;
+	echo "foo:initial" >expect &&
+	>actual &&
+	git config --unset core.pager &&
+	git config pager.log "sed s/^/foo:/ >actual" &&
+	test_terminal git log --format=%s -1 &&
+	test_cmp expect actual
+'
+
+test_expect_success TTY 'command-specific pager overrides core.pager' '
+	unset PAGER GIT_PAGER;
+	echo "foo:initial" >expect &&
+	>actual &&
+	git config core.pager "exit 1"
+	git config pager.log "sed s/^/foo:/ >actual" &&
+	test_terminal git log --format=%s -1 &&
+	test_cmp expect actual
+'
+
+test_expect_success TTY 'command-specific pager overridden by environment' '
+	GIT_PAGER="sed s/^/foo:/ >actual" && export GIT_PAGER &&
+	>actual &&
+	echo "foo:initial" >expect &&
+	git config pager.log "exit 1" &&
+	test_terminal git log --format=%s -1 &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.3.1.158.g6af003.dirty
