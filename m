From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] git wrapper: execute git-shell when argv[1] is '-c'
Date: Mon, 25 Aug 2008 22:52:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808252251450.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20080824202325.GA14930@eagain.net>  <7vfxoukv56.fsf@gitster.siamese.dyndns.org>  <20080824203825.GB14930@eagain.net>  <7vbpzikt4b.fsf@gitster.siamese.dyndns.org>  <20080824222534.GC14930@eagain.net>  <alpine.DEB.1.00.0808251235430.24820@pacific.mpi-cbg.de.mpi-cbg.de>
  <48B29B2A.6000802@gnu.org>  <alpine.DEB.1.00.0808251955490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <237967ef0808251125q3e50fa04wf0e97ff29298bef2@mail.gmail.com> <alpine.DEB.1.00.0808252206150.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.DEB.1.00.0808252225520.24820@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0808252248150.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paolo Bonzini <bonzini@gnu.org>, Tommi Virtanen <tv@eagain.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mikael Magnusson <mikachu@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Aug 25 22:49:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXizU-0000OS-9F
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 22:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131AbYHYUrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 16:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753315AbYHYUrk
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 16:47:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:38532 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752967AbYHYUrj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 16:47:39 -0400
Received: (qmail invoked by alias); 25 Aug 2008 20:47:38 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp034) with SMTP; 25 Aug 2008 22:47:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/NJqlk0azNerhSSLM6jOx9A4EFOOrVavEXh8EhDo
	BGJo3KPyGZOSz5
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0808252248150.24820@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93674>


When a program is called via ssh's '-c' option, the login shell is called 
on the remote computer, with the given arguments.  In the case that Git 
was specified as login shell in /etc/passwd, Git used to complain that it 
does not know the '-c' option and die.

This commit assumes that '-c' indicates that Git was specified as
a login shell, and hands off to git-shell.

Noticed by Tommi Virtanen.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This should be pretty uncontroversial, as it turns a former
	error into something useful.

	However, I would not know where in the documentation (in addition
	to git-shell.txt, I guess), this change should be described.

 git.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 2fd74c4..b16736a 100644
--- a/git.c
+++ b/git.c
@@ -419,14 +419,23 @@ static void execv_dashed_external(const char **argv)
 int main(int argc, const char **argv)
 {
 	const char *cmd = argv[0] && *argv[0] ? argv[0] : "git-help";
-	char *slash = (char *)cmd + strlen(cmd);
+	char *slash;
 	int done_alias = 0;
 
 	/*
+	 * When Git is called with "-c", it is either an error, or Git
+	 * was specified as a login shell in /etc/passwd.  Assuming the
+	 * latter, we continue with git-shell.
+	 */
+	if (argc > 2 && !strcmp(argv[1], "-c"))
+		cmd = "git-shell";
+
+	/*
 	 * Take the basename of argv[0] as the command
 	 * name, and the dirname as the default exec_path
 	 * if we don't have anything better.
 	 */
+	slash = (char *)cmd + strlen(cmd);
 	while (cmd <= slash && !is_dir_sep(*slash))
 		slash--;
 	if (slash < cmd) {
-- 
1.6.0.211.ga840e.dirty
