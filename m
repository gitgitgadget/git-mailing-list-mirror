From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 05/19] apply: factor out checkout_target() helper function
Date: Wed, 13 Jun 2012 12:32:46 -0700
Message-ID: <1339615980-19727-6-git-send-email-gitster@pobox.com>
References: <1339615980-19727-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 21:34:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SetKa-0001yQ-SX
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 21:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773Ab2FMTeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 15:34:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65379 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754748Ab2FMTdM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 15:33:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6908D86FE
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=gsHb
	Et11Z5hcLrQdYSQqMd/Fc1E=; b=w8ebcCAlrvuebAXQQOS+WL+LKi0FVyaFj8iR
	PrsEhem3I1606cDQ6U0ucUyJWKn7AumSqoJ8GfQk725vktm4xon89bRtcOEYYAKr
	SrTGDi8KtEEStx1Y6eUwOvoxg8ycAWQvYMJGsvSIYF6wyfBMVZzeMQ2SygM1kTSo
	hua3+B8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=nJrb9o
	iN8UzXXtsmRjHkYM+HPQsemWQEZxSyJwtHdz4Lss5eM3KC0IUvnlvo8KJloBHhj7
	y8Yl4K0YyqZssyM3LZ/logPCfR1XUvlNYK8cHoNCaML7sgCsA/YbfAPeudi3Jiua
	XLchJuakskk4ZtjS7fCVbNB30x4chPqeG/B9c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60F7B86FD
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E57A986FB for
 <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:11 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc3.30.g3bdace2
In-Reply-To: <1339615980-19727-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9CDC86C4-B58E-11E1-892E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199937>

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
index 3199691..6a1fdc0 100644
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
1.7.11.rc3.30.g3bdace2
