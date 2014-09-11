From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] hash-object: reduce file-scope statics
Date: Thu, 11 Sep 2014 14:17:21 -0700
Message-ID: <1410470243-26552-2-git-send-email-gitster@pobox.com>
References: <xmqqoauldfij.fsf@gitster.dls.corp.google.com>
 <1410470243-26552-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 23:17:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSBkG-0004bn-Ur
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 23:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757535AbaIKVRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 17:17:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56905 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbaIKVR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 17:17:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 130D03ACE0;
	Thu, 11 Sep 2014 17:17:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=kxhq
	ws8piZwCpkl3L6CgIhbrBiw=; b=lbmy5aZRO5zCmjR/2tIYzYA/m8wH0FSYxR6q
	dyxDGfAzJ+zj4ChEzsbKUd4xvzTU1lj2i0VsEunlH/3+NOLdtO5P5JvCwNuv9JQr
	0Qlq3e1ibyFP+MLSc6uuJvCmS79B58z+5JQpVyncofDXSq9+Qp4wEUZq46Uz2/6k
	zsYyquY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=dhftGP
	SFo6FkBl3S8r+a33DH5PYu2Sd2pRwTBW90BMNEJ83OJKIHihdjZldvyy9HUiz98q
	8y3Xbl1l9WMlU1iALsuOSVQCKldZTab0jBuKMmLVIMrElLxJ2DJ5PoLZ1RflZzge
	LX8e779l5bH1UlY4Wl5nhUktVw+s/Po638lvc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 08E7A3ACDF;
	Thu, 11 Sep 2014 17:17:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7F1753ACDE;
	Thu, 11 Sep 2014 17:17:27 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-459-g1bc3b2b
In-Reply-To: <1410470243-26552-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0834D6CE-39F9-11E4-A257-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256880>

Most of the knobs that affect helper functions called from
cmd_hash_object() were passed to them as parameters already, and the
only effect of having them as file-scope statics was to make the
reader wonder if the parameters are hiding the file-scope global
values by accident.  Adjust their initialisation and make them
function-local variables.

The only exception was no_filters hash_stdin_paths() peeked from the
file-scope global, which was converted to a parameter to the helper
function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/hash-object.c | 52 +++++++++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index d7fcf4c..40008e2 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -36,9 +36,7 @@ static void hash_object(const char *path, const char *type, int write_object,
 	hash_fd(fd, type, write_object, vpath);
 }
 
-static int no_filters;
-
-static void hash_stdin_paths(const char *type, int write_objects)
+static void hash_stdin_paths(const char *type, int write_objects, int no_filters)
 {
 	struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
 
@@ -50,42 +48,38 @@ static void hash_stdin_paths(const char *type, int write_objects)
 			strbuf_swap(&buf, &nbuf);
 		}
 		hash_object(buf.buf, type, write_objects,
-		    no_filters ? NULL : buf.buf);
+			    no_filters ? NULL : buf.buf);
 	}
 	strbuf_release(&buf);
 	strbuf_release(&nbuf);
 }
 
-static const char * const hash_object_usage[] = {
-	N_("git hash-object [-t <type>] [-w] [--path=<file>|--no-filters] [--stdin] [--] <file>..."),
-	N_("git hash-object  --stdin-paths < <list-of-paths>"),
-	NULL
-};
-
-static const char *type;
-static int write_object;
-static int hashstdin;
-static int stdin_paths;
-static const char *vpath;
-
-static const struct option hash_object_options[] = {
-	OPT_STRING('t', NULL, &type, N_("type"), N_("object type")),
-	OPT_BOOL('w', NULL, &write_object, N_("write the object into the object database")),
-	OPT_COUNTUP( 0 , "stdin", &hashstdin, N_("read the object from stdin")),
-	OPT_BOOL( 0 , "stdin-paths", &stdin_paths, N_("read file names from stdin")),
-	OPT_BOOL( 0 , "no-filters", &no_filters, N_("store file as is without filters")),
-	OPT_STRING( 0 , "path", &vpath, N_("file"), N_("process file as it were from this path")),
-	OPT_END()
-};
-
 int cmd_hash_object(int argc, const char **argv, const char *prefix)
 {
+	static const char * const hash_object_usage[] = {
+		N_("git hash-object [-t <type>] [-w] [--path=<file>|--no-filters] [--stdin] [--] <file>..."),
+		N_("git hash-object  --stdin-paths < <list-of-paths>"),
+		NULL
+	};
+	const char *type = blob_type;
+	int hashstdin = 0;
+	int stdin_paths = 0;
+	int write_object = 0;
+	int no_filters = 0;
+	const char *vpath = NULL;
+	const struct option hash_object_options[] = {
+		OPT_STRING('t', NULL, &type, N_("type"), N_("object type")),
+		OPT_BOOL('w', NULL, &write_object, N_("write the object into the object database")),
+		OPT_COUNTUP( 0 , "stdin", &hashstdin, N_("read the object from stdin")),
+		OPT_BOOL( 0 , "stdin-paths", &stdin_paths, N_("read file names from stdin")),
+		OPT_BOOL( 0 , "no-filters", &no_filters, N_("store file as is without filters")),
+		OPT_STRING( 0 , "path", &vpath, N_("file"), N_("process file as it were from this path")),
+		OPT_END()
+	};
 	int i;
 	int prefix_length = -1;
 	const char *errstr = NULL;
 
-	type = blob_type;
-
 	argc = parse_options(argc, argv, NULL, hash_object_options,
 			     hash_object_usage, 0);
 
@@ -131,7 +125,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	}
 
 	if (stdin_paths)
-		hash_stdin_paths(type, write_object);
+		hash_stdin_paths(type, write_object, no_filters);
 
 	return 0;
 }
-- 
2.1.0-459-g1bc3b2b
