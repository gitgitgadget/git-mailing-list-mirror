From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/5] status: show the ref that is checked out, even if it's detached
Date: Sun,  3 Mar 2013 16:41:20 +0700
Message-ID: <1362303681-6585-5-git-send-email-pclouds@gmail.com>
References: <1362303681-6585-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 03 10:41:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UC5Q9-000115-LC
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 10:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948Ab3CCJk6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Mar 2013 04:40:58 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:47416 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842Ab3CCJk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 04:40:57 -0500
Received: by mail-pb0-f42.google.com with SMTP id xb4so2535230pbc.1
        for <git@vger.kernel.org>; Sun, 03 Mar 2013 01:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=FiCN8a3FmUFvXqq//dhC6ajPnePOLqjkargYQX4yI4k=;
        b=FqUZFNeEHyZFE/xSfqUurqB8rkmbGyos253aWI8fko4j43gNGWepiGDQxEkxygMGUu
         YTgKTDx0ZPsfpUnLKHSWS/PRTz4jJzuSplmxNF+OgiNPLewdnp7fkJx3WnUZ0B4aO58T
         q/NXolxtDx/v+jRiAusssMKoUvOztnM4iNwJL2RNvkmuHKqZfZFvfRt74Nx5sWot/Hcv
         iHN/mgqhHPYvLsnxp++AeBCggShMbpgdEZqYPMWOzG8qb45EueocUy5F41iUP4yLl61A
         2Wsny3GPA7dD2dfqE43jILE8UClhDlbB8QcKB9OwXIWB/VNIRThnDTSvXca43muPFGHX
         qKNQ==
X-Received: by 10.68.203.33 with SMTP id kn1mr22462847pbc.197.1362303657130;
        Sun, 03 Mar 2013 01:40:57 -0800 (PST)
Received: from lanh ([115.74.33.184])
        by mx.google.com with ESMTPS id o5sm19690471pay.5.2013.03.03.01.40.53
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 03 Mar 2013 01:40:56 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 03 Mar 2013 16:42:00 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1362303681-6585-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217346>

When a remote ref or a tag is checked out, HEAD is automatically
detached. There is no user friendly way to find out what ref is
checked out in this case. This patch digs in reflog for this
information and shows "Detached from origin/master" or "Detached from
v1.8.0" instead of "Currently not on any branch".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wt-status.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++----
 wt-status.h |  3 ++-
 2 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 6a3566b..4b6421a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1001,7 +1001,60 @@ static void read_and_strip_branch(struct strbuf =
*sb,
 		*branch =3D xstrdup(*branch);
 }
=20
-void wt_status_get_state(struct wt_status_state *state)
+struct grab_1st_switch_cbdata {
+	struct strbuf buf;
+	unsigned char sha1[20];
+};
+
+static int grab_1st_switch(unsigned char *osha1, unsigned char *nsha1,
+			   const char *email, unsigned long timestamp, int tz,
+			   const char *message, void *cb_data)
+{
+	struct grab_1st_switch_cbdata *cb =3D cb_data;
+	const char *target =3D NULL;
+
+	if (prefixcmp(message, "checkout: moving from "))
+		return 0;
+	message +=3D strlen("checkout: moving from ");
+	target =3D strstr(message, " to ");
+	if (!target)
+		return 0;
+	target +=3D strlen(" to ");
+	strbuf_reset(&cb->buf);
+	hashcpy(cb->sha1, nsha1);
+	if (!prefixcmp(target, "refs/")) {
+		const char *end =3D target;
+		while (*end && *end !=3D '\n')
+			end++;
+		strbuf_add(&cb->buf, target, end - target);
+	}
+	return 0;
+}
+
+static void wt_status_get_detached_from(struct wt_status_state *state)
+{
+	struct grab_1st_switch_cbdata cb;
+	struct commit *commit;
+	unsigned char sha1[20];
+
+	strbuf_init(&cb.buf, 0);
+	for_each_recent_reflog_ent("HEAD", grab_1st_switch, 40960, &cb);
+	if (cb.buf.len &&
+	    !read_ref(cb.buf.buf, sha1) &&
+	    (commit =3D lookup_commit_reference_gently(sha1, 1)) !=3D NULL &&
+	    !hashcmp(cb.sha1, commit->object.sha1)) {
+		int ofs =3D 0;
+		if (!prefixcmp(cb.buf.buf, "refs/tags/"))
+			ofs =3D strlen("refs/tags/");
+		else if (!prefixcmp(cb.buf.buf, "refs/remotes/"))
+			ofs =3D strlen("refs/remotes/");
+		state->detached_from =3D xstrdup(cb.buf.buf + ofs);
+	}
+	strbuf_release(&cb.buf);
+}
+
+void wt_status_get_state(struct wt_status_state *state,
+			 int get_detached_from)
 {
 	struct strbuf branch =3D STRBUF_INIT;
 	struct strbuf onto =3D STRBUF_INIT;
@@ -1040,6 +1093,10 @@ void wt_status_get_state(struct wt_status_state =
*state)
 		read_and_strip_branch(&branch, &state->branch,
 				      "BISECT_START");
 	}
+
+	if (get_detached_from)
+		wt_status_get_detached_from(state);
+
 	strbuf_release(&branch);
 	strbuf_release(&onto);
 }
@@ -1066,7 +1123,8 @@ void wt_status_print(struct wt_status *s)
 	const char *branch_status_color =3D color(WT_STATUS_HEADER, s);
 	struct wt_status_state state;
=20
-	wt_status_get_state(&state);
+	wt_status_get_state(&state,
+			    s->branch && !strcmp(s->branch, "HEAD"));
=20
 	if (s->branch) {
 		const char *on_what =3D _("On branch ");
@@ -1074,9 +1132,14 @@ void wt_status_print(struct wt_status *s)
 		if (!prefixcmp(branch_name, "refs/heads/"))
 			branch_name +=3D 11;
 		else if (!strcmp(branch_name, "HEAD")) {
-			branch_name =3D "";
 			branch_status_color =3D color(WT_STATUS_NOBRANCH, s);
-			on_what =3D _("Not currently on any branch.");
+			if (state.detached_from) {
+				branch_name =3D state.detached_from;
+				on_what =3D _("Detached from ");
+			} else {
+				branch_name =3D "";
+				on_what =3D _("Not currently on any branch.");
+			}
 		}
 		status_printf(s, color(WT_STATUS_HEADER, s), "");
 		status_printf_more(s, branch_status_color, "%s", on_what);
@@ -1088,6 +1151,7 @@ void wt_status_print(struct wt_status *s)
 	wt_status_print_state(s, &state);
 	free(state.branch);
 	free(state.onto);
+	free(state.detached_from);
=20
 	if (s->is_initial) {
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
diff --git a/wt-status.h b/wt-status.h
index 5ddcbf6..74c9055 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -81,12 +81,13 @@ struct wt_status_state {
 	int bisect_in_progress;
 	char *branch;
 	char *onto;
+	char *detached_from;
 };
=20
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
-void wt_status_get_state(struct wt_status_state *state);
+void wt_status_get_state(struct wt_status_state *state, int get_detach=
ed_from);
=20
 void wt_shortstatus_print(struct wt_status *s);
 void wt_porcelain_print(struct wt_status *s);
--=20
1.8.1.2.536.gf441e6d
