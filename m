From: Paul Fox <pgf@foxharp.boston.ma.us>
Subject: [PATCH/RFC] launch_editor: ignore SIGINT while the editor has control
Date: Wed, 07 Nov 2012 14:16:52 -0500
Message-ID: <20121107191652.842C52E8089@grass.foxharp.boston.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 07 20:26:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWBGf-0001Rs-M4
	for gcvg-git-2@plane.gmane.org; Wed, 07 Nov 2012 20:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306Ab2KGT0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2012 14:26:15 -0500
Received: from colo.foxharp.net ([166.84.7.52]:40942 "EHLO colo.foxharp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093Ab2KGTZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2012 14:25:58 -0500
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Nov 2012 14:25:58 EST
Received: from grass.foxharp.boston.ma.us (localhost [127.0.0.1])
	by colo.foxharp.net (Postfix) with ESMTP id CFA0A540E4;
	Wed,  7 Nov 2012 14:14:03 -0500 (EST)
Received: by grass.foxharp.boston.ma.us (Postfix, from userid 406)
	id 842C52E8089; Wed,  7 Nov 2012 14:16:52 -0500 (EST)
Received: from grass (localhost [127.0.0.1])
	by grass.foxharp.boston.ma.us (Postfix) with ESMTP id 7F0012E8007;
	Wed,  7 Nov 2012 14:16:52 -0500 (EST)
Content-ID: <25468.1352315812.1@grass>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209138>

the user's editor likely catches SIGINT (ctrl-C).  but if the user
spawns a command from the editor and uses ctrl-C to kill that command,
the SIGINT will likely also kill git itself.  (depending on the
editor, this can leave the terminal in an unusable state.)

Signed-off-by: Paul Fox <pgf@foxharp.boston.ma.us>
---

i often shell out of my editor while composing a git commit message,
in order to recheck the diffs or the log, do a final test build, etc.
when i interrupt one of these operations, the spawned program gets
killed.  in addition git itself gets killed, which in turn kills my
editor.  this is never what i intended.  :-)

the problem is easy to demonstrate with vim, vile, or em.  in a vi-like
editor:
    git commit foo
    :!sleep 10
    ^C

both CVS and my usual mailer (MH) protect against this behavior when
spawning editors by using code similar to the patch below, which
causes the spawning process to ignore SIGINT while the editor is
running.

i looked at the other invocations of run_command_v_opt_xxx() in git,
but couldn't convince myself that any of the others needed similar
protection.  i also couldn't convince myself that i wouldn't cause
collateral damage if i tried moving the sigchain_push/pop into
run-command.c.  (but perhaps it's simple -- maybe the RUN_USING_SHELL
flag should always imply this behavior.)

the patch is against current master.

paul

 editor.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/editor.c b/editor.c
index d834003..775f22d 100644
--- a/editor.c
+++ b/editor.c
@@ -37,8 +37,12 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 
 	if (strcmp(editor, ":")) {
 		const char *args[] = { editor, path, NULL };
+		int ret;
 
-		if (run_command_v_opt_cd_env(args, RUN_USING_SHELL, NULL, env))
+		sigchain_push(SIGINT, SIG_IGN);
+		ret = run_command_v_opt_cd_env(args, RUN_USING_SHELL, NULL, env);
+		sigchain_pop(SIGINT);
+		if (ret)
 			return error("There was a problem with the editor '%s'.",
 					editor);
 	}
-- 
1.7.5.4


=---------------------
 paul fox, pgf@foxharp.boston.ma.us (arlington, ma, where it's 31.8 degrees)
