From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 32/33] refs: change do_for_each_*() functions to take ref_cache arguments
Date: Sun, 14 Apr 2013 14:54:47 +0200
Message-ID: <1365944088-10588-33-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:56:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMTe-0004tF-Hf
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138Ab3DNM4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:56:10 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:53354 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752111Ab3DNM4H (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:56:07 -0400
X-AuditID: 12074413-b7f226d000000902-6b-516aa767e953
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id C2.E6.02306.767AA615; Sun, 14 Apr 2013 08:56:07 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAkT007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:56:05 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqJu+PCvQYME3QYuuK91MFg29V5gt
	Vj6+y2xxe8V8ZosfLT3MDqwef99/YPJof/+O2eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M5oat/JWPBZtaJv0ne2BsZV8l2MnBwSAiYStyZeY4ewxSQu3FvP1sXIxSEkcJlRouHw
	PSjnLJPEoW+dbCBVbAK6Eot6mpm6GDk4RASyJXavBRvELOAgsflzIyOILSwQKfH0+TxmEJtF
	QFXi274jbCDlvAKuEkt21ELsUpA4vn0bWDknUHj682NgNwgJuEjM2jybdQIj7wJGhlWMcok5
	pbm6uYmZOcWpybrFyYl5ealFuuZ6uZkleqkppZsYIQElvINx10m5Q4wCHIxKPLwvGLMChVgT
	y4orcw8xSnIwKYnyKi4DCvEl5adUZiQWZ8QXleakFh9ilOBgVhLhdWwFyvGmJFZWpRblw6Sk
	OViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHhfLwVqFCxKTU+tSMvMKUFIM3FwgggukA08
	QBu0QLbzFhck5hZnpkMUnWJUlBLn/QgyQQAkkVGaBzcAFvuvGMWB/hGGOJ4HmDbgul8BDWYC
	GuyzNx1kcEkiQkqqgZH7fubv1T7/ZiQkXFdwPLL55p+H4X9fNVn3HxFxFF555X6C9Nm0DUlK
	z7u2KPnVl0/ab/UoPMUpfuZ8P1fLFV2meUWdvkrTV52ZI+15QubfqRxzxZJjJToRc+Jtcu+I
	ZK1/Uam16ZIlu4BGSJbEYfZjr6+GfD15YrnbnkDPzgU9XtrX/GYc5lRiKc5INNRi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221115>

Change the callers convert submodule names into ref_cache pointers.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index 361a28f..cfcb42f 100644
--- a/refs.c
+++ b/refs.c
@@ -1505,14 +1505,13 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
 }
 
 /*
- * Call fn for each reference in the specified submodule, omitting
+ * Call fn for each reference in the specified ref_cache, omitting
  * references not in the containing_dir of base.  fn is called for all
  * references, including broken ones.
  */
-static int do_for_each_entry(const char *submodule, const char *base,
+static int do_for_each_entry(struct ref_cache *refs, const char *base,
 			     each_ref_entry_fn fn, void *cb_data)
 {
-	struct ref_cache *refs = get_ref_cache(submodule);
 	struct ref_dir *packed_dir = get_packed_refs(refs);
 	struct ref_dir *loose_dir = get_loose_refs(refs);
 	int retval = 0;
@@ -1541,14 +1540,14 @@ static int do_for_each_entry(const char *submodule, const char *base,
 }
 
 /*
- * Call fn for each reference in the specified submodule for which the
+ * Call fn for each reference in the specified ref_cache for which the
  * refname begins with base.  If trim is non-zero, then trim that many
  * characters off the beginning of each refname before passing the
  * refname to fn.  flags can be DO_FOR_EACH_INCLUDE_BROKEN to include
  * broken references in the iteration.
  */
-static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn fn,
-			   int trim, int flags, void *cb_data)
+static int do_for_each_ref(struct ref_cache *refs, const char *base,
+			   each_ref_fn fn, int trim, int flags, void *cb_data)
 {
 	struct ref_entry_cb data;
 	data.base = base;
@@ -1557,7 +1556,7 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 	data.fn = fn;
 	data.cb_data = cb_data;
 
-	return do_for_each_entry(submodule, base, do_one_ref, &data);
+	return do_for_each_entry(refs, base, do_one_ref, &data);
 }
 
 static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
@@ -1590,23 +1589,23 @@ int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(NULL, "", fn, 0, 0, cb_data);
+	return do_for_each_ref(get_ref_cache(NULL), "", fn, 0, 0, cb_data);
 }
 
 int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(submodule, "", fn, 0, 0, cb_data);
+	return do_for_each_ref(get_ref_cache(submodule), "", fn, 0, 0, cb_data);
 }
 
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(NULL, prefix, fn, strlen(prefix), 0, cb_data);
+	return do_for_each_ref(get_ref_cache(NULL), prefix, fn, strlen(prefix), 0, cb_data);
 }
 
 int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 		each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(submodule, prefix, fn, strlen(prefix), 0, cb_data);
+	return do_for_each_ref(get_ref_cache(submodule), prefix, fn, strlen(prefix), 0, cb_data);
 }
 
 int for_each_tag_ref(each_ref_fn fn, void *cb_data)
@@ -1641,7 +1640,7 @@ int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *c
 
 int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(NULL, "refs/replace/", fn, 13, 0, cb_data);
+	return do_for_each_ref(get_ref_cache(NULL), "refs/replace/", fn, 13, 0, cb_data);
 }
 
 int head_ref_namespaced(each_ref_fn fn, void *cb_data)
@@ -1664,7 +1663,7 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
 	strbuf_addf(&buf, "%srefs/", get_git_namespace());
-	ret = do_for_each_ref(NULL, buf.buf, fn, 0, 0, cb_data);
+	ret = do_for_each_ref(get_ref_cache(NULL), buf.buf, fn, 0, 0, cb_data);
 	strbuf_release(&buf);
 	return ret;
 }
@@ -1706,7 +1705,7 @@ int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
 
 int for_each_rawref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(NULL, "", fn, 0,
+	return do_for_each_ref(get_ref_cache(NULL), "", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
@@ -2101,7 +2100,7 @@ int pack_refs(unsigned int flags)
 
 	write_or_die(cbdata.fd, PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER));
 
-	do_for_each_entry(NULL, "", pack_one_ref, &cbdata);
+	do_for_each_entry(get_ref_cache(NULL), "", pack_one_ref, &cbdata);
 	if (commit_lock_file(&packlock) < 0)
 		die_errno("unable to overwrite old ref-pack file");
 	prune_refs(cbdata.ref_to_prune);
-- 
1.8.2.1
