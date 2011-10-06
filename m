From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] Split GPG interface into its own helper library
Date: Wed, 05 Oct 2011 17:46:36 -0700
Message-ID: <7vipo33q1f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 02:46:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBc6m-0005SV-SP
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 02:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935644Ab1JFAqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 20:46:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48477 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935275Ab1JFAqj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 20:46:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECE076C8C;
	Wed,  5 Oct 2011 20:46:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=o
	px9g9YIhbLt1c8hOpsr3JtC/Jo=; b=eUb4GiuSErQrFbnG+6QS/SUYW2jJiNIVT
	JB9zt5EEIdr1Vffc/1GOiBBP4TMlxqAEN2a97vowcHcs+LbBAqZluWONnFHIhnCI
	o0V40O0QGnZHGsKR51K2jFiX+1cW+hJNk7jSnbFeNJjyYM03ESBQXe8JkCJDl6v6
	HOJIlhxScE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Ur9
	85UurytfxRmxKJX5nbU3zT9TwXj8Xim/y8SEmYiQm9nWWicHhThYfMesbWjdNOht
	R7wPf1f2rIGndsBthSIMox5hVoRVkd7kJmnlshQKMypkC2SshbfkvESbbVV4M9Oq
	adSzqFXrPqPuGaa8vbVTg1MaOZT+uUlNosjQygZg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E56756C8B;
	Wed,  5 Oct 2011 20:46:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 188836C8A; Wed,  5 Oct 2011
 20:46:38 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A61BD5DC-EFB4-11E0-A7D8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182910>

This mostly moves existing code from builtin/tag.c (for signing)
and builtin/verify-tag.c (for verifying) to a new gpg-interface.c
file to provide a more generic library interface.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is a re-roll of what was queued as part of jc/signed-push
   topic. The helper is now aware of user.signingkey configuration
   and can use it across all the future users.

 Makefile             |    2 +
 builtin/tag.c        |   76 +++-----------------------------
 builtin/verify-tag.c |   35 +-------------
 gpg-interface.c      |  119 ++++++++++++++++++++++++++++++++++++++++++++++++++
 gpg-interface.h      |   14 ++++++
 5 files changed, 144 insertions(+), 102 deletions(-)
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
index 667515e..3141680 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -14,6 +14,7 @@
 #include "parse-options.h"
 #include "diff.h"
 #include "revision.h"
+#include "gpg-interface.h"
 
 static const char * const git_tag_usage[] = {
 	"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<head>]",
@@ -23,8 +24,6 @@ static const char * const git_tag_usage[] = {
 	NULL
 };
 
-static char signingkey[1000];
-
 struct tag_filter {
 	const char **patterns;
 	int lines;
@@ -208,60 +207,7 @@ static int verify_tag(const char *name, const char *ref,
 
 static int do_sign(struct strbuf *buffer)
 {
-	struct child_process gpg;
-	const char *args[4];
-	char *bracket;
-	int len;
-	int i, j;
-
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
+	return sign_buffer(buffer, get_signing_key());
 }
 
 static const char tag_template[] =
@@ -270,21 +216,11 @@ static const char tag_template[] =
 	"# Write a tag message\n"
 	"#\n");
 
-static void set_signingkey(const char *value)
-{
-	if (strlcpy(signingkey, value, sizeof(signingkey)) >= sizeof(signingkey))
-		die(_("signing key value too long (%.10s...)"), value);
-}
-
 static int git_tag_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "user.signingkey")) {
-		if (!value)
-			return config_error_nonbool(var);
-		set_signingkey(value);
-		return 0;
-	}
-
+	int status = git_gpg_config(var, value, cb);
+	if (status)
+		return status;
 	return git_default_config(var, value, cb);
 }
 
@@ -463,7 +399,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	if (keyid) {
 		sign = 1;
-		set_signingkey(keyid);
+		set_signing_key(keyid);
 	}
 	if (sign)
 		annotate = 1;
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
index 0000000..98e8154
--- /dev/null
+++ b/gpg-interface.c
@@ -0,0 +1,119 @@
+/*
+ * Copyright (c) 2011, Google Inc.
+ */
+#include "cache.h"
+#include "run-command.h"
+#include "strbuf.h"
+#include "gpg-interface.h"
+#include "sigchain.h"
+
+static char *configured_signing_key;
+
+void set_signing_key(const char *key)
+{
+	free(configured_signing_key);
+	configured_signing_key = xstrdup(key);
+}
+
+int git_gpg_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "user.signingkey")) {
+		if (!value)
+			return config_error_nonbool(var);
+		set_signing_key(value);
+	}
+	return 0;
+}
+
+const char *get_signing_key(void)
+{
+	if (configured_signing_key)
+		return configured_signing_key;
+	return git_committer_info(IDENT_ERROR_ON_NO_NAME|IDENT_NO_DATE);
+}
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
index 0000000..4e459fe
--- /dev/null
+++ b/gpg-interface.h
@@ -0,0 +1,14 @@
+#ifndef GPG_INTERFACE_H
+#define GPG_INTERFACE_H
+
+/*
+ * Copyright (c) 2011, Google Inc.
+ */
+
+extern int sign_buffer(struct strbuf *buffer, const char *signing_key);
+extern int verify_signed_buffer(const char *buffer, size_t total, size_t payload);
+extern int git_gpg_config(const char *, const char *, void *);
+extern void set_signing_key(const char *);
+extern const char *get_signing_key(void);
+
+#endif
-- 
1.7.7.138.g7f41b6
