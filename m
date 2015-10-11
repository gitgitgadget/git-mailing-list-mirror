From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/3] fixup: use xstrfmt instead of fixed-size buf + sprintf + xstrdup
Date: Sun, 11 Oct 2015 18:16:26 +0200
Message-ID: <1444580188-18773-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqa8rp2xku.fsf@grenoble-inp.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, karthik.188@gmail.com
X-From: git-owner@vger.kernel.org Sun Oct 11 18:16:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlJIi-0003e6-5f
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 18:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbbJKQQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 12:16:39 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53407 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbbJKQQi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 12:16:38 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t9BGGVvq028532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 11 Oct 2015 18:16:31 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9BGGXFG023619;
	Sun, 11 Oct 2015 18:16:33 +0200
X-Mailer: git-send-email 2.6.0.rc2.24.gb06d8e9.dirty
In-Reply-To: <vpqa8rp2xku.fsf@grenoble-inp.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 11 Oct 2015 18:16:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9BGGVvq028532
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1445184994.41387@oKc9Cpyx5noRfZ0SS5By5Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279340>

The char buf[40] is safe (at least while the strings are not
translated), but I'd rather avoid magic numbers like this 40 in the
code, and use a construct that does not have this size limitation.
Especially if it makes the code shorter.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 ref-filter.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 6044eb0..7932c21 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1116,7 +1116,6 @@ static void populate_value(struct ref_array_item *ref)
 				 strcmp(formatp, "trackshort") &&
 				 (starts_with(name, "upstream") ||
 				  starts_with(name, "push"))) {
-				char buf[40];
 				unsigned int nobracket = 0;
 
 				if (!strcmp(valp, ",nobracket"))
@@ -1135,24 +1134,21 @@ static void populate_value(struct ref_array_item *ref)
 					v->s = "";
 				else if (!num_ours) {
 					if (nobracket)
-						sprintf(buf, "behind %d", num_theirs);
+						v->s = xstrfmt("behind %d", num_theirs);
 					else
-						sprintf(buf, "[behind %d]", num_theirs);
-					v->s = xstrdup(buf);
+						v->s = xstrfmt("[behind %d]", num_theirs);
 				} else if (!num_theirs) {
 					if (nobracket)
-						sprintf(buf, "ahead %d", num_ours);
+						v->s = xstrfmt("ahead %d", num_ours);
 					else
-						sprintf(buf, "[ahead %d]", num_ours);
-					v->s = xstrdup(buf);
+						v->s = xstrfmt("[ahead %d]", num_ours);
 				} else {
 					if (nobracket)
-						sprintf(buf, "ahead %d, behind %d",
-							num_ours, num_theirs);
+						v->s = xstrfmt("ahead %d, behind %d",
+							       num_ours, num_theirs);
 					else
-						sprintf(buf, "[ahead %d, behind %d]",
-						num_ours, num_theirs);
-					v->s = xstrdup(buf);
+						v->s = xstrfmt("[ahead %d, behind %d]",
+							       num_ours, num_theirs);
 				}
 				continue;
 			} else if (!strcmp(formatp, "trackshort") &&
-- 
2.6.0.rc2.24.gb06d8e9.dirty
