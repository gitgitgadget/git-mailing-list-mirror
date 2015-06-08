From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/13] initial_ref_transaction_commit(): check for ref D/F conflicts
Date: Mon,  8 Jun 2015 13:45:46 +0200
Message-ID: <bfce44d80a716a076e743ab406265dad9a8a8e88.1433763494.git.mhagger@alum.mit.edu>
References: <cover.1433763494.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 13:46:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1vVs-0005gt-LG
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 13:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792AbbFHLqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 07:46:37 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:62189 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752643AbbFHLqI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 07:46:08 -0400
X-AuditID: 1207440f-f79236d000000c5e-12-5575807fea27
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id D5.FD.03166.F7085755; Mon,  8 Jun 2015 07:46:07 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t58Bjop9017042
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 07:46:06 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433763494.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqFvfUBpqcP+mkUXXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLA6vH3/cfmDwWbCr1eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M05OP8VaMEGmYuaRugbGWWJdjJwcEgImEms/fGaGsMUkLtxbz9bFyMUhJHCZUWLr7zlM
	EM4JJokpq76zglSxCehKLOppZgKxRQTUJCa2HWIBKWIW6GCUuLB8G3sXIweHsECIxP69YPUs
	AqoSN65MYAOxeQWiJD7tmsQOsU1O4vzxn2CbOQUsJO7+vwBWIyRgLvFxWzvjBEbeBYwMqxjl
	EnNKc3VzEzNzilOTdYuTE/PyUot0TfRyM0v0UlNKNzFCAop/B2PXeplDjAIcjEo8vAcWlYQK
	sSaWFVfmHmKU5GBSEuXtKisNFeJLyk+pzEgszogvKs1JLT7EKMHBrCTCy2QBlONNSaysSi3K
	h0lJc7AoifOqL1H3ExJITyxJzU5NLUgtgsnKcHAoSfB+rANqFCxKTU+tSMvMKUFIM3Fwggzn
	khIpTs1LSS1KLC3JiAdFRnwxMDZAUjxAe5+BtPMWFyTmAkUhWk8xKkqJ8z4GSQiAJDJK8+DG
	wtLEK0ZxoC+FeXXrgap4gCkGrvsV0GAmoMHfvxaDDC5JREhJNTBu++j784WLgvOio7pmly8U
	vUsQvt60l09AdE5aX72S0y1JXZ6zz2vu3nfYeN6WY+4NjxP9+mtW/t3EHXlmK8PjGIVTeYqq
	j7xuqll09M362ZujZWOWfMVU1sQ41sZon8GBT48eOsftrp3BHfxksWelSr3YCnPH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271024>

In initial_ref_transaction_commit(), check for D/F conflicts (i.e.,
the type of conflict that exists between "refs/foo" and
"refs/foo/bar") among the references being created and between the
references being created and any hypothetical existing references.

Ideally, there shouldn't *be* any existing references when this
function is called. But, at least in the case of the "testgit" remote
helper, "clone" can be called after the remote-tracking "HEAD" and
"master" branches have already been created. So let's just do the
full-blown check.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

Notes (discussion):
    I'm a bit torn on this commit. Part of me says that we should avoid
    the overhead of the extra checks against loose_refs and packed_refs
    because there shouldn't be any references there anyway. Instead, the
    "testgit" remote helper should be fixed.
    
    But these tests should be pretty cheap, and we would want to check for
    ref D/F conflicts among the new references in any case, so it seems
    safer to include these checks. Also, our documentation suggests that
    users refer to git-remote-testgit(1) as an example when writing their
    own remote helpers, so it could be that there is other code out there
    that has imitated its light misuse of this functionality.

 refs.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/refs.c b/refs.c
index ced4e53..2c4d9ab 100644
--- a/refs.c
+++ b/refs.c
@@ -4058,9 +4058,19 @@ cleanup:
 	return ret;
 }
 
+static int ref_present(const char *refname,
+		       const struct object_id *oid, int flags, void *cb_data)
+{
+	struct string_list *affected_refnames = cb_data;
+
+	return string_list_has_string(affected_refnames, refname);
+}
+
 int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err)
 {
+	struct ref_dir *loose_refs = get_loose_refs(&ref_cache);
+	struct ref_dir *packed_refs = get_packed_refs(&ref_cache);
 	int ret = 0, i;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
@@ -4080,12 +4090,36 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 		goto cleanup;
 	}
 
+	/*
+	 * It's really undefined to call this function in an active
+	 * repository or when there are existing references: we are
+	 * only locking and changing packed-refs, so (1) any
+	 * simultaneous processes might try to change a reference at
+	 * the same time we do, and (2) any existing loose versions of
+	 * the references that we are setting would have precedence
+	 * over our values. But some remote helpers create the remote
+	 * "HEAD" and "master" branches before calling this function,
+	 * so here we really only check that none of the references
+	 * that we are creating already exists.
+	 */
+	if (for_each_rawref(ref_present, &affected_refnames))
+		die("BUG: initial ref transaction called with existing refs");
+
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
 		if ((update->flags & REF_HAVE_OLD) &&
 		    !is_null_sha1(update->old_sha1))
 			die("BUG: initial ref transaction with old_sha1 set");
+		if (verify_refname_available(update->refname,
+					     &affected_refnames, NULL,
+					     loose_refs, err) ||
+		    verify_refname_available(update->refname,
+					     &affected_refnames, NULL,
+					     packed_refs, err)) {
+			ret = TRANSACTION_NAME_CONFLICT;
+			goto cleanup;
+		}
 	}
 
 	if (lock_packed_refs(0)) {
-- 
2.1.4
