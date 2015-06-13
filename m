From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 11/12] initial_ref_transaction_commit(): check for ref D/F conflicts
Date: Sat, 13 Jun 2015 16:42:14 +0200
Message-ID: <95cc41220378be062b4f8406f2e1adf6da529abc.1434206062.git.mhagger@alum.mit.edu>
References: <cover.1434206062.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 16:43:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3meI-0007yB-Oj
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 16:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858AbbFMOmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 10:42:52 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:59070 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752176AbbFMOmd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2015 10:42:33 -0400
X-AuditID: 1207440d-f79c76d000000bf7-10-557c4158dc8b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id C5.BE.03063.8514C755; Sat, 13 Jun 2015 10:42:32 -0400 (EDT)
Received: from michael.fritz.box (p5DDB10EE.dip0.t-ipconnect.de [93.219.16.238])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5DEgGpZ026136
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 13 Jun 2015 10:42:31 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434206062.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqBvhWBNq8HiWqkXXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLA6vH3/cfmDwWbCr1eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M54/bmIq2CxW8bD9MGMD42vBLkZODgkBE4lbr+czQdhiEhfurWcDsYUELjNKvDld0sXI
	BWSfYJK4NfMnWBGbgK7Eop5mMFtEQE1iYtshFpAiZoEORokLy7exgySEBcIlTnbPA7NZBFQl
	Fn76ygpi8wpESTxsnMIMsU1O4vzxn0A2BwengIXEy6ZMiMXmEm9XtLNOYORdwMiwilEuMac0
	Vzc3MTOnODVZtzg5MS8vtUjXSC83s0QvNaV0EyMkoHh3MP5fJ3OIUYCDUYmHNyO2OlSINbGs
	uDL3EKMkB5OSKG/kHqAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEV5B7ZpQId6UxMqq1KJ8mJQ0
	B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBO81e6BGwaLU9NSKtMycEoQ0EwcnyHAuKZHi
	1LyU1KLE0pKMeFBkxBcDYwMkxQO0V94BZG9xQWIuUBSi9RSjopQ4rwRIQgAkkVGaBzcWliZe
	MYoDfSnM6wFSxQNMMXDdr4AGMwENbu+pAhlckoiQkmpgFNbILZpz8Grmlg/Z7Oct86/eW3Ti
	14UF25/tO/Nt46vcjTdeh7V36zFkVbvdmVG8Y4Kkxu+G5xMn9/Cd2NcfxK6j+nYGuzLr/JDl
	EtVauQqNe3h7nnId0/+++W+JmPoVc+fvPAktaktfuN74Xri88u4OJ4bes+fendm1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271556>

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
 refs.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/refs.c b/refs.c
index dfe9090..340d67f 100644
--- a/refs.c
+++ b/refs.c
@@ -4062,9 +4062,19 @@ cleanup:
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
@@ -4084,12 +4094,36 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
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
