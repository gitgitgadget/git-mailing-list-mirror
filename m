From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pager: config variable pager.color
Date: Mon, 31 Jul 2006 02:53:46 -0700
Message-ID: <7vzmeq6qxh.fsf@assigned-by-dhcp.cox.net>
References: <E1G6xHb-0008Rw-G2@moooo.ath.cx>
	<Pine.LNX.4.63.0607300112340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<E1G6zPH-00062L-Je@moooo.ath.cx>
	<7vd5bmbo46.fsf@assigned-by-dhcp.cox.net>
	<17613.50574.56000.861072@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 31 11:54:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7UTF-0006w3-Rz
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 11:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWGaJxs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 05:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWGaJxs
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 05:53:48 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:22993 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751500AbWGaJxs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 05:53:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060731095347.PURI6077.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Jul 2006 05:53:47 -0400
To: Juergen Ruehle <j.ruehle@bmiag.de>
In-Reply-To: <17613.50574.56000.861072@lapjr.intranet.kiel.bmiag.de> (Juergen
	Ruehle's message of "Mon, 31 Jul 2006 10:55:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24507>

Juergen Ruehle <j.ruehle@bmiag.de> writes:

> AFAICS Matthias' patch has the added benefit of moving setup_pager to
> before large files (i.e. packs) are mapped. This helps non-COW-fork
> (i.e. cygwin) tremendously. Actually with Linus' setup refactoring
> this could probably be easily moved to the wrapper,...

Hmph.  Never thought about that.  Something like this?

-- >8 --
Builtins: control the use of pager from the command table.

This moves the built-in "always-use-pager" logic for log family
to the command dispatch table of git wrapper.  This makes it
easier to change the default use of pager, and has an added
benefit that we fork and exec the pager early before packs are
mmapped.

Pointed out by Juergen Ruehle <j.ruehle@bmiag.de>.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/builtin-log.c b/builtin-log.c
index 82c69d1..bba1496 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -34,7 +34,6 @@ static int cmd_log_walk(struct rev_info 
 	struct commit *commit;
 
 	prepare_revision_walk(rev);
-	setup_pager();
 	while ((commit = get_revision(rev)) != NULL) {
 		log_tree_commit(rev, commit);
 		free(commit->buffer);
diff --git a/git.c b/git.c
index 7321d6c..d031eb9 100644
--- a/git.c
+++ b/git.c
@@ -211,6 +211,7 @@ static int handle_alias(int *argcp, cons
 const char git_version_string[] = GIT_VERSION;
 
 #define NEEDS_PREFIX 1
+#define USE_PAGER 2
 
 static void handle_internal_command(int argc, const char **argv, char **envp)
 {
@@ -218,13 +219,13 @@ static void handle_internal_command(int 
 	static struct cmd_struct {
 		const char *cmd;
 		int (*fn)(int, const char **, const char *);
-		int prefix;
+		int option;
 	} commands[] = {
 		{ "version", cmd_version },
 		{ "help", cmd_help },
-		{ "log", cmd_log, NEEDS_PREFIX },
-		{ "whatchanged", cmd_whatchanged, NEEDS_PREFIX },
-		{ "show", cmd_show, NEEDS_PREFIX },
+		{ "log", cmd_log, NEEDS_PREFIX | USE_PAGER },
+		{ "whatchanged", cmd_whatchanged, NEEDS_PREFIX | USE_PAGER },
+		{ "show", cmd_show, NEEDS_PREFIX | USE_PAGER },
 		{ "push", cmd_push },
 		{ "format-patch", cmd_format_patch, NEEDS_PREFIX },
 		{ "count-objects", cmd_count_objects },
@@ -275,8 +276,10 @@ static void handle_internal_command(int 
 			continue;
 
 		prefix = NULL;
-		if (p->prefix)
+		if (p->option & NEEDS_PREFIX)
 			prefix = setup_git_directory();
+		if (p->option & USE_PAGER)
+			setup_pager();
 		if (getenv("GIT_TRACE")) {
 			int i;
 			fprintf(stderr, "trace: built-in: git");
