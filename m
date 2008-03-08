From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH 2/2] git-clean: correct printing relative path
Date: Sat,  8 Mar 2008 22:33:36 +0300
Message-ID: <1205004816-28301-2-git-send-email-dpotapov@gmail.com>
References: <7vbq5r5czw.fsf@gitster.siamese.dyndns.org>
 <1205004816-28301-1-git-send-email-dpotapov@gmail.com>
Cc: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 20:34:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY4oS-0007J6-Vn
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 20:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755578AbYCHTdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 14:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755563AbYCHTdz
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 14:33:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:25792 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482AbYCHTdy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 14:33:54 -0500
Received: by ug-out-1314.google.com with SMTP id z38so4621410ugc.16
        for <git@vger.kernel.org>; Sat, 08 Mar 2008 11:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=l2At9WeGxXRPXcUhFd/51Asc0kiQz9FveEiiAZ609wQ=;
        b=vj1wg0ZT0owIfxveTpX570W0bcwgT9oVLKtyAPmVwqoNTkGsxUBjLSJSR7ktd3sou1XhxNfPDWhQGIE2OPsaZ7S7fER18/sXbtQfJDV/uyAo8SjF+273kiLY3uES03mgyrLOf8WFHZwEc6OlYA1KvAWb5Kxd8sU4uotZXt0w8as=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JNZvT6wDQTcxAlBBI7dWe8AfOcfK5lqly/FtrpuR1A7MuG2gCrUIHHj/x4S2fBt8h8aHGDNKGVpcqBuD9POPPPbBxPFiZYQJoy+fivfv8VDflJSSCw3Z9WHATVJvfdnvrCmtp3Cs4kM4QCyWl45IDNbU+JImUE9NGBUi7D7mHE0=
Received: by 10.78.164.9 with SMTP id m9mr8558818hue.30.1205004830917;
        Sat, 08 Mar 2008 11:33:50 -0800 (PST)
Received: from localhost ( [85.141.189.14])
        by mx.google.com with ESMTPS id w5sm20373253mue.2.2008.03.08.11.33.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Mar 2008 11:33:49 -0800 (PST)
X-Mailer: git-send-email 1.5.4
In-Reply-To: <1205004816-28301-1-git-send-email-dpotapov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76575>

When the given path contains '..' then git-clean incorrectly printed names
of files. This patch changes cmd_clean to use quote_path_relative().
Also, "failed to remove ..." message used absolutely path, but not it is
corrected to use relative path.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 builtin-clean.c |   32 ++++++++++++++------------------
 1 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/builtin-clean.c b/builtin-clean.c
index 3b220d5..fefec30 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -10,6 +10,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "parse-options.h"
+#include "quote.h"
 
 static int force = -1; /* unset */
 
@@ -34,7 +35,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	struct dir_struct dir;
 	const char *path, *base;
 	static const char **pathspec;
-	int prefix_offset = 0;
+	struct strbuf buf;
+	const char *qname;
 	char *seen = NULL;
 	struct option options[] = {
 		OPT__QUIET(&quiet),
@@ -56,6 +58,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, options, builtin_clean_usage, 0);
 
+	strbuf_init(&buf, 0);
 	memset(&dir, 0, sizeof(dir));
 	if (ignored_only)
 		dir.show_ignored = 1;
@@ -72,8 +75,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (!ignored)
 		setup_standard_excludes(&dir);
 
-	if (prefix)
-		prefix_offset = strlen(prefix);
 	pathspec = get_pathspec(prefix, argv);
 	read_cache();
 
@@ -134,39 +135,34 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 		if (S_ISDIR(st.st_mode)) {
 			strbuf_addstr(&directory, ent->name);
+			qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
 			if (show_only && (remove_directories || matches)) {
-				printf("Would remove %s\n",
-				       directory.buf + prefix_offset);
+				printf("Would remove %s\n", qname);
 			} else if (remove_directories || matches) {
 				if (!quiet)
-					printf("Removing %s\n",
-					       directory.buf + prefix_offset);
+					printf("Removing %s\n", qname);
 				if (remove_dir_recursively(&directory, 0) != 0) {
-					warning("failed to remove '%s'",
-						directory.buf + prefix_offset);
+					warning("failed to remove '%s'", qname);
 					errors++;
 				}
 			} else if (show_only) {
-				printf("Would not remove %s\n",
-				       directory.buf + prefix_offset);
+				printf("Would not remove %s\n", qname);
 			} else {
-				printf("Not removing %s\n",
-				       directory.buf + prefix_offset);
+				printf("Not removing %s\n", qname);
 			}
 			strbuf_reset(&directory);
 		} else {
 			if (pathspec && !matches)
 				continue;
+			qname = quote_path_relative(ent->name, -1, &buf, prefix);
 			if (show_only) {
-				printf("Would remove %s\n",
-				       ent->name + prefix_offset);
+				printf("Would remove %s\n", qname);
 				continue;
 			} else if (!quiet) {
-				printf("Removing %s\n",
-				       ent->name + prefix_offset);
+				printf("Removing %s\n", qname);
 			}
 			if (unlink(ent->name) != 0) {
-				warning("failed to remove '%s'", ent->name);
+				warning("failed to remove '%s'", qname);
 				errors++;
 			}
 		}
-- 
1.5.4.3.486.g3d6a2

