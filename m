From: mhagger@alum.mit.edu
Subject: [PATCH v2 09/18] do_for_each_reflog(): reuse strbuf across recursive function calls
Date: Fri, 27 Apr 2012 00:26:58 +0200
Message-ID: <1335479227-7877-10-git-send-email-mhagger@alum.mit.edu>
References: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 00:28:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNXAU-0008VY-De
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 00:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759477Ab2DZW1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 18:27:30 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:37105 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759472Ab2DZW12 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 18:27:28 -0400
Received: from michael.berlin.jpk.com (michael2.berlin.jpk.com [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 85A0A24813F;
	Fri, 27 Apr 2012 00:27:27 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196438>

From: Michael Haggerty <mhagger@alum.mit.edu>

This saves some memory allocations.  Also require that the name
argument end in slash, which removes some extra bookkeeping.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/refs.c b/refs.c
index f43c255..989c10d 100644
--- a/refs.c
+++ b/refs.c
@@ -2242,24 +2242,20 @@ int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_dat
 	return for_each_recent_reflog_ent(refname, fn, 0, cb_data);
 }
 
-static int do_for_each_reflog(const char *base, each_ref_fn fn, void *cb_data)
+/*
+ * Call fn for each reflog in the namespace indicated by name.  name
+ * must be empty or end with '/'.  Name will be used as a scratch
+ * space, but its contents will be restored before return.
+ */
+static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data)
 {
-	DIR *d = opendir(git_path("logs/%s", base));
+	DIR *d = opendir(git_path("logs/%s", name->buf));
 	int retval = 0;
 	struct dirent *de;
-	int baselen;
-	struct strbuf log;
+	int oldlen = name->len;
 
 	if (!d)
-		return *base ? errno : 0;
-
-	baselen = strlen(base);
-	strbuf_init(&log, baselen + 257);
-	strbuf_add(&log, base, baselen);
-	if (log.len && log.buf[log.len-1] != '/') {
-		strbuf_addch(&log, '/');
-		baselen++;
-	}
+		return name->len ? errno : 0;
 
 	while ((de = readdir(d)) != NULL) {
 		struct stat st;
@@ -2268,32 +2264,37 @@ static int do_for_each_reflog(const char *base, each_ref_fn fn, void *cb_data)
 			continue;
 		if (has_extension(de->d_name, ".lock"))
 			continue;
-		strbuf_addstr(&log, de->d_name);
-		if (stat(git_path("logs/%s", log.buf), &st) < 0) {
+		strbuf_addstr(name, de->d_name);
+		if (stat(git_path("logs/%s", name->buf), &st) < 0) {
 			/* Silently ignore. */
 		} else {
 			if (S_ISDIR(st.st_mode)) {
-				retval = do_for_each_reflog(log.buf, fn, cb_data);
+				strbuf_addch(name, '/');
+				retval = do_for_each_reflog(name, fn, cb_data);
 			} else {
 				unsigned char sha1[20];
-				if (read_ref_full(log.buf, sha1, 0, NULL))
-					retval = error("bad ref for %s", log.buf);
+				if (read_ref_full(name->buf, sha1, 0, NULL))
+					retval = error("bad ref for %s", name->buf);
 				else
-					retval = fn(log.buf, sha1, 0, cb_data);
+					retval = fn(name->buf, sha1, 0, cb_data);
 			}
 			if (retval)
 				break;
 		}
-		strbuf_setlen(&log, baselen);
+		strbuf_setlen(name, oldlen);
 	}
-	strbuf_release(&log);
 	closedir(d);
 	return retval;
 }
 
 int for_each_reflog(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_reflog("", fn, cb_data);
+	int retval;
+	struct strbuf name;
+	strbuf_init(&name, PATH_MAX);
+	retval = do_for_each_reflog(&name, fn, cb_data);
+	strbuf_release(&name);
+	return retval;
 }
 
 int update_ref(const char *action, const char *refname,
-- 
1.7.10
