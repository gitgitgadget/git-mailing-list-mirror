From: Jeff King <peff@peff.net>
Subject: Re: To page or not to page
Date: Fri, 2 May 2008 11:36:28 -0400
Message-ID: <20080502153628.GA6294@sigill.intra.peff.net>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org> <20080502054508.GA28506@sigill.intra.peff.net> <20080502060930.GA1079@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri May 02 17:37:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrxKP-0000M4-8h
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 17:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934413AbYEBPga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 11:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762065AbYEBPga
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 11:36:30 -0400
Received: from peff.net ([208.65.91.99]:1641 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934144AbYEBPg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 11:36:29 -0400
Received: (qmail 12809 invoked by uid 111); 2 May 2008 15:36:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 02 May 2008 11:36:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 May 2008 11:36:28 -0400
Content-Disposition: inline
In-Reply-To: <20080502060930.GA1079@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81007>

On Fri, May 02, 2008 at 02:09:30AM -0400, Jeff King wrote:

> > I agree with you; I don't like it at all. Probably whether or not to use
> > a pager for a given command should be controlled by a "pager.<cmd>"
> > config variable.
> 
> Here is a quick and dirty patch to do that. It should probably be split
> into two (there is a big code movement of the commands array), and it
> needs documentation and tests. But I'm going to sleep for now.

Here is a cleaner patch. Rather than looking at all of pager.*, it waits
until we see which command to execute, and just looks up pager.cmd (we
end up having to parse the config the same number of times). And we
don't have to munge the static global commands array, which just feels a
little cleaner.

Still no documentation, and still not a "real" patch; I am curious to
see the list reaction on the issues I raised elsewhere in the thread
(like the user-facing inconsistencies).

---
 git.c |   30 +++++++++++++++++++++++++++++-
 1 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 89b431f..68d8b37 100644
--- a/git.c
+++ b/git.c
@@ -230,6 +230,25 @@ struct cmd_struct {
 	int option;
 };
 
+static const char *pager_command_key;
+static int pager_command_value;
+
+int pager_command_config(const char *var, const char *value)
+{
+	if (!prefixcmp(var, "pager.") && !strcmp(var + 6, pager_command_key))
+		pager_command_value = git_config_bool(var, value);
+	return 0;
+}
+
+/* returns 0 for "no pager", 1 for "use pager", and -1 for "not specified" */
+int check_pager_config(const char *cmd)
+{
+	pager_command_key = cmd;
+	pager_command_value = -1;
+	git_config(pager_command_config);
+	return pager_command_value;
+}
+
 static int run_command(struct cmd_struct *p, int argc, const char **argv)
 {
 	int status;
@@ -239,8 +258,17 @@ static int run_command(struct cmd_struct *p, int argc, const char **argv)
 	prefix = NULL;
 	if (p->option & RUN_SETUP)
 		prefix = setup_git_directory();
-	if (p->option & USE_PAGER)
+	switch (check_pager_config(p->cmd)) {
+	case 0:
+		break;
+	case 1:
 		setup_pager();
+		break;
+	default:
+		if (p->option & USE_PAGER)
+			setup_pager();
+		break;
+	}
 	if (p->option & NEED_WORK_TREE)
 		setup_work_tree();
 
-- 
1.5.5.1.221.ga481.dirty
