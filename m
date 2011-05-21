From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 07/12] streaming_write_entry(): use streaming API in
 write_entry()
Date: Fri, 20 May 2011 23:56:30 -0700
Message-ID: <1305960995-25738-8-git-send-email-gitster@pobox.com>
References: <1305960995-25738-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 08:57:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNg86-0006EB-84
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 08:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244Ab1EUG5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 02:57:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54969 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab1EUG5g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 02:57:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 848475DC7
	for <git@vger.kernel.org>; Sat, 21 May 2011 02:59:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=M0nP
	TJmpIB+RHnWS1kpTSXGn894=; b=JzpZXRdL3uQUjTOVYB8qqMYr2CEdJFs9VYW/
	pHKaKsYGCunC+gf3YEuFm/fGUlQSrwoj5VsNUId0bBOzwHD9UHQWdHxoVGx0ydee
	esw0dW97tIeuRCuzT5y+1GJ73KkHNrG7F7d3Jz06vpOehj0Ccb6afVKi3fmiDqvh
	SERaonw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=FwpC6d
	EE9byQW8Km/m8FKVFvHUApqQ4anu+H/41s74j3SWwJG8qAhx6NGUVHroVLUa1w5g
	PWNMn1a2wGdLOog3PYkY08kgNnekbyX9o4IAmyk4thLwCYqX76BNKTq8Mq1V5T/7
	bFm/5yfZCoG6zrhYgQU5ZtL8sIj3vjn/fzeps=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7FD0B5DC6
	for <git@vger.kernel.org>; Sat, 21 May 2011 02:59:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B35A05DC5 for
 <git@vger.kernel.org>; Sat, 21 May 2011 02:59:41 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.2.369.g8fc017
In-Reply-To: <1305960995-25738-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E733BFA2-8377-11E0-89B7-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174101>

When the output to a path does not have to be converted, we can read from
the object database from the streaming API and write to the file in the
working tree, without having to hold everything in the memory.

The ident, auto- and safe- crlf conversions inherently require you to read
the whole thing before deciding what to do, so while it is technically
possible to support them by using a buffer of an unbound size or rewinding
and reading the stream twice, it is less practical than the traditional
"read the whole thing in core and convert" approach.

Adding streaming filters for the other conversions on top of this should
be doable by tweaking the can_bypass_conversion() function (it should be
renamed to can_filter_stream() when it happens). Then the streaming API
can be extended to wrap the git_istream streaming_write_entry() opens on
the underlying object in another git_istream that reads from it, filters
what is read, and let the streaming_write_entry() read the filtered
result. But that is outside the scope of this series.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h   |    1 +
 convert.c |   23 +++++++++++++++++++++++
 entry.c   |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 7650d2e..2a7a77f 100644
--- a/cache.h
+++ b/cache.h
@@ -1156,6 +1156,7 @@ extern int convert_to_git(const char *path, const char *src, size_t len,
                           struct strbuf *dst, enum safe_crlf checksafe);
 extern int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst);
 extern int renormalize_buffer(const char *path, const char *src, size_t len, struct strbuf *dst);
+extern int can_bypass_conversion(const char *path);
 
 /* add */
 /*
diff --git a/convert.c b/convert.c
index efc7e07..d3c0041 100644
--- a/convert.c
+++ b/convert.c
@@ -813,3 +813,26 @@ int renormalize_buffer(const char *path, const char *src, size_t len, struct str
 	}
 	return ret | convert_to_git(path, src, len, dst, 0);
 }
+
+/*
+ * You would be crazy to set CRLF, smuge/clean or ident to
+ * a large binary blob you would want us not to slurp into
+ * the memory!
+ */
+int can_bypass_conversion(const char *path)
+{
+	struct conv_attrs ca;
+	enum crlf_action crlf_action;
+
+	convert_attrs(&ca, path);
+
+	if (ca.ident ||
+	    (ca.drv && (ca.drv->smudge || ca.drv->clean)))
+		return 0;
+
+	crlf_action = input_crlf_action(ca.crlf_action, ca.eol_attr);
+	if ((crlf_action == CRLF_BINARY) ||
+	    (crlf_action == CRLF_GUESS && auto_crlf == AUTO_CRLF_FALSE))
+		return 1;
+	return 0;
+}
diff --git a/entry.c b/entry.c
index cc6502a..da37d01 100644
--- a/entry.c
+++ b/entry.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "blob.h"
 #include "dir.h"
+#include "streaming.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -114,6 +115,50 @@ static int fstat_output(int fd, const struct checkout *state, struct stat *st)
 	return 0;
 }
 
+static int streaming_write_entry(struct cache_entry *ce, char *path,
+				 const struct checkout *state, int to_tempfile,
+				 int *fstat_done, struct stat *statbuf)
+{
+	struct git_istream *st;
+	enum object_type type;
+	unsigned long sz;
+	int result = -1;
+	int fd = -1;
+
+	st = open_istream(ce->sha1, &type, &sz);
+	if (!st)
+		return -1;
+	if (type != OBJ_BLOB)
+		goto close_and_exit;
+
+	fd = open_output_fd(path, ce, to_tempfile);
+	if (fd < 0)
+		goto close_and_exit;
+
+	for (;;) {
+		char buf[10240];
+		ssize_t wrote;
+		ssize_t readlen = read_istream(st, buf, sizeof(buf));
+
+		if (!readlen)
+			break;
+
+		wrote = write_in_full(fd, buf, readlen);
+
+		if (wrote != readlen)
+			goto close_and_exit;
+	}
+	*fstat_done = fstat_output(fd, state, statbuf);
+
+close_and_exit:
+	close_istream(st);
+	if (0 <= fd)
+		result = close(fd);
+	if (result && 0 <= fd)
+		unlink(path);
+	return result;
+}
+
 static int write_entry(struct cache_entry *ce, char *path, const struct checkout *state, int to_tempfile)
 {
 	unsigned int ce_mode_s_ifmt = ce->ce_mode & S_IFMT;
@@ -124,6 +169,12 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 	size_t wrote, newsize = 0;
 	struct stat st;
 
+	if ((ce_mode_s_ifmt == S_IFREG) &&
+	    can_bypass_conversion(path) &&
+	    !streaming_write_entry(ce, path, state, to_tempfile,
+				   &fstat_done, &st))
+		goto finish;
+
 	switch (ce_mode_s_ifmt) {
 	case S_IFREG:
 	case S_IFLNK:
@@ -176,6 +227,7 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 		return error("unknown file mode for %s in index", path);
 	}
 
+finish:
 	if (state->refresh_cache) {
 		if (!fstat_done)
 			lstat(ce->name, &st);
-- 
1.7.5.2.369.g8fc017
