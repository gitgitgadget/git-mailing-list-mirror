From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Soft aliases: add "less" and minimal documentation
Date: Wed, 5 Dec 2007 11:37:55 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712051131120.27959@racer.site>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org>
 <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
 <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org>
 <7vfxz89x9q.fsf@gitster.siamese.dyndns.org> <7vabpctx3b.fsf@gitster.siamese.dyndns.org>
 <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
 <7v4pfakr4j.fsf@gitster.siamese.dyndns.org> <7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
 <7vy7ca6ea9.fsf@gitster.siamese.dyndns.org> <7vzlwps8zf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 12:38:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzsaT-0005Qf-Q1
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 12:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbXLELi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 06:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbXLELiZ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 06:38:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:39223 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750964AbXLELiY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 06:38:24 -0500
Received: (qmail invoked by alias); 05 Dec 2007 11:38:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp012) with SMTP; 05 Dec 2007 12:38:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX184yZ4Z5Rs41akWXYZH2FYMqi+qKhdlqxlqrsGomN
	8JFtBoFfdlhX7l
X-X-Sender: gene099@racer.site
In-Reply-To: <7vzlwps8zf.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67147>


Now you can use "git less HEAD" to view the raw HEAD commit object.  It
is really a soft alias (i.e. it can be overridden by any user-specified
alias) to "-p cat-file -p".

This commit refactors the code a bit, to make adding new soft aliases
much easier.

It also adds a few lines in git.txt, so that users actually have a chance
to find out about soft aliases.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Wed, 5 Dec 2007, Junio C Hamano wrote:

	> * jk/builtin-alias (Fri Nov 30 11:22:58 2007 -0500) 1 commit
	>  + Support builtin aliases
	> 
	> Cute hack.  I'd like to have "git less" here.

	How about this?

	BTW now it should be easy to add soft aliases for "update", "up",
	"checkin" and "ci".

 Documentation/git.txt |    9 +++++++++
 git.c                 |   13 +++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index c4e4d24..d29dfdc 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -248,6 +248,15 @@ users typically do not use them directly.
 include::cmds-purehelpers.txt[]
 
 
+Soft aliases
+~~~~~~~~~~~~
+
+There are a few hard-coded aliases which can be overridden by explicit
+aliases (see gitlink:git-config[1]).  These include "view" for viewing
+the repository graphically, and "less" to show an object from the
+database using the pager.
+
+
 Configuration Mechanism
 -----------------------
 
diff --git a/git.c b/git.c
index 92cc49b..3c82f80 100644
--- a/git.c
+++ b/git.c
@@ -148,10 +148,19 @@ static int split_cmdline(char *cmdline, const char ***argv)
 	return count;
 }
 
+static struct {
+	const char *alias, *command;
+} builtin_aliases[] = {
+	{ "view", "!gitk" },
+	{ "less", "-p cat-file -p" },
+};
+
 static char *builtin_alias(const char *cmd)
 {
-	if (!strcmp(cmd, "view"))
-		return xstrdup("!gitk");
+	int i;
+	for (i = 0; i < ARRAY_SIZE(builtin_aliases); i++)
+		if (!strcmp(cmd, builtin_aliases[i].alias))
+			return xstrdup(builtin_aliases[i].command);
 	return NULL;
 }
 
-- 
1.5.3.7.2139.g2a5a3
