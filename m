From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/4] Unify appending signoff in format-patch, commit and sequencer
Date: Thu, 22 Nov 2012 23:38:09 +0700
Message-ID: <1353602289-9418-5-git-send-email-pclouds@gmail.com>
References: <CACsJy8BiJRK7N3_HZ2WXpMd1YkDSW00AxuYqiCWJgij+Kq6AiQ@mail.gmail.com>
 <1353602289-9418-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 20:17:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbcGw-000201-7z
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 20:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117Ab2KVTQx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2012 14:16:53 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59084 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940Ab2KVTQv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 14:16:51 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so6043679pbc.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 11:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KdnFaIcyNxJrUxbS0KEPpvVi9I+cZDZl57BhP996juE=;
        b=rJEhGrwV/5KcA5JQVH7fxon0xRQysEbUb1ZjBEcHC4fs45IGoJ7+a/AtmRDnUd8gVZ
         cxj6OhtX0RGpTw3GcP6uDDUZHQ9/jpfu9+dsP/I5ZMNjX9ryHrsm200MOsM46R15kkq9
         qXjNBIFXlJDPe53333NlKbpdhTDKdFb9Vu7bU1Ruc0yyVeg8iaumTXGgKfkkUvcSDFJG
         QaWbPCrYmj7Ylp59AX52wAJkPpYckIqq1LKIEVuL79Ly/QDoQn8dr9C7jdTMZIhbf5Hp
         AiExlHFPVys/2dyO3OHGHw7602e6mIEdw91o/LrTCT4Tv0JkvNQ2Hq/SepVKK4gSDqXh
         RrUg==
Received: by 10.66.78.6 with SMTP id x6mr2736127paw.45.1353602307193;
        Thu, 22 Nov 2012 08:38:27 -0800 (PST)
Received: from lanh ([115.74.40.93])
        by mx.google.com with ESMTPS id nm9sm2294140pbc.46.2012.11.22.08.38.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Nov 2012 08:38:25 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 22 Nov 2012 23:38:37 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1353602289-9418-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210193>

There are two implementations of append_signoff in log-tree.c and
sequencer.c, which do more or less the same thing. This patch removes
the sequencer.c's in favor of the format-patch's.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c  | 10 ++++++++-
 log-tree.c        | 14 ++++++++----
 log-tree.h        |  4 ++++
 sequencer.c       | 65 ++---------------------------------------------=
--------
 sequencer.h       |  4 ----
 t/t7501-commit.sh |  2 +-
 6 files changed, 26 insertions(+), 73 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a17a5df..6d323d9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -698,7 +698,15 @@ static int prepare_to_commit(const char *index_fil=
e, const char *prefix,
 			previous =3D eol;
 		}
=20
-		append_signoff(&sb, ignore_footer);
+		if (ignore_footer) {
+			struct strbuf footer =3D STRBUF_INIT;
+			strbuf_addstr(&footer, sb.buf + sb.len - ignore_footer);
+			strbuf_setlen(&sb, sb.len - ignore_footer);
+			append_signoff(&sb, SOB_IGNORE_SAME);
+			strbuf_addstr(&sb, footer.buf);
+			strbuf_release(&footer);
+		} else
+			append_signoff(&sb, SOB_IGNORE_SAME);
 	}
=20
 	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
diff --git a/log-tree.c b/log-tree.c
index 7e50545..e8d31d9 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -12,6 +12,8 @@
=20
 struct decoration name_decoration =3D { "object names" };
=20
+const char sign_off_header[] =3D "Signed-off-by: ";
+
 enum decoration_type {
 	DECORATION_NONE =3D 0,
 	DECORATION_REF_LOCAL,
@@ -207,7 +209,7 @@ void show_decorations(struct rev_info *opt, struct =
commit *commit)
 }
=20
 /*
- * Search for "^[-A-Za-z]+: [^@]+@" pattern. It usually matches
+ * Search for "^[-A-Za-z0-9]+: [^@]+@" pattern. It usually matches
  * Signed-off-by: and Acked-by: lines.
  */
 static int detect_any_signoff(char *letter, int size)
@@ -243,6 +245,7 @@ static int detect_any_signoff(char *letter, int siz=
e)
 		}
 		if (('A' <=3D ch && ch <=3D 'Z') ||
 		    ('a' <=3D ch && ch <=3D 'z') ||
+		    ('0' <=3D ch && ch <=3D '9') ||
 		    ch =3D=3D '-') {
 			seen_head =3D 1;
 			continue;
@@ -253,11 +256,10 @@ static int detect_any_signoff(char *letter, int s=
ize)
 	return seen_head && seen_name;
 }
=20
-static void append_signoff(struct strbuf *sb, int flags)
+void append_signoff(struct strbuf *sb, int flags)
 {
 	char* signoff =3D xstrdup(fmt_name(getenv("GIT_COMMITTER_NAME"),
 					 getenv("GIT_COMMITTER_EMAIL")));
-	static const char sign_off_header[] =3D "Signed-off-by: ";
 	size_t signoff_len =3D strlen(signoff);
 	int has_signoff =3D 0;
 	char *cp;
@@ -310,7 +312,11 @@ static void append_signoff(struct strbuf *sb, int =
flags)
 		if (!isspace(cp[signoff_len]))
 			continue;
 		/* we already have him */
-		return;
+		if (flags & SOB_IGNORE_SAME) {
+			if (cp[signoff_len + 1] =3D=3D '\0')
+				return;
+		} else
+			return;
 	}
=20
 	if (!has_signoff)
diff --git a/log-tree.h b/log-tree.h
index f5ac238..739f729 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -24,4 +24,8 @@ void load_ref_decorations(int flags);
 void get_patch_filename(struct commit *commit, const char *subject, in=
t nr,
 			const char *suffix, struct strbuf *buf);
=20
+#define SOB_IGNORE_SAME   1
+extern const char sign_off_header[];
+void append_signoff(struct strbuf *msgbuf, int flags);
+
 #endif
diff --git a/sequencer.c b/sequencer.c
index e3723d2..bc02a66 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -14,11 +14,10 @@
 #include "merge-recursive.h"
 #include "refs.h"
 #include "argv-array.h"
+#include "log-tree.h"
=20
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
=20
-const char sign_off_header[] =3D "Signed-off-by: ";
-
 static void remove_sequencer_state(void)
 {
 	struct strbuf seq_dir =3D STRBUF_INIT;
@@ -236,7 +235,7 @@ static int do_recursive_merge(struct commit *base, =
struct commit *next,
 	rollback_lock_file(&index_lock);
=20
 	if (opts->signoff)
-		append_signoff(msgbuf, 0);
+		append_signoff(msgbuf, SOB_IGNORE_SAME);
=20
 	if (!clean) {
 		int i;
@@ -1016,63 +1015,3 @@ int sequencer_pick_revisions(struct replay_opts =
*opts)
 	save_opts(opts);
 	return pick_commits(todo_list, opts);
 }
-
-static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
-{
-	int ch;
-	int hit =3D 0;
-	int i, j, k;
-	int len =3D sb->len - ignore_footer;
-	int first =3D 1;
-	const char *buf =3D sb->buf;
-
-	for (i =3D len - 1; i > 0; i--) {
-		if (hit && buf[i] =3D=3D '\n')
-			break;
-		hit =3D (buf[i] =3D=3D '\n');
-	}
-
-	while (i < len - 1 && buf[i] =3D=3D '\n')
-		i++;
-
-	for (; i < len; i =3D k) {
-		for (k =3D i; k < len && buf[k] !=3D '\n'; k++)
-			; /* do nothing */
-		k++;
-
-		if ((buf[k] =3D=3D ' ' || buf[k] =3D=3D '\t') && !first)
-			continue;
-
-		first =3D 0;
-
-		for (j =3D 0; i + j < len; j++) {
-			ch =3D buf[i + j];
-			if (ch =3D=3D ':')
-				break;
-			if (isalnum(ch) ||
-			    (ch =3D=3D '-'))
-				continue;
-			return 0;
-		}
-	}
-	return 1;
-}
-
-void append_signoff(struct strbuf *msgbuf, int ignore_footer)
-{
-	struct strbuf sob =3D STRBUF_INIT;
-	int i;
-
-	strbuf_addstr(&sob, sign_off_header);
-	strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
-				getenv("GIT_COMMITTER_EMAIL")));
-	strbuf_addch(&sob, '\n');
-	for (i =3D msgbuf->len - 1 - ignore_footer; i > 0 && msgbuf->buf[i - =
1] !=3D '\n'; i--)
-		; /* do nothing */
-	if (prefixcmp(msgbuf->buf + i, sob.buf)) {
-		if (!i || !ends_rfc2822_footer(msgbuf, ignore_footer))
-			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
-		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, sob.buf, sob.l=
en);
-	}
-	strbuf_release(&sob);
-}
diff --git a/sequencer.h b/sequencer.h
index 9d57d57..99eb7fa 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -46,8 +46,4 @@ struct replay_opts {
=20
 int sequencer_pick_revisions(struct replay_opts *opts);
=20
-extern const char sign_off_header[];
-
-void append_signoff(struct strbuf *msgbuf, int ignore_footer);
-
 #endif
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 195e747..6dd4580 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -353,7 +353,7 @@ test_expect_success 'signoff gap' '
=20
 	echo 3 >positive &&
 	git add positive &&
-	alt=3D"Alt-RFC-822-Header: Value" &&
+	alt=3D"Alt-RFC-822-Header: Va@lue" &&
 	git commit -s -m "welcome
=20
 $alt" &&
--=20
1.8.0.4.g5d0415a
