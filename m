From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 32/33] refs: change do_for_each_*() functions to take ref_cache arguments
Date: Mon, 22 Apr 2013 21:52:40 +0200
Message-ID: <1366660361-21831-33-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 22:02:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMw2-0007GU-7y
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 22:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239Ab3DVUBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 16:01:55 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:63507 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755218Ab3DVUBw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 16:01:52 -0400
X-AuditID: 12074412-b7f216d0000008d4-7f-517595643a3f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 14.8F.02260.46595715; Mon, 22 Apr 2013 15:54:12 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOj008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:54:11 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqJsytTTQYP9rU4uuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M44eu0PW8ET9YrlTUvZGhhf
	KXQxcnJICJhIdExexQRhi0lcuLeerYuRi0NI4DKjxJzJT1khnAtMEtuWvGYEqWIT0JVY1NMM
	1iEioCYxse0QC4jNLOAgsflzI1iNsECMxOWuT2A2i4CqxO3Pj5hBbF4BV4lDXU+ZIbYpSBzf
	vg2shhMofrrjBNgcIQEXiRUHp7JMYORdwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXTC83
	s0QvNaV0EyMkWIR2MK4/KXeIUYCDUYmHV8C9NFCINbGsuDL3EKMkB5OSKC/HFKAQX1J+SmVG
	YnFGfFFpTmrxIUYJDmYlEV7RfKAcb0piZVVqUT5MSpqDRUmc9+didT8hgfTEktTs1NSC1CKY
	rAwHh5IE77fJQI2CRanpqRVpmTklCGkmDk4QwQWygQdogzzIdt7igsTc4sx0iKJTjIpS4rxu
	k4ASAiCJjNI8uAGwuH7FKA70jzAvH0g7DzAlwHW/AhrMBDQ4M6EEZHBJIkJKqoGx7IvUrgme
	J/uD7hon2zZIOBTZBc9Pjcr7nHBj5dvIHy8naZ6+rch/TrLw/E4dlvRjbkpPT3+eUSgtMcd4
	LZ9nXH4RA1+Q/3rrYxpfT/j0GN88cyynMfFlLc/7j4fb4rx2TrA2ePBj3oJcFTZzswcxpqEJ
	5Wz/kvr2Ch3+omp8sGaW1uMu30lKLMUZiYZazEXFiQDbzIgexgIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222080>

Change the callers convert submodule names into ref_cache pointers.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index b1cda1b..f246b77 100644
--- a/refs.c
+++ b/refs.c
@@ -1503,16 +1503,15 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
 }
 
 /*
- * Call fn for each reference in the specified submodule, omitting
+ * Call fn for each reference in the specified ref_cache, omitting
  * references not in the containing_dir of base.  fn is called for all
  * references, including broken ones.  If fn ever returns a non-zero
  * value, stop the iteration and return that value; otherwise, return
  * 0.
  */
-static int do_for_each_entry(const char *submodule, const char *base,
+static int do_for_each_entry(struct ref_cache *refs, const char *base,
 			     each_ref_entry_fn fn, void *cb_data)
 {
-	struct ref_cache *refs = get_ref_cache(submodule);
 	struct ref_dir *packed_dir = get_packed_refs(refs);
 	struct ref_dir *loose_dir = get_loose_refs(refs);
 	int retval = 0;
@@ -1541,7 +1540,7 @@ static int do_for_each_entry(const char *submodule, const char *base,
 }
 
 /*
- * Call fn for each reference in the specified submodule for which the
+ * Call fn for each reference in the specified ref_cache for which the
  * refname begins with base.  If trim is non-zero, then trim that many
  * characters off the beginning of each refname before passing the
  * refname to fn.  flags can be DO_FOR_EACH_INCLUDE_BROKEN to include
@@ -1549,8 +1548,8 @@ static int do_for_each_entry(const char *submodule, const char *base,
  * value, stop the iteration and return that value; otherwise, return
  * 0.
  */
-static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn fn,
-			   int trim, int flags, void *cb_data)
+static int do_for_each_ref(struct ref_cache *refs, const char *base,
+			   each_ref_fn fn, int trim, int flags, void *cb_data)
 {
 	struct ref_entry_cb data;
 	data.base = base;
@@ -1559,7 +1558,7 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 	data.fn = fn;
 	data.cb_data = cb_data;
 
-	return do_for_each_entry(submodule, base, do_one_ref, &data);
+	return do_for_each_entry(refs, base, do_one_ref, &data);
 }
 
 static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
@@ -1592,23 +1591,23 @@ int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 
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
@@ -1643,7 +1642,7 @@ int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *c
 
 int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(NULL, "refs/replace/", fn, 13, 0, cb_data);
+	return do_for_each_ref(get_ref_cache(NULL), "refs/replace/", fn, 13, 0, cb_data);
 }
 
 int head_ref_namespaced(each_ref_fn fn, void *cb_data)
@@ -1666,7 +1665,7 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
 	strbuf_addf(&buf, "%srefs/", get_git_namespace());
-	ret = do_for_each_ref(NULL, buf.buf, fn, 0, 0, cb_data);
+	ret = do_for_each_ref(get_ref_cache(NULL), buf.buf, fn, 0, 0, cb_data);
 	strbuf_release(&buf);
 	return ret;
 }
@@ -1708,7 +1707,7 @@ int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
 
 int for_each_rawref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(NULL, "", fn, 0,
+	return do_for_each_ref(get_ref_cache(NULL), "", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
@@ -2103,7 +2102,7 @@ int pack_refs(unsigned int flags)
 
 	write_or_die(cbdata.fd, PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER));
 
-	do_for_each_entry(NULL, "", pack_one_ref, &cbdata);
+	do_for_each_entry(get_ref_cache(NULL), "", pack_one_ref, &cbdata);
 	if (commit_lock_file(&packlock) < 0)
 		die_errno("unable to overwrite old ref-pack file");
 	prune_refs(cbdata.ref_to_prune);
-- 
1.8.2.1
