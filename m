From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow an alias to start with "-p"
Date: Tue, 25 Jul 2006 01:03:12 -0400
Message-ID: <20060725050312.GA5618@coredump.intra.peff.net>
References: <Pine.LNX.4.63.0607190125150.29667@wbgn013.biozentrum.uni-wuerzburg.de> <7v8xmjh5sv.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0607241408170.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 25 07:03:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5F4g-0006xw-N6
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 07:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWGYFDQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 01:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWGYFDQ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 01:03:16 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:54440 "HELO
	peff.net") by vger.kernel.org with SMTP id S932456AbWGYFDP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 01:03:15 -0400
Received: (qmail 20583 invoked from network); 25 Jul 2006 01:02:48 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 25 Jul 2006 01:02:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Jul 2006 01:03:12 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607241408170.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24158>

On Mon, Jul 24, 2006 at 02:10:45PM +0200, Johannes Schindelin wrote:

> @@ -264,6 +289,7 @@ int main(int argc, const char **argv, ch
>  	if (!strncmp(cmd, "git-", 4)) {
>  		cmd += 4;
>  		argv[0] = cmd;
> +		handle_alias(&argc, &argv);
>  		handle_internal_command(argc, argv, envp);
>  		die("cannot handle %s internally", cmd);
>  	}

I believe this change is the source of the breakage in tests.
GIT_DIR=foo git-init-db no longer works because handle_alias
unconditionally calls setup_git_directory_gently(), which thinks that if
GIT_DIR is set, it must exist.

This can be fixed by giving precedence to the internal command over
alias checking.  This makes sense, anyway, since later in the function,
we give precedence to internal commands in the "git init-db" form.

Patch is below (wow, that +++ is kind of ugly!).

-Peff

+++
git: choose internal commands over aliases for git-*

This is especially important because some commands (like init-db) don't
require a working GIT_DIR, and alias expansion tries to look at it. It
also matches the behavior of "git cmd".

Signed-off-by: Jeff King <peff@peff.net>
---
 git.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 8d7c644..68ce826 100644
--- a/git.c
+++ b/git.c
@@ -289,8 +289,8 @@ int main(int argc, const char **argv, ch
 	if (!strncmp(cmd, "git-", 4)) {
 		cmd += 4;
 		argv[0] = cmd;
-		handle_alias(&argc, &argv);
 		handle_internal_command(argc, argv, envp);
+		handle_alias(&argc, &argv);
 		die("cannot handle %s internally", cmd);
 	}
 
-- 
1.4.2.rc1.gc470-dirty
