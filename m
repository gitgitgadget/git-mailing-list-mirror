From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] hash-object: add --literally option
Date: Thu, 11 Sep 2014 14:17:23 -0700
Message-ID: <1410470243-26552-4-git-send-email-gitster@pobox.com>
References: <xmqqoauldfij.fsf@gitster.dls.corp.google.com>
 <1410470243-26552-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 23:17:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSBkH-0004bn-Vl
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 23:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757541AbaIKVRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 17:17:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56141 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757536AbaIKVRc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 17:17:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0CB9B3ACE7;
	Thu, 11 Sep 2014 17:17:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=FE5O
	Rgc1lMJIKx/C/6NgXGKs4ig=; b=qxddiODXNpEyhh0kwfZE3pKETAidV8+GTYyS
	9FWxXScx+U9JR63UAr0qW2vd4Z2GK6JwWZFKfQyRxtHc4NRCj/weC7dbsFOKPCpU
	fzTb9Nchf1FnqHTWAYimXxfseKIMnd65bg4/nisBZ3FJfWpvPAUffLr2RhC6HxKC
	3JH3L8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=p3ksOM
	m+lXWslueHnIkxX+8/XCRr9lyWV7qN/9p5JMOFeURitWrT3ayg8/W6uvZuvHIuFm
	MmP8skz/nKrpNGTLfUzx1dwfVnud+8wqsYkdlR3RblXcK9maTjGSY9iFHJIRgavc
	f0WQ6bnNb1C1t5FZoErr7pYdNW8XWQQjGgVVw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 038A73ACE6;
	Thu, 11 Sep 2014 17:17:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 74C663ACE5;
	Thu, 11 Sep 2014 17:17:31 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-459-g1bc3b2b
In-Reply-To: <1410470243-26552-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0A90EEBC-39F9-11E4-ADDC-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256879>

This is allows "hash-object --stdin" to just hash any garbage into a
"loose object" that may not pass the standard object parsing check
or fsck, so that different kind of corrupt objects third-party tools
may create can be imitated in our test suite.  That would in turn
allow us to test features that catch these corrupt objects.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/hash-object.c | 45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 1fb07ee..6158363 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -10,13 +10,36 @@
 #include "parse-options.h"
 #include "exec_cmd.h"
 
-static void hash_fd(int fd, const char *type, const char *path, unsigned flags)
+/*
+ * This is to create corrupt objects for debugging and as such it
+ * needs to bypass the data conversion performed by, and the type
+ * limitation imposed by, index_fd() and its callees.
+ */
+static int hash_literally(unsigned char *sha1, int fd, const char *type, unsigned flags)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int ret;
+
+	if (strbuf_read(&buf, fd, 4096) < 0)
+		ret = -1;
+	else if (flags & HASH_WRITE_OBJECT)
+		ret = write_sha1_file(buf.buf, buf.len, type, sha1);
+	else
+		ret = hash_sha1_file(buf.buf, buf.len, type, sha1);
+	strbuf_release(&buf);
+	return ret;
+}
+
+static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
+		    int literally)
 {
 	struct stat st;
 	unsigned char sha1[20];
 
 	if (fstat(fd, &st) < 0 ||
-	    index_fd(sha1, fd, &st, type_from_string(type), path, flags))
+	    (literally
+	     ? hash_literally(sha1, fd, type, flags)
+	     : index_fd(sha1, fd, &st, type_from_string(type), path, flags)))
 		die((flags & HASH_WRITE_OBJECT)
 		    ? "Unable to add %s to database"
 		    : "Unable to hash %s", path);
@@ -25,16 +48,17 @@ static void hash_fd(int fd, const char *type, const char *path, unsigned flags)
 }
 
 static void hash_object(const char *path, const char *type, const char *vpath,
-			unsigned flags)
+			unsigned flags, int literally)
 {
 	int fd;
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
 		die_errno("Cannot open '%s'", path);
-	hash_fd(fd, type, vpath, flags);
+	hash_fd(fd, type, vpath, flags, literally);
 }
 
-static void hash_stdin_paths(const char *type, int no_filters, unsigned flags)
+static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
+			     int literally)
 {
 	struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
 
@@ -45,7 +69,8 @@ static void hash_stdin_paths(const char *type, int no_filters, unsigned flags)
 				die("line is badly quoted");
 			strbuf_swap(&buf, &nbuf);
 		}
-		hash_object(buf.buf, type, no_filters ? NULL : buf.buf, flags);
+		hash_object(buf.buf, type, no_filters ? NULL : buf.buf, flags,
+			    literally);
 	}
 	strbuf_release(&buf);
 	strbuf_release(&nbuf);
@@ -62,6 +87,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	int hashstdin = 0;
 	int stdin_paths = 0;
 	int no_filters = 0;
+	int literally = 0;
 	unsigned flags = HASH_FORMAT_CHECK;
 	const char *vpath = NULL;
 	const struct option hash_object_options[] = {
@@ -71,6 +97,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 		OPT_COUNTUP( 0 , "stdin", &hashstdin, N_("read the object from stdin")),
 		OPT_BOOL( 0 , "stdin-paths", &stdin_paths, N_("read file names from stdin")),
 		OPT_BOOL( 0 , "no-filters", &no_filters, N_("store file as is without filters")),
+		OPT_BOOL( 0, "literally", &literally, N_("just hash any random garbage to create corrupt objects for debugging Git")),
 		OPT_STRING( 0 , "path", &vpath, N_("file"), N_("process file as it were from this path")),
 		OPT_END()
 	};
@@ -111,7 +138,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	}
 
 	if (hashstdin)
-		hash_fd(0, type, vpath, flags);
+		hash_fd(0, type, vpath, flags, literally);
 
 	for (i = 0 ; i < argc; i++) {
 		const char *arg = argv[i];
@@ -119,11 +146,11 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 		if (0 <= prefix_length)
 			arg = prefix_filename(prefix, prefix_length, arg);
 		hash_object(arg, type, no_filters ? NULL : vpath ? vpath : arg,
-			    flags);
+			    flags, literally);
 	}
 
 	if (stdin_paths)
-		hash_stdin_paths(type, no_filters, flags);
+		hash_stdin_paths(type, no_filters, flags, literally);
 
 	return 0;
 }
-- 
2.1.0-459-g1bc3b2b
