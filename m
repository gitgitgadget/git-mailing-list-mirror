From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] launch_editor: refactor to use start/finish_command
Date: Sun, 11 Nov 2012 11:55:01 -0500
Message-ID: <20121111165500.GA19850@sigill.intra.peff.net>
References: <20121111163100.GB13188@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Fox <pgf@foxharp.boston.ma.us>, git@vger.kernel.org
To: Kalle Olavi Niemitalo <kon@iki.fi>
X-From: git-owner@vger.kernel.org Sun Nov 11 17:55:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXaob-0003P1-Kj
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 17:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818Ab2KKQzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 11:55:05 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43956 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445Ab2KKQzE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 11:55:04 -0500
Received: (qmail 1084 invoked by uid 107); 11 Nov 2012 16:55:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 11 Nov 2012 11:55:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2012 11:55:01 -0500
Content-Disposition: inline
In-Reply-To: <20121111163100.GB13188@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209403>

The launch_editor function uses the convenient run_command_*
interface. Let's use the more flexible start_command and
finish_command functions, which will let us manipulate the
parent state while we're waiting for the child to finish.

Signed-off-by: Jeff King <peff@peff.net>
---
 editor.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/editor.c b/editor.c
index d834003..842f782 100644
--- a/editor.c
+++ b/editor.c
@@ -37,8 +37,16 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 
 	if (strcmp(editor, ":")) {
 		const char *args[] = { editor, path, NULL };
+		struct child_process p;
 
-		if (run_command_v_opt_cd_env(args, RUN_USING_SHELL, NULL, env))
+		memset(&p, 0, sizeof(p));
+		p.argv = args;
+		p.env = env;
+		p.use_shell = 1;
+		if (start_command(&p) < 0)
+			return error("unable to start editor '%s'", editor);
+
+		if (finish_command(&p))
 			return error("There was a problem with the editor '%s'.",
 					editor);
 	}
-- 
1.8.0.207.gdf2154c
