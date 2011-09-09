From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/4] Split GPG interface into its own helper library
Date: Fri,  9 Sep 2011 13:41:42 -0700
Message-ID: <1315600904-17032-3-git-send-email-gitster@pobox.com>
References: <1315512102-19022-1-git-send-email-gitster@pobox.com>
 <1315600904-17032-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 22:42:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R27tv-00036K-2H
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 22:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933669Ab1IIUly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 16:41:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59938 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933350Ab1IIUlu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 16:41:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52D555E5A
	for <git@vger.kernel.org>; Fri,  9 Sep 2011 16:41:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=kROt
	iYlcp4qgPTqr8GR6mJ4d4ew=; b=POTNzHcfu9TVEKKcekWFnWdlh65iP6CxWYvw
	eL9gemGbyQVw6g9e9fVqOjPHXzZ9QYmbGqW3UVQZDiSy6MUMDt0RgxpvP/+CMa8i
	pxX0LcU47PM3G70UrVO/O3bc88Q2V6FWEN2b/cN3Pr6kCJM0bNhGRW/jzqMlXGQl
	74pOKTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=iTk33O
	OmpOL2Hn1R3iEO0CCHTOweeM7EZp361HPn8qZqmQje3tp+2V1ksBzraMGAArdBcZ
	LRUCBjeoTe/Of5r1WnjRzT4guz6QcD0KQo2r55CrDShs9iDrSHyOenbuT70K98Yf
	tX4n6U4urGm3kHaV+EoQ260V5axYLK97B0p/g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B2BD5E59
	for <git@vger.kernel.org>; Fri,  9 Sep 2011 16:41:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9225D5E58 for
 <git@vger.kernel.org>; Fri,  9 Sep 2011 16:41:49 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.188.g3793ac
In-Reply-To: <1315600904-17032-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2456C7B8-DB24-11E0-B07A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181121>

This mostly moves existing code from builtin/tag.c (for signing)
and builtin/verify-tag.c (for verifying) to a new gpg-interface.c
file to provide a more generic library interface.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile             |    2 +
 builtin/tag.c        |   60 ++++----------------------------
 builtin/verify-tag.c |   35 ++-----------------
 gpg-interface.c      |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++
 gpg-interface.h      |   11 ++++++
 5 files changed, 117 insertions(+), 85 deletions(-)
 create mode 100644 gpg-interface.c
 create mode 100644 gpg-interface.h

diff --git a/Makefile b/Makefile
index 8d6d451..2183223 100644
--- a/Makefile
+++ b/Makefile
@@ -530,6 +530,7 @@ LIB_H += exec_cmd.h
 LIB_H += fsck.h
 LIB_H += gettext.h
 LIB_H += git-compat-util.h
+LIB_H += gpg-interface.h
 LIB_H += graph.h
 LIB_H += grep.h
 LIB_H += hash.h
@@ -620,6 +621,7 @@ LIB_OBJS += entry.o
 LIB_OBJS += environment.o
 LIB_OBJS += exec_cmd.o
 LIB_OBJS += fsck.o
+LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
 LIB_OBJS += grep.o
 LIB_OBJS += hash.o
diff --git a/builtin/tag.c b/builtin/tag.c
index 667515e..e9d36fa 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -14,6 +14,7 @@
 #include "parse-options.h"
 #include "diff.h"
 #include "revision.h"
+#include "gpg-interface.h"
 
 static const char * const git_tag_usage[] = {
 	"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<head>]",
@@ -208,60 +209,13 @@ static int verify_tag(const char *name, const char *ref,
 
 static int do_sign(struct strbuf *buffer)
 {
-	struct child_process gpg;
-	const char *args[4];
-	char *bracket;
-	int len;
-	int i, j;
+	const char *key;
 
-	if (!*signingkey) {
-		if (strlcpy(signingkey, git_committer_info(IDENT_ERROR_ON_NO_NAME),
-				sizeof(signingkey)) > sizeof(signingkey) - 1)
-			return error(_("committer info too long."));
-		bracket = strchr(signingkey, '>');
-		if (bracket)
-			bracket[1] = '\0';
-	}
-
-	/* When the username signingkey is bad, program could be terminated
-	 * because gpg exits without reading and then write gets SIGPIPE. */
-	signal(SIGPIPE, SIG_IGN);
-
-	memset(&gpg, 0, sizeof(gpg));
-	gpg.argv = args;
-	gpg.in = -1;
-	gpg.out = -1;
-	args[0] = "gpg";
-	args[1] = "-bsau";
-	args[2] = signingkey;
-	args[3] = NULL;
-
-	if (start_command(&gpg))
-		return error(_("could not run gpg."));
-
-	if (write_in_full(gpg.in, buffer->buf, buffer->len) != buffer->len) {
-		close(gpg.in);
-		close(gpg.out);
-		finish_command(&gpg);
-		return error(_("gpg did not accept the tag data"));
-	}
-	close(gpg.in);
-	len = strbuf_read(buffer, gpg.out, 1024);
-	close(gpg.out);
-
-	if (finish_command(&gpg) || !len || len < 0)
-		return error(_("gpg failed to sign the tag"));
-
-	/* Strip CR from the line endings, in case we are on Windows. */
-	for (i = j = 0; i < buffer->len; i++)
-		if (buffer->buf[i] != '\r') {
-			if (i != j)
-				buffer->buf[j] = buffer->buf[i];
-			j++;
-		}
-	strbuf_setlen(buffer, j);
-
-	return 0;
+	if (*signingkey)
+		key = signingkey;
+	else
+		key = git_committer_info(IDENT_ERROR_ON_NO_NAME|IDENT_NO_DATE);
+	return sign_buffer(buffer, key);
 }
 
 static const char tag_template[] =
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 3134766..8b4f742 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -11,6 +11,7 @@
 #include "run-command.h"
 #include <signal.h>
 #include "parse-options.h"
+#include "gpg-interface.h"
 
 static const char * const verify_tag_usage[] = {
 		"git verify-tag [-v|--verbose] <tag>...",
@@ -19,42 +20,12 @@ static const char * const verify_tag_usage[] = {
 
 static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 {
-	struct child_process gpg;
-	const char *args_gpg[] = {"gpg", "--verify", "FILE", "-", NULL};
-	char path[PATH_MAX];
-	size_t len;
-	int fd, ret;
+	int len;
 
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
 	len = parse_signature(buf, size);
 	if (verbose)
 		write_in_full(1, buf, len);
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
-	unlink_or_warn(path);
-
-	return ret;
+	return verify_signed_buffer(buf, size, len);
 }
 
 static int verify_tag(const char *name, int verbose)
diff --git a/gpg-interface.c b/gpg-interface.c
new file mode 100644
index 0000000..b83cca1
--- /dev/null
+++ b/gpg-interface.c
@@ -0,0 +1,94 @@
+/*
+ * Copyright (c) 2011, Google Inc.
+ */
+#include "cache.h"
+#include "run-command.h"
+#include "strbuf.h"
+#include "gpg-interface.h"
+#include "sigchain.h"
+
+int sign_buffer(struct strbuf *buffer, const char *signing_key)
+{
+	struct child_process gpg;
+	const char *args[4];
+	ssize_t len;
+	int i, j;
+
+	memset(&gpg, 0, sizeof(gpg));
+	gpg.argv = args;
+	gpg.in = -1;
+	gpg.out = -1;
+	args[0] = "gpg";
+	args[1] = "-bsau";
+	args[2] = signing_key;
+	args[3] = NULL;
+
+	if (start_command(&gpg))
+		return error(_("could not run gpg."));
+
+	/*
+	 * When the username signingkey is bad, program could be terminated
+	 * because gpg exits without reading and then write gets SIGPIPE.
+	 */
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	if (write_in_full(gpg.in, buffer->buf, buffer->len) != buffer->len) {
+		close(gpg.in);
+		close(gpg.out);
+		finish_command(&gpg);
+		return error(_("gpg did not accept the data"));
+	}
+	close(gpg.in);
+	len = strbuf_read(buffer, gpg.out, 1024);
+	close(gpg.out);
+
+	sigchain_pop(SIGPIPE);
+
+	if (finish_command(&gpg) || !len || len < 0)
+		return error(_("gpg failed to sign the data"));
+
+	/* Strip CR from the line endings, in case we are on Windows. */
+	for (i = j = 0; i < buffer->len; i++)
+		if (buffer->buf[i] != '\r') {
+			if (i != j)
+				buffer->buf[j] = buffer->buf[i];
+			j++;
+		}
+	strbuf_setlen(buffer, j);
+
+	return 0;
+}
+
+int verify_signed_buffer(const char *buf, size_t total, size_t payload)
+{
+	struct child_process gpg;
+	const char *args_gpg[] = {"gpg", "--verify", "FILE", "-", NULL};
+	char path[PATH_MAX];
+	int fd, ret;
+
+	fd = git_mkstemp(path, PATH_MAX, ".git_vtag_tmpXXXXXX");
+	if (fd < 0)
+		return error("could not create temporary file '%s': %s",
+			     path, strerror(errno));
+	if (write_in_full(fd, buf, total) < 0)
+		return error("failed writing temporary file '%s': %s",
+			     path, strerror(errno));
+	close(fd);
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
+	write_in_full(gpg.in, buf, payload);
+	close(gpg.in);
+	ret = finish_command(&gpg);
+
+	unlink_or_warn(path);
+
+	return ret;
+}
diff --git a/gpg-interface.h b/gpg-interface.h
new file mode 100644
index 0000000..7689357
--- /dev/null
+++ b/gpg-interface.h
@@ -0,0 +1,11 @@
+#ifndef GPG_INTERFACE_H
+#define GPG_INTERFACE_H
+
+/*
+ * Copyright (c) 2011, Google Inc.
+ */
+
+extern int sign_buffer(struct strbuf *buffer, const char *signing_key);
+extern int verify_signed_buffer(const char *buffer, size_t total, size_t payload);
+
+#endif
-- 
1.7.7.rc0.188.g3793ac
