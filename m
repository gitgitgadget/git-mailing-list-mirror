From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v0 3/3] Bigfile: teach "git add" to send a large file
 straight to a pack
Date: Sun,  8 May 2011 01:47:35 -0700
Message-ID: <1304844455-23570-4-git-send-email-gitster@pobox.com>
References: <1304844455-23570-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 10:47:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIzea-0004V0-8H
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 10:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806Ab1EHIrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 04:47:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43908 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab1EHIrp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 04:47:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A64A24E03
	for <git@vger.kernel.org>; Sun,  8 May 2011 04:49:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=srw7
	av9/r7HApHm+e/+D+Tt4Nsc=; b=evGOPWW5qKMK2KW67NxAgJeq9i1T1quA357u
	l6DIpumgms/gVbkFsitY8AwmDu1lJHYyrfgGWCHuKltUkIEi2fGtE4rQSaVtK1Op
	8C6jQPWIhNTOwMfFqI2CRv/vXN8j2OOJF0eeZQWNbOQQ+jZA9IoWFHQEO8SMnxDc
	cinpK8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=jRBpxG
	Coh/guUICto3DMtz3o+bYe3kerg0xY2VBe/zN9AgPvy7tqJ9Af3PN8wuw16aRK4g
	gKfPprjN/4jzlSgY+0r4x2xl4vSSoNG8LTqZiA61fNJ7pgXNCUt4SoPRyO6x++4g
	YFGZcpSoqkgOGLVxFwGH0s55CK57/4UHSUSUU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A37FF4E02
	for <git@vger.kernel.org>; Sun,  8 May 2011 04:49:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B2DB54E01 for
 <git@vger.kernel.org>; Sun,  8 May 2011 04:49:47 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.268.gce5bd
In-Reply-To: <1304844455-23570-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2160B180-7950-11E0-BD5C-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173084>

When adding a new content to the repository, we have always slurped
the blob in its entirety in-core first, and computed the object name
and compressed it into a loose object file.  Handling large binary
files (e.g.  video and audio asset for games) has been problematic
because of this design.

At the middle level of "git add" callchain is an internal API
index_fd() that takes an open file descriptor to read from the
working tree file being added with its size. Teach it to call out to
fast-import when adding a large blob.

This is merely a POC that has two large "NEEDSWORK" items.

 * The code in this patch runs fast-import via start_command() API;
   because the caller needs the object name, we can only stuff one
   object per pack (see in-code comments for future directions for a
   possible solution).

 * The decision to stream in this patch is based on the size of the
   blob, but it should be tied to an attribute, "bigdata". The
   attribute should also mean the blob will not undergo any
   convert-to-git processing.

The write-out codepath in entry.c::write_entry() should be taught to
stream, instead of reading everything in core. This should not be so
hard to implement, especially if we limit ourselves only to loose
object files and non-delta representation in packfiles.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c      |  102 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 t/t1050-large.sh |   22 ++++++++++++
 2 files changed, 123 insertions(+), 1 deletions(-)
 create mode 100755 t/t1050-large.sh

diff --git a/sha1_file.c b/sha1_file.c
index 49416b0..ef1a698 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -11,6 +11,7 @@
 #include "pack.h"
 #include "blob.h"
 #include "commit.h"
+#include "run-command.h"
 #include "tag.h"
 #include "tree.h"
 #include "tree-walk.h"
@@ -2658,6 +2659,103 @@ static int index_core(unsigned char *sha1, int fd, size_t size,
 	return ret;
 }
 
+/*
+ * NEEDSWORK: This creates one packfile per large blob, because the
+ * caller immediately wants the result sha1, and fast-import can
+ * report the object name via marks mechanism only by closing the
+ * created packfile. We should instead add an internal "stuff objects
+ * into a single pack, all in non-delta representation, keeping track
+ * of only <object-name, offset> tuples in core" API, that keeps one
+ * append-only packfile open at a time.  Have the first call to this
+ * function open a packfile on demand, and make sure the caller calls
+ * another function in the API to close the packfile at end, at which
+ * point the in-core tuples of <object-name, offset> should be written
+ * out as a corresponding pack .idx file and the tentative .pack file
+ * renamed to the final name.
+ *
+ * This also bypasses the usual "convert-to-git" dance, but that is on
+ * purpose. We could write a streaming version of the converting
+ * functions and insert that before feeding the data to fast-import
+ * (or equivalent in-core API described above), but the primary
+ * motivation for trying to stream from the working tree file and to
+ * avoid mmaping it in core is to deal with large binary blobs, and
+ * by definition they do _not_ want to get any conversion.
+ */
+static int index_stream(unsigned char *sha1, int fd, size_t size,
+			enum object_type type, const char *path,
+			unsigned flags)
+{
+	struct child_process fast_import;
+	char export_marks[512];
+	const char *argv[] = { "fast-import", "--quiet", export_marks, NULL };
+	char tmpfile[512];
+	char fast_import_cmd[512];
+	char buf[512];
+	int len, tmpfd;
+
+	strcpy(tmpfile, git_path("hashstream_XXXXXX"));
+	tmpfd = git_mkstemp_mode(tmpfile, 0600);
+	if (tmpfd < 0)
+		die_errno("cannot create tempfile: %s", tmpfile);
+	if (close(tmpfd))
+		die_errno("cannot close tempfile: %s", tmpfile);
+	sprintf(export_marks, "--export-marks=%s", tmpfile);
+
+	memset(&fast_import, 0, sizeof(fast_import));
+	fast_import.in = -1;
+	fast_import.argv = argv;
+	fast_import.git_cmd = 1;
+	if (start_command(&fast_import))
+		die_errno("index-stream: git fast-import failed");
+
+	len = sprintf(fast_import_cmd, "blob\nmark :1\ndata %lu\n",
+		      (unsigned long) size);
+	write_or_whine(fast_import.in, fast_import_cmd, len,
+		       "index-stream: feeding fast-import");
+	while (size) {
+		char buf[10240];
+		size_t sz = size < sizeof(buf) ? size : sizeof(buf);
+		size_t actual;
+
+		actual = read_in_full(fd, buf, sz);
+		if (actual < 0)
+			die_errno("index-stream: reading input");
+		if (write_in_full(fast_import.in, buf, actual) != actual)
+			die_errno("index-stream: feeding fast-import");
+		size -= actual;
+	}
+	if (close(fast_import.in))
+		die_errno("index-stream: closing fast-import");
+	if (finish_command(&fast_import))
+		die_errno("index-stream: finishing fast-import");
+
+	tmpfd = open(tmpfile, O_RDONLY);
+	if (tmpfd < 0)
+		die_errno("index-stream: cannot open fast-import mark");
+	len = read(tmpfd, buf, sizeof(buf));
+	if (len < 0)
+		die_errno("index-stream: reading fast-import mark");
+	if (close(tmpfd) < 0)
+		die_errno("index-stream: closing fast-import mark");
+	if (unlink(tmpfile))
+		die_errno("index-stream: unlinking fast-import mark");
+	if (len != 44 ||
+	    memcmp(":1 ", buf, 3) ||
+	    get_sha1_hex(buf + 3, sha1))
+		die_errno("index-stream: unexpected fast-import mark: <%s>", buf);
+	return 0;
+}
+
+/*
+ * NEEDSWORK: Currently, we choose blobs that are bigger than
+ * core.bigFileThreshold to send out to a pack, but we might want to
+ * control this by choosing any blob that has "bigdata" attribute on
+ * path, regardless of its size. By design, index_stream() ignores
+ * any "convert-to-git" conversions, so associating an attribute with
+ * the logic to choose which paths to give index_stream() makes it
+ * easier to explain---we can say "bigdata will trump all the crlf,
+ * clean, smudge, ident and any other conversion related crap.
+ */
 int index_fd(unsigned char *sha1, int fd, struct stat *st,
 	     enum object_type type, const char *path, unsigned flags)
 {
@@ -2666,8 +2764,10 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st,
 
 	if (!S_ISREG(st->st_mode))
 		ret = index_pipe(sha1, fd, type, path, flags);
-	else
+	else if (size <= big_file_threshold && type != OBJ_BLOB)
 		ret = index_core(sha1, fd, size, type, path, flags);
+	else
+		ret = index_stream(sha1, fd, size, type, path, flags);
 	close(fd);
 	return ret;
 }
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
new file mode 100755
index 0000000..489c0f0
--- /dev/null
+++ b/t/t1050-large.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+# Copyright (c) 2011, Google Inc.
+
+test_description='adding and checking out large blobs'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	git config core.bigfilethreshold 200k &&
+	echo X | dd of=large bs=1k seek=2000
+'
+
+test_expect_success 'add a large file' '
+	git add large &&
+	git cat-file blob :large >actual &&
+	# make sure we got a packfile and no loose objects
+	test -f .git/objects/pack/pack-*.pack &&
+	test ! -f .git/objects/??/?????????????????????????????????????? &&
+	cmp -s large actual  # This should be "cmp", not "test_cmp"
+'
+
+test_done
-- 
1.7.5.1.268.gce5bd
