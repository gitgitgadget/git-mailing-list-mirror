From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Avoid chdir() in list_commands_in_dir()
Date: Sun, 27 Jul 2008 22:34:14 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807272233160.5526@eeepc-johanness>
References: <cover.1217037178.git.vmiklos@frugalware.org> <f311372167c02868ccf5aa4dc03c97b7f956d855.1217037178.git.vmiklos@frugalware.org> <1217073292-27945-1-git-send-email-vmiklos@frugalware.org> <4f2b03391e3f85cf2224f97a2a7765d08707bd73.1217037178.git.vmiklos@frugalware.org>
 <7vwsj7yu1q.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807272219350.5526@eeepc-johanness>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 22:34:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNCwX-0000Qp-H3
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 22:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757809AbYG0UdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 16:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757972AbYG0UdN
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 16:33:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:50833 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757724AbYG0UdM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 16:33:12 -0400
Received: (qmail invoked by alias); 27 Jul 2008 20:33:10 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp068) with SMTP; 27 Jul 2008 22:33:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/8AFoncU/lOfp8oWLV+Bhx+j0g/A09H2FKpaZCM
	2WKgJ2mzJKUVng
X-X-Sender: user@eeepc-johanness
In-Reply-To: <alpine.DEB.1.00.0807272219350.5526@eeepc-johanness>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90367>


The function list_commands_in_dir() tried to be lazy and just chdir()
to the directory which entries it listed, so that the check if the
file is executable could be done on dir->d_name.

However, there is no good reason to jump around wildly just to find
all Git commands.

Instead, have a strbuf and construct the full path dynamically.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 help.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 480befe..7af6582 100644
--- a/help.c
+++ b/help.c
@@ -426,17 +426,24 @@ static unsigned int list_commands_in_dir(struct cmdnames *cmds,
 	int prefix_len = strlen(prefix);
 	DIR *dir = opendir(path);
 	struct dirent *de;
+	struct strbuf buf = STRBUF_INIT;
+	int len;
 
-	if (!dir || chdir(path))
+	if (!dir)
 		return 0;
 
+	strbuf_addf(&buf, "%s/", path);
+	len = buf.len;
+
 	while ((de = readdir(dir)) != NULL) {
 		int entlen;
 
 		if (prefixcmp(de->d_name, prefix))
 			continue;
 
-		if (!is_executable(de->d_name))
+		strbuf_setlen(&buf, len);
+		strbuf_addstr(&buf, de->d_name);
+		if (!is_executable(buf.buf))
 			continue;
 
 		entlen = strlen(de->d_name) - prefix_len;
@@ -449,6 +456,7 @@ static unsigned int list_commands_in_dir(struct cmdnames *cmds,
 		add_cmdname(cmds, de->d_name + prefix_len, entlen);
 	}
 	closedir(dir);
+	strbuf_release(&buf);
 
 	return longest;
 }
-- 
1.6.0.rc0.97.ge2309
