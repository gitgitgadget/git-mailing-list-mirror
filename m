From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/3] Split GPG interface into its own helper library
Date: Tue, 18 Oct 2011 17:20:43 -0700
Message-ID: <1318983645-18897-2-git-send-email-gitster@pobox.com>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org>
 <1318983645-18897-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 02:21:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGJu3-0007Gr-B3
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 02:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400Ab1JSAUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 20:20:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48284 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323Ab1JSAUu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 20:20:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B596C44DD
	for <git@vger.kernel.org>; Tue, 18 Oct 2011 20:20:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=mmXA
	OeRz5jo6htcS3E8tgvl2HIQ=; b=JWyw3s2L30uwTXTrytcDpUQtMXjYvYS8f/Ty
	xQaIcd5I0q9NlxQOwhW1WWnWC6I+tTOe2eArn3zHVgYIB6CI/ow+TGvRknMbAp9o
	k/kcp8vjhrPygp/3OXliSoRQTqwhBGPcF6BJ7E/nSPB10S+bMqrzQ8wAXDQqyTnf
	8S32x/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=yUH+Yt
	uED0qpgf6h6/xXFFvQCLQs44B0V9XMuvh+995+sTnomO3zaqQqWWRl9rWgE37hm6
	TzDhlQKT64YPs2N08iwAMyyLyJVFKA4gKI1GZYM8PMcdL3hYF5NYUmRV88ex2x9F
	Rw0MTkj8P15xH2L0XO6H1HOL8LqsHubMIiiWE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD30444DC
	for <git@vger.kernel.org>; Tue, 18 Oct 2011 20:20:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4A0C44DB for
 <git@vger.kernel.org>; Tue, 18 Oct 2011 20:20:48 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.388.g3a4b7
In-Reply-To: <1318983645-18897-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 3210CB96-F9E8-11E0-A99B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183912>

This mostly moves existing code from builtin/tag.c (for signing)
and builtin/verify-tag.c (for verifying) to a new gpg-interface.c
file to provide a more generic library interface.

 - sign_buffer() takes a payload strbuf, a signature strbuf, and a signing
   key, runs "gpg" to produce a detached signature for the payload, and
   appends it to the signature strbuf. The contents of a signed tag that
   concatenates the payload and the detached signature can be produced by
   giving the same strbuf as payload and signature strbuf.

 - verify_signed_buffer() takes a payload and a detached signature as
   <ptr, len> pairs, and runs "gpg --verify" to see if the payload matches
   the signature.

"verify-tag" (aka "tag -v") saved the whole tag contents as if it is a
detached signature, and fed gpg the payload part of the tag. It relied on
gpg to fail when the given tag is not signed but just is annotated.  The
updated run_gpg_verify() function detects the lack of detached signature
in the input, and errors out without bothering "gpg".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile             |    2 +
 builtin/tag.c        |   76 ++-------------------------
 builtin/verify-tag.c |   36 ++-----------
 gpg-interface.c      |  137 ++++++++++++++++++++++++++++++++++++++++++++++++++
 gpg-interface.h      |   10 ++++
 tag.c                |    5 ++
 6 files changed, 166 insertions(+), 100 deletions(-)
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
index 667515e..fb0d4a1 100644
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
+	return sign_buffer(buffer, buffer, get_signing_key());
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
index 3134766..4bbcf77 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -11,6 +11,7 @@
 #include "run-command.h"
 #include <signal.h>
 #include "parse-options.h"
+#include "gpg-interface.h"
 
 static const char * const verify_tag_usage[] = {
 		"git verify-tag [-v|--verbose] <tag>...",
@@ -19,42 +20,17 @@ static const char * const verify_tag_usage[] = {
 
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
+	if (size == len)
+		return error("no signature found");
 
-	unlink_or_warn(path);
-
-	return ret;
+	return verify_signed_buffer(buf, len,
+				    buf + len, size - len, 0);
 }
 
 static int verify_tag(const char *name, int verbose)
diff --git a/gpg-interface.c b/gpg-interface.c
new file mode 100644
index 0000000..62f3806
--- /dev/null
+++ b/gpg-interface.c
@@ -0,0 +1,137 @@
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
+/*
+ * Create a detached signature for the contents of "buffer" and append
+ * it after "signature"; "buffer" and "signature" can be the same
+ * strbuf instance, which would cause the detached signature appended
+ * at the end.
+ */
+int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
+{
+	struct child_process gpg;
+	const char *args[4];
+	ssize_t len;
+	size_t i, j, bottom;
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
+
+	bottom = signature->len;
+	len = strbuf_read(signature, gpg.out, 1024);
+	close(gpg.out);
+
+	sigchain_pop(SIGPIPE);
+
+	if (finish_command(&gpg) || !len || len < 0)
+		return error(_("gpg failed to sign the data"));
+
+	/* Strip CR from the line endings, in case we are on Windows. */
+	for (i = j = bottom; i < signature->len; i++)
+		if (signature->buf[i] != '\r') {
+			if (i != j)
+				signature->buf[j] = signature->buf[i];
+			j++;
+		}
+	strbuf_setlen(signature, j);
+
+	return 0;
+}
+
+/*
+ * Run "gpg" to see if the payload matches the detached signature.
+ * gpg_output_to tells where the output from "gpg" should go:
+ *   < 0: /dev/null
+ *   = 0: standard error of the calling process
+ *   > 0: the specified file descriptor
+ */
+int verify_signed_buffer(const char *payload, size_t payload_size,
+			 const char *signature, size_t signature_size,
+			 int gpg_output_to)
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
+	if (write_in_full(fd, signature, signature_size) < 0)
+		return error("failed writing detached signature to '%s': %s",
+			     path, strerror(errno));
+	close(fd);
+
+	memset(&gpg, 0, sizeof(gpg));
+	gpg.argv = args_gpg;
+	gpg.in = -1;
+	if (gpg_output_to < 0)
+		gpg.no_stderr = 1;
+	else
+		gpg.err = gpg_output_to;
+	args_gpg[2] = path;
+	if (start_command(&gpg)) {
+		unlink(path);
+		return error("could not run gpg.");
+	}
+
+	write_in_full(gpg.in, payload, payload_size);
+	close(gpg.in);
+	ret = finish_command(&gpg);
+
+	unlink_or_warn(path);
+
+	return ret;
+}
diff --git a/gpg-interface.h b/gpg-interface.h
new file mode 100644
index 0000000..df58bb9
--- /dev/null
+++ b/gpg-interface.h
@@ -0,0 +1,10 @@
+#ifndef GPG_INTERFACE_H
+#define GPG_INTERFACE_H
+
+extern int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key);
+extern int verify_signed_buffer(const char *payload, size_t payload_size, const char *signature, size_t signature_size, int gpg_output_to);
+extern int git_gpg_config(const char *, const char *, void *);
+extern void set_signing_key(const char *);
+extern const char *get_signing_key(void);
+
+#endif
diff --git a/tag.c b/tag.c
index 7d38cc0..3aa186d 100644
--- a/tag.c
+++ b/tag.c
@@ -139,6 +139,11 @@ int parse_tag(struct tag *item)
 	return ret;
 }
 
+/*
+ * Look at a signed tag object, and return the offset where
+ * the embedded detached signature begins, or the end of the
+ * data when there is no such signature.
+ */
 size_t parse_signature(const char *buf, unsigned long size)
 {
 	char *eol;
-- 
1.7.7.388.g3a4b7
