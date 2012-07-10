From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 14/19] apply: move verify_index_match() higher
Date: Tue, 10 Jul 2012 00:04:07 -0700
Message-ID: <1341903852-4815-15-git-send-email-gitster@pobox.com>
References: <1341903852-4815-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 09:05:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoUVZ-0000bE-QJ
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 09:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162Ab2GJHE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 03:04:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53289 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754152Ab2GJHEy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 03:04:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BD0C7DF8
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=azOL
	ZAkv1onWFpIlc5+wZSNMUoY=; b=Y0fJRoaSMS5Lh1TI/RWWysWmLuNie5WNsPsK
	H1OSfjVq6Y7ydYsrITF2owjXpTWiltbu9yhh6l3J8J1pqmHiFzk5MC2WtlqQALro
	MmKcPmUx+bgqanr4z8qhBwpv/D0JfuXMCEGSGfosOiKyy9rfVKeJrfoW4Ez3mPUf
	oiCAYoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=BZEyXh
	Gy8mW2UMcGsd+rVDHspcq/fwpIlgVxAccQF1F+VuFSH35h5Oc0Sqp6SnxrOo1xY4
	+B7BNyf+e/TJsU6z6bKgaLCrSkFdxSegGsonmeucfxh/FWMOU/BS6MCVRnGjMrnt
	ERYqT1bbmCSwmUN9/FIp4iAqt32R+nbQIevkI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83B957DF7
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D36B37DF3 for
 <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:51 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.294.g68a9409
In-Reply-To: <1341903852-4815-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8B7BF2D2-CA5D-11E1-A394-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201250>

We will be adding another caller of this function in a later patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index d84958b..682852c 100644
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
1.7.11.1.294.g68a9409
