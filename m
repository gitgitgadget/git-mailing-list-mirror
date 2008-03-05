From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] git-clean: correct printing relative path
Date: Wed, 5 Mar 2008 17:17:20 +0300
Message-ID: <20080305141720.GA11542@dpotapov.dyndns.org>
References: <20080305094058.GF4793@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 15:18:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWuRa-0000oA-FR
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 15:18:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbYCEOR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 09:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbYCEOR2
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 09:17:28 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:55533 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbYCEOR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 09:17:27 -0500
Received: by nf-out-0910.google.com with SMTP id g13so884862nfb.21
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 06:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=ePZu/WJVnQNEAjXQj51hBdj5GG/CsRr8X8BF86Ww0bk=;
        b=dk99kVjwmH776op9rGZInoFaDPoZs9Tgf+p0UiaJthKSr4MndN39vU1zphZgeyvuE9FjHCyc1r8bYetKtOBrVR0dXtD1UpH3h/3rjDZd36epzIKdAJPZI3QO/F0qpxkwGc9Yj9SKhgnDRjO/I+zqWfGp1Q+0AJJTzXHR/3erkWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=lrA4TooLvHafu5khoT31JYD4u0parX07TkV1BXVbENgXC+lyus6LNMMr4tojP1ERMnhpln3aShSSV0+80Wicp+5i0Vj20yauoL6gHr4K8qxpAvHrD+ANdCew60hod5h3CU5Fe1Izdi80M86QP2PsdonT7+qaxsOEuUIj2r2lZQY=
Received: by 10.82.184.2 with SMTP id h2mr2675977buf.1.1204726644536;
        Wed, 05 Mar 2008 06:17:24 -0800 (PST)
Received: from localhost ( [85.141.189.14])
        by mx.google.com with ESMTPS id o11sm1449297fkf.9.2008.03.05.06.17.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Mar 2008 06:17:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080305094058.GF4793@artemis.madism.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76217>

When the given path contains '..' then git-clean incorrectly printed names
of files. This patch changes cmd_clean to use quote_path() from wt-status.
Also, "failed to remove ..." message used absolutely path, but not it is
corrected to use relative path.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
I resend this patch, because it got filtered by vger.kernel.org
when I used git-send-email from 1.5.4.

 builtin-clean.c |   31 +++++++++++++------------------
 wt-status.c     |    4 ++--
 wt-status.h     |    2 ++
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/builtin-clean.c b/builtin-clean.c
index 3b220d5..3d75ad6 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -34,7 +34,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	struct dir_struct dir;
 	const char *path, *base;
 	static const char **pathspec;
-	int prefix_offset = 0;
+	struct strbuf buf;
+	const char *qname;
 	char *seen = NULL;
 	struct option options[] = {
 		OPT__QUIET(&quiet),
@@ -56,6 +57,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, options, builtin_clean_usage, 0);
 
+	strbuf_init(&buf, 0);
 	memset(&dir, 0, sizeof(dir));
 	if (ignored_only)
 		dir.show_ignored = 1;
@@ -72,8 +74,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (!ignored)
 		setup_standard_excludes(&dir);
 
-	if (prefix)
-		prefix_offset = strlen(prefix);
 	pathspec = get_pathspec(prefix, argv);
 	read_cache();
 
@@ -133,40 +133,35 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
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
1.5.4
