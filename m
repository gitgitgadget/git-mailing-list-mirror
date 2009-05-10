From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/6] mktree: do not barf on a submodule commit
Date: Sun, 10 May 2009 11:49:49 -0700
Message-ID: <1241981391-19639-5-git-send-email-gitster@pobox.com>
References: <1241981391-19639-1-git-send-email-gitster@pobox.com>
 <1241981391-19639-2-git-send-email-gitster@pobox.com>
 <1241981391-19639-3-git-send-email-gitster@pobox.com>
 <1241981391-19639-4-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 20:50:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3E6Q-0004rg-ND
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 20:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873AbZEJSuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 14:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755920AbZEJSuF
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 14:50:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52402 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755512AbZEJSuB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 14:50:01 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 226D6B1B68
	for <git@vger.kernel.org>; Sun, 10 May 2009 14:50:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 91B2CB1B67 for
 <git@vger.kernel.org>; Sun, 10 May 2009 14:50:01 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.9.g6345d
In-Reply-To: <1241981391-19639-4-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5E69FCEE-3D93-11DE-854C-CABC03BA4B0C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118737>

It is perfectly normal if a tree entry points at a missing commit as long
as the mode of the entry says it is a submodule.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-mktree.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/builtin-mktree.c b/builtin-mktree.c
index 133ab4b..17cdb3d 100644
--- a/builtin-mktree.c
+++ b/builtin-mktree.c
@@ -89,9 +89,16 @@ static void mktree_line(char *buf, size_t len, int line_termination)
 	    ntr[41] != '\t' ||
 	    get_sha1_hex(ntr + 1, sha1))
 		die("input format error: %s", buf);
-	type = sha1_object_info(sha1, NULL);
+
+	/* It is perfectly normal if we do not have a commit from a submodule */
+	if (!S_ISGITLINK(mode))
+		type = sha1_object_info(sha1, NULL);
+	else
+		type = OBJ_COMMIT;
+
 	if (type < 0)
 		die("object %s unavailable", sha1_to_hex(sha1));
+
 	*ntr++ = 0; /* now at the beginning of SHA1 */
 	if (type != type_from_string(ptr))
 		die("object type %s mismatch (%s)", ptr, typename(type));
-- 
1.6.3.9.g6345d
