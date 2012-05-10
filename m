From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/8] apply: clear_image() clears things a bit more
Date: Wed,  9 May 2012 23:02:21 -0700
Message-ID: <1336629745-22436-5-git-send-email-gitster@pobox.com>
References: <1336629745-22436-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 08:03:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSMTc-0002kF-TA
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 08:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755999Ab2EJGDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 02:03:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62992 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449Ab2EJGCh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 02:02:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5533D5FD7
	for <git@vger.kernel.org>; Thu, 10 May 2012 02:02:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=kR25
	PAeiIHxTKYKZYSHCynzK2y0=; b=rUE9gflgCt3NBDVNoDaDXVxwKFxuF6A3Tidw
	6D78RJEuit9aAkEN0G4dYZrCA6RiLsFXpLx+rXGe7iyCPM4/Ee8a3cVoftVDKyBz
	yzypMHs1W0k9GXSurOfeHoR492a79MNOBIsjOzq8//Lu1nXXLhvJuC923MRcoqWt
	YWs0urM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=X1pdeJ
	nrloxbqEFC6kYvGbbiawV2J7w4YHLhh7hWOvReQWYL/MvkGGY0VpEyl63Zm1ogp9
	FQ3f9qb+KZK+aim/1IWJv8k1yz7MZWzRgd9zeqmwrj5Wr+YuQ9gXL3iSKisakXeq
	2/1AhnXB54Jf5YRqMN27B3kD+G+I+WzsmD/kE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C8A15FD6
	for <git@vger.kernel.org>; Thu, 10 May 2012 02:02:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6BCE05FD5 for
 <git@vger.kernel.org>; Thu, 10 May 2012 02:02:34 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.1.562.gfc79b1c
In-Reply-To: <1336629745-22436-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: BC9B7DD8-9A65-11E1-BF5D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197544>

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
index 9f6f74f..628a89e 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -372,8 +372,8 @@ static void prepare_image(struct image *image, char *buf, size_t len,
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
1.7.10.1.562.gfc79b1c
