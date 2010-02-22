From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] Fix a signal handler
Date: Mon, 22 Feb 2010 13:10:51 +0100
Message-ID: <4B82744B.4060805@web.de>
References: <4B684F5F.7020409@web.de> <20100202205849.GA14385@sigill.intra.peff.net> <4B71A2EE.8070708@web.de> <4B72E81B.3020900@web.de> <20100210173348.GA5091@coredump.intra.peff.net> <4B76A985.9070809@web.de> <20100214064745.GC20630@coredump.intra.peff.net> <7vsk94qfuy.fsf@alter.siamese.dyndns.org> <4B7D6B7A.1090004@web.de> <7veikib96d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 14:27:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjX82-0005qY-R2
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 13:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502Ab0BVMK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 07:10:58 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:33963 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178Ab0BVMK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 07:10:57 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id D6A0B1487942A;
	Mon, 22 Feb 2010 13:10:55 +0100 (CET)
Received: from [78.48.108.130] (helo=[192.168.1.202])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NjX7n-0003X6-00; Mon, 22 Feb 2010 13:10:55 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <7veikib96d.fsf@alter.siamese.dyndns.org>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX18gFOD9G76Hvlyz7tPwpYTotZ0anJ/S8YLuVirM
	gS56PK5g4NX66Jy3+Aj0dgwI0BA6epuuEDNC2SOBYU6zsBrByr
	OsKR2XVWg83e8UzaTaUg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140675>

> Of are you asking me if I'd apply your patch if you send a polished update,
> and asking me to decide it before seeing the patch?

Would you like to pick this source code adjustment up?

Regards,
Markus

---
From e138904a08ceaf469fa2f4d0ec87b5891be14760 Mon Sep 17 00:00:00 2001
From: Markus Elfring <Markus.Elfring@web.de>
Date: Mon, 22 Feb 2010 11:53:35 +0100
Subject: [PATCH] Fix a signal handler

A global flag can only be set by a signal handler in a portable way
if it has got the data type "sig_atomic_t". The previously used assignment
of a function pointer in the function "early_output" was moved to another
variable in the function "setup_early_output".

The involved software design details were also mentioned on the mailing list.

Signed-off-by: Markus Elfring <Markus.Elfring@web.de>

---
 builtin-log.c |   10 ++--------
 revision.c    |   14 ++++++--------
 revision.h    |    3 ++-
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index e0d5caa..beccf7f 100644
--- a/builtin-log.c
+++ b/builtin-log.c
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
1.7.0
