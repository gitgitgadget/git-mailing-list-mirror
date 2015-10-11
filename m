From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/3] ref-filter: allow porcelain to translate messages in the output
Date: Sun, 11 Oct 2015 18:16:27 +0200
Message-ID: <1444580188-18773-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqa8rp2xku.fsf@grenoble-inp.fr>
 <1444580188-18773-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, karthik.188@gmail.com
X-From: git-owner@vger.kernel.org Sun Oct 11 18:16:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlJIo-0003e6-Ke
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 18:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbbJKQQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 12:16:44 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50485 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbbJKQQl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 12:16:41 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t9BGGWUc028526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 11 Oct 2015 18:16:32 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9BGGXFH023619;
	Sun, 11 Oct 2015 18:16:34 +0200
X-Mailer: git-send-email 2.6.0.rc2.24.gb06d8e9.dirty
In-Reply-To: <1444580188-18773-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 11 Oct 2015 18:16:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9BGGWUc028526
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1445184995.56329@AFdPr0yjqZsGeeCnr7/j+w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279342>

This patch shows the way, but is obviously incomplete as it works only
for "nobracket" version. Actually, I think the code should first build
the unbracketed output string and then do something like

if (!nobracket) {
	const char *to_free = v->s;
	v->s = xstrfmt("[%s]", v->s);
	free(to_free);
}

so we don't have to worry about brackets anywhere else in the code.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 ref-filter.c | 28 ++++++++++++++++++++++++----
 ref-filter.h |  3 +++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 7932c21..c2ee8c9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -15,6 +15,26 @@
 #include "version.h"
 #include "wt-status.h"
 
+static struct ref_msg {
+	const char *gone;
+	const char *ahead;
+	const char *behind;
+	const char *ahead_behind;
+} msgs = {
+	"gone",
+	"ahead %d",
+	"behind %d",
+	"ahead %d, behind %d"
+};
+
+void setup_ref_filter_porcelain_msg(void)
+{
+	msgs.gone = _("gone");
+	msgs.ahead = _("ahead %d");
+	msgs.behind = _("behind %d");
+	msgs.ahead_behind = _("ahead %d, behind %d");
+}
+
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
 static struct {
@@ -1124,7 +1144,7 @@ static void populate_value(struct ref_array_item *ref)
 				if (stat_tracking_info(branch, &num_ours,
 						       &num_theirs, NULL)) {
 					if (nobracket)
-						v->s = "gone";
+						v->s = msgs.gone;
 					else
 						v->s = "[gone]";
 					continue;
@@ -1134,17 +1154,17 @@ static void populate_value(struct ref_array_item *ref)
 					v->s = "";
 				else if (!num_ours) {
 					if (nobracket)
-						v->s = xstrfmt("behind %d", num_theirs);
+						v->s = xstrfmt(msgs.behind, num_theirs);
 					else
 						v->s = xstrfmt("[behind %d]", num_theirs);
 				} else if (!num_theirs) {
 					if (nobracket)
-						v->s = xstrfmt("ahead %d", num_ours);
+						v->s = xstrfmt(msgs.ahead, num_ours);
 					else
 						v->s = xstrfmt("[ahead %d]", num_ours);
 				} else {
 					if (nobracket)
-						v->s = xstrfmt("ahead %d, behind %d",
+						v->s = xstrfmt(msgs.ahead_behind,
 							       num_ours, num_theirs);
 					else
 						v->s = xstrfmt("[ahead %d, behind %d]",
diff --git a/ref-filter.h b/ref-filter.h
index 0014b92..2cce02c 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -112,4 +112,7 @@ int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
 /*  Get the current HEAD's description */
 char *get_head_description(void);
 
+/*  Set up translated strings in the output. */
+void setup_ref_filter_porcelain_msg(void);
+
 #endif /*  REF_FILTER_H  */
-- 
2.6.0.rc2.24.gb06d8e9.dirty
