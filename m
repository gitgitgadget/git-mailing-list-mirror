From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Correct singular form in diff summary line for human interaction
Date: Tue, 31 Jan 2012 21:24:00 +0700
Message-ID: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Frederik Schwarzer <schwarzerf@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 15:24:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsEdd-00061d-S7
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 15:24:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754609Ab2AaOYp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Jan 2012 09:24:45 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45845 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754424Ab2AaOYo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 09:24:44 -0500
Received: by dadp15 with SMTP id p15so247441dad.19
        for <git@vger.kernel.org>; Tue, 31 Jan 2012 06:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=a9qz/KicqMy9ZpFdgiRHzppLq4HZlEDNg749wGNj378=;
        b=hRaqnPOCrrjmdPqKqD80OW8K8T4YuFW4ifbggIVTzsIw1w9VKV6OCOiUPiJFG8H2lZ
         GlrbOLLdwmcSq+bPJyfzs8Fql88gJZSM1NIwpB2rrZekesDl2e3ZBHZVUlK0snhnVRb7
         Pj5nqSrXCTRg1I1nifkVhxuXRFz3nGDvocHgU=
Received: by 10.68.240.164 with SMTP id wb4mr50148586pbc.57.1328019883937;
        Tue, 31 Jan 2012 06:24:43 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.57.120])
        by mx.google.com with ESMTPS id j4sm55771919pbg.12.2012.01.31.06.24.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 Jan 2012 06:24:42 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 31 Jan 2012 21:24:01 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189453>

"git diff --stat" and "git apply --stat" now learn to print the line
"%d files changed, %d insertions(+), %d deletions(-)" in singular form
whenever applicable.

This change uncondtionally would upset scripts because scripts are not
nice. They simply hate changes. They can be very hostile when that
happens. So only adjust the line for human consumption.

Convenient function interactive_use() is added for this purpose. The
command thinks it's in human hands when:

 - GIT_SCRIPTING environment variable is not set
 - pager is on or
 - both stdout and stderr point to tty device

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 The third attempt in the last couple months to remove three "s" in
 one line. I did not upset the test suite with this and hopefully
 won't upset any scripts around. Good start?

 builtin/apply.c |    3 ++-
 cache.h         |    1 +
 diff.c          |   33 ++++++++++++++++++++++++++++-----
 diff.h          |    3 +++
 pager.c         |    7 +++++++
 5 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index c24dc54..389898f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -14,6 +14,7 @@
 #include "builtin.h"
 #include "string-list.h"
 #include "dir.h"
+#include "diff.h"
 #include "parse-options.h"
=20
 /*
@@ -3241,7 +3242,7 @@ static void stat_patch_list(struct patch *patch)
 		show_stats(patch);
 	}
=20
-	printf(" %d files changed, %d insertions(+), %d deletions(-)\n", file=
s, adds, dels);
+	print_stat_summary(stdout, files, adds, dels);
 }
=20
 static void numstat_patch_list(struct patch *patch)
diff --git a/cache.h b/cache.h
index 10afd71..7e0bb2b 100644
--- a/cache.h
+++ b/cache.h
@@ -1175,6 +1175,7 @@ extern void setup_pager(void);
 extern const char *pager_program;
 extern int pager_in_use(void);
 extern int pager_use_color;
+extern int interactive_use(void);
=20
 extern const char *editor_program;
 extern const char *askpass_program;
diff --git a/diff.c b/diff.c
index 7e15426..2d63e9c 100644
--- a/diff.c
+++ b/diff.c
@@ -1322,6 +1322,32 @@ static void fill_print_name(struct diffstat_file=
 *file)
 	file->print_name =3D pname;
 }
=20
+int print_stat_summary(FILE *fp, int files, int insertions, int deleti=
ons)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int ret;
+
+	if (!interactive_use())
+		return fprintf(fp, " %d files changed, %d insertions(+), %d deletion=
s(-)\n",
+			       files, insertions, deletions);
+
+	strbuf_addf(&sb,
+		    ngettext(" %d file changed,", " %d files changed,",
+			     files),
+		    files);
+	strbuf_addf(&sb,
+		    ngettext(" %d insertion(+),", " %d insertions(+),",
+			     insertions),
+		    insertions);
+	strbuf_addf(&sb,
+		    ngettext(" %d deletion(-)\n", " %d deletions(-)\n",
+			     deletions),
+		    deletions);
+	ret =3D fputs(sb.buf, fp);
+	strbuf_release(&sb);
+	return ret;
+}
+
 static void show_stats(struct diffstat_t *data, struct diff_options *o=
ptions)
 {
 	int i, len, add, del, adds =3D 0, dels =3D 0;
@@ -1475,9 +1501,7 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
 		extra_shown =3D 1;
 	}
 	fprintf(options->file, "%s", line_prefix);
-	fprintf(options->file,
-	       " %d files changed, %d insertions(+), %d deletions(-)\n",
-	       total_files, adds, dels);
+	print_stat_summary(options->file, total_files, adds, dels);
 }
=20
 static void show_shortstats(struct diffstat_t *data, struct diff_optio=
ns *options)
@@ -1507,8 +1531,7 @@ static void show_shortstats(struct diffstat_t *da=
ta, struct diff_options *option
 				options->output_prefix_data);
 		fprintf(options->file, "%s", msg->buf);
 	}
-	fprintf(options->file, " %d files changed, %d insertions(+), %d delet=
ions(-)\n",
-	       total_files, adds, dels);
+	print_stat_summary(options->file, total_files, adds, dels);
 }
=20
 static void show_numstat(struct diffstat_t *data, struct diff_options =
*options)
diff --git a/diff.h b/diff.h
index ae71f4c..7af5f1e 100644
--- a/diff.h
+++ b/diff.h
@@ -324,4 +324,7 @@ extern struct userdiff_driver *get_textconv(struct =
diff_filespec *one);
=20
 extern int parse_rename_score(const char **cp_p);
=20
+extern int print_stat_summary(FILE *fp, int files,
+			      int insertions, int deletions);
+
 #endif /* DIFF_H */
diff --git a/pager.c b/pager.c
index 975955b..9a3d3d8 100644
--- a/pager.c
+++ b/pager.c
@@ -110,3 +110,10 @@ int pager_in_use(void)
 	env =3D getenv("GIT_PAGER_IN_USE");
 	return env ? git_config_bool("GIT_PAGER_IN_USE", env) : 0;
 }
+
+int interactive_use(void)
+{
+	const char *env;
+	env =3D getenv("GIT_SCRIPTING");
+	return !env && (pager_in_use() || (isatty(1) && isatty(2)));
+}
--=20
1.7.8.36.g69ee2
