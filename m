From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] Allow to print diffstat in English regardless current locale
Date: Sun, 26 Aug 2012 02:26:55 +0700
Message-ID: <1345922816-20616-2-git-send-email-pclouds@gmail.com>
References: <1345922816-20616-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 25 21:34:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5M7L-0007SI-1T
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 21:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757393Ab2HYTdg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Aug 2012 15:33:36 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44666 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757332Ab2HYTdU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 15:33:20 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so5316467pbb.19
        for <git@vger.kernel.org>; Sat, 25 Aug 2012 12:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=iTZwjC1uWdTriLKOcHFlktNIz0Fb/0FXGawcwkUll4s=;
        b=gT+UFy/IAEFWIoJraKgWRA2uVm0YXCXyx8h4WTjw/zHiSPNPRUUhRv387IP2Nxietw
         RfLRCMWTwXmlblh0IRwfVKrcUyxiaISF1974v8EkVpHWNXvKSmgRhEDoGEtXgx1tOxV8
         nW1jE8CWmXOkij5SgzR1r6OqGrRIiisXXK7JOqiOF18knxHFg14gBxYB+X4rj9EGbao3
         L0btzMoNrz1AqN5cKrMaYTiA5ks676iekzFibOOUYLBUCj8SdCFxiwaHwbkwuq9D1Hxk
         X2abePTLLiosC9IZPaKkz5HhJA52zaWF2BDsVxm5m2Fs9seF2ybwzsFldpAOlvJFhL0L
         oRpw==
Received: by 10.66.76.106 with SMTP id j10mr10650359paw.51.1345923200456;
        Sat, 25 Aug 2012 12:33:20 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.35.79])
        by mx.google.com with ESMTPS id jz10sm1913203pbc.8.2012.08.25.12.33.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Aug 2012 12:33:19 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 26 Aug 2012 02:27:12 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345922816-20616-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204283>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/apply.c |  2 +-
 diff.c          | 19 ++++++++++++-------
 diff.h          |  2 +-
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index d453c83..3f2779f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3627,7 +3627,7 @@ static void stat_patch_list(struct patch *patch)
 		show_stats(patch);
 	}
=20
-	print_stat_summary(stdout, files, adds, dels);
+	print_stat_summary(stdout, 0, files, adds, dels);
 }
=20
 static void numstat_patch_list(struct patch *patch)
diff --git a/diff.c b/diff.c
index 95706a5..47d7e50 100644
--- a/diff.c
+++ b/diff.c
@@ -1390,18 +1390,21 @@ static void fill_print_name(struct diffstat_fil=
e *file)
 	file->print_name =3D pname;
 }
=20
-int print_stat_summary(FILE *fp, int files, int insertions, int deleti=
ons)
+int print_stat_summary(FILE *fp, int no_l10n, int files,
+		       int insertions, int deletions)
 {
+#define C_(s) (no_l10n ? s : _(s))
+#define CQ_(s1, s2, num) (no_l10n ? (num =3D=3D 1 ? s1 : s2) : Q_(s1, =
s2, num))
 	struct strbuf sb =3D STRBUF_INIT;
 	int ret;
=20
 	if (!files) {
 		assert(insertions =3D=3D 0 && deletions =3D=3D 0);
-		return fprintf(fp, "%s\n", _(" 0 files changed"));
+		return fprintf(fp, "%s\n", C_(" 0 files changed"));
 	}
=20
 	strbuf_addf(&sb,
-		    Q_(" %d file changed", " %d files changed", files),
+		    CQ_(" %d file changed", " %d files changed", files),
 		    files);
=20
 	/*
@@ -1418,7 +1421,7 @@ int print_stat_summary(FILE *fp, int files, int i=
nsertions, int deletions)
 		 * do not translate it.
 		 */
 		strbuf_addf(&sb,
-			    Q_(", %d insertion(+)", ", %d insertions(+)",
+			    CQ_(", %d insertion(+)", ", %d insertions(+)",
 			       insertions),
 			    insertions);
 	}
@@ -1429,7 +1432,7 @@ int print_stat_summary(FILE *fp, int files, int i=
nsertions, int deletions)
 		 * do not translate it.
 		 */
 		strbuf_addf(&sb,
-			    Q_(", %d deletion(-)", ", %d deletions(-)",
+			    CQ_(", %d deletion(-)", ", %d deletions(-)",
 			       deletions),
 			    deletions);
 	}
@@ -1437,6 +1440,8 @@ int print_stat_summary(FILE *fp, int files, int i=
nsertions, int deletions)
 	ret =3D fputs(sb.buf, fp);
 	strbuf_release(&sb);
 	return ret;
+#undef C_
+#undef CQ_
 }
=20
 static void show_stats(struct diffstat_t *data, struct diff_options *o=
ptions)
@@ -1682,7 +1687,7 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 		extra_shown =3D 1;
 	}
 	fprintf(options->file, "%s", line_prefix);
-	print_stat_summary(options->file, total_files, adds, dels);
+	print_stat_summary(options->file, 0, total_files, adds, dels);
 }
=20
 static void show_shortstats(struct diffstat_t *data, struct diff_optio=
ns *options)
@@ -1711,7 +1716,7 @@ static void show_shortstats(struct diffstat_t *da=
ta, struct diff_options *option
 				options->output_prefix_data);
 		fprintf(options->file, "%s", msg->buf);
 	}
-	print_stat_summary(options->file, total_files, adds, dels);
+	print_stat_summary(options->file, 0, total_files, adds, dels);
 }
=20
 static void show_numstat(struct diffstat_t *data, struct diff_options =
*options)
diff --git a/diff.h b/diff.h
index e027650..eec79ef 100644
--- a/diff.h
+++ b/diff.h
@@ -329,7 +329,7 @@ extern struct userdiff_driver *get_textconv(struct =
diff_filespec *one);
=20
 extern int parse_rename_score(const char **cp_p);
=20
-extern int print_stat_summary(FILE *fp, int files,
+extern int print_stat_summary(FILE *fp, int no_l10n, int files,
 			      int insertions, int deletions);
=20
 #endif /* DIFF_H */
--=20
1.7.12.rc1.27.g6d3049b.dirty
