From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3+ 1/5] wt-status: move strbuf into read_and_strip_branch()
Date: Sat, 16 Mar 2013 09:12:36 +0700
Message-ID: <1363399956-13325-1-git-send-email-pclouds@gmail.com>
References: <1363174973-17597-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 16 03:13:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGgcY-0005K7-3V
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 03:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201Ab3CPCMv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 22:12:51 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:44905 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932145Ab3CPCMu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 22:12:50 -0400
Received: by mail-pb0-f42.google.com with SMTP id xb4so4534280pbc.29
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 19:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Ky6O1L5dIXCTYIq4apdKi65w7rqFRGbbWO4c3xQ1M10=;
        b=rqAp2tALH7D/7LvETCXjb+KIbaK0OAXqy7jrw1i5dHQZADdAAGr40wq8/wP22oStaZ
         lVcKppsugyGxDMFn5llHpkuJEN3mdU+LK7hNcFa72xKrh00mzi52EwX6a5a11mapP57V
         f0rguXvIF01Q6jMz9FFYO4YeXAT4D8+l1c3vIVQ+GooA0wFAvKjDEg70Slw5XNQ4luJ1
         v0xMLduh3u8xBFf6Sq/d+hvil3UMEz+tgFb6TaLMwyhgeUGVnkJa1D2pltI3kP59Jzyq
         qq1tmgtfLNr6xD62KzBZgylQr446K4d4EVaecSeWYHQCgXTE9yYWV6zcdAi2UEXZl2Ft
         Cppw==
X-Received: by 10.68.222.73 with SMTP id qk9mr21326555pbc.115.1363399969983;
        Fri, 15 Mar 2013 19:12:49 -0700 (PDT)
Received: from lanh ([115.74.58.84])
        by mx.google.com with ESMTPS id kb3sm11461786pbc.21.2013.03.15.19.12.46
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 15 Mar 2013 19:12:49 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 16 Mar 2013 09:12:43 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1363174973-17597-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218272>

The strbufs are placed outside read_and_strip_branch as a premature
optimization: when it reads "refs/heads/foo" to strbuf and wants to
return just "foo", it could do so without memory movement. In return
the caller must not use the returned pointer after releasing strbufs,
which own the buffers that contain the returned strings. It's a clumsy
design.

By moving strbufs into read_and_strip_branch(), the returned pointer
always points to a malloc'd buffer or NULL. The pointer can be passed
around and freed after use.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Fixed the commit message. No code change.

 wt-status.c | 65 ++++++++++++++++++++++++++++-------------------------=
--------
 wt-status.h |  4 ++--
 2 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index ef405d0..6cac27b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -969,41 +969,41 @@ static void show_bisect_in_progress(struct wt_sta=
tus *s,
 /*
  * Extract branch information from rebase/bisect
  */
-static void read_and_strip_branch(struct strbuf *sb,
-				  const char **branch,
-				  const char *path)
+static char *read_and_strip_branch(const char *path)
 {
+	struct strbuf sb =3D STRBUF_INIT;
 	unsigned char sha1[20];
=20
-	strbuf_reset(sb);
-	if (strbuf_read_file(sb, git_path("%s", path), 0) <=3D 0)
-		return;
+	if (strbuf_read_file(&sb, git_path("%s", path), 0) <=3D 0)
+		goto got_nothing;
=20
-	while (sb->len && sb->buf[sb->len - 1] =3D=3D '\n')
-		strbuf_setlen(sb, sb->len - 1);
-	if (!sb->len)
-		return;
-	if (!prefixcmp(sb->buf, "refs/heads/"))
-		*branch =3D sb->buf + strlen("refs/heads/");
-	else if (!prefixcmp(sb->buf, "refs/"))
-		*branch =3D sb->buf;
-	else if (!get_sha1_hex(sb->buf, sha1)) {
+	while (&sb.len && sb.buf[sb.len - 1] =3D=3D '\n')
+		strbuf_setlen(&sb, sb.len - 1);
+	if (!sb.len)
+		goto got_nothing;
+	if (!prefixcmp(sb.buf, "refs/heads/"))
+		strbuf_remove(&sb,0, strlen("refs/heads/"));
+	else if (!prefixcmp(sb.buf, "refs/"))
+		;
+	else if (!get_sha1_hex(sb.buf, sha1)) {
 		const char *abbrev;
 		abbrev =3D find_unique_abbrev(sha1, DEFAULT_ABBREV);
-		strbuf_reset(sb);
-		strbuf_addstr(sb, abbrev);
-		*branch =3D sb->buf;
-	} else if (!strcmp(sb->buf, "detached HEAD")) /* rebase */
-		;
+		strbuf_reset(&sb);
+		strbuf_addstr(&sb, abbrev);
+	} else if (!strcmp(sb.buf, "detached HEAD")) /* rebase */
+		goto got_nothing;
 	else			/* bisect */
-		*branch =3D sb->buf;
+		;
+	return strbuf_detach(&sb, NULL);
+
+got_nothing:
+	strbuf_release(&sb);
+	return NULL;
 }
=20
 static void wt_status_print_state(struct wt_status *s)
 {
 	const char *state_color =3D color(WT_STATUS_HEADER, s);
-	struct strbuf branch =3D STRBUF_INIT;
-	struct strbuf onto =3D STRBUF_INIT;
 	struct wt_status_state state;
 	struct stat st;
=20
@@ -1018,27 +1018,22 @@ static void wt_status_print_state(struct wt_sta=
tus *s)
 				state.am_empty_patch =3D 1;
 		} else {
 			state.rebase_in_progress =3D 1;
-			read_and_strip_branch(&branch, &state.branch,
-					      "rebase-apply/head-name");
-			read_and_strip_branch(&onto, &state.onto,
-					      "rebase-apply/onto");
+			state.branch =3D read_and_strip_branch("rebase-apply/head-name");
+			state.onto =3D read_and_strip_branch("rebase-apply/onto");
 		}
 	} else if (!stat(git_path("rebase-merge"), &st)) {
 		if (!stat(git_path("rebase-merge/interactive"), &st))
 			state.rebase_interactive_in_progress =3D 1;
 		else
 			state.rebase_in_progress =3D 1;
-		read_and_strip_branch(&branch, &state.branch,
-				      "rebase-merge/head-name");
-		read_and_strip_branch(&onto, &state.onto,
-				      "rebase-merge/onto");
+		state.branch =3D read_and_strip_branch("rebase-merge/head-name");
+		state.onto =3D read_and_strip_branch("rebase-merge/onto");
 	} else if (!stat(git_path("CHERRY_PICK_HEAD"), &st)) {
 		state.cherry_pick_in_progress =3D 1;
 	}
 	if (!stat(git_path("BISECT_LOG"), &st)) {
 		state.bisect_in_progress =3D 1;
-		read_and_strip_branch(&branch, &state.branch,
-				      "BISECT_START");
+		state.branch =3D read_and_strip_branch("BISECT_START");
 	}
=20
 	if (state.merge_in_progress)
@@ -1051,8 +1046,8 @@ static void wt_status_print_state(struct wt_statu=
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
index 81e1dcf..b8c3512 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -79,8 +79,8 @@ struct wt_status_state {
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
--=20
1.8.2.83.gc99314b
