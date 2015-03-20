From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 13/16] refs: convert for_each_reflog to struct object_id
Date: Fri, 20 Mar 2015 19:28:33 +0000
Message-ID: <1426879716-47835-14-git-send-email-sandals@crustytoothpaste.net>
References: <1426879716-47835-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 20:29:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ2bk-0001va-21
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 20:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbbCTT3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 15:29:06 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50668 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751397AbbCTT25 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2015 15:28:57 -0400
Received: from vauxhall.crustytoothpaste.net (wsip-184-177-1-73.no.no.cox.net [184.177.1.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4812328094;
	Fri, 20 Mar 2015 19:28:56 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1426879716-47835-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: 0.163 () BAYES_00,RDNS_DYNAMIC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265950>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/fsck.c   |  2 +-
 builtin/reflog.c |  4 ++--
 refs.c           | 10 +++++-----
 refs.h           |  2 +-
 revision.c       |  2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 05616a0..91eb4f6 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -476,7 +476,7 @@ static int fsck_handle_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
-static int fsck_handle_reflog(const char *logname, const unsigned char *sha1, int flag, void *cb_data)
+static int fsck_handle_reflog(const char *logname, const struct object_id *oid, int flag, void *cb_data)
 {
 	for_each_reflog_ent(logname, fsck_handle_reflog_ent, NULL);
 	return 0;
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 66ee402..bf03fd7 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -449,14 +449,14 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	return status;
 }
 
-static int collect_reflog(const char *ref, const unsigned char *sha1, int unused, void *cb_data)
+static int collect_reflog(const char *ref, const struct object_id *oid, int unused, void *cb_data)
 {
 	struct collected_reflog *e;
 	struct collect_reflog_cb *cb = cb_data;
 	size_t namelen = strlen(ref);
 
 	e = xmalloc(sizeof(*e) + namelen + 1);
-	hashcpy(e->sha1, sha1);
+	hashcpy(e->sha1, oid->hash);
 	memcpy(e->reflog, ref, namelen + 1);
 	ALLOC_GROW(cb->e, cb->nr + 1, cb->alloc);
 	cb->e[cb->nr++] = e;
diff --git a/refs.c b/refs.c
index de7ac1c..bbcb044 100644
--- a/refs.c
+++ b/refs.c
@@ -3491,7 +3491,7 @@ int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_dat
  * must be empty or end with '/'.  Name will be used as a scratch
  * space, but its contents will be restored before return.
  */
-static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data)
+static int do_for_each_reflog(struct strbuf *name, each_ref_fn_oid fn, void *cb_data)
 {
 	DIR *d = opendir(git_path("logs/%s", name->buf));
 	int retval = 0;
@@ -3516,11 +3516,11 @@ static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data
 				strbuf_addch(name, '/');
 				retval = do_for_each_reflog(name, fn, cb_data);
 			} else {
-				unsigned char sha1[20];
-				if (read_ref_full(name->buf, 0, sha1, NULL))
+				struct object_id oid;
+				if (read_ref_full(name->buf, 0, oid.hash, NULL))
 					retval = error("bad ref for %s", name->buf);
 				else
-					retval = fn(name->buf, sha1, 0, cb_data);
+					retval = fn(name->buf, &oid, 0, cb_data);
 			}
 			if (retval)
 				break;
@@ -3531,7 +3531,7 @@ static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data
 	return retval;
 }
 
-int for_each_reflog(each_ref_fn fn, void *cb_data)
+int for_each_reflog(each_ref_fn_oid fn, void *cb_data)
 {
 	int retval;
 	struct strbuf name;
diff --git a/refs.h b/refs.h
index 89217a7..c491c44 100644
--- a/refs.h
+++ b/refs.h
@@ -249,7 +249,7 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
  * Calls the specified function for each reflog file until it returns nonzero,
  * and returns the value
  */
-extern int for_each_reflog(each_ref_fn, void *);
+extern int for_each_reflog(each_ref_fn_oid, void *);
 
 #define REFNAME_ALLOW_ONELEVEL 1
 #define REFNAME_REFSPEC_PATTERN 2
diff --git a/revision.c b/revision.c
index ffd3528..b491d22 100644
--- a/revision.c
+++ b/revision.c
@@ -1283,7 +1283,7 @@ static int handle_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
-static int handle_one_reflog(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int handle_one_reflog(const char *path, const struct object_id *oid, int flag, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
 	cb->warned_bad_reflog = 0;
-- 
2.2.1.209.g41e5f3a
