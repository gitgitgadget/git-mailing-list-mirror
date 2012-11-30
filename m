From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] launch_editor: propagate signals from editor to git
Date: Fri, 30 Nov 2012 17:41:50 -0500
Message-ID: <20121130224149.GE23772@sigill.intra.peff.net>
References: <20121130223943.GA27120@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Fox <pgf@foxharp.boston.ma.us>,
	Krzysztof Mazur <krzysiek@podlesie.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 30 23:42:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeZHb-0000Uo-Tv
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 23:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199Ab2K3Wlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 17:41:52 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48005 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487Ab2K3Wlw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 17:41:52 -0500
Received: (qmail 7055 invoked by uid 107); 30 Nov 2012 22:42:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Nov 2012 17:42:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Nov 2012 17:41:50 -0500
Content-Disposition: inline
In-Reply-To: <20121130223943.GA27120@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210952>

We block SIGINT and SIGQUIT while the editor runs so that
git is not killed accidentally by a stray "^C" meant for the
editor or its subprocesses. This works because most editors
ignore SIGINT.

However, some editor wrappers, like emacsclient, expect to
die due to ^C. We detect the signal death in the editor and
properly exit, but not before writing a useless error
message to stderr. Instead, let's notice when the editor was
killed by a terminal signal and just raise the signal on
ourselves.  This skips the message and looks to our parent
like we received SIGINT ourselves.

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
 editor.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/editor.c b/editor.c
index c892a81..065a7ab 100644
--- a/editor.c
+++ b/editor.c
@@ -39,7 +39,7 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 	if (strcmp(editor, ":")) {
 		const char *args[] = { editor, path, NULL };
 		struct child_process p;
-		int ret;
+		int ret, sig;
 
 		memset(&p, 0, sizeof(p));
 		p.argv = args;
@@ -51,8 +51,11 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		sigchain_push(SIGINT, SIG_IGN);
 		sigchain_push(SIGQUIT, SIG_IGN);
 		ret = finish_command(&p);
+		sig = ret + 128;
 		sigchain_pop(SIGINT);
 		sigchain_pop(SIGQUIT);
+		if (sig == SIGINT || sig == SIGQUIT)
+			raise(sig);
 		if (ret)
 			return error("There was a problem with the editor '%s'.",
 					editor);
-- 
1.8.0.1.620.g558b0aa
