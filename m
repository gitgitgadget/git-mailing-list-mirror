From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/4] wt-status: move wt_status_get_state() out to wt_status_print()
Date: Wed,  6 Mar 2013 19:21:20 +0700
Message-ID: <1362572482-20570-3-git-send-email-pclouds@gmail.com>
References: <1362303681-6585-1-git-send-email-pclouds@gmail.com>
 <1362572482-20570-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 06 13:21:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDDLE-00080v-VR
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 13:21:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758030Ab3CFMUj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Mar 2013 07:20:39 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:45404 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757939Ab3CFMUi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 07:20:38 -0500
Received: by mail-pb0-f54.google.com with SMTP id rr4so5931861pbb.27
        for <git@vger.kernel.org>; Wed, 06 Mar 2013 04:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=c1hOFYFzc9wgHOe18flitw9qnuaOeZVCEvTrJHJYBoU=;
        b=dzT5eyHPCrqLjByRoWzqgw7ZgQduPr6EVeFGLfPp/Sa70KFdNZV5izTcg44zkvmP29
         uruSpyNYd8ipY/Sqg1kS8xtkjgbJUpidIhWw0BQNaBz+RUZHvvnt9uG/jm3wd7nxGKla
         EiJqb3Eq5PqGfRFi6x4LBK1h2UD5l+zgSAF6fDZ99NRmV3BpgdDgeUeBMYNTouOx3Eh8
         8R1tWY3SK4Z7vY8gCpHbgGbNlteCc2beUU1/dola3z6DEmHLPsHGts1xRiKfO/Y7vSLd
         Ev1dM9beH7QLIKvI6nMZ0qx0lDGJKma3AHfRJofPCO87tUAZorxRwyqg0x/n5iPEcf8R
         pY1w==
X-Received: by 10.68.196.35 with SMTP id ij3mr45305883pbc.56.1362572437925;
        Wed, 06 Mar 2013 04:20:37 -0800 (PST)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id b9sm31116053pba.6.2013.03.06.04.20.34
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Mar 2013 04:20:37 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 06 Mar 2013 19:21:46 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1362572482-20570-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217518>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wt-status.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 183aafe..6a3566b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1044,31 +1044,29 @@ void wt_status_get_state(struct wt_status_state=
 *state)
 	strbuf_release(&onto);
 }
=20
-static void wt_status_print_state(struct wt_status *s)
+static void wt_status_print_state(struct wt_status *s,
+				  struct wt_status_state *state)
 {
 	const char *state_color =3D color(WT_STATUS_HEADER, s);
-	struct wt_status_state state;
-
-	wt_status_get_state(&state);
-
-	if (state.merge_in_progress)
-		show_merge_in_progress(s, &state, state_color);
-	else if (state.am_in_progress)
-		show_am_in_progress(s, &state, state_color);
-	else if (state.rebase_in_progress || state.rebase_interactive_in_prog=
ress)
-		show_rebase_in_progress(s, &state, state_color);
-	else if (state.cherry_pick_in_progress)
-		show_cherry_pick_in_progress(s, &state, state_color);
-	if (state.bisect_in_progress)
-		show_bisect_in_progress(s, &state, state_color);
-	free(state.branch);
-	free(state.onto);
+	if (state->merge_in_progress)
+		show_merge_in_progress(s, state, state_color);
+	else if (state->am_in_progress)
+		show_am_in_progress(s, state, state_color);
+	else if (state->rebase_in_progress || state->rebase_interactive_in_pr=
ogress)
+		show_rebase_in_progress(s, state, state_color);
+	else if (state->cherry_pick_in_progress)
+		show_cherry_pick_in_progress(s, state, state_color);
+	if (state->bisect_in_progress)
+		show_bisect_in_progress(s, state, state_color);
 }
=20
 void wt_status_print(struct wt_status *s)
 {
 	const char *branch_color =3D color(WT_STATUS_ONBRANCH, s);
 	const char *branch_status_color =3D color(WT_STATUS_HEADER, s);
+	struct wt_status_state state;
+
+	wt_status_get_state(&state);
=20
 	if (s->branch) {
 		const char *on_what =3D _("On branch ");
@@ -1087,7 +1085,10 @@ void wt_status_print(struct wt_status *s)
 			wt_status_print_tracking(s);
 	}
=20
-	wt_status_print_state(s);
+	wt_status_print_state(s, &state);
+	free(state.branch);
+	free(state.onto);
+
 	if (s->is_initial) {
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"))=
;
--=20
1.8.1.2.536.gf441e6d
