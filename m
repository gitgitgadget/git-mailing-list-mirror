From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/9] apply: clear_image() clears things a bit more
Date: Thu, 10 May 2012 15:32:45 -0700
Message-ID: <1336689173-15822-2-git-send-email-gitster@pobox.com>
References: <1336689173-15822-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 00:33:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSbvY-0006Py-1u
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 00:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519Ab2EJWdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 18:33:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36622 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932399Ab2EJWc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 18:32:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C23C8426
	for <git@vger.kernel.org>; Thu, 10 May 2012 18:32:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=eccL
	fR7e169p0CJDdj0CwBujFVw=; b=HoJxbzreRlm2PhW9iSIToYFnmxOmFcBXAyYv
	XjBoFlHVZM/yR2nBhcW4KsG+97w1YHpWpbyXY7M6KZtp6WouwoHrDY3Fdzeyr11f
	sM8KtK/wDG0R3I0qscN0z7AX9g0yFFBFGcUZ/oOdvualPto6EvBR3lncLkMtpI3U
	RuVmIdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=c/rb9r
	lecy6GSkQVRCYh0EJNoyplDE1OcKG8OG8qUG+LKesKmS0M7BA6bjcrnGhh5P5nxC
	CgTlHGEuI+SnFkeylHOJCQZ+Bln1ZgJfirqtYeWt5reTFPX9bkZpwEEew6vM0Jdq
	lg2OHWv5snjd28nTVq5uJBE42r+048AZe0Pow=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 048618425
	for <git@vger.kernel.org>; Thu, 10 May 2012 18:32:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 86E5E8424 for
 <git@vger.kernel.org>; Thu, 10 May 2012 18:32:56 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.1.574.g840b38f
In-Reply-To: <1336689173-15822-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 16F21AB4-9AF0-11E1-B5B1-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197646>

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
index 725712d..99b1608 100644
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
1.7.10.1.574.g840b38f
