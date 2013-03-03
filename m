From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/5] wt-status: split wt_status_state parsing function out
Date: Sun,  3 Mar 2013 16:41:18 +0700
Message-ID: <1362303681-6585-3-git-send-email-pclouds@gmail.com>
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
	id 1UC5Q8-000115-NW
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 10:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074Ab3CCJkq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Mar 2013 04:40:46 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35528 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934Ab3CCJkn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 04:40:43 -0500
Received: by mail-pa0-f43.google.com with SMTP id bh2so2613167pad.2
        for <git@vger.kernel.org>; Sun, 03 Mar 2013 01:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=aZ553Bvc/rarAfnf8XjMGg8HIwviT07QggMElq05YRw=;
        b=jgy/zlklSSs2hlIJXIeaL2EJqXKwd9vFJxX8Jwq7bzHOVkSF7TsxyaTTQlUj/c07Hv
         6ScQV/bjOOw9lX8MURffXEJnxzh1Ln02fwZbfTVEBSZjajUGU7NZ2mf851xVshNy4Ipi
         KRJlAy1/t9s4ndD3sbIsrc0UrcifvY0g9mgINQPAPFvNLX1+G2v0KliWtNttfyQ2LDge
         NSR78yMfLUJ3eNxR6+zaFSQTMh2kfg8bgo8r6BEOxVumamR3KEvsWmdmiyifoWRYEvr/
         MSVxv9FM1nGVMnnTnVwKkw5wO/SIrSAyfMqY7vkyqcOB3gN73fxXuynXDFf4kHkYb4/L
         8D/Q==
X-Received: by 10.66.250.169 with SMTP id zd9mr27320063pac.134.1362303643513;
        Sun, 03 Mar 2013 01:40:43 -0800 (PST)
Received: from lanh ([115.74.33.184])
        by mx.google.com with ESMTPS id z6sm19663684paw.20.2013.03.03.01.40.39
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 03 Mar 2013 01:40:42 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 03 Mar 2013 16:41:47 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1362303681-6585-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217344>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wt-status.c | 52 +++++++++++++++++++++++++++++++---------------------
 wt-status.h |  5 +++--
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index ef405d0..183aafe 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -970,7 +970,7 @@ static void show_bisect_in_progress(struct wt_statu=
s *s,
  * Extract branch information from rebase/bisect
  */
 static void read_and_strip_branch(struct strbuf *sb,
-				  const char **branch,
+				  char **branch,
 				  const char *path)
 {
 	unsigned char sha1[20];
@@ -994,52 +994,62 @@ static void read_and_strip_branch(struct strbuf *=
sb,
 		strbuf_addstr(sb, abbrev);
 		*branch =3D sb->buf;
 	} else if (!strcmp(sb->buf, "detached HEAD")) /* rebase */
-		;
+		*branch =3D NULL;
 	else			/* bisect */
 		*branch =3D sb->buf;
+	if (*branch)
+		*branch =3D xstrdup(*branch);
 }
=20
-static void wt_status_print_state(struct wt_status *s)
+void wt_status_get_state(struct wt_status_state *state)
 {
-	const char *state_color =3D color(WT_STATUS_HEADER, s);
 	struct strbuf branch =3D STRBUF_INIT;
 	struct strbuf onto =3D STRBUF_INIT;
-	struct wt_status_state state;
 	struct stat st;
=20
-	memset(&state, 0, sizeof(state));
+	memset(state, 0, sizeof(*state));
=20
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
-			read_and_strip_branch(&branch, &state.branch,
+			state->rebase_in_progress =3D 1;
+			read_and_strip_branch(&branch, &state->branch,
 					      "rebase-apply/head-name");
-			read_and_strip_branch(&onto, &state.onto,
+			read_and_strip_branch(&onto, &state->onto,
 					      "rebase-apply/onto");
 		}
 	} else if (!stat(git_path("rebase-merge"), &st)) {
 		if (!stat(git_path("rebase-merge/interactive"), &st))
-			state.rebase_interactive_in_progress =3D 1;
+			state->rebase_interactive_in_progress =3D 1;
 		else
-			state.rebase_in_progress =3D 1;
-		read_and_strip_branch(&branch, &state.branch,
+			state->rebase_in_progress =3D 1;
+		read_and_strip_branch(&branch, &state->branch,
 				      "rebase-merge/head-name");
-		read_and_strip_branch(&onto, &state.onto,
+		read_and_strip_branch(&onto, &state->onto,
 				      "rebase-merge/onto");
 	} else if (!stat(git_path("CHERRY_PICK_HEAD"), &st)) {
-		state.cherry_pick_in_progress =3D 1;
+		state->cherry_pick_in_progress =3D 1;
 	}
 	if (!stat(git_path("BISECT_LOG"), &st)) {
-		state.bisect_in_progress =3D 1;
-		read_and_strip_branch(&branch, &state.branch,
+		state->bisect_in_progress =3D 1;
+		read_and_strip_branch(&branch, &state->branch,
 				      "BISECT_START");
 	}
+	strbuf_release(&branch);
+	strbuf_release(&onto);
+}
+
+static void wt_status_print_state(struct wt_status *s)
+{
+	const char *state_color =3D color(WT_STATUS_HEADER, s);
+	struct wt_status_state state;
+
+	wt_status_get_state(&state);
=20
 	if (state.merge_in_progress)
 		show_merge_in_progress(s, &state, state_color);
@@ -1051,8 +1061,8 @@ static void wt_status_print_state(struct wt_statu=
s *s)
 		show_cherry_pick_in_progress(s, &state, state_color);
 	if (state.bisect_in_progress)
 		show_bisect_in_progress(s, &state, state_color);
-	strbuf_release(&branch);
-	strbuf_release(&onto);
+	free(state.branch);
+	free(state.onto);
 }
=20
 void wt_status_print(struct wt_status *s)
diff --git a/wt-status.h b/wt-status.h
index 81e1dcf..5ddcbf6 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -79,13 +79,14 @@ struct wt_status_state {
 	int rebase_interactive_in_progress;
 	int cherry_pick_in_progress;
 	int bisect_in_progress;
-	const char *branch;
-	const char *onto;
+	char *branch;
+	char *onto;
 };
=20
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
+void wt_status_get_state(struct wt_status_state *state);
=20
 void wt_shortstatus_print(struct wt_status *s);
 void wt_porcelain_print(struct wt_status *s);
--=20
1.8.1.2.536.gf441e6d
