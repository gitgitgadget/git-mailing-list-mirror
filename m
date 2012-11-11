From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] launch_editor: propagate SIGINT from editor to git
Date: Sun, 11 Nov 2012 11:57:06 -0500
Message-ID: <20121111165706.GE19850@sigill.intra.peff.net>
References: <20121111163100.GB13188@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Fox <pgf@foxharp.boston.ma.us>, git@vger.kernel.org
To: Kalle Olavi Niemitalo <kon@iki.fi>
X-From: git-owner@vger.kernel.org Sun Nov 11 17:57:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXaqZ-0004IT-De
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 17:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab2KKQ5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 11:57:09 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43974 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752999Ab2KKQ5I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 11:57:08 -0500
Received: (qmail 1204 invoked by uid 107); 11 Nov 2012 16:57:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 11 Nov 2012 11:57:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2012 11:57:06 -0500
Content-Disposition: inline
In-Reply-To: <20121111163100.GB13188@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209407>

We block SIGINT while the editor runs so that git is not
killed accidentally by a stray "^C" meant for the editor or
its subprocesses. This works because most editors ignore
SIGINT.

However, some editor wrappers, like emacsclient, expect to
die due to ^C. We detect the signal death in the editor and
properly exit, but not before writing a useless error
message to stderr. Instead, let's notice when the editor was
killed by SIGINT and just raise the signal on ourselves.
This skips the message and looks to our parent like we
received SIGINT ourselves.

The end effect is that if the user's editor ignores SIGINT,
we will, too. And if it does not, then we will behave as if
we did not ignore it. That should make all users happy.

Note that in the off chance that another part of git has
ignored SIGINT while calling launch_editor, we will still
properly detect and propagate the failed return code from
the editor (i.e., the worst case is that we generate the
useless error, not fail to notice the editor's death).

Signed-off-by: Jeff King <peff@peff.net>
---
 editor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/editor.c b/editor.c
index 28aae85..1275527 100644
--- a/editor.c
+++ b/editor.c
@@ -51,6 +51,8 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		sigchain_push(SIGINT, SIG_IGN);
 		ret = finish_command(&p);
 		sigchain_pop(SIGINT);
+		if (WIFSIGNALED(ret) && WTERMSIG(ret) == SIGINT)
+			raise(SIGINT);
 		if (ret)
 			return error("There was a problem with the editor '%s'.",
 					editor);
-- 
1.8.0.207.gdf2154c
