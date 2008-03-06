From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH v3] git-clean: correct printing relative path
Date: Thu, 6 Mar 2008 20:43:42 +0300
Message-ID: <20080306174342.GA32364@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 18:45:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXK8v-0001az-77
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 18:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765844AbYCFRnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 12:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbYCFRnw
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 12:43:52 -0500
Received: from ti-out-0910.google.com ([209.85.142.191]:20184 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765844AbYCFRnu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 12:43:50 -0500
Received: by ti-out-0910.google.com with SMTP id 28so2684694tif.23
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 09:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        bh=i5yAfLZbrmPbNx05bctR5mFv1BR+ZfWmoZW6NNdZcKs=;
        b=AqHvCjY5Icgknv99Ebbum0B7wQrtlmDGzSS/AWgoODsOu5x34TeI/R4FRvZt//g3fVD9YVP1OhymJ03zTYmhs/UxiHtKpkODBQFTxWneb9/WHuHXuMGjaA0Rp/ygh11p8XtYYGnEbUn/xdcKT+Wj4n4jrlJgpfX4/i/XaJskm2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=stbIIRtfeRuGnTiIfYNPtw0gWMhnJiKms9IWpk9wzIXAp8Zq1UzlR7wzVCaHFyb+UY2nMGkb3z1a00GprCpq6q1dGbDBJDdHTaye+dyYp0U7rOGydntXfhFPrFn1mMVQyWIQTdKNqIYCFpwJrfaGw9H2wat+801m0u0sLHReosg=
Received: by 10.150.182.17 with SMTP id e17mr8628ybf.190.1204825426653;
        Thu, 06 Mar 2008 09:43:46 -0800 (PST)
Received: from localhost ( [85.140.168.16])
        by mx.google.com with ESMTPS id j10sm3528779muh.16.2008.03.06.09.43.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Mar 2008 09:43:45 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76403>

When the given path contains '..' then git-clean incorrectly printed names
of files. This patch changes cmd_clean to use quote_path() from wt-status.
Also, "failed to remove ..." message used absolutely path, but not it is
corrected to use relative path.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
My previous patch printed an incorrect path in the case of a directory.
This was due to that 'qname' was determined before adding 'entry->name'
to 'directory'.

 builtin-clean.c |   32 ++++++++++++++------------------
 wt-status.c     |    4 ++--
 wt-status.h     |    2 ++
 3 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/builtin-clean.c b/builtin-clean.c
index 3b220d5..4b901fe 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -10,6 +10,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "parse-options.h"
+#include "wt-status.h"
 
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
+			qname = quote_path(directory.buf, directory.len, &buf, prefix);
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
+			qname = quote_path(ent->name, -1, &buf, prefix);
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
diff --git a/wt-status.c b/wt-status.c
index 32d780a..712fe91 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -82,8 +82,8 @@ static void wt_status_print_trailer(struct wt_status *s)
 	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
 }
 
-static char *quote_path(const char *in, int len,
-			struct strbuf *out, const char *prefix)
+char *quote_path(const char *in, int len,
+		struct strbuf *out, const char *prefix)
 {
 	if (len < 0)
 		len = strlen(in);
diff --git a/wt-status.h b/wt-status.h
index 02afaa6..4b46dda 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -32,5 +32,7 @@ int wt_status_use_color;
 int wt_status_relative_paths;
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
+char *quote_path(const char *in, int len,
+		struct strbuf *out, const char *prefix);
 
 #endif /* STATUS_H */
-- 
1.5.4

