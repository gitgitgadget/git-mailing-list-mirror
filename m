From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] help.c: don't blame an user's typo when the system is
 at fault
Date: Mon, 20 Jul 2009 11:12:17 -0400
Message-ID: <20090720151217.GA5347@coredump.intra.peff.net>
References: <alpine.DEB.2.00.0907201309150.5423@ds9.cixit.se>
 <200907201545.06030.barra_cuda@katamail.com>
 <200907201617.48168.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michele Ballabio <barra_cuda@katamail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 20 17:12:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSuXO-0005Qq-B3
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 17:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbZGTPMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 11:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131AbZGTPMO
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 11:12:14 -0400
Received: from peff.net ([208.65.91.99]:34179 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336AbZGTPMN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 11:12:13 -0400
Received: (qmail 26499 invoked by uid 107); 20 Jul 2009 15:14:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 20 Jul 2009 11:14:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jul 2009 11:12:17 -0400
Content-Disposition: inline
In-Reply-To: <200907201617.48168.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123607>

On Mon, Jul 20, 2009 at 04:17:47PM +0200, Thomas Rast wrote:

> The invocation of help_unknown_cmd comes from
> 
> 	while (1) {
> 		// ...
> 		was_alias = run_argv(&argc, &argv);
> 		if (errno != ENOENT)
> 			break;
> 		// ... side branch with an exit() ...
> 		if (!done_help) {
> 			cmd = argv[0] = help_unknown_cmd(cmd);
> 
> so errno is always ENOENT when help_unknown_cmd() is called.
> (Furthermore, the function itself uses git_config() and
> load_command_list(), both of which _probably_ clobber errno, I don't
> really have the time for an in-depth check.)
> 
> It also seems that the 'errno != ENOENT' check was intended to catch
> the case where the command failed for any reason other than that it
> does not exist, but this collides with the kernel reporting ENOENT if
> the _interpreter_ does not exist.  Perhaps run_argv should
> differentiate the case where a command executable exists but cannot be
> run?

Yes, I think double-checking the suggested commands list is only half of
it; it still says "citool is not a git command" which is wrong. Getting
it totally right means differentiating the two ENOENT cases, which I
think would require searching the PATH.

Something like the patch below should work, though I didn't think
terribly long about it, so there might be a corner case that isn't
covered, or some easier helper functions for accomplishing this.

---
diff --git a/git.c b/git.c
index 5da6c65..4e44c98 100644
--- a/git.c
+++ b/git.c
@@ -3,6 +3,7 @@
 #include "cache.h"
 #include "quote.h"
 #include "run-command.h"
+#include "help.h"
 
 const char git_usage_string[] =
 	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [--html-path] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
@@ -449,6 +450,16 @@ static int run_argv(int *argcp, const char ***argv)
 	return done_alias;
 }
 
+static int command_exists(const char *s)
+{
+	static struct cmdnames main_cmds, other_cmds;
+	static int loaded;
+	if (!loaded) {
+		load_command_list("git-", &main_cmds, &other_cmds);
+		loaded = 1;
+	}
+	return is_in_cmdlist(&main_cmds, s) || is_in_cmdlist(&other_cmds, s);
+}
 
 int main(int argc, const char **argv)
 {
@@ -504,7 +515,7 @@ int main(int argc, const char **argv)
 		static int done_help = 0;
 		static int was_alias = 0;
 		was_alias = run_argv(&argc, &argv);
-		if (errno != ENOENT)
+		if (errno != ENOENT || command_exists(argv[0]))
 			break;
 		if (was_alias) {
 			fprintf(stderr, "Expansion of alias '%s' failed; "
