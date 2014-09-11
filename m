From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] hash-object: pass 'write_object' as a flag
Date: Thu, 11 Sep 2014 14:17:22 -0700
Message-ID: <1410470243-26552-3-git-send-email-gitster@pobox.com>
References: <xmqqoauldfij.fsf@gitster.dls.corp.google.com>
 <1410470243-26552-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 23:17:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSBkH-0004bn-FJ
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 23:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757540AbaIKVRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 17:17:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58172 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbaIKVRa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 17:17:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 03AB73ACE3;
	Thu, 11 Sep 2014 17:17:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Y0PK
	RtMz41I2suuWqqk9shKPKc0=; b=x5QNVtN5pUebt5elr6mgG9yowZneKQgAhytk
	Bj88CHbXbKVFm1M8zsr/wsEEfeFsI1ppaTaSsUo2SbxLOLBoQcq6GWeTqQO3RvTn
	hOQWLaJr1tRXEGDuiHOMMJ9ybtV3sd10BYDPFvB3sIaXZyvN20txv0JvqLDcl5v9
	VWwyxjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=c/sOrv
	jddAUJzjfkl3V6hMDo1bRrLNR3+jxwM7j2xLseD7roD05qfR4YOSmLXo/FKw2Y59
	Ihogs8VRpEmffw1iMHI8j52Qj1lhMc5URxX/AkewYMAFBJOCvAaS2luwdLjXZaXr
	R2ga5HyPIuPMccCY6LyjVIEftQN94fDl1YAU4=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EE2CD3ACE2;
	Thu, 11 Sep 2014 17:17:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7072D3ACE1;
	Thu, 11 Sep 2014 17:17:29 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-459-g1bc3b2b
In-Reply-To: <1410470243-26552-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 095CF4AA-39F9-11E4-9AB3-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256881>

Instead of forcing callers of lower level functions write
(write_object ? HASH_WRITE_OBJECT : 0), prepare the flag to be
passed down in the callchain from the command line parser.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/hash-object.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 40008e2..1fb07ee 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -10,33 +10,31 @@
 #include "parse-options.h"
 #include "exec_cmd.h"
 
-static void hash_fd(int fd, const char *type, int write_object, const char *path)
+static void hash_fd(int fd, const char *type, const char *path, unsigned flags)
 {
 	struct stat st;
 	unsigned char sha1[20];
-	unsigned flags = (HASH_FORMAT_CHECK |
-			  (write_object ? HASH_WRITE_OBJECT : 0));
 
 	if (fstat(fd, &st) < 0 ||
 	    index_fd(sha1, fd, &st, type_from_string(type), path, flags))
-		die(write_object
+		die((flags & HASH_WRITE_OBJECT)
 		    ? "Unable to add %s to database"
 		    : "Unable to hash %s", path);
 	printf("%s\n", sha1_to_hex(sha1));
 	maybe_flush_or_die(stdout, "hash to stdout");
 }
 
-static void hash_object(const char *path, const char *type, int write_object,
-			const char *vpath)
+static void hash_object(const char *path, const char *type, const char *vpath,
+			unsigned flags)
 {
 	int fd;
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
 		die_errno("Cannot open '%s'", path);
-	hash_fd(fd, type, write_object, vpath);
+	hash_fd(fd, type, vpath, flags);
 }
 
-static void hash_stdin_paths(const char *type, int write_objects, int no_filters)
+static void hash_stdin_paths(const char *type, int no_filters, unsigned flags)
 {
 	struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
 
@@ -47,8 +45,7 @@ static void hash_stdin_paths(const char *type, int write_objects, int no_filters
 				die("line is badly quoted");
 			strbuf_swap(&buf, &nbuf);
 		}
-		hash_object(buf.buf, type, write_objects,
-			    no_filters ? NULL : buf.buf);
+		hash_object(buf.buf, type, no_filters ? NULL : buf.buf, flags);
 	}
 	strbuf_release(&buf);
 	strbuf_release(&nbuf);
@@ -64,12 +61,13 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	const char *type = blob_type;
 	int hashstdin = 0;
 	int stdin_paths = 0;
-	int write_object = 0;
 	int no_filters = 0;
+	unsigned flags = HASH_FORMAT_CHECK;
 	const char *vpath = NULL;
 	const struct option hash_object_options[] = {
 		OPT_STRING('t', NULL, &type, N_("type"), N_("object type")),
-		OPT_BOOL('w', NULL, &write_object, N_("write the object into the object database")),
+		OPT_BIT('w', NULL, &flags, N_("write the object into the object database"),
+			HASH_WRITE_OBJECT),
 		OPT_COUNTUP( 0 , "stdin", &hashstdin, N_("read the object from stdin")),
 		OPT_BOOL( 0 , "stdin-paths", &stdin_paths, N_("read file names from stdin")),
 		OPT_BOOL( 0 , "no-filters", &no_filters, N_("store file as is without filters")),
@@ -83,7 +81,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, NULL, hash_object_options,
 			     hash_object_usage, 0);
 
-	if (write_object) {
+	if (flags & HASH_WRITE_OBJECT) {
 		prefix = setup_git_directory();
 		prefix_length = prefix ? strlen(prefix) : 0;
 		if (vpath && prefix)
@@ -113,19 +111,19 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	}
 
 	if (hashstdin)
-		hash_fd(0, type, write_object, vpath);
+		hash_fd(0, type, vpath, flags);
 
 	for (i = 0 ; i < argc; i++) {
 		const char *arg = argv[i];
 
 		if (0 <= prefix_length)
 			arg = prefix_filename(prefix, prefix_length, arg);
-		hash_object(arg, type, write_object,
-			    no_filters ? NULL : vpath ? vpath : arg);
+		hash_object(arg, type, no_filters ? NULL : vpath ? vpath : arg,
+			    flags);
 	}
 
 	if (stdin_paths)
-		hash_stdin_paths(type, write_object, no_filters);
+		hash_stdin_paths(type, no_filters, flags);
 
 	return 0;
 }
-- 
2.1.0-459-g1bc3b2b
