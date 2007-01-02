From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: [PATCH 3/4] Improve "nothing to commit" part of status output
Date: Tue,  2 Jan 2007 20:26:22 +0100
Message-ID: <11677659941419-git-send-email-j.ruehle@bmiag.de>
References: <1167765983316-git-send-email-j.ruehle@bmiag.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	=?iso-8859-1?q?J=FCrgen_R=FChle?= <j-r@online.de>
X-From: git-owner@vger.kernel.org Tue Jan 02 20:27:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1pHo-00082t-UN
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 20:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbXABT04 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 14:26:56 -0500
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbXABT04
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 14:26:56 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:37847 "EHLO
	meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964919AbXABT0z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 14:26:55 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id 67C773AED2;
	Tue,  2 Jan 2007 20:26:53 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 14482-09; Tue, 2 Jan 2007 20:26:53 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de (eorl.intranet.kiel.bmiag.de [10.131.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id 1BE733AED1;
	Tue,  2 Jan 2007 20:26:53 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 37A943ADC6;
	Tue,  2 Jan 2007 20:26:52 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eorl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 20656-05; Tue, 2 Jan 2007 20:26:41 +0100 (CET)
Received: from localhost.localdomain (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 599483ADCB;
	Tue,  2 Jan 2007 20:26:35 +0100 (CET)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.5.0.rc0.g31e2
In-Reply-To: <1167765983316-git-send-email-j.ruehle@bmiag.de>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eorl.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35803>

=46rom: =3D?iso-8859-1?q?J=3DFCrgen_R=3DFChle?=3D <j-r@online.de>

Previously git-status in a clean working directory would advice the use=
r to use
git add. This isn't very helpful when there is nothing to add in the wo=
rking
directory, therefore note a clean working directory while displaying th=
e other
sections and print the appropriate message for each case.

Signed-off-by: J=FCrgen R=FChle <j-r@online.de>
---
 wt-status.c |   20 +++++++++++++++-----
 wt-status.h |    1 +
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 98ca135..302f7ee 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -51,6 +51,8 @@ void wt_status_prepare(struct wt_status *s)
 	s->verbose =3D 0;
 	s->commitable =3D 0;
 	s->untracked =3D 0;
+
+	s->workdir_clean =3D 1;
 }
=20
 static void wt_status_print_cached_header(const char *reference)
@@ -173,9 +175,12 @@ static void wt_status_print_changed_cb(struct diff=
_queue_struct *q,
                         struct diff_options *options,
                         void *data)
 {
+	struct wt_status *s =3D data;
 	int i;
-	if (q->nr)
+	if (q->nr) {
+		s->workdir_clean =3D 0;
 		wt_status_print_header("Changed but not added", use_add_msg);
+	}
 	for (i =3D 0; i < q->nr; i++)
 		wt_status_print_filepair(WT_STATUS_CHANGED, q->queue[i]);
 	if (q->nr)
@@ -225,7 +230,7 @@ static void wt_status_print_changed(struct wt_statu=
s *s)
 	run_diff_files(&rev, 0);
 }
=20
-static void wt_status_print_untracked(const struct wt_status *s)
+static void wt_status_print_untracked(struct wt_status *s)
 {
 	struct dir_struct dir;
 	const char *x;
@@ -260,6 +265,7 @@ static void wt_status_print_untracked(const struct =
wt_status *s)
 				continue;
 		}
 		if (!shown_header) {
+			s->workdir_clean =3D 0;
 			wt_status_print_header("Untracked files", use_add_msg);
 			shown_header =3D 1;
 		}
@@ -302,9 +308,13 @@ void wt_status_print(struct wt_status *s)
 	if (s->verbose && !s->is_initial)
 		wt_status_print_verbose(s);
 	if (!s->commitable)
-		printf("%s (%s)\n",
-			s->amend ? "# No changes" : "nothing to commit",
-			use_add_msg);
+		if (s->amend)
+			printf("# No changes\n");
+		else if (s->workdir_clean)
+			printf(s->is_initial ? "nothing to commit\n"
+				: "nothing to commit (working directory matches HEAD)\n");
+		else
+			printf("no changes added to commit (use \"git add\" and/or \"git co=
mmit [-a|-i|-o]\")\n");
 }
=20
 int git_status_config(const char *k, const char *v)
diff --git a/wt-status.h b/wt-status.h
index 0a5a5b7..892a86c 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -16,6 +16,7 @@ struct wt_status {
 	int verbose;
 	int amend;
 	int untracked;
+	int workdir_clean;
 };
=20
 int git_status_config(const char *var, const char *value);
--=20
1.5.0.rc0.g31e2
