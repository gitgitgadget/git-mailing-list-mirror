From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Make '!' aliases more useful
Date: Sun, 1 Jul 2007 22:51:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707012249590.4438@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jul 01 23:52:32 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I57LK-0004ko-P0
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 23:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbXGAVwI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 17:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbXGAVwH
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 17:52:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:34857 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751789AbXGAVwG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 17:52:06 -0400
Received: (qmail invoked by alias); 01 Jul 2007 21:52:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 01 Jul 2007 23:52:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18zwrJWsyQzGgxGdm3t72dXYvJTTu3cnYQSEz8XpD
	lAdMYWxFxbwiuJ
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51324>


When an alias starts with an exclamation mark, the rest is interpreted
as a shell command. However, all arguments passed to git used to be
ignored.

Now you can have an alias like

	$ git config alias.e '!echo'

and

	$ git e Hello World

does what you expect it to do.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I have this in my $HOME/.gitconfig:

		[alias]
			debug = !GIT_PAGER= gdb --args git

	which allows me to debug, say "git log a..b" by saying "git debug 
	log a..b".

 git.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index 8ea70da..32e8aa9 100644
--- a/git.c
+++ b/git.c
@@ -205,6 +205,21 @@ static int handle_alias(int *argcp, const char ***argv)
 	git_config(git_alias_config);
 	if (alias_string) {
 		if (alias_string[0] == '!') {
+			if (*argcp > 1) {
+				int i, sz = PATH_MAX;
+				char *s = xmalloc(sz), *new_alias = s;
+
+				add_to_string(&s, &sz, alias_string, 0);
+				free(alias_string);
+				alias_string = new_alias;
+				for (i = 1; i < *argcp &&
+					!add_to_string(&s, &sz, " ", 0) &&
+					!add_to_string(&s, &sz, (*argv)[i], 1)
+					; i++)
+					; /* do nothing */
+				if (!sz)
+					die("Too many or long arguments");
+			}
 			trace_printf("trace: alias to shell cmd: %s => %s\n",
 				     alias_command, alias_string + 1);
 			ret = system(alias_string + 1);
-- 
1.5.2.2.3276.gf2524-dirty
