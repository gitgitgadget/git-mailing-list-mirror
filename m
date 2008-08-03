From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH 3/5] use parse_options() in git hash-object
Date: Sun,  3 Aug 2008 18:36:20 +0400
Message-ID: <1217774182-28566-3-git-send-email-dpotapov@gmail.com>
References: <20080803055602.GN7008@dpotapov.dyndns.org>
 <1217774182-28566-1-git-send-email-dpotapov@gmail.com>
 <1217774182-28566-2-git-send-email-dpotapov@gmail.com>
Cc: Alexander Litvinov <litvinov2004@gmail.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 16:37:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPeiG-0007u3-K0
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 16:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908AbYHCOgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 10:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755871AbYHCOgh
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 10:36:37 -0400
Received: from ik-out-1112.google.com ([66.249.90.179]:7497 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755859AbYHCOgg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 10:36:36 -0400
Received: by ik-out-1112.google.com with SMTP id c28so2127626ika.5
        for <git@vger.kernel.org>; Sun, 03 Aug 2008 07:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XaFVyob78zLvXeAtrxhh43LUGJaNByxoypPTuDqvAYc=;
        b=Zbm/ENIhQxoIOJ2UxVfnhOhyfggK7mPxN9dlfkcaYhdWba3Hhf7nLmy4cpj6iqMLpn
         2U8rmxPMgRRNKsZhDAaKAo6xfmtEk1/XVfHOUPkMYc1oOYHjMg0Tff1rnqXgexIQDww8
         5gLF/g2q0Spp+auyGbNtB4Cmu+qLtRD8+dyJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NN1rtLvar3sel3/QPE5DsvYhkk3SeFIHGjcl5GuHcQ6zRwC/gYJH+TjIfy51O/Uo+V
         mw8M7iE9CAPpzjQDkWLHpz1kPnrHP2bNeE7HE/VYUKpmbL+BpjFhY0YxFNOQvyKS5o0S
         oYcHlimH/3LbbSYvYSRBKFvwiTjsL7ChiezoI=
Received: by 10.210.68.17 with SMTP id q17mr12361328eba.118.1217774195476;
        Sun, 03 Aug 2008 07:36:35 -0700 (PDT)
Received: from localhost ( [85.141.191.110])
        by mx.google.com with ESMTPS id 34sm15033700nfu.24.2008.08.03.07.36.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Aug 2008 07:36:34 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc1.58.gacdf
In-Reply-To: <1217774182-28566-2-git-send-email-dpotapov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91245>

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 hash-object.c |  122 +++++++++++++++++++++++++--------------------------------
 1 files changed, 53 insertions(+), 69 deletions(-)

diff --git a/hash-object.c b/hash-object.c
index ac44b4e..b658fae 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "blob.h"
 #include "quote.h"
+#include "parse-options.h"
 
 static void hash_fd(int fd, const char *type, int write_object, const char *path)
 {
@@ -48,87 +49,70 @@ static void hash_stdin_paths(const char *type, int write_objects)
 	strbuf_release(&nbuf);
 }
 
-static const char hash_object_usage[] =
-"git hash-object [-t <type>] [-w] [--stdin] [--] <file>...\n"
-"   or: git hash-object  --stdin-paths < <list-of-paths>";
+static const char * const hash_object_usage[] = {
+	"git hash-object [-t <type>] [-w] [--stdin] [--] <file>...",
+	"git hash-object  --stdin-paths < <list-of-paths>",
+	NULL
+};
 
-int main(int argc, char **argv)
+static const char *type;
+static int write_object;
+static int hashstdin;
+static int stdin_paths;
+
+static const struct option hash_object_options[] = {
+	OPT_STRING('t', NULL, &type, "type", "object type"),
+	OPT_BOOLEAN('w', NULL, &write_object, "write the object into the object database"),
+	OPT_BOOLEAN( 0 , "stdin", &hashstdin, "read the object from stdin"),
+	OPT_BOOLEAN( 0 , "stdin-paths", &stdin_paths, "read file names from stdin"),
+	OPT_END()
+};
+
+int main(int argc, const char **argv)
 {
 	int i;
-	const char *type = blob_type;
-	int write_object = 0;
 	const char *prefix = NULL;
 	int prefix_length = -1;
-	int no_more_flags = 0;
-	int hashstdin = 0;
-	int stdin_paths = 0;
+	const char *errstr = NULL;
+
+	type = blob_type;
 
 	git_config(git_default_config, NULL);
 
-	for (i = 1 ; i < argc; i++) {
-		if (!no_more_flags && argv[i][0] == '-') {
-			if (!strcmp(argv[i], "-t")) {
-				if (argc <= ++i)
-					usage(hash_object_usage);
-				type = argv[i];
-			}
-			else if (!strcmp(argv[i], "-w")) {
-				if (prefix_length < 0) {
-					prefix = setup_git_directory();
-					prefix_length =
-						prefix ? strlen(prefix) : 0;
-				}
-				write_object = 1;
-			}
-			else if (!strcmp(argv[i], "--")) {
-				no_more_flags = 1;
-			}
-			else if (!strcmp(argv[i], "--help"))
-				usage(hash_object_usage);
-			else if (!strcmp(argv[i], "--stdin-paths")) {
-				if (hashstdin) {
-					error("Can't use --stdin-paths with --stdin");
-					usage(hash_object_usage);
-				}
-				stdin_paths = 1;
-
-			}
-			else if (!strcmp(argv[i], "--stdin")) {
-				if (stdin_paths) {
-					error("Can't use %s with --stdin-paths", argv[i]);
-					usage(hash_object_usage);
-				}
-				if (hashstdin)
-					die("Multiple --stdin arguments are not supported");
-				hashstdin = 1;
-			}
-			else
-				usage(hash_object_usage);
-		}
-		else {
-			const char *arg = argv[i];
-
-			if (stdin_paths) {
-				error("Can't specify files (such as \"%s\") with --stdin-paths", arg);
-				usage(hash_object_usage);
-			}
-
-			if (hashstdin) {
-				hash_fd(0, type, write_object, NULL);
-				hashstdin = 0;
-			}
-			if (0 <= prefix_length)
-				arg = prefix_filename(prefix, prefix_length,
-						      arg);
-			hash_object(arg, type, write_object);
-			no_more_flags = 1;
-		}
+	argc = parse_options(argc, argv, hash_object_options, hash_object_usage, 0);
+
+	if (write_object) {
+		prefix = setup_git_directory();
+		prefix_length = prefix ? strlen(prefix) : 0;
 	}
 
-	if (stdin_paths)
-		hash_stdin_paths(type, write_object);
+	if (stdin_paths) {
+		if (hashstdin)
+			errstr = "Can't use --stdin-paths with --stdin";
+		else if (argc)
+			errstr = "Can't specify files with --stdin-paths";
+	}
+	else if (hashstdin > 1)
+		errstr = "Multiple --stdin arguments are not supported";
+
+	if (errstr) {
+		error (errstr);
+		usage_with_options(hash_object_usage, hash_object_options);
+	}
 
 	if (hashstdin)
 		hash_fd(0, type, write_object, NULL);
+
+	for (i = 0 ; i < argc; i++) {
+		const char *arg = argv[i];
+
+		if (0 <= prefix_length)
+			arg = prefix_filename(prefix, prefix_length, arg);
+		hash_object(arg, type, write_object);
+	}
+
+	if (stdin_paths)
+		hash_stdin_paths(type, write_object);
+
 	return 0;
 }
-- 
1.6.0.rc1.58.gacdf
