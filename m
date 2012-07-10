From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 03/19] apply: clear_image() clears things a bit more
Date: Tue, 10 Jul 2012 00:03:56 -0700
Message-ID: <1341903852-4815-4-git-send-email-gitster@pobox.com>
References: <1341903852-4815-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 09:04:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoUUn-00085p-VO
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 09:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754059Ab2GJHE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 03:04:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53032 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152Ab2GJHE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 03:04:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCCCD7DCE
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=I9DO
	vvniFgpWCc+skvPlGWPgS5Y=; b=ZFTkgj3sZpVFtaiBQPFj3mRk1IdV55qdtpgJ
	lhrC58nPYkjH4/i3PtFuHsy5RSNBMcx6I0hfCQghD379B6t67PZS1ffFa9HGOcyQ
	8slv17odFHyepJvWoHbCe3MfuLwmldRgroHLNoQzBr83ll+rLtaYfeyajB7MiK1E
	Jq2cAQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=t9C8Hg
	XIBMs50XIYdm77tshjY/h1RrFxUST/h+qIVSwZht+Ump3h7eqbRZ6v+QIiAWOZP4
	vhQaFx7Oe/40bM86U1AoGpBmDcMjvzkJskJppJW2Ds9bIGUrXzWUOwJbUhYz5Dqh
	9VDUg6gwaLQOPfU4G3CAL82Rqhsv/9UGd1VvE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFE537DCD
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54B267DCB for
 <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:24 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.294.g68a9409
In-Reply-To: <1341903852-4815-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7B15311A-CA5D-11E1-ACF3-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201241>

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
index 35460c9..09f5df3 100644
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
1.7.11.1.294.g68a9409
