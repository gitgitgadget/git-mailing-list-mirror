From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] Build-in "git-shell"
Date: Tue, 19 Aug 2008 18:06:12 -0700
Message-ID: <7v7iacv6kb.fsf@gitster.siamese.dyndns.org>
References: <20080818123727.GB11842@schiele.dyndns.org>
 <7vy72tkfu0.fsf@gitster.siamese.dyndns.org>
 <20080819072650.GE11842@schiele.dyndns.org>
 <7vpro5fnke.fsf@gitster.siamese.dyndns.org> <48AA8931.1030009@viscovery.net>
 <20080819091830.GG11842@schiele.dyndns.org>
 <7vbpzoy53d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 03:07:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVcAY-0003uf-Bs
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 03:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848AbYHTBGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 21:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753847AbYHTBGW
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 21:06:22 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39904 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818AbYHTBGW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 21:06:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0AA6B60C80;
	Tue, 19 Aug 2008 21:06:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9B5AB60C7B; Tue, 19 Aug 2008 21:06:15 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 32D762E2-6E54-11DD-BDB1-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92946>

This trivially makes "git-shell" a built-in.  It makes the executable even
fatter, though.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                   |    1 +
 shell.c => builtin-shell.c |    5 +++--
 builtin.h                  |    1 +
 git.c                      |    1 +
 4 files changed, 6 insertions(+), 2 deletions(-)
 rename shell.c => builtin-shell.c (94%)

diff --git a/Makefile b/Makefile
index 71339e1..1a52f71 100644
--- a/Makefile
+++ b/Makefile
@@ -546,6 +546,7 @@ BUILTIN_OBJS += builtin-rev-parse.o
 BUILTIN_OBJS += builtin-revert.o
 BUILTIN_OBJS += builtin-rm.o
 BUILTIN_OBJS += builtin-send-pack.o
+BUILTIN_OBJS += builtin-shell.o
 BUILTIN_OBJS += builtin-shortlog.o
 BUILTIN_OBJS += builtin-show-branch.o
 BUILTIN_OBJS += builtin-show-ref.o
diff --git a/shell.c b/builtin-shell.c
similarity index 94%
rename from shell.c
rename to builtin-shell.c
index 0f6a727..3cf97d4 100644
--- a/shell.c
+++ b/builtin-shell.c
@@ -2,6 +2,7 @@
 #include "quote.h"
 #include "exec_cmd.h"
 #include "strbuf.h"
+#include "builtin.h"
 
 static int do_generic_cmd(const char *me, char *arg)
 {
@@ -44,7 +45,7 @@ static struct commands {
 	{ NULL },
 };
 
-int main(int argc, char **argv)
+int cmd_shell(int argc, const char **argv, const char *prefix)
 {
 	char *prog;
 	struct commands *cmd;
@@ -62,7 +63,7 @@ int main(int argc, char **argv)
 	else if (argc != 3 || strcmp(argv[1], "-c"))
 		die("What do you think I am? A shell?");
 
-	prog = argv[2];
+	prog = xstrdup(argv[2]);
 	if (!strncmp(prog, "git", 3) && isspace(prog[3]))
 		/* Accept "git foo" as if the caller said "git-foo". */
 		prog[3] = '-';
diff --git a/builtin.h b/builtin.h
index f3502d3..2b57a5e 100644
--- a/builtin.h
+++ b/builtin.h
@@ -88,6 +88,7 @@ extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
 extern int cmd_revert(int argc, const char **argv, const char *prefix);
 extern int cmd_rm(int argc, const char **argv, const char *prefix);
 extern int cmd_send_pack(int argc, const char **argv, const char *prefix);
+extern int cmd_shell(int argc, const char **argv, const char *prefix);
 extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 37b1d76..89e4645 100644
--- a/git.c
+++ b/git.c
@@ -338,6 +338,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
 		{ "rm", cmd_rm, RUN_SETUP },
 		{ "send-pack", cmd_send_pack, RUN_SETUP },
+		{ "shell", cmd_shell },
 		{ "shortlog", cmd_shortlog, USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
-- 
1.6.0.6.gc6670b
