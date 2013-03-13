From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 2/5] wt-status: split wt_status_state parsing function out
Date: Wed, 13 Mar 2013 18:42:50 +0700
Message-ID: <1363174973-17597-3-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Mar 13 12:43:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFk60-0006Mr-NP
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 12:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275Ab3CMLnW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Mar 2013 07:43:22 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:54487 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218Ab3CMLnV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 07:43:21 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so934284pbc.31
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 04:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=yfNTyWtTg8GXWoMUWaEjKxvHYl1aa/WXm+MqLo1IMdI=;
        b=LxM5dGMTw3wI73Rhj/AW0ZR+xPYlwr7jp+QiD+O38TI96b3o4sn0ROdOthpt4ug9FZ
         Hr2pcjDlh1GJaZ8zPk4Vb8l4wHPXYaBkOKGgGUU7HAfqFPaqNM9+lYW3tyTjOud/AYXf
         51brqmv3lPSgSAVOcjcCVVXpwRfFaJjMjEhdzcPD/gadlB99wEXZePOQJCOOJR0Eja9o
         orF1cMvTQ6pHF8PtuwULMtMbLb/SEpSMWNl6jRrX5HcKOu9NCgFWL075q3oGYMoUUPp7
         MREOwrw9w7a8iKH73IpxfN4spAqwgMCMEckRmGJ2v/2yQZw6tMRvcssxQJ44Q1DkDRJZ
         hOPA==
X-Received: by 10.68.42.134 with SMTP id o6mr16627398pbl.52.1363175000864;
        Wed, 13 Mar 2013 04:43:20 -0700 (PDT)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id 1sm29258530pbg.18.2013.03.13.04.43.17
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Mar 2013 04:43:20 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Mar 2013 18:43:14 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1363174973-17597-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218049>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wt-status.c | 41 +++++++++++++++++++++++------------------
 wt-status.h |  1 +
 2 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 6cac27b..0d8989f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1001,40 +1001,45 @@ got_nothing:
 	return NULL;
 }
=20
-static void wt_status_print_state(struct wt_status *s)
+void wt_status_get_state(struct wt_status_state *state)
 {
-	const char *state_color =3D color(WT_STATUS_HEADER, s);
-	struct wt_status_state state;
 	struct stat st;
=20
-	memset(&state, 0, sizeof(state));
-
 	if (!stat(git_path("MERGE_HEAD"), &st)) {
-		state.merge_in_progress =3D 1;
+		state->merge_in_progress =3D 1;
 	} else if (!stat(git_path("rebase-apply"), &st)) {
 		if (!stat(git_path("rebase-apply/applying"), &st)) {
-			state.am_in_progress =3D 1;
+			state->am_in_progress =3D 1;
 			if (!stat(git_path("rebase-apply/patch"), &st) && !st.st_size)
-				state.am_empty_patch =3D 1;
+				state->am_empty_patch =3D 1;
 		} else {
-			state.rebase_in_progress =3D 1;
-			state.branch =3D read_and_strip_branch("rebase-apply/head-name");
-			state.onto =3D read_and_strip_branch("rebase-apply/onto");
+			state->rebase_in_progress =3D 1;
+			state->branch =3D read_and_strip_branch("rebase-apply/head-name");
+			state->onto =3D read_and_strip_branch("rebase-apply/onto");
 		}
 	} else if (!stat(git_path("rebase-merge"), &st)) {
 		if (!stat(git_path("rebase-merge/interactive"), &st))
-			state.rebase_interactive_in_progress =3D 1;
+			state->rebase_interactive_in_progress =3D 1;
 		else
-			state.rebase_in_progress =3D 1;
-		state.branch =3D read_and_strip_branch("rebase-merge/head-name");
-		state.onto =3D read_and_strip_branch("rebase-merge/onto");
+			state->rebase_in_progress =3D 1;
+		state->branch =3D read_and_strip_branch("rebase-merge/head-name");
+		state->onto =3D read_and_strip_branch("rebase-merge/onto");
 	} else if (!stat(git_path("CHERRY_PICK_HEAD"), &st)) {
-		state.cherry_pick_in_progress =3D 1;
+		state->cherry_pick_in_progress =3D 1;
 	}
 	if (!stat(git_path("BISECT_LOG"), &st)) {
-		state.bisect_in_progress =3D 1;
-		state.branch =3D read_and_strip_branch("BISECT_START");
+		state->bisect_in_progress =3D 1;
+		state->branch =3D read_and_strip_branch("BISECT_START");
 	}
+}
+
+static void wt_status_print_state(struct wt_status *s)
+{
+	const char *state_color =3D color(WT_STATUS_HEADER, s);
+	struct wt_status_state state;
+
+	memset(&state, 0, sizeof(state));
+	wt_status_get_state(&state);
=20
 	if (state.merge_in_progress)
 		show_merge_in_progress(s, &state, state_color);
diff --git a/wt-status.h b/wt-status.h
index b8c3512..5ddcbf6 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -86,6 +86,7 @@ struct wt_status_state {
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
+void wt_status_get_state(struct wt_status_state *state);
=20
 void wt_shortstatus_print(struct wt_status *s);
 void wt_porcelain_print(struct wt_status *s);
--=20
1.8.1.2.536.gf441e6d
