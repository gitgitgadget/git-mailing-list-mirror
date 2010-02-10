From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] Fix signal handler
Date: Wed, 10 Feb 2010 18:08:43 +0100
Message-ID: <4B72E81B.3020900@web.de>
References: <4B684F5F.7020409@web.de> <20100202205849.GA14385@sigill.intra.peff.net> <4B71A2EE.8070708@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080606010603020809060803"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 10 18:08:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfG3b-0007kw-HU
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 18:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754252Ab0BJRIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 12:08:50 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:47921 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab0BJRIt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 12:08:49 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id E3A6F14D892B4;
	Wed, 10 Feb 2010 18:08:47 +0100 (CET)
Received: from [92.228.137.24] (helo=[192.168.1.202])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NfG3T-0004XE-00; Wed, 10 Feb 2010 18:08:47 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <4B71A2EE.8070708@web.de>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1/YJc4PMNnChZ8vWt3lZtEyWAskq+WaWTZaySlM
	6qKcW6r0pEdQlnXXlkf/EVlGupAPEN5p80j0SFKG2FXnZ8oGWY
	0tuzBa3e3HTKtCH/i0Cg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139520>

This is a multi-part message in MIME format.
--------------080606010603020809060803
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

How do Git software developers think about the appended update suggestion?
Would you like to integrate such adjustments into your source code
repository?

Regards,
Markus

--------------080606010603020809060803
Content-Type: text/x-patch;
 name="0001-Fix-a-signal-handler.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Fix-a-signal-handler.patch"

>From c37d8dafef11168d8302d40c8d1453943a058d95 Mon Sep 17 00:00:00 2001
From: Markus Elfring <Markus.Elfring@web.de>
Date: Wed, 10 Feb 2010 17:05:45 +0100
Subject: [PATCH] Fix a signal handler

A global flag can only be set by a signal handler in a portable way if it has got the data type "sig_atomic_t". The previously used assignment of a function pointer in the function "early_output" was moved to another variable in the function "setup_early_output".
The involved software design details were also mentioned on the mailing list.
---
 builtin-log.c |   12 +++---------
 revision.c    |   14 ++++++--------
 revision.h    |    3 ++-
 3 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 8d16832..358c98b 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -123,7 +123,7 @@ static void show_early_header(struct rev_info *rev, const char *stage, int nr)
 
 static struct itimerval early_output_timer;
 
-static void log_show_early(struct rev_info *revs, struct commit_list *list)
+extern void log_show_early(struct rev_info *revs, struct commit_list *list)
 {
 	int i = revs->early_output;
 	int show_header = 1;
@@ -170,20 +170,14 @@ static void log_show_early(struct rev_info *revs, struct commit_list *list)
 
 static void early_output(int signal)
 {
-	show_early_output = log_show_early;
+	show_early_output = 1;
 }
 
 static void setup_early_output(struct rev_info *rev)
 {
 	struct sigaction sa;
 
-	/*
-	 * Set up the signal handler, minimally intrusively:
-	 * we only set a single volatile integer word (not
-	 * using sigatomic_t - trying to avoid unnecessary
-	 * system dependencies and headers), and using
-	 * SA_RESTART.
-	 */
+	early_output_function = &log_show_early;
 	memset(&sa, 0, sizeof(sa));
 	sa.sa_handler = early_output;
 	sigemptyset(&sa.sa_mask);
diff --git a/revision.c b/revision.c
index 3ba6d99..62402fb 100644
--- a/revision.c
+++ b/revision.c
@@ -13,7 +13,8 @@
 #include "decorate.h"
 #include "log-tree.h"
 
-volatile show_early_output_fn_t show_early_output;
+sig_atomic_t show_early_output = 0;
+show_early_output_fn_t early_output_function = NULL;
 
 char *path_name(const struct name_path *path, const char *name)
 {
@@ -654,7 +655,6 @@ static int limit_list(struct rev_info *revs)
 		struct commit_list *entry = list;
 		struct commit *commit = list->item;
 		struct object *obj = &commit->object;
-		show_early_output_fn_t show;
 
 		list = list->next;
 		free(entry);
@@ -680,12 +680,10 @@ static int limit_list(struct rev_info *revs)
 		date = commit->date;
 		p = &commit_list_insert(commit, p)->next;
 
-		show = show_early_output;
-		if (!show)
-			continue;
-
-		show(revs, newlist);
-		show_early_output = NULL;
+		if (show_early_output) {
+			(*early_output_function)(revs, newlist);
+			show_early_output = 0;
+		}
 	}
 	if (revs->cherry_pick)
 		cherry_pick_list(newlist, revs);
diff --git a/revision.h b/revision.h
index a14deef..93a8ffc 100644
--- a/revision.h
+++ b/revision.h
@@ -135,7 +135,8 @@ struct rev_info {
 
 /* revision.c */
 typedef void (*show_early_output_fn_t)(struct rev_info *, struct commit_list *);
-extern volatile show_early_output_fn_t show_early_output;
+extern show_early_output_fn_t early_output_function;
+extern sig_atomic_t show_early_output;
 
 extern void init_revisions(struct rev_info *revs, const char *prefix);
 extern int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def);
-- 
1.6.6.1


--------------080606010603020809060803--
