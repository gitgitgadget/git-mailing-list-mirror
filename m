From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 3/5] wt-status: move wt_status_get_state() out to wt_status_print()
Date: Wed, 13 Mar 2013 18:42:51 +0700
Message-ID: <1363174973-17597-4-git-send-email-pclouds@gmail.com>
References: <1362572482-20570-1-git-send-email-pclouds@gmail.com>
 <1363174973-17597-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 13 12:43:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFk68-0006VB-3Q
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 12:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544Ab3CMLn3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Mar 2013 07:43:29 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:36750 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569Ab3CMLn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 07:43:28 -0400
Received: by mail-pb0-f48.google.com with SMTP id wy12so930645pbc.35
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 04:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=ilrfEKTGuhvnJtG5pe75rxJgayAqtr4VXpSVi6QQuq0=;
        b=aul1N7KsOFPlsXz1iq6+pN1WWjhJUklxzYRpqjR8oJlOK9YqXpMVERhf/MSGyHd5ul
         h4wkX7Ih2k6w74AtHQliPwoyJJpFRYxP5ryiKCfyLrCzoCgonRb8N3zXMSii9yR9NdUt
         YhtkugLR0DNEHjT28bmONv6lIjJW9X1EyGXVm3mClgRC/yqYDzNyQkqxBBx56yw2u1UX
         mHUV6UXd/1IStWrrZqLC2+zdBWN1ejHaYy2AhOC6w6yhBDDHymtpWt6tI7wwHHFR6ldD
         Ioz0L9sADPqa3i+4vrL0evmbTh46L0afAI11h1IonXqGWaCl7WaO6O5CjKYlmVkroFzb
         xdJA==
X-Received: by 10.68.245.229 with SMTP id xr5mr45422285pbc.163.1363175008362;
        Wed, 13 Mar 2013 04:43:28 -0700 (PDT)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id y1sm9791233pbg.10.2013.03.13.04.43.24
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Mar 2013 04:43:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Mar 2013 18:43:21 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1363174973-17597-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218050>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wt-status.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 0d8989f..17690d8 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1033,32 +1033,30 @@ void wt_status_get_state(struct wt_status_state=
 *state)
 	}
 }
=20
-static void wt_status_print_state(struct wt_status *s)
+static void wt_status_print_state(struct wt_status *s,
+				  struct wt_status_state *state)
 {
 	const char *state_color =3D color(WT_STATUS_HEADER, s);
-	struct wt_status_state state;
-
-	memset(&state, 0, sizeof(state));
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
+	memset(&state, 0, sizeof(state));
+	wt_status_get_state(&state);
=20
 	if (s->branch) {
 		const char *on_what =3D _("On branch ");
@@ -1077,7 +1075,10 @@ void wt_status_print(struct wt_status *s)
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
