From: Petter Urkedal <urkedal@nbi.dk>
Subject: [PATCH] Reserve a slot for argv[0] in default_arg.
Date: Sat,  3 Oct 2009 15:29:31 +0200
Message-ID: <1254576571-29274-1-git-send-email-urkedal@nbi.dk>
Cc: Petter Urkedal <urkedal@nbi.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 03 15:37:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mu4nh-0000Tt-Ed
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 15:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756306AbZJCNgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2009 09:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756226AbZJCNgy
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Oct 2009 09:36:54 -0400
Received: from 79.142.225.158.static.router1.bolignet.dk ([79.142.225.158]:59377
	"EHLO eideticdew.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756166AbZJCNgy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2009 09:36:54 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Oct 2009 09:36:54 EDT
Received: by eideticdew.org (Postfix, from userid 502)
	id 2A951AD466; Sat,  3 Oct 2009 15:29:52 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129485>

Setting "av" to one slot before the allocated "default_arg" array causes
glibc abort with "free(): invalid next size (normal)" in some
configurations (Gentoo, glibc-2.9_p20081201-r2, gcc-5.3.2 with PIE).
---
 builtin-show-branch.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 3510a86..3ab72b7 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -568,6 +568,9 @@ static int git_show_branch_config(const char *var, const char *value, void *cb)
 		if (default_alloc <= default_num + 1) {
 			default_alloc = default_alloc * 3 / 2 + 20;
 			default_arg = xrealloc(default_arg, sizeof *default_arg * default_alloc);
+			if (!default_num)
+			    /* One unused position for argv[0]. */
+			    default_arg[default_num++] = NULL;
 		}
 		default_arg[default_num++] = xstrdup(value);
 		default_arg[default_num] = NULL;
@@ -692,8 +695,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 
 	/* If nothing is specified, try the default first */
 	if (ac == 1 && default_num) {
-		ac = default_num + 1;
-		av = default_arg - 1; /* ick; we would not address av[0] */
+		ac = default_num;
+		av = default_arg;
 	}
 
 	ac = parse_options(ac, av, prefix, builtin_show_branch_options,
-- 
1.6.4.4
