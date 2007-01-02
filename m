From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: [PATCH 2/4] Improve cached content header of status output
Date: Tue,  2 Jan 2007 20:26:21 +0100
Message-ID: <11677659921833-git-send-email-j.ruehle@bmiag.de>
References: <1167765983316-git-send-email-j.ruehle@bmiag.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	=?iso-8859-1?q?J=FCrgen_R=FChle?= <j-r@online.de>
X-From: git-owner@vger.kernel.org Tue Jan 02 20:27:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1pHo-00082t-Dz
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 20:27:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbXABT0u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 14:26:50 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbXABT0t
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 14:26:49 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:37843 "EHLO
	meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964920AbXABT0s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 14:26:48 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id 7B43A3AED2;
	Tue,  2 Jan 2007 20:26:46 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 14487-07; Tue, 2 Jan 2007 20:26:46 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de (eorl.intranet.kiel.bmiag.de [10.131.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id 4094A3AED1;
	Tue,  2 Jan 2007 20:26:46 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 32CB33ADC8;
	Tue,  2 Jan 2007 20:26:45 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eorl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 20762-03; Tue, 2 Jan 2007 20:26:35 +0100 (CET)
Received: from localhost.localdomain (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 638E93ADC6;
	Tue,  2 Jan 2007 20:26:33 +0100 (CET)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.5.0.rc0.g31e2
In-Reply-To: <1167765983316-git-send-email-j.ruehle@bmiag.de>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eorl.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35804>

=46rom: =3D?iso-8859-1?q?J=3DFCrgen_R=3DFChle?=3D <j-r@online.de>

This tries to be more to the point while also including a pointer on ho=
w to
unstage changes from the index.

Since this header is printed in two different code paths and the name o=
f the
reference commit is needed for the unstage part, provide a new printing
function.

Signed-off-by: J=FCrgen R=FChle <j-r@online.de>
---
 wt-status.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 34be91b..98ca135 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -53,6 +53,18 @@ void wt_status_prepare(struct wt_status *s)
 	s->untracked =3D 0;
 }
=20
+static void wt_status_print_cached_header(const char *reference)
+{
+	const char *c =3D color(WT_STATUS_HEADER);
+	color_printf_ln(c, "# Cached changes to be committed:");
+	if (reference) {
+		color_printf_ln(c, "#   (use \"git reset %s <file>...\" and \"git rm=
 --cached <file>...\" to unstage)", reference);
+	} else {
+		color_printf_ln(c, "#   (use \"git rm --cached <file>...\" to unstag=
e)");
+	}
+	color_printf_ln(c, "#");
+}
+
 static void wt_status_print_header(const char *main, const char *sub)
 {
 	const char *c =3D color(WT_STATUS_HEADER);
@@ -147,8 +159,7 @@ static void wt_status_print_updated_cb(struct diff_=
queue_struct *q,
 		if (q->queue[i]->status =3D=3D 'U')
 			continue;
 		if (!shown_header) {
-			wt_status_print_header("Added but not yet committed",
-					"will commit");
+			wt_status_print_cached_header(s->reference);
 			s->commitable =3D 1;
 			shown_header =3D 1;
 		}
@@ -179,8 +190,7 @@ void wt_status_print_initial(struct wt_status *s)
 	read_cache();
 	if (active_nr) {
 		s->commitable =3D 1;
-		wt_status_print_header("Added but not yet committed",
-				"will commit");
+		wt_status_print_cached_header(NULL);
 	}
 	for (i =3D 0; i < active_nr; i++) {
 		color_printf(color(WT_STATUS_HEADER), "#\t");
--=20
1.5.0.rc0.g31e2
