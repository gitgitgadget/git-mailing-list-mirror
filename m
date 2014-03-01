From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 27/27] count-objects: report unused files in $GIT_DIR/repos/...
Date: Sat,  1 Mar 2014 19:13:03 +0700
Message-ID: <1393675983-3232-28-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 13:23:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJixJ-0002w6-Va
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 13:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbaCAMXk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 07:23:40 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:64753 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083AbaCAMXi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 07:23:38 -0500
Received: by mail-pa0-f41.google.com with SMTP id fa1so1926719pad.28
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 04:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=budxmYktU7nP6tJ9PVMlDXqJ+RkNHxDkRgvomCdnJ60=;
        b=BpsECo3EP0Qjd5YtBudzFDyn9L5q8+OF1+86kK2/RDKYTF08AyW0eKelvQV+7uOBdy
         yc88CKJHwob1iWrZX9S607uwUqtHDr7+C5+GRvezlrIPJOdAQcc0j9t1dLa57JNpUnG1
         X+94o510b746m989e2wsvm3+OVJZeCPLigb6bKFom7qr/LrBQMuIIf5x2C0YJFbYRuU5
         OqXjiPb3peOW+xxm0x4VQb5XDYRKwIfWqZZLllefthKo3QSZ7KnHqwO8+Xi5ulWxBgCF
         lYgqGok3VTNdX4Du2M1fDZilgdBHlvRAkrBmyM4ZEATw9lGVHFoUGbYBgsuSddMHpy1U
         6jVg==
X-Received: by 10.66.16.131 with SMTP id g3mr9394272pad.138.1393676618025;
        Sat, 01 Mar 2014 04:23:38 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id ug9sm15939109pbc.11.2014.03.01.04.23.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 04:23:37 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 01 Mar 2014 19:24:03 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243091>

In linked checkouts, borrowed parts like config is taken from
$GIT_COMMON_DIR. $GIT_DIR/config is never used. Report them as
garbage.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/count-objects.c | 37 ++++++++++++++++++++++++++++++++++++-
 path.c                  |  4 ++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index a7f70cb..725cd5f 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -78,6 +78,39 @@ static void count_objects(DIR *d, char *path, int le=
n, int verbose,
 	}
 }
=20
+static void report_linked_checkout_garbage(void)
+{
+	/*
+	 * must be more or less in sync with * path.c:update_common_dir().
+	 *
+	 * "logs" is let slip because logs/HEAD is in $GIT_DIR but the
+	 * remaining in $GIT_COMMON_DIR. Probably not worth traversing
+	 * the entire "logs" directory for that.
+	 *
+	 * The same "gc.pid" for because it's a temporary file.
+	 */
+	const char *list[] =3D {
+		"branches", "hooks", "info", "lost-found", "modules",
+		"objects", "refs", "remotes", "rr-cache", "svn",
+		"config", "packed-refs", "shallow", NULL
+	};
+	struct strbuf sb =3D STRBUF_INIT;
+	const char **p;
+	int len;
+
+	if (!file_exists(git_path("commondir")))
+		return;
+	strbuf_addf(&sb, "%s/", get_git_dir());
+	len =3D sb.len;
+	for (p =3D list; *p; p++) {
+		strbuf_setlen(&sb, len);
+		strbuf_addstr(&sb, *p);
+		if (file_exists(sb.buf))
+			report_garbage("unused in linked checkout", sb.buf);
+	}
+	strbuf_release(&sb);
+}
+
 static char const * const count_objects_usage[] =3D {
 	N_("git count-objects [-v] [-H | --human-readable]"),
 	NULL
@@ -102,8 +135,10 @@ int cmd_count_objects(int argc, const char **argv,=
 const char *prefix)
 	/* we do not take arguments other than flags for now */
 	if (argc)
 		usage_with_options(count_objects_usage, opts);
-	if (verbose)
+	if (verbose) {
 		report_garbage =3D real_report_garbage;
+		report_linked_checkout_garbage();
+	}
 	memcpy(path, objdir, len);
 	if (len && objdir[len-1] !=3D '/')
 		path[len++] =3D '/';
diff --git a/path.c b/path.c
index 47383ff..2e6035d 100644
--- a/path.c
+++ b/path.c
@@ -92,6 +92,10 @@ static void replace_dir(struct strbuf *buf, int len,=
 const char *newdir)
=20
 static void update_common_dir(struct strbuf *buf, int git_dir_len)
 {
+	/*
+	 * Remember to report_linked_checkout_garbage()
+	 * builtin/count-objects.c
+	 */
 	const char *common_dir_list[] =3D {
 		"branches", "hooks", "info", "logs", "lost-found", "modules",
 		"objects", "refs", "remotes", "repos", "rr-cache", "svn",
--=20
1.9.0.40.gaa8c3ea
