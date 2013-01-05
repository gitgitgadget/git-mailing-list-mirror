From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Add getenv.so for catching invalid getenv() use via LD_PRELOAD
Date: Sat,  5 Jan 2013 15:55:46 +0700
Message-ID: <1357376146-7155-1-git-send-email-pclouds@gmail.com>
References: <CAEvUa7niTJVfp8_kuWs50kvhfZ59F-yAuAmeOXEduHXOq-tRFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael <fedora.dm0@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 09:57:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrPY6-0007Vu-6p
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 09:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323Ab3AEIzz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jan 2013 03:55:55 -0500
Received: from mail-da0-f48.google.com ([209.85.210.48]:39045 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755176Ab3AEIzx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 03:55:53 -0500
Received: by mail-da0-f48.google.com with SMTP id k18so7936070dae.7
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 00:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=9/uFM0mzKOVhoIfWYYmZf6vfZFVosuWLQ1yD/YIrRas=;
        b=vfJTaQte1qh1XsDNUwMRmba+y1IuuGr0NjVVN1J4vzXsTN+fMnVQ3EQq816a5QnOw+
         z2fc3p8Ue2JrtWccsMhxHVEHIn6dB9z9/RZe+EvAtdkY7FRW4Vbkh1Lj9x/1cR/u7P+n
         +TQkDlsiyj57+sKo/jRVtUI1lrKS/DfobDfI71XyyGTovDN6RF3KurhiZwTEGYheY3+V
         qmDWFI35mnxj2/GfogpOuX/wlJka+O66tw+ojyfYaeRy54dT4QeDlIgttbnICeI+630r
         Ez6f60AE+V8W+gCdZ90XBpDuPCrgWoih3wZtgN6d26IBE+u/Mb2d/eaVTUsJJYCBHRSm
         X8fQ==
X-Received: by 10.68.247.134 with SMTP id ye6mr169254680pbc.69.1357376152180;
        Sat, 05 Jan 2013 00:55:52 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id sk1sm33778194pbc.0.2013.01.05.00.55.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 00:55:50 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 05 Jan 2013 15:55:54 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <CAEvUa7niTJVfp8_kuWs50kvhfZ59F-yAuAmeOXEduHXOq-tRFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212683>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Perhaps this will help the getenv bug hunting (I assume we do the
 hunting on Linux platform only). So far it catches this and is stuck
 at getenv in git_pager().

  diff --git a/exec_cmd.c b/exec_cmd.c
  index 125fa6f..d8be5ce 100644
  --- a/exec_cmd.c
  +++ b/exec_cmd.c
  @@ -97,7 +97,7 @@ static void add_path(struct strbuf *out, const char=
 *path)
  =20
   void setup_path(void)
   {
  -       const char *old_path =3D getenv("PATH");
  +       char *old_path =3D xstrdup(getenv("PATH"));
          struct strbuf new_path =3D STRBUF_INIT;
  =20
          add_path(&new_path, git_exec_path());
  @@ -110,6 +110,7 @@ void setup_path(void)
  =20
          setenv("PATH", new_path.buf, 1);
  =20
  +       free(old_path);
          strbuf_release(&new_path);
   }

 contrib/getenv/Makefile |  2 ++
 contrib/getenv/getenv.c | 67 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 contrib/getenv/Makefile
 create mode 100644 contrib/getenv/getenv.c

diff --git a/contrib/getenv/Makefile b/contrib/getenv/Makefile
new file mode 100644
index 0000000..4881b85
--- /dev/null
+++ b/contrib/getenv/Makefile
@@ -0,0 +1,2 @@
+getenv.so: getenv.c
+	$(CC) -g -shared -fPIC -ldl -o $@ $<
diff --git a/contrib/getenv/getenv.c b/contrib/getenv/getenv.c
new file mode 100644
index 0000000..e351e10
--- /dev/null
+++ b/contrib/getenv/getenv.c
@@ -0,0 +1,67 @@
+#include <gnu/lib-names.h>
+#include <sys/mman.h>
+#include <dlfcn.h>
+#include <execinfo.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+
+/* Global symbols for easy access from gdb */
+static char *getenv_current;
+static char *getenv_prev;
+
+/*
+ * Intercept standard getenv() via LD_PRELOAD. The return value is
+ * made inaccessible by the next getenv() call. This helps catch
+ * places that ignore the statement "The string pointed to may be
+ * overwritten by a subsequent call to getenv()" [1].
+ *
+ * The backtrace is appended after the env string, which may be
+ * helpful to identify where this getenv() is called in a core dump.
+ *
+ * [1] http://pubs.opengroup.org/onlinepubs/9699919799/functions/geten=
v.html
+ */
+char *getenv(const char *name)
+{
+	static char *(*libc_getenv)(const char*);
+	char *value;
+
+	if (!libc_getenv) {
+		void *libc =3D dlopen(LIBC_SO, RTLD_LAZY);
+		libc_getenv =3D dlsym(libc, "getenv");
+	}
+	if (getenv_current) {
+		mprotect(getenv_current, strlen(getenv_current) + 1, PROT_NONE);
+		getenv_prev =3D getenv_current;
+		getenv_current =3D NULL;
+	}
+
+	value =3D libc_getenv(name);
+	if (value) {
+		int len =3D strlen(value) + 1;
+		int backtrace_len =3D 0;
+		void *buffer[100];
+		char **symbols;
+		int i, n;
+
+		n =3D backtrace(buffer, 100);
+		symbols =3D backtrace_symbols(buffer, n);
+		if (symbols) {
+			for (i =3D 0;i < n; i++)
+				backtrace_len +=3D strlen(symbols[i]) + 1; /* \n */
+			backtrace_len++; /* NULL */
+		}
+
+		getenv_current =3D mmap(NULL, len + backtrace_len, PROT_READ | PROT_=
WRITE,
+				   MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+		memcpy(getenv_current, value, len);
+		value =3D getenv_current;
+
+		if (symbols) {
+			char *p =3D getenv_current + len;
+			for (i =3D 0; i < n; i++)
+				p +=3D sprintf(p, "%s\n", symbols[i]);
+		}
+	}
+	return value;
+}
--=20
1.8.0.rc2.23.g1fb49df
