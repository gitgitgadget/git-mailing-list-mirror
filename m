From: Paul Fox <pgf@foxharp.boston.ma.us>
Subject: [PATCH 2/5] launch_editor: ignore SIGINT while the editor has control
Date: Sun, 11 Nov 2012 11:55:11 -0500
Message-ID: <20121111165510.GB19850@sigill.intra.peff.net>
References: <20121111163100.GB13188@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Fox <pgf@foxharp.boston.ma.us>, git@vger.kernel.org
To: Kalle Olavi Niemitalo <kon@iki.fi>
X-From: git-owner@vger.kernel.org Sun Nov 11 18:02:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXavA-0006Eu-1N
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 18:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157Ab2KKRBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 12:01:55 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43991 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456Ab2KKRBy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 12:01:54 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Nov 2012 12:01:54 EST
Received: (qmail 1090 invoked by uid 107); 11 Nov 2012 16:56:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 11 Nov 2012 11:56:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2012 11:55:11 -0500
Content-Disposition: inline
In-Reply-To: <20121111163100.GB13188@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209414>

The user's editor likely catches SIGINT (ctrl-C).  but if
the user spawns a command from the editor and uses ctrl-C to
kill that command, the SIGINT will likely also kill git
itself (depending on the editor, this can leave the terminal
in an unusable state).

Signed-off-by: Paul Fox <pgf@foxharp.boston.ma.us>
Signed-off-by: Jeff King <peff@peff.net>
---
 editor.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/editor.c b/editor.c
index 842f782..28aae85 100644
--- a/editor.c
+++ b/editor.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "strbuf.h"
 #include "run-command.h"
+#include "sigchain.h"
 
 #ifndef DEFAULT_EDITOR
 #define DEFAULT_EDITOR "vi"
@@ -38,6 +39,7 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 	if (strcmp(editor, ":")) {
 		const char *args[] = { editor, path, NULL };
 		struct child_process p;
+		int ret;
 
 		memset(&p, 0, sizeof(p));
 		p.argv = args;
@@ -46,7 +48,10 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		if (start_command(&p) < 0)
 			return error("unable to start editor '%s'", editor);
 
-		if (finish_command(&p))
+		sigchain_push(SIGINT, SIG_IGN);
+		ret = finish_command(&p);
+		sigchain_pop(SIGINT);
+		if (ret)
 			return error("There was a problem with the editor '%s'.",
 					editor);
 	}
-- 
1.8.0.207.gdf2154c
