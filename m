From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH v2] git-clean: correct printing relative path
Date: Thu, 6 Mar 2008 02:51:05 +0300
Message-ID: <20080305235105.GE11519@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 00:51:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX3Or-0001UW-O5
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 00:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756720AbYCEXvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 18:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756207AbYCEXvM
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 18:51:12 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:28317 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755453AbYCEXvK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 18:51:10 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2005894fga.17
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 15:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        bh=0n3uJ6GBcx3PPX7OgFFGcxGaXQxI1ECzU+ucJFUF2Nw=;
        b=kG2K7gpEIQg9Fa0p3d0RaYElvY9u8qjydcp0b+g3CJ+diZLX1d9usXOlXhvTmt6l/6gqg+8gVOACIO2EuYt5KOROW8jkSdfWwVuH0hYocnzSs8Sq0hrXznCvqzrfp3v+YhkgXPErIb+/mrDNAHQ94ewlha3Njxm4dsz5zwYTEJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=esOI5o6EQuFxrGwhgDxlJVwcQ+bM+SZpsDPmCAMZUye63K/6RLeGLXaVByAMRwjk24KAyBzssphpKC3ruauksa3QCrqjiCI4hWlUV1YZXhr02yAgLFwBKLnetr4CiKV3rgfNbOl4P3TMIMDBTxAF08ZsXjR+Vm3n5JQNDBC7gRM=
Received: by 10.86.72.15 with SMTP id u15mr3524734fga.11.1204761068996;
        Wed, 05 Mar 2008 15:51:08 -0800 (PST)
Received: from localhost ( [85.141.189.14])
        by mx.google.com with ESMTPS id f19sm2774544fka.18.2008.03.05.15.51.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Mar 2008 15:51:08 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76294>

When the given path contains '..' then git-clean incorrectly printed names
of files. This patch changes cmd_clean to use quote_path() from wt-status.
Also, "failed to remove ..." message used absolutely path, but not it is
corrected to use relative path.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
Add missing include "wt-status.h"

 builtin-clean.c |   32 ++++++++++++++------------------
 wt-status.c     |    4 ++--
 wt-status.h     |    2 ++
 3 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/builtin-clean.c b/builtin-clean.c
index 3b220d5..c3b29b9 100644
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
 
@@ -133,40 +134,35 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		}
 
 		if (S_ISDIR(st.st_mode)) {
+			qname = quote_path(directory.buf, -1, &buf, prefix);
 			strbuf_addstr(&directory, ent->name);
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
1.5.4.3.448.g0426d

