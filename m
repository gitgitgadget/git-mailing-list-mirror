From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] status: disable translation when --porcelain is used
Date: Thu, 20 Mar 2014 13:12:41 +0100
Message-ID: <1395317561-9380-1-git-send-email-Matthieu.Moy@imag.fr>
References: <CAPP0M7Rw50hPHm49FetNXPGESXOoAND4NXU9F=rajv+NA=G32Q@mail.gmail.com>
Cc: ghostanarky@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 20 13:13:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQbqZ-0001mO-70
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 13:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756480AbaCTMM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 08:12:57 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54218 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbaCTMM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 08:12:56 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s2KCCh0X023187
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 20 Mar 2014 13:12:43 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2KCCheq017542;
	Thu, 20 Mar 2014 13:12:44 +0100
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1WQbpz-0002S1-Nq; Thu, 20 Mar 2014 13:12:43 +0100
X-Mailer: git-send-email 1.9.1.295.g2661741
In-Reply-To: <CAPP0M7Rw50hPHm49FetNXPGESXOoAND4NXU9F=rajv+NA=G32Q@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 20 Mar 2014 13:12:45 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2KCCh0X023187
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1395922365.86834@MTMz8arIniuXf0odlvK1Pw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244545>

"git status --branch --porcelain" displays the status of the branch
(ahead, behind, gone), and used gettext to translate the string.

Use hardcoded strings when --porcelain is used, but keep the gettext
translation for "git status --short" which is essentially the same, but
meant to be read by a human.

Reported-by: Anarky <ghostanarky@gmail.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
> The porcelain format of git status is described as not based on user
> configuration.
> But with --branch, behind/ahead are translated following the user's locale.
> Is it normal that scripts need to take care of that?

Indeed, I'd call that a bug. Here's a fix.

 wt-status.c | 15 ++++++++++-----
 wt-status.h |  1 +
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index a452407..e55e5b9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1509,19 +1509,23 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 		return;
 	}
 
+	const char *gone   = s->no_gettext ? "gone"   : _("gone");
+	const char *behind = s->no_gettext ? "behind " : _("behind ");
+	const char *ahead  = s->no_gettext ? "ahead "  : _("ahead ");
+
 	color_fprintf(s->fp, header_color, " [");
 	if (upstream_is_gone) {
-		color_fprintf(s->fp, header_color, _("gone"));
+		color_fprintf(s->fp, header_color, gone);
 	} else if (!num_ours) {
-		color_fprintf(s->fp, header_color, _("behind "));
+		color_fprintf(s->fp, header_color, behind);
 		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
 	} else if (!num_theirs) {
-		color_fprintf(s->fp, header_color, _("ahead "));
+		color_fprintf(s->fp, header_color, ahead);
 		color_fprintf(s->fp, branch_color_local, "%d", num_ours);
 	} else {
-		color_fprintf(s->fp, header_color, _("ahead "));
+		color_fprintf(s->fp, header_color, ahead);
 		color_fprintf(s->fp, branch_color_local, "%d", num_ours);
-		color_fprintf(s->fp, header_color, _(", behind "));
+		color_fprintf(s->fp, header_color, ", %s", behind);
 		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
 	}
 
@@ -1566,5 +1570,6 @@ void wt_porcelain_print(struct wt_status *s)
 	s->use_color = 0;
 	s->relative_paths = 0;
 	s->prefix = NULL;
+	s->no_gettext = 1;
 	wt_shortstatus_print(s);
 }
diff --git a/wt-status.h b/wt-status.h
index 30a4812..82f6ce6 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -50,6 +50,7 @@ struct wt_status {
 	enum commit_whence whence;
 	int nowarn;
 	int use_color;
+	int no_gettext;
 	int display_comment_prefix;
 	int relative_paths;
 	int submodule_summary;
-- 
1.9.1.295.g2661741
