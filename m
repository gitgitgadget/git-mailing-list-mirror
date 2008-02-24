From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] Teach git-describe --long to output always the long format
Date: Sun, 24 Feb 2008 15:46:52 +0100
Message-ID: <1203864412-27977-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 15:47:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTI8p-0004lI-2v
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 15:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbYBXOrL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Feb 2008 09:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbYBXOrK
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 09:47:10 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:53339 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbYBXOrI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 09:47:08 -0500
Received: by fg-out-1718.google.com with SMTP id e21so942216fga.17
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 06:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=G2GGx240teaQ96Prpnvq0qy4TdIR8JVhq6oHdDK6gSo=;
        b=YasvJZUXtMPr9wYSolwbiX9rHEBsRcVSgcOS28U/JBlumlDsFSmo+gjoVmT6co6JPZ/dM/4JVtVnphHnnwSENDhh/1sYVBvn8Wjb5zN4jMWESJejKSeUNy2nPYM11M6KcLc6+phndgyEq1xzlhD8DY8UF1hKi47fXSi7+dGQRdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=jag8JdFdTa35EGopwOBOlmBK0DRjr/iLOt7c43schlm+KmvBJkEC88oVXkQXs9mpcRyJyIzUTGZ+uM1ZXJJKW2tv1dNppGJ4qzXOWRYLRKSFPRyxjuIH3VsMi795U90bbY7G5dpTuJv17fhw3EMJbgGdZuAWjD05kboUZOCE20I=
Received: by 10.82.111.8 with SMTP id j8mr3351281buc.2.1203864427430;
        Sun, 24 Feb 2008 06:47:07 -0800 (PST)
Received: from localhost ( [91.13.69.136])
        by mx.google.com with ESMTPS id l19sm4863443fgb.0.2008.02.24.06.46.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Feb 2008 06:47:00 -0800 (PST)
X-Mailer: git-send-email 1.5.4.3.293.gac81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74937>

Sometimes it is convenient to have the sha1 of a commit even
if it matches a tag.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 builtin-describe.c  |   11 ++++++++++-
 t/t6120-describe.sh |    2 ++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index 3428483..e46105a 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -17,6 +17,7 @@ static const char * const describe_usage[] =3D {
 static int debug;	/* Display lots of verbose info */
 static int all;	/* Default to annotated tags only */
 static int tags;	/* But allow any tags if --tags is specified */
+static int longformat;
 static int abbrev =3D DEFAULT_ABBREV;
 static int max_candidates =3D 10;
 const char *pattern =3D NULL;
@@ -155,7 +156,11 @@ static void describe(const char *arg, int last_one=
)
=20
 	n =3D cmit->util;
 	if (n) {
-		printf("%s\n", n->path);
+		if (!longformat)
+			printf("%s\n", n->path );
+		else
+			printf("%s-0-g%s\n", n->path,
+				find_unique_abbrev(cmit->object.sha1, abbrev));
 		return;
 	}
=20
@@ -254,6 +259,7 @@ int cmd_describe(int argc, const char **argv, const=
 char *prefix)
 		OPT_BOOLEAN(0, "debug",      &debug, "debug search strategy on stder=
r"),
 		OPT_BOOLEAN(0, "all",        &all, "use any ref in .git/refs"),
 		OPT_BOOLEAN(0, "tags",       &tags, "use any tag in .git/refs/tags")=
,
+		OPT_BOOLEAN(0, "long",       &longformat, "always use long format"),
 		OPT__ABBREV(&abbrev),
 		OPT_INTEGER(0, "candidates", &max_candidates,
 			    "consider <n> most recent tags (default: 10)"),
@@ -270,6 +276,9 @@ int cmd_describe(int argc, const char **argv, const=
 char *prefix)
=20
 	save_commit_buffer =3D 0;
=20
+	if (longformat && abbrev =3D=3D 0)
+		die("--long is incompatible with --abbrev=3D0");
+
 	if (contains) {
 		const char **args =3D xmalloc((6 + argc) * sizeof(char*));
 		int i =3D 0;
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index ae8ee11..a7557bd 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -94,4 +94,6 @@ check_describe D-* --tags HEAD^^
 check_describe A-* --tags HEAD^^2
 check_describe B --tags HEAD^^2^
=20
+check_describe B-0-* --long HEAD^^2^
+
 test_done
--=20
1.5.4.3.293.gac81
