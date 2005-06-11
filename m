From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff-stages: unuglify the too big main() function.
Date: Fri, 10 Jun 2005 18:44:36 -0700
Message-ID: <7vu0k56517.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
	<7vis0o30sc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
	<7voeagrp11.fsf_-_@assigned-by-dhcp.cox.net>
	<7v64woroui.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506090800580.2286@ppc970.osdl.org>
	<7vaclzclqd.fsf@assigned-by-dhcp.cox.net>
	<7vekbbb2me.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 03:40:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DguzM-0004YI-PG
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 03:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVFKBo7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 21:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVFKBo7
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 21:44:59 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:40105 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261518AbVFKBoj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2005 21:44:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050611014438.WBQX23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Jun 2005 21:44:38 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vekbbb2me.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 09 Jun 2005 15:13:13 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Split the core of the program, diff_stage, from one big "main()"
function that does it all and leave only the parameter parsing,
setup and finalize part in the main().

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 diff-stages.c |   75 ++++++++++++++++++++++++++++++---------------------------
 1 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/diff-stages.c b/diff-stages.c
--- a/diff-stages.c
+++ b/diff-stages.c
@@ -17,9 +17,47 @@ static const char *orderfile = NULL;
 static char *diff_stages_usage =
 "git-diff-stages [-p] [-r] [-z] [-M] [-C] [-R] [-S<string>] [-O<orderfile>] <stage1> <stage2> [<path>...]";
 
+static void diff_stages(int stage1, int stage2)
+{
+	int i = 0;
+	while (i < active_nr) {
+		struct cache_entry *ce, *stages[4] = { NULL, };
+		struct cache_entry *one, *two;
+		const char *name;
+		int len;
+		ce = active_cache[i];
+		len = ce_namelen(ce);
+		name = ce->name;
+		for (;;) {
+			int stage = ce_stage(ce);
+			stages[stage] = ce;
+			if (active_nr <= ++i)
+				break;
+			ce = active_cache[i];
+			if (ce_namelen(ce) != len ||
+			    memcmp(name, ce->name, len))
+				break;
+		}
+		one = stages[stage1];
+		two = stages[stage2];
+		if (!one && !two)
+			continue;
+		if (!one)
+			diff_addremove('+', ntohl(two->ce_mode),
+				       two->sha1, name, NULL);
+		else if (!two)
+			diff_addremove('-', ntohl(one->ce_mode),
+				       one->sha1, name, NULL);
+		else if (memcmp(one->sha1, two->sha1, 20) ||
+			 (one->ce_mode != two->ce_mode))
+			 diff_change(ntohl(one->ce_mode), ntohl(two->ce_mode),
+				     one->sha1, two->sha1, name, NULL);
+	}
+}
+
 int main(int ac, const char **av)
 {
-	int stage1, stage2, i;
+	int stage1, stage2;
 
 	read_cache();
 	while (1 < ac && av[1][0] == '-') {
@@ -67,40 +105,7 @@ int main(int ac, const char **av)
 	av += 3; /* The rest from av[0] are for paths restriction. */
 	diff_setup(diff_setup_opt);
 
-	i = 0;
-	while (i < active_nr) {
-		struct cache_entry *ce, *stages[4] = { NULL, };
-		struct cache_entry *one, *two;
-		const char *name;
-		int len;
-		ce = active_cache[i];
-		len = ce_namelen(ce);
-		name = ce->name;
-		for (;;) {
-			int stage = ce_stage(ce);
-			stages[stage] = ce;
-			if (active_nr <= ++i)
-				break;
-			ce = active_cache[i];
-			if (ce_namelen(ce) != len ||
-			    memcmp(name, ce->name, len))
-				break;
-		}
-		one = stages[stage1];
-		two = stages[stage2];
-		if (!one && !two)
-			continue;
-		if (!one)
-			diff_addremove('+', ntohl(two->ce_mode),
-				       two->sha1, name, NULL);
-		else if (!two)
-			diff_addremove('-', ntohl(one->ce_mode),
-				       one->sha1, name, NULL);
-		else if (memcmp(one->sha1, two->sha1, 20) ||
-			 (one->ce_mode != two->ce_mode))
-			 diff_change(ntohl(one->ce_mode), ntohl(two->ce_mode),
-				     one->sha1, two->sha1, name, NULL);
-	}
+	diff_stages(stage1, stage2);
 
 	diffcore_std(av,
 		     detect_rename, diff_score_opt,
------------

