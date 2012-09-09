From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?q?=5BPATCH/RFC=5D=20blame=3A=20respect=20=22core=2Eignorecase=22?=
Date: Sun,  9 Sep 2012 19:01:53 +0200
Message-ID: <1347210113-27435-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 19:02:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAktf-0000PM-D8
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 19:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550Ab2IIRCB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Sep 2012 13:02:01 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56811 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542Ab2IIRCA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 13:02:00 -0400
Received: by wgbdr13 with SMTP id dr13so1217787wgb.1
        for <git@vger.kernel.org>; Sun, 09 Sep 2012 10:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=YeIUSNet2ZgcsCvCYDvY7myvfxktuIh+ShIhuCsnaHI=;
        b=Rzjt0fQDjx6l1yENdFvmcnA1KFFcLcW43dJsSypwTKLZQi3C8BSLDTlJv3fv7LnU8J
         KXOyLfxKkCpn9f3AABSr/1H9aNUWbW6ksEod6DrqXHmC/09PSDXHLxSa927gOWGsmxlv
         uOHc64mJorJc3/tskRCU/if6ltbelMhSV3YiLqONa4iBzOGQlC4J73h6ZVUf10LU+pn1
         7h0N3Z3Q+dMN3M1/fHsyZth+ptYjC8qyerGtvxUa2KHY0Xcp6u4tdy46adpIUlWfQ7kf
         iroUvGknU2tiKRg+TjQBBYTh0y81/NH8ks4jegRuD3A++sCdVFL+5NpnUnRBa43RRWqr
         Dt+g==
Received: by 10.216.85.130 with SMTP id u2mr6285742wee.202.1347210118754;
        Sun, 09 Sep 2012 10:01:58 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-138-170.pools.arcor-ip.net. [94.222.138.170])
        by mx.google.com with ESMTPS id do5sm18137358wib.10.2012.09.09.10.01.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 09 Sep 2012 10:01:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.gfe115d7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205084>

If "core.ignorecase" is true, "git blame" fails
when the given path differs to the real path in case
sensitivity.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 .gitignore             |  1 +
 Makefile               |  3 +++
 builtin/blame.c        | 58 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
 test-path-ignorecase.c | 27 +++++++++++++++++++++++
 4 Dateien ge=C3=A4ndert, 89 Zeilen hinzugef=C3=BCgt(+)
 create mode 100644 test-path-ignorecase.c

diff --git a/.gitignore b/.gitignore
index bb5c91e..65ab9f6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -195,6 +195,7 @@
 /test-sigchain
 /test-subprocess
 /test-svn-fe
+/test-path-ignorecase
 /common-cmds.h
 *.tar.gz
 *.dsc
diff --git a/Makefile b/Makefile
index 6b0c961..dbdd214 100644
--- a/Makefile
+++ b/Makefile
@@ -503,6 +503,7 @@ TEST_PROGRAMS_NEED_X +=3D test-sha1
 TEST_PROGRAMS_NEED_X +=3D test-sigchain
 TEST_PROGRAMS_NEED_X +=3D test-subprocess
 TEST_PROGRAMS_NEED_X +=3D test-svn-fe
+TEST_PROGRAMS_NEED_X +=3D test-path-ignorecase
=20
 TEST_PROGRAMS =3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
=20
@@ -2562,6 +2563,8 @@ test-parse-options$X: parse-options.o parse-optio=
ns-cb.o
=20
 test-svn-fe$X: vcs-svn/lib.a
=20
+test-path-ignorecase$X: builtin/blame.o
+
 .PRECIOUS: $(TEST_OBJS)
=20
 test-%$X: test-%.o GIT-LDFLAGS $(GITLIBS)
diff --git a/builtin/blame.c b/builtin/blame.c
index 0d50273..895f665 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1937,6 +1937,61 @@ static int has_string_in_work_tree(const char *p=
ath)
 	return !lstat(path, &st);
 }
=20
+const char* get_path_ignorecase(const char *path)
+{
+	struct strbuf res =3D STRBUF_INIT;
+	struct strbuf p =3D STRBUF_INIT;
+	int offset =3D 0;
+
+	if (!ignore_case || has_string_in_work_tree(path))
+		return path;
+
+	for (;;) {
+		char c =3D path[offset++];
+
+		if (is_dir_sep(c) || c =3D=3D '\0') {
+			DIR *dir;
+
+			if (res.len)
+				dir =3D opendir(res.buf);
+			else
+				dir =3D opendir(".");
+
+			if (dir !=3D NULL) {
+				for (;;) {
+					struct dirent *ent =3D readdir(dir);
+
+					if (ent =3D=3D NULL )
+						break;
+
+					if (!strcmp(".", ent->d_name) || !strcmp("..", ent->d_name))
+						continue;
+
+					if (!strcmp(p.buf, ent->d_name))
+						break;
+
+					if (!strcasecmp(p.buf, ent->d_name)) {
+						strbuf_release(&p);
+						strbuf_add(&p, ent->d_name, strlen(ent->d_name));
+						break;
+					}
+				}
+				closedir(dir);
+			}
+
+			strbuf_addch(&p, c);
+			strbuf_addbuf(&res, &p);
+			strbuf_release(&p);
+		} else {
+			strbuf_addch(&p, c);
+		}
+
+		if (c =3D=3D '\0')
+			break;
+	}
+	return res.buf;
+}
+
 static unsigned parse_score(const char *arg)
 {
 	char *end;
@@ -2448,6 +2503,7 @@ parse_done:
 			/* FALLTHROUGH */
 		case 1: /* (1a) */
 			path =3D add_prefix(prefix, argv[--argc]);
+			path =3D get_path_ignorecase(path);
 			argv[argc] =3D NULL;
 			break;
 		default:
@@ -2457,8 +2513,10 @@ parse_done:
 		if (argc < 2)
 			usage_with_options(blame_opt_usage, options);
 		path =3D add_prefix(prefix, argv[argc - 1]);
+		path =3D get_path_ignorecase(path);
 		if (argc =3D=3D 3 && !has_string_in_work_tree(path)) { /* (2b) */
 			path =3D add_prefix(prefix, argv[1]);
+			path =3D get_path_ignorecase(path);
 			argv[1] =3D argv[2];
 		}
 		argv[argc - 1] =3D "--";
diff --git a/test-path-ignorecase.c b/test-path-ignorecase.c
new file mode 100644
index 0000000..1f17f5c
--- /dev/null
+++ b/test-path-ignorecase.c
@@ -0,0 +1,27 @@
+#include "cache.h"
+
+static const char *usage_msg =3D "\n"
+		"test-similar-path <path>...\n";
+const char* get_path_ignorecase(const char *path);
+
+int main(int argc, char **argv)
+{
+	char *p;
+	const char *np;
+
+	if (argc !=3D 2) {
+		usage(usage_msg);
+		return 1;
+	}
+
+	argv++;
+	p =3D *argv;
+
+	ignore_case =3D 1;
+
+	np =3D get_path_ignorecase(p);
+
+	printf("%s\n", np);
+
+	return 0;
+}
--=20
1.7.12.1.gfe115d7
