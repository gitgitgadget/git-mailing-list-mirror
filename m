From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 14/19] apply: move verify_index_match() higher
Date: Wed, 13 Jun 2012 12:32:55 -0700
Message-ID: <1339615980-19727-15-git-send-email-gitster@pobox.com>
References: <1339615980-19727-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 21:33:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SetKG-00010Q-Mx
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 21:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789Ab2FMTdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 15:33:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32833 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754590Ab2FMTd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 15:33:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 687278733
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=wM/E
	5lDFfE0qCFj/Ef+EQNzoTrU=; b=vIcdW9gxdq+f4mNxFykawWeotD2LnaVkHFN3
	5ThwnvGL13uUMsjLHexTOLpcgdZaY+VXvF88T10QWcJJwFGlInQ4JSaudDUPCYw+
	KMW/PhR50B3vSxStQztM3vDNBD226pk/0lnCKmHYsQRGXBuyKmwlXfKHaXZf0TNN
	eFybhEI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=MV7Gpy
	ojw7C52il1aAcJTpN8yghXh35AG/VpKsv61bXHynsacv580+j+0w1HFVm6L9pnDu
	6XOji/8tCszC/MYM29SXeuRdOAuGnwpQhq79DPpnagkPMpSCva2XMBDyR+jDaAkQ
	s2GAnmN2oq1mVy46tZuL317Fg+BGiGYMfw6OE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E9728732
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0A0D8730 for
 <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:28 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc3.30.g3bdace2
In-Reply-To: <1339615980-19727-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A6FB69FE-B58E-11E1-925F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199932>

We will be adding another caller of this function in a later patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 5ef8652..8bc4218 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3074,6 +3074,16 @@ static struct patch *previous_patch(struct patch *patch, int *gone)
 	return previous;
 }
 
+static int verify_index_match(struct cache_entry *ce, struct stat *st)
+{
+	if (S_ISGITLINK(ce->ce_mode)) {
+		if (!S_ISDIR(st->st_mode))
+			return -1;
+		return 0;
+	}
+	return ce_match_stat(ce, st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
+}
+
 #define SUBMODULE_PATCH_WITHOUT_INDEX 1
 
 static int load_patch_target(struct strbuf *buf,
@@ -3260,16 +3270,6 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 	return 0;
 }
 
-static int verify_index_match(struct cache_entry *ce, struct stat *st)
-{
-	if (S_ISGITLINK(ce->ce_mode)) {
-		if (!S_ISDIR(st->st_mode))
-			return -1;
-		return 0;
-	}
-	return ce_match_stat(ce, st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
-}
-
 /*
  * If "patch" that we are looking at modifies or deletes what we have,
  * we would want it not to lose any local modification we have, either
-- 
1.7.11.rc3.30.g3bdace2
