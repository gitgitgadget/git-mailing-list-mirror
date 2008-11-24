From: Deskin Miller <deskinm@umich.edu>
Subject: [RFC PATCH 1/4] Refactor builtin-verify-tag.c
Date: Sun, 23 Nov 2008 22:23:17 -0500
Message-ID: <1227497000-8684-2-git-send-email-deskinm@umich.edu>
References: <1227497000-8684-1-git-send-email-deskinm@umich.edu>
Cc: Deskin Miller <deskinm@umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 24 04:25:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4S4J-00061G-3Z
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 04:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbYKXDXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2008 22:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbYKXDXc
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Nov 2008 22:23:32 -0500
Received: from rn-out-0910.google.com ([64.233.170.187]:37493 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbYKXDX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2008 22:23:28 -0500
Received: by rn-out-0910.google.com with SMTP id k40so1521802rnd.17
        for <git@vger.kernel.org>; Sun, 23 Nov 2008 19:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=PNGWrKeb/RD+i8ZXdmfLip1wadQIfhZg0diQaejp8Y4=;
        b=sf3Gde4zc7rGLHgid7H3OsEb85i5zZKRZxQzvEYFH5Yuuozj5QwaiEoOGPLmBJWeQZ
         NM4GLV+IKCdOrQaBDRR73oLvU1XgCu1r1RJNOEs6RXzYEFpjboJt3MXPyFOdR6pTrX9r
         DfEMWYMfW1iYqX1y5+SXBhJrBV/Ss2PLqUdiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=NdUSRJi0r3hiA9mUyywxYC+ZnVGzEcdor4cV66++A64dug12C6zM3t1I/fbiV38lFS
         3sDaBKJW0/ygp1aRhuolkUuWXjFkBKzTFbmexvRKWsayFz73IKCy+y+4AvhGm/2BMJPB
         fSv8kD93vSIQkNHfvfxtGVCM601jirkk6eynU=
Received: by 10.151.103.1 with SMTP id f1mr6192827ybm.181.1227497007061;
        Sun, 23 Nov 2008 19:23:27 -0800 (PST)
Received: from localhost.localdomain ([152.160.57.162])
        by mx.google.com with ESMTPS id a13sm6706484rnc.12.2008.11.23.19.23.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 Nov 2008 19:23:26 -0800 (PST)
X-Mailer: git-send-email 1.6.0.4.770.ga8394
In-Reply-To: <1227497000-8684-1-git-send-email-deskinm@umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101584>

builtin-verify-tag.c didn't expose any of its functionality to be used
internally.  Refactor some of it into new verify-tag.c and expose
verify_tag_sha1 able to be called from elsewhere in git.

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
 Makefile             |    2 +
 builtin-verify-tag.c |   61 ++-------------------------------------
 verify-tag.c         |   77 ++++++++++++++++++++++++++++++++++++++++++++++++++
 verify-tag.h         |   10 ++++++
 4 files changed, 93 insertions(+), 57 deletions(-)
 create mode 100644 verify-tag.c
 create mode 100644 verify-tag.h

diff --git a/Makefile b/Makefile
index 35adafa..b372aa4 100644
--- a/Makefile
+++ b/Makefile
@@ -392,6 +392,7 @@ LIB_H += tree-walk.h
 LIB_H += unpack-trees.h
 LIB_H += userdiff.h
 LIB_H += utf8.h
+LIB_H += verify-tag.h
 LIB_H += wt-status.h
 
 LIB_OBJS += abspath.o
@@ -490,6 +491,7 @@ LIB_OBJS += unpack-trees.o
 LIB_OBJS += userdiff.o
 LIB_OBJS += usage.o
 LIB_OBJS += utf8.o
+LIB_OBJS += verify-tag.o
 LIB_OBJS += walker.o
 LIB_OBJS += wrapper.o
 LIB_OBJS += write_or_die.o
diff --git a/builtin-verify-tag.c b/builtin-verify-tag.c
index 729a159..dd350e8 100644
--- a/builtin-verify-tag.c
+++ b/builtin-verify-tag.c
@@ -7,65 +7,16 @@
  */
 #include "cache.h"
 #include "builtin.h"
-#include "tag.h"
-#include "run-command.h"
+#include "verify-tag.h"
 #include <signal.h>
 
 static const char builtin_verify_tag_usage[] =
 		"git verify-tag [-v|--verbose] <tag>...";
 
-#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
-
-static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
-{
-	struct child_process gpg;
-	const char *args_gpg[] = {"gpg", "--verify", "FILE", "-", NULL};
-	char path[PATH_MAX], *eol;
-	size_t len;
-	int fd, ret;
-
-	fd = git_mkstemp(path, PATH_MAX, ".git_vtag_tmpXXXXXX");
-	if (fd < 0)
-		return error("could not create temporary file '%s': %s",
-						path, strerror(errno));
-	if (write_in_full(fd, buf, size) < 0)
-		return error("failed writing temporary file '%s': %s",
-						path, strerror(errno));
-	close(fd);
-
-	/* find the length without signature */
-	len = 0;
-	while (len < size && prefixcmp(buf + len, PGP_SIGNATURE)) {
-		eol = memchr(buf + len, '\n', size - len);
-		len += eol ? eol - (buf + len) + 1 : size - len;
-	}
-	if (verbose)
-		write_in_full(1, buf, len);
-
-	memset(&gpg, 0, sizeof(gpg));
-	gpg.argv = args_gpg;
-	gpg.in = -1;
-	args_gpg[2] = path;
-	if (start_command(&gpg)) {
-		unlink(path);
-		return error("could not run gpg.");
-	}
-
-	write_in_full(gpg.in, buf, len);
-	close(gpg.in);
-	ret = finish_command(&gpg);
-
-	unlink(path);
-
-	return ret;
-}
-
 static int verify_tag(const char *name, int verbose)
 {
 	enum object_type type;
 	unsigned char sha1[20];
-	char *buf;
-	unsigned long size;
 	int ret;
 
 	if (get_sha1(name, sha1))
@@ -76,13 +27,9 @@ static int verify_tag(const char *name, int verbose)
 		return error("%s: cannot verify a non-tag object of type %s.",
 				name, typename(type));
 
-	buf = read_sha1_file(sha1, &type, &size);
-	if (!buf)
-		return error("%s: unable to read file.", name);
-
-	ret = run_gpg_verify(buf, size, verbose);
-
-	free(buf);
+	ret = verify_tag_sha1(sha1, verbose);
+	if (ret)
+		error("Failed to verify %s.", name);
 	return ret;
 }
 
diff --git a/verify-tag.c b/verify-tag.c
new file mode 100644
index 0000000..c9be331
--- /dev/null
+++ b/verify-tag.c
@@ -0,0 +1,77 @@
+/*
+ * Internals for "git verify-tag"
+ *
+ * Copyright (c) 2008 Deskin Miller <deskinm@umich.edu>
+ *
+ */
+#include "cache.h"
+#include "object.h"
+#include "run-command.h"
+
+#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
+
+static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
+{
+	struct child_process gpg;
+	const char *args_gpg[] = {"gpg", "--verify", "FILE", "-", NULL};
+	char path[PATH_MAX], *eol;
+	size_t len;
+	int fd, ret;
+
+	fd = git_mkstemp(path, PATH_MAX, ".git_vtag_tmpXXXXXX");
+	if (fd < 0)
+		return error("could not create temporary file '%s': %s",
+						path, strerror(errno));
+	if (write_in_full(fd, buf, size) < 0)
+		return error("failed writing temporary file '%s': %s",
+						path, strerror(errno));
+	close(fd);
+
+	/* find the length without signature */
+	len = 0;
+	while (len < size && prefixcmp(buf + len, PGP_SIGNATURE)) {
+		eol = memchr(buf + len, '\n', size - len);
+		len += eol ? eol - (buf + len) + 1 : size - len;
+	}
+	if (verbose)
+		write_in_full(1, buf, len);
+
+	memset(&gpg, 0, sizeof(gpg));
+	gpg.argv = args_gpg;
+	gpg.in = -1;
+	args_gpg[2] = path;
+	if (start_command(&gpg)) {
+		unlink(path);
+		return error("could not run gpg.");
+	}
+
+	write_in_full(gpg.in, buf, len);
+	close(gpg.in);
+	ret = finish_command(&gpg);
+
+	unlink(path);
+
+	return ret;
+}
+
+int verify_tag_sha1(const unsigned char *sha1, int verbose)
+{
+	enum object_type type;
+	char *buf;
+	unsigned long size;
+	int ret;
+
+	type = sha1_object_info(sha1, NULL);
+	if (type != OBJ_TAG)
+		return error("Cannot verify a non-tag object of type %s.",
+				typename(type));
+
+	buf = read_sha1_file(sha1, &type, &size);
+	if (!buf)
+		return error("Cnable to read file.");
+
+	ret = run_gpg_verify(buf, size, verbose);
+
+	free(buf);
+	return ret;
+}
diff --git a/verify-tag.h b/verify-tag.h
new file mode 100644
index 0000000..45bdca7
--- /dev/null
+++ b/verify-tag.h
@@ -0,0 +1,10 @@
+#ifndef VERIFY_TAG_H
+#define VERIFY_TAG_H
+/*
+ * Internals for "git verify-tag"
+ *
+ * Copyright (c) 2008 Deskin Miller <deskinm@umich.edu>
+ */
+extern int verify_tag_sha1(const unsigned char *sha1, int verbose);
+
+#endif /* VERIFY_TAG_H */
-- 
1.6.0.4.770.ga8394
