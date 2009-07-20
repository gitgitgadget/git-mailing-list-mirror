From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] help.c: don't blame an user's typo when the system is at fault
Date: Mon, 20 Jul 2009 15:45:05 +0200
Message-ID: <200907201545.06030.barra_cuda@katamail.com>
References: <alpine.DEB.2.00.0907201309150.5423@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Jul 20 15:44:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSt9w-0001bd-DI
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 15:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645AbZGTNn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 09:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753088AbZGTNn4
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 09:43:56 -0400
Received: from smtp.katamail.com ([62.149.157.154]:36910 "HELO smtp2.aruba.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751526AbZGTNn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 09:43:56 -0400
Received: (qmail 23594 invoked by uid 89); 20 Jul 2009 13:43:48 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05 autolearn=ham
	version=3.2.3
Received: from unknown (HELO rfc-1918) (barra?cuda@katamail.com@78.134.82.131)
  by smtp2-pc with SMTP; 20 Jul 2009 13:43:48 -0000
User-Agent: KMail/1.9.10
In-Reply-To: <alpine.DEB.2.00.0907201309150.5423@ds9.cixit.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123599>

As reported by Peter Krefting:

  If git cannot start one of the external commands (at least some of them),
  the DWIM engine is a bit flaky:

     $ git citool
     /usr/local/libexec/git-core/git-citool: line 10: exec: wish: not found
     git: 'citool' is not a git-command. See 'git --help'.

     Did you mean this?
         citool

Now we check whether the best bet found by levenshtein() differs from
the command line or not before proceeding.

The new error is:

$ git citool
/usr/local/libexec/git-core/git-citool: line 10: exec: wish: not found
fatal: Failed to run command 'citool': No such file or directory

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---

Is the call to strerror() useless anyway?

 help.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/help.c b/help.c
index fd87bb5..eec62a3 100644
--- a/help.c
+++ b/help.c
@@ -325,6 +325,9 @@ const char *help_unknown_cmd(const char *cmd)
 
 	if (!main_cmds.cnt)
 		die ("Uh oh. Your system reports no Git commands at all.");
+	if (!strcmp(cmd, main_cmds.names[0]->name))
+		die("Failed to run command '%s': %s\n",
+			cmd, strerror(errno));
 
 	best_similarity = main_cmds.names[0]->len;
 	n = 1;
-- 
1.6.3.1.17.g076c3
