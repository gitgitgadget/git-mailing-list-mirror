From: Jeff King <peff@peff.net>
Subject: Re: [Funky] "git -p cmd" inside a bare repository
Date: Fri, 14 Dec 2007 00:12:23 -0500
Message-ID: <20071214051223.GD10169@sigill.intra.peff.net>
References: <20071129122139.GA11176@laptop> <7vmysexdvw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 06:12:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J32qt-0004DO-Q6
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 06:12:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbXLNFM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 00:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbXLNFMZ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 00:12:25 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3796 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbXLNFMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 00:12:25 -0500
Received: (qmail 20112 invoked by uid 111); 14 Dec 2007 05:12:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 14 Dec 2007 00:12:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Dec 2007 00:12:23 -0500
Content-Disposition: inline
In-Reply-To: <7vmysexdvw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68223>

On Thu, Dec 13, 2007 at 05:29:23PM -0800, Junio C Hamano wrote:

> I _think_ what is happening is that setup_pager() tries to run
> git_config(), which runs setup(), and then RUN_SETUP set for "ls-tree"
> (or "show") internal command runs setup again.  HEAD is given to
> resolve_ref() and git_path("%s", ref) makes it to ".git/HEAD", even
> though in a bare repository git_dir should be set to ".", and of course
> we cannot find such a path in the git directory.

I think that there is perhaps a larger bug here, which is that running
setup twice gives bad results, and should either be fixed or have its
own "don't run me twice" guard.

But it makes sense to always spawn the pager at the same time for
consistency. As a bonus, this makes "git -p bogus" a little more
friendly by not spawning the pager until we verify the command name.

-- >8 --
delay "git -p" page spawning until command runtime

This makes the timing consistent with those commands that always spawn a
pager. It also avoids a funny interaction related to calling
setup_pager() before setup().

---
diff --git a/git.c b/git.c
index c8b7e74..21d204f 100644
--- a/git.c
+++ b/git.c
@@ -6,6 +6,8 @@
 const char git_usage_string[] =
 	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
 
+static int user_asked_for_pager;
+
 static int handle_options(const char*** argv, int* argc, int* envchanged)
 {
 	int handled = 0;
@@ -35,7 +37,7 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
 				exit(0);
 			}
 		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
-			setup_pager();
+			user_asked_for_pager = 1;
 		} else if (!strcmp(cmd, "--no-pager")) {
 			setenv("GIT_PAGER", "cat", 1);
 			if (envchanged)
@@ -256,7 +258,7 @@ static int run_command(struct cmd_struct *p, int argc, const char **argv)
 	prefix = NULL;
 	if (p->option & RUN_SETUP)
 		prefix = setup_git_directory();
-	if (p->option & USE_PAGER)
+	if (p->option & USE_PAGER || user_asked_for_pager)
 		setup_pager();
 	if (p->option & NEED_WORK_TREE)
 		setup_work_tree();
