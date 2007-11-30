From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 11:22:58 -0500
Message-ID: <20071130162257.GA22882@coredump.intra.peff.net>
References: <7veje8twt2.fsf@gitster.siamese.dyndns.org> <20071130003512.GB11683@coredump.intra.peff.net> <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org> <20071130005852.GA12224@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291821220.8458@woody.linux-foundation.org> <5E2A9E2B-8B9A-46B0-99D0-DB3798F10119@zib.de> <20071130151223.GB22095@coredump.intra.peff.net> <8aa486160711300728x70f591f1hf8884a78f2b15806@mail.gmail.com> <20071130152942.GA22489@coredump.intra.peff.net> <alpine.LFD.0.9999.0711300745330.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi B?jar <sbejar@gmail.com>, Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 17:23:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy8eD-0000UA-JT
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 17:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762436AbXK3QXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 11:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762526AbXK3QXE
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 11:23:04 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1879 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762436AbXK3QXB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 11:23:01 -0500
Received: (qmail 3546 invoked by uid 111); 30 Nov 2007 16:22:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 30 Nov 2007 11:22:59 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Nov 2007 11:22:58 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0711300745330.8458@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66648>

On Fri, Nov 30, 2007 at 07:50:47AM -0800, Linus Torvalds wrote:

> Well, different people will want different viewers *anyway* (ie some will 
> prefer qgit etc), so how about making "git view" be something that 
> literally acts as a built-in alias that just defaults to running gitk (if 
> for no other reason than the fact that gitk is the one that ships with 
> git, and simply has most users).

I think that is a good idea, and here's a patch.

-- >8 --
Support builtin aliases

Builtin aliases are "default" alias values that can be
overridden by user-configured aliases.

For example, the first such alias is "view", an alias for
gitk. A user with no further configuration can run
"git view" to use gitk. However, they can also set the
config option "alias.view" to "!tig" to run tig.
---
 git.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index f220284..95296aa 100644
--- a/git.c
+++ b/git.c
@@ -151,6 +151,13 @@ static int split_cmdline(char *cmdline, const char ***argv)
 	return count;
 }
 
+static char *builtin_alias(const char *cmd)
+{
+	if (!strcmp(cmd, "view"))
+		return xstrdup("!gitk");
+	return NULL;
+}
+
 static int handle_alias(int *argcp, const char ***argv)
 {
 	int nongit = 0, envchanged = 0, ret = 0, saved_errno = errno;
@@ -162,6 +169,8 @@ static int handle_alias(int *argcp, const char ***argv)
 
 	alias_command = (*argv)[0];
 	git_config(git_alias_config);
+	if (!alias_string)
+		alias_string = builtin_alias(alias_command);
 	if (alias_string) {
 		if (alias_string[0] == '!') {
 			if (*argcp > 1) {
-- 
1.5.3.6.2064.g2e22f-dirty
