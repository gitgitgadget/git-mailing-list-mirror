From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 06/19] apply: split load_preimage() helper function out
Date: Tue, 10 Jul 2012 00:03:59 -0700
Message-ID: <1341903852-4815-7-git-send-email-gitster@pobox.com>
References: <1341903852-4815-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 09:04:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoUV0-0008MO-Gb
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 09:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092Ab2GJHEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 03:04:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53099 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980Ab2GJHEf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 03:04:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB1D87DD9
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=o20D
	xuBNdx5hxfDwWkwshEXqNnA=; b=WKBHgCXBR1VGMxR8FMfUHdEdqDsMKpq/F7vC
	LmKMFU6wKRMyHu5LXCNYJsDY1Lo+qg8GzgAH9DYdrwLWURQTNGrhtGwmC0RA8GZB
	E4mHCu90wLQJyaGmDrmrgylI/+rfrzKelh1ZAF70E+KKpN276wEwUApo5A4Z1hlr
	xC7+mBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=HoZsHw
	hNoHA3Hy2gqPOAyV0/Zm0pFM6lCrBqk2nreZg7b8iEnEQYQ50+AoyIJ0lB0SsXNO
	Y4Rx6dLFRhEI9Ky7y3eMouz8TICPXcwXZG7OiyJ+mr3UPJDQtlw1E0kckNz2P+tj
	wxzzgxl4vuDZtU80Dsu4SBlEN91y6cZqL4rvE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2B2E7DD8
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 652D37DD6 for
 <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:33 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.294.g68a9409
In-Reply-To: <1341903852-4815-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 807CA502-CA5D-11E1-9EEB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201244>

Given a patch for a single path, the function apply_data() reads the
preimage in core, and applies the change represented in the patch.

Separate out the first part that reads the preimage into a separate
helper function load_preimage().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 487e403..4d2546f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3046,10 +3046,10 @@ static int checkout_target(struct cache_entry *ce, struct stat *st)
 	return 0;
 }
 
-static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
+static int load_preimage(struct image *image,
+			 struct patch *patch, struct stat *st, struct cache_entry *ce)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct image image;
 	size_t len;
 	char *img;
 	struct patch *tpatch;
@@ -3086,7 +3086,16 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 	}
 
 	img = strbuf_detach(&buf, &len);
-	prepare_image(&image, img, len, !patch->is_binary);
+	prepare_image(image, img, len, !patch->is_binary);
+	return 0;
+}
+
+static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
+{
+	struct image image;
+
+	if (load_preimage(&image, patch, st, ce) < 0)
+		return -1;
 
 	if (apply_fragments(&image, patch) < 0)
 		return -1; /* note with --reject this succeeds. */
-- 
1.7.11.1.294.g68a9409
