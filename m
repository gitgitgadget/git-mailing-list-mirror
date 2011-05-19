From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/11] streaming_write_entry(): use streaming API in
 write_entry()
Date: Thu, 19 May 2011 14:33:42 -0700
Message-ID: <1305840826-7783-8-git-send-email-gitster@pobox.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
 <1305840826-7783-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 23:35:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNAst-0007T2-Ii
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 23:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934837Ab1ESVfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 17:35:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33583 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934839Ab1ESVeG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 17:34:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 992CC52B5
	for <git@vger.kernel.org>; Thu, 19 May 2011 17:36:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ZxFm
	eBkqQxe1PFMeemF9tukmq7o=; b=M1luyL6KA/6IPcd1LKjLbP6WbfwwvvCgHZDs
	xxnHN5jPV1DVfK1PzWCakyr89jSKiccH/AIne80oqB4VlM1YEczhSqkt4HA5g5JW
	9/0bqsdbmKCFTQQH9wfQ5eX1F0dD9gfpw+6AS2dn4+X6KkP3J1Zvo57q4dmVhZQr
	WsjbJKM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=NW7al1
	D107KKcDwJFwnNLIGRgaLFf6mvyfWQYkyZhvUHKJRjUUSAcOZ6HgfWWRgLxC+JJG
	9v7/B9IVW4jHa43eaPXDEO/zB1whAnoEkmR06TynL95gaL9mff0KqPLUy3XRtN3v
	h2LUGb8caTLeCOawSlKV2FHCn/JP6mHqhyyow=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 93CE052B4
	for <git@vger.kernel.org>; Thu, 19 May 2011 17:36:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A2E2D52B1 for
 <git@vger.kernel.org>; Thu, 19 May 2011 17:36:12 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.416.gac10c8
In-Reply-To: <1305840826-7783-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0517FEE8-8260-11E0-AE6D-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174024>

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
index 38e14b2..8c5bb8a 100644
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
index cc6502a..7733a6b 100644
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
+		result |= close(fd);
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
1.7.5.1.416.gac10c8
