From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 1/9] Enable wt-status output to a given FILE pointer.
Date: Wed,  5 Sep 2007 20:23:30 -0400
Message-ID: <11890382183913-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 02:36:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT5Ld-0001k6-PF
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 02:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757190AbXIFAfq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 5 Sep 2007 20:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756945AbXIFAfp
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 20:35:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43753 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756843AbXIFAfo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 20:35:44 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l860Zi99005389
	for <git@vger.kernel.org>; Wed, 5 Sep 2007 20:35:44 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l860ZhVo032579;
	Wed, 5 Sep 2007 20:35:43 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l860ZhbV016503;
	Wed, 5 Sep 2007 20:35:43 -0400
X-Mailer: git-send-email 1.5.3.rc5.852.gc119
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57786>

Still defaults to stdout, but you can now override wt_status.fp after
calling wt_status_prepare().

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 color.c     |   18 ++++++------
 color.h     |    4 +-
 wt-status.c |   85 ++++++++++++++++++++++++++++++---------------------=
-------
 wt-status.h |    3 ++
 4 files changed, 58 insertions(+), 52 deletions(-)

diff --git a/color.c b/color.c
index 09d82ee..124ba33 100644
--- a/color.c
+++ b/color.c
@@ -135,39 +135,39 @@ int git_config_colorbool(const char *var, const c=
har *value)
 	return git_config_bool(var, value);
 }
=20
-static int color_vprintf(const char *color, const char *fmt,
+static int color_vfprintf(FILE *fp, const char *color, const char *fmt=
,
 		va_list args, const char *trail)
 {
 	int r =3D 0;
=20
 	if (*color)
-		r +=3D printf("%s", color);
-	r +=3D vprintf(fmt, args);
+		r +=3D fprintf(fp, "%s", color);
+	r +=3D vfprintf(fp, fmt, args);
 	if (*color)
-		r +=3D printf("%s", COLOR_RESET);
+		r +=3D fprintf(fp, "%s", COLOR_RESET);
 	if (trail)
-		r +=3D printf("%s", trail);
+		r +=3D fprintf(fp, "%s", trail);
 	return r;
 }
=20
=20
=20
-int color_printf(const char *color, const char *fmt, ...)
+int color_fprintf(FILE *fp, const char *color, const char *fmt, ...)
 {
 	va_list args;
 	int r;
 	va_start(args, fmt);
-	r =3D color_vprintf(color, fmt, args, NULL);
+	r =3D color_vfprintf(fp, color, fmt, args, NULL);
 	va_end(args);
 	return r;
 }
=20
-int color_printf_ln(const char *color, const char *fmt, ...)
+int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...=
)
 {
 	va_list args;
 	int r;
 	va_start(args, fmt);
-	r =3D color_vprintf(color, fmt, args, "\n");
+	r =3D color_vfprintf(fp, color, fmt, args, "\n");
 	va_end(args);
 	return r;
 }
diff --git a/color.h b/color.h
index 88bb8ff..6809800 100644
--- a/color.h
+++ b/color.h
@@ -6,7 +6,7 @@
=20
 int git_config_colorbool(const char *var, const char *value);
 void color_parse(const char *var, const char *value, char *dst);
-int color_printf(const char *color, const char *fmt, ...);
-int color_printf_ln(const char *color, const char *fmt, ...);
+int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
+int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...=
);
=20
 #endif /* COLOR_H */
diff --git a/wt-status.c b/wt-status.c
index 5205420..65a7259 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -52,31 +52,33 @@ void wt_status_prepare(struct wt_status *s)
 	head =3D resolve_ref("HEAD", sha1, 0, NULL);
 	s->branch =3D head ? xstrdup(head) : NULL;
 	s->reference =3D "HEAD";
+	s->fp =3D stdout;
 }
=20
-static void wt_status_print_cached_header(const char *reference)
+static void wt_status_print_cached_header(struct wt_status *s)
 {
 	const char *c =3D color(WT_STATUS_HEADER);
-	color_printf_ln(c, "# Changes to be committed:");
-	if (reference) {
-		color_printf_ln(c, "#   (use \"git reset %s <file>...\" to unstage)"=
, reference);
+	color_fprintf_ln(s->fp, c, "# Changes to be committed:");
+	if (s->reference) {
+		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to u=
nstage)", s->reference);
 	} else {
-		color_printf_ln(c, "#   (use \"git rm --cached <file>...\" to unstag=
e)");
+		color_fprintf_ln(s->fp, c, "#   (use \"git rm --cached <file>...\" t=
o unstage)");
 	}
-	color_printf_ln(c, "#");
+	color_fprintf_ln(s->fp, c, "#");
 }
=20
-static void wt_status_print_header(const char *main, const char *sub)
+static void wt_status_print_header(struct wt_status *s,
+				   const char *main, const char *sub)
 {
 	const char *c =3D color(WT_STATUS_HEADER);
-	color_printf_ln(c, "# %s:", main);
-	color_printf_ln(c, "#   (%s)", sub);
-	color_printf_ln(c, "#");
+	color_fprintf_ln(s->fp, c, "# %s:", main);
+	color_fprintf_ln(s->fp, c, "#   (%s)", sub);
+	color_fprintf_ln(s->fp, c, "#");
 }
=20
-static void wt_status_print_trailer(void)
+static void wt_status_print_trailer(struct wt_status *s)
 {
-	color_printf_ln(color(WT_STATUS_HEADER), "#");
+	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
 }
=20
 static const char *quote_crlf(const char *in, char *buf, size_t sz)
@@ -108,7 +110,8 @@ static const char *quote_crlf(const char *in, char =
*buf, size_t sz)
 	return ret;
 }
=20
-static void wt_status_print_filepair(int t, struct diff_filepair *p)
+static void wt_status_print_filepair(struct wt_status *s,
+				     int t, struct diff_filepair *p)
 {
 	const char *c =3D color(t);
 	const char *one, *two;
@@ -117,36 +120,36 @@ static void wt_status_print_filepair(int t, struc=
t diff_filepair *p)
 	one =3D quote_crlf(p->one->path, onebuf, sizeof(onebuf));
 	two =3D quote_crlf(p->two->path, twobuf, sizeof(twobuf));
=20
-	color_printf(color(WT_STATUS_HEADER), "#\t");
+	color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
 	switch (p->status) {
 	case DIFF_STATUS_ADDED:
-		color_printf(c, "new file:   %s", one);
+		color_fprintf(s->fp, c, "new file:   %s", one);
 		break;
 	case DIFF_STATUS_COPIED:
-		color_printf(c, "copied:     %s -> %s", one, two);
+		color_fprintf(s->fp, c, "copied:     %s -> %s", one, two);
 		break;
 	case DIFF_STATUS_DELETED:
-		color_printf(c, "deleted:    %s", one);
+		color_fprintf(s->fp, c, "deleted:    %s", one);
 		break;
 	case DIFF_STATUS_MODIFIED:
-		color_printf(c, "modified:   %s", one);
+		color_fprintf(s->fp, c, "modified:   %s", one);
 		break;
 	case DIFF_STATUS_RENAMED:
-		color_printf(c, "renamed:    %s -> %s", one, two);
+		color_fprintf(s->fp, c, "renamed:    %s -> %s", one, two);
 		break;
 	case DIFF_STATUS_TYPE_CHANGED:
-		color_printf(c, "typechange: %s", one);
+		color_fprintf(s->fp, c, "typechange: %s", one);
 		break;
 	case DIFF_STATUS_UNKNOWN:
-		color_printf(c, "unknown:    %s", one);
+		color_fprintf(s->fp, c, "unknown:    %s", one);
 		break;
 	case DIFF_STATUS_UNMERGED:
-		color_printf(c, "unmerged:   %s", one);
+		color_fprintf(s->fp, c, "unmerged:   %s", one);
 		break;
 	default:
 		die("bug: unhandled diff status %c", p->status);
 	}
-	printf("\n");
+	fprintf(s->fp, "\n");
 }
=20
 static void wt_status_print_updated_cb(struct diff_queue_struct *q,
@@ -160,14 +163,14 @@ static void wt_status_print_updated_cb(struct dif=
f_queue_struct *q,
 		if (q->queue[i]->status =3D=3D 'U')
 			continue;
 		if (!shown_header) {
-			wt_status_print_cached_header(s->reference);
+			wt_status_print_cached_header(s);
 			s->commitable =3D 1;
 			shown_header =3D 1;
 		}
-		wt_status_print_filepair(WT_STATUS_UPDATED, q->queue[i]);
+		wt_status_print_filepair(s, WT_STATUS_UPDATED, q->queue[i]);
 	}
 	if (shown_header)
-		wt_status_print_trailer();
+		wt_status_print_trailer(s);
 }
=20
 static void wt_status_print_changed_cb(struct diff_queue_struct *q,
@@ -184,12 +187,12 @@ static void wt_status_print_changed_cb(struct dif=
f_queue_struct *q,
 				msg =3D use_add_rm_msg;
 				break;
 			}
-		wt_status_print_header("Changed but not updated", msg);
+		wt_status_print_header(s, "Changed but not updated", msg);
 	}
 	for (i =3D 0; i < q->nr; i++)
-		wt_status_print_filepair(WT_STATUS_CHANGED, q->queue[i]);
+		wt_status_print_filepair(s, WT_STATUS_CHANGED, q->queue[i]);
 	if (q->nr)
-		wt_status_print_trailer();
+		wt_status_print_trailer(s);
 }
=20
 static void wt_read_cache(struct wt_status *s)
@@ -206,16 +209,16 @@ static void wt_status_print_initial(struct wt_sta=
tus *s)
 	wt_read_cache(s);
 	if (active_nr) {
 		s->commitable =3D 1;
-		wt_status_print_cached_header(NULL);
+		wt_status_print_cached_header(s);
 	}
 	for (i =3D 0; i < active_nr; i++) {
-		color_printf(color(WT_STATUS_HEADER), "#\t");
-		color_printf_ln(color(WT_STATUS_UPDATED), "new file: %s",
+		color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
+		color_fprintf_ln(s->fp, color(WT_STATUS_UPDATED), "new file: %s",
 				quote_crlf(active_cache[i]->name,
 					   buf, sizeof(buf)));
 	}
 	if (active_nr)
-		wt_status_print_trailer();
+		wt_status_print_trailer(s);
 }
=20
 static void wt_status_print_updated(struct wt_status *s)
@@ -281,12 +284,12 @@ static void wt_status_print_untracked(struct wt_s=
tatus *s)
 		}
 		if (!shown_header) {
 			s->workdir_untracked =3D 1;
-			wt_status_print_header("Untracked files",
+			wt_status_print_header(s, "Untracked files",
 					       use_add_to_include_msg);
 			shown_header =3D 1;
 		}
-		color_printf(color(WT_STATUS_HEADER), "#\t");
-		color_printf_ln(color(WT_STATUS_UNTRACKED), "%.*s",
+		color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
+		color_fprintf_ln(s->fp, color(WT_STATUS_UNTRACKED), "%.*s",
 				ent->len, ent->name);
 	}
 }
@@ -316,14 +319,14 @@ void wt_status_print(struct wt_status *s)
 			branch_name =3D "";
 			on_what =3D "Not currently on any branch.";
 		}
-		color_printf_ln(color(WT_STATUS_HEADER),
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER),
 			"# %s%s", on_what, branch_name);
 	}
=20
 	if (s->is_initial) {
-		color_printf_ln(color(WT_STATUS_HEADER), "#");
-		color_printf_ln(color(WT_STATUS_HEADER), "# Initial commit");
-		color_printf_ln(color(WT_STATUS_HEADER), "#");
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "# Initial commit")=
;
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
 		wt_status_print_initial(s);
 	}
 	else {
@@ -337,7 +340,7 @@ void wt_status_print(struct wt_status *s)
 		wt_status_print_verbose(s);
 	if (!s->commitable) {
 		if (s->amend)
-			printf("# No changes\n");
+			fprintf(s->fp, "# No changes\n");
 		else if (s->workdir_dirty)
 			printf("no changes added to commit (use \"git add\" and/or \"git co=
mmit -a\")\n");
 		else if (s->workdir_untracked)
diff --git a/wt-status.h b/wt-status.h
index cfea4ae..4f3a615 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -1,6 +1,8 @@
 #ifndef STATUS_H
 #define STATUS_H
=20
+#include <stdio.h>
+
 enum color_wt_status {
 	WT_STATUS_HEADER,
 	WT_STATUS_UPDATED,
@@ -19,6 +21,7 @@ struct wt_status {
 	int commitable;
 	int workdir_dirty;
 	int workdir_untracked;
+	FILE *fp;
 };
=20
 int git_status_config(const char *var, const char *value);
--=20
1.5.2.GIT
