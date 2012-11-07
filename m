From: Paul Fox <pgf@foxharp.boston.ma.us>
Subject: Re: [PATCH/RFC] launch_editor: ignore SIGINT while the editor has control
Date: Wed, 07 Nov 2012 18:35:15 -0500
Message-ID: <20121107233515.107ED2E8089@grass.foxharp.boston.ma.us>
References: <20121107191652.842C52E8089@grass.foxharp.boston.ma.us> <20121107220027.GA17463@shrek.podlesie.net> (sfid-20121107_170809_946190_2B68162F)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Krzysztof Mazur <krzysiek@podlesie.net>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 00:35:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWF9e-0001yh-VI
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 00:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716Ab2KGXfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2012 18:35:16 -0500
Received: from colo.foxharp.net ([166.84.7.52]:35438 "EHLO colo.foxharp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672Ab2KGXfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2012 18:35:16 -0500
Received: from grass.foxharp.boston.ma.us (localhost [127.0.0.1])
	by colo.foxharp.net (Postfix) with ESMTP id 272B3540E4;
	Wed,  7 Nov 2012 18:32:26 -0500 (EST)
Received: by grass.foxharp.boston.ma.us (Postfix, from userid 406)
	id 107ED2E8089; Wed,  7 Nov 2012 18:35:15 -0500 (EST)
Received: from grass (localhost [127.0.0.1])
	by grass.foxharp.boston.ma.us (Postfix) with ESMTP id 0E39A2E8007;
	Wed,  7 Nov 2012 18:35:15 -0500 (EST)
In-reply-to: <20121107220027.GA17463@shrek.podlesie.net> (sfid-20121107_170809_946190_2B68162F)
Content-ID: <11455.1352331314.1@grass>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209145>

the user's editor likely catches SIGINT (ctrl-C).  but if the user
spawns a command from the editor and uses ctrl-C to kill that command,
the SIGINT will likely also kill git itself.  (depending on the
editor, this can leave the terminal in an unusable state.)

Signed-off-by: Paul Fox <pgf@foxharp.boston.ma.us>
---

krzysztof wrote:
...
 > editor.c: In function 'launch_editor':
 > editor.c:42:3: warning: implicit declaration of function 'sigchain_push' [-Wimplicit-function-declaration]
 > editor.c:44:3: warning: implicit declaration of function 'sigchain_pop' [-Wimplicit-function-declaration]

sigh.  i had that initially, lost the patch, and then recreated
without it.  but i'm surprised my build (i did rebuild! :-) doesn't
emit those errors.  in any case, here's the fixed patch.

 editor.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/editor.c b/editor.c
index d834003..3ca361b 100644
--- a/editor.c
+++ b/editor.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "strbuf.h"
 #include "run-command.h"
+#include "sigchain.h"
 
 #ifndef DEFAULT_EDITOR
 #define DEFAULT_EDITOR "vi"
@@ -37,8 +38,12 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 
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
 paul fox, pgf@foxharp.boston.ma.us (arlington, ma, where it's 26.6 degrees)
