From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH REPLACING 2/3] launch_editor(): read the file, even when
 EDITOR=:
Date: Thu, 8 Nov 2007 14:06:52 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711081406280.4362@racer.site>
References: <Pine.LNX.4.64.0711081213580.4362@racer.site>
 <Pine.LNX.4.64.0711081215360.4362@racer.site> <47330222.7000206@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Nov 08 15:08:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq82N-0007kA-QV
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 15:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757554AbXKHOHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 09:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756955AbXKHOHA
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 09:07:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:36042 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756153AbXKHOG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 09:06:59 -0500
Received: (qmail invoked by alias); 08 Nov 2007 14:06:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp045) with SMTP; 08 Nov 2007 15:06:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19BjHs9lNxBvAqw1Rux0BWfxjje7Poo0OQQPL9OeJ
	nra4dia01R9rOV
X-X-Sender: gene099@racer.site
In-Reply-To: <47330222.7000206@viscovery.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64024>


Earlier we just returned in case EDITOR=: but the message stored
in the file was not read back.  Fix this, at the same time
simplifying the code as suggested by Johannes Sixt.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-tag.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index c3b76da..86d8121 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -20,8 +20,6 @@ static char signingkey[1000];
 void launch_editor(const char *path, struct strbuf *buffer)
 {
 	const char *editor, *terminal;
-	struct child_process child;
-	const char *args[3];
 
 	editor = getenv("GIT_EDITOR");
 	if (!editor && editor_program)
@@ -42,17 +40,12 @@ void launch_editor(const char *path, struct strbuf *buffer)
 	if (!editor)
 		editor = "vi";
 
-	if (!strcmp(editor, ":"))
-		return;
+	if (strcmp(editor, ":")) {
+		const char *args[] = { editor, path, NULL };
 
-	memset(&child, 0, sizeof(child));
-	child.argv = args;
-	args[0] = editor;
-	args[1] = path;
-	args[2] = NULL;
-
-	if (run_command(&child))
-		die("There was a problem with the editor %s.", editor);
+		if (run_command_v_opt(args, 0))
+			die("There was a problem with the editor %s.", editor);
+	}
 
 	if (strbuf_read_file(buffer, path, 0) < 0)
 		die("could not read message file '%s': %s",
-- 
1.5.3.5.1634.g0fa78
