From: Jeff King <peff@peff.net>
Subject: [PATCH 4/6] editor: use run_command's shell feature
Date: Wed, 30 Dec 2009 05:56:16 -0500
Message-ID: <20091230105616.GD22959@coredump.intra.peff.net>
References: <20091230095634.GA16349@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 11:56:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPwE3-000378-16
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 11:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbZL3K4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 05:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752638AbZL3K4T
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 05:56:19 -0500
Received: from peff.net ([208.65.91.99]:37837 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752398AbZL3K4T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 05:56:19 -0500
Received: (qmail 5198 invoked by uid 107); 30 Dec 2009 11:01:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 30 Dec 2009 06:01:01 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Dec 2009 05:56:16 -0500
Content-Disposition: inline
In-Reply-To: <20091230095634.GA16349@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135884>

Now that run_command implements the same code in a more
general form, we can make use of it.

Signed-off-by: Jeff King <peff@peff.net>
---
Should also be non-controversial, and the diffstat shows that this is
the payoff for all of the added code earlier in the series. :)

 editor.c |   21 ++-------------------
 1 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/editor.c b/editor.c
index 615f575..d834003 100644
--- a/editor.c
+++ b/editor.c
@@ -36,26 +36,9 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		return error("Terminal is dumb, but EDITOR unset");
 
 	if (strcmp(editor, ":")) {
-		size_t len = strlen(editor);
-		int i = 0;
-		int failed;
-		const char *args[6];
-		struct strbuf arg0 = STRBUF_INIT;
+		const char *args[] = { editor, path, NULL };
 
-		if (strcspn(editor, "|&;<>()$`\\\"' \t\n*?[#~=%") != len) {
-			/* there are specials */
-			strbuf_addf(&arg0, "%s \"$@\"", editor);
-			args[i++] = "sh";
-			args[i++] = "-c";
-			args[i++] = arg0.buf;
-		}
-		args[i++] = editor;
-		args[i++] = path;
-		args[i] = NULL;
-
-		failed = run_command_v_opt_cd_env(args, 0, NULL, env);
-		strbuf_release(&arg0);
-		if (failed)
+		if (run_command_v_opt_cd_env(args, RUN_USING_SHELL, NULL, env))
 			return error("There was a problem with the editor '%s'.",
 					editor);
 	}
-- 
1.6.6.65.g050d2.dirty
