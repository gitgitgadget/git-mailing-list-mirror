From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/9] apply: split load_preimage() helper function out
Date: Thu, 10 May 2012 15:32:47 -0700
Message-ID: <1336689173-15822-4-git-send-email-gitster@pobox.com>
References: <1336689173-15822-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 00:33:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSbvA-0006Aa-K4
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 00:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576Ab2EJWdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 18:33:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36655 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761733Ab2EJWdA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 18:33:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 916DA842C
	for <git@vger.kernel.org>; Thu, 10 May 2012 18:33:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=EEEs
	6rpqJ3ftP0/YAkk7NxSS2/Q=; b=R5OOdBw0JVvO2WfqVnlMc6OQ6oh+uYoTgNMG
	wVpyxJhJHLwVkdSZeKNjs7oO9TkB1O+MaPMgWj4tB9DfI6I9dwfDpbALmJRAHpFW
	8PcqEQsN89hJl+sAAKuCM6ILB6wlCCMNM86j3kGqF1dDcnl1dTN68f8YOVdmz9av
	I/qoCrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=s3cCz5
	zf3R+BWVvc6i8yrHQiQb/LR6ni/6FuLRKAUPFib1MjKZVaLCmMESRrhoQHDHqDle
	Gxj+Qw3VxGVA5zZ/j4HQn/obgmjxue0PVCDDbeMhxMJZjd0N3mGHDsbh+QufCkqp
	JRA88lbW2iCjMaarMvKE3c046MpxM6G7TOltA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 890C5842B
	for <git@vger.kernel.org>; Thu, 10 May 2012 18:33:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1ACF7842A for
 <git@vger.kernel.org>; Thu, 10 May 2012 18:33:00 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.1.574.g840b38f
In-Reply-To: <1336689173-15822-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1910DB78-9AF0-11E1-AAE8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197639>

The function apply_data() gets a patch for a single path, reads the
preimage in core, and applies the change represented in the patch.

Separate out the first part that reads the preimage into a separate
helper function load_preimage().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ca330e3..2a31023 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3028,10 +3028,10 @@ static void prepare_fn_table(struct patch *patch)
 	}
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
@@ -3068,7 +3068,16 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
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
1.7.10.1.574.g840b38f
