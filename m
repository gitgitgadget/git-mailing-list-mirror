From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 05/19] apply: factor out checkout_target() helper function
Date: Tue, 10 Jul 2012 00:03:58 -0700
Message-ID: <1341903852-4815-6-git-send-email-gitster@pobox.com>
References: <1341903852-4815-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 09:04:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoUUz-0008MO-Vt
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 09:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079Ab2GJHEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 03:04:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53077 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980Ab2GJHEc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 03:04:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E29C7DD5
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=tQPi
	prMrTYzRLNghFFbNf8Zes34=; b=XlLsj90b85BOowVam6hfonkYrwCSRuMupAmk
	/CzduNvkiJ/BrN54poKzh+7cJjDsfC9+JfT/hxXPeHicpTqtMDLbXYKBjXhvYojI
	t8kPmbXg5jWutSNHTdJcI5mYdp25umWzA8rCB5Vc0sDWdE7DQG7Bkee4ql/lsiLv
	/bOGCK8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=wMMWAS
	XTEJ2NgdEbKc1CezJZRzmbGS7fq5UHaSKUVb1VtaA7XMyI8q0p0mX4pNB/lNfoR1
	XK24X9SfMf8lBUXOMSwqZjN09FhKtrLiH10UQ4nmIAN8oIxBaQPVy3mOfbAoPHYp
	kNAGyYeky0MYVfKQq+zlocRJ+qn254ygH/6ZA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 142167DD4
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B6DA7DD3 for
 <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:29 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.294.g68a9409
In-Reply-To: <1341903852-4815-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7E7A984A-CA5D-11E1-8822-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201242>

When a patch wants to touch a path, if the path exists in the index
but is missing in the working tree, "git apply --index" checks out
the file to the working tree from the index automatically and then
applies the patch.

Split this logic out to a separate helper function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 15bcbb0..487e403 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3034,6 +3034,18 @@ static void prepare_fn_table(struct patch *patch)
 	}
 }
 
+static int checkout_target(struct cache_entry *ce, struct stat *st)
+{
+	struct checkout costate;
+
+	memset(&costate, 0, sizeof(costate));
+	costate.base_dir = "";
+	costate.refresh_cache = 1;
+	if (checkout_entry(ce, &costate, NULL) || lstat(ce->name, st))
+		return error(_("cannot checkout %s"), ce->name);
+	return 0;
+}
+
 static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -3163,13 +3175,7 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 		}
 		*ce = active_cache[pos];
 		if (stat_ret < 0) {
-			struct checkout costate;
-			/* checkout */
-			memset(&costate, 0, sizeof(costate));
-			costate.base_dir = "";
-			costate.refresh_cache = 1;
-			if (checkout_entry(*ce, &costate, NULL) ||
-			    lstat(old_name, st))
+			if (checkout_target(*ce, st))
 				return -1;
 		}
 		if (!cached && verify_index_match(*ce, st))
-- 
1.7.11.1.294.g68a9409
