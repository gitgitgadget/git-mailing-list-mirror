From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 03/19] apply: clear_image() clears things a bit more
Date: Wed, 13 Jun 2012 12:32:44 -0700
Message-ID: <1339615980-19727-4-git-send-email-gitster@pobox.com>
References: <1339615980-19727-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 21:33:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SetJi-0007rf-PA
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 21:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761Ab2FMTdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 15:33:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65334 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754741Ab2FMTdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 15:33:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFD3386F6
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=CsuY
	ckPEPah3Yy584D5WW6sur3I=; b=N16dNom9I+WYNTIlMP+vU3ukBQyB/MmiFDQE
	+OP6BaAsxu2Zrxitd+jas5i24Mtz06a5MgUakkCsR8Kbkt5Gr2R/cUOKj0H956b5
	13tV5lvcSEE/Yp64u4GcpPXGqIA2eAZ6aotClrkEgTcAAfzYXDCsVSKYdkejB7eW
	uUgi+ss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=jdgZJ6
	Q5joXYDykUBrQrE9Xk91GOJSgfgouuqSf09Yqm176FG1IFzebgNLK+NhLETBUolw
	YLT0IKq+BhX3MqEPe4foNVpENtUSn7CQ0Zi3QJK0vrB8uF84oN23eE0+I+VwE9mg
	g1cV/zmUVRy/jCFhyDTLLSjJwrloDTuaufC8c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C686B86F5
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61EC586F4 for
 <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:07 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc3.30.g3bdace2
In-Reply-To: <1339615980-19727-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9A27B00C-B58E-11E1-9670-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199920>

The clear_image() function did not clear the line table in the image
structure; this does not matter for the current callers, as the function
is only called from the codepaths that deal with binary patches where the
line table is never populated, and the codepaths that do populate the line
table free it themselves.

But it will start to matter when we introduce a codepath to retry a failed
patch, so make sure it clears and frees everything.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 8488c8e..e2b0942 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -371,8 +371,8 @@ static void prepare_image(struct image *image, char *buf, size_t len,
 static void clear_image(struct image *image)
 {
 	free(image->buf);
-	image->buf = NULL;
-	image->len = 0;
+	free(image->line_allocated);
+	memset(image, 0, sizeof(*image));
 }
 
 /* fmt must contain _one_ %s and no other substitution */
-- 
1.7.11.rc3.30.g3bdace2
