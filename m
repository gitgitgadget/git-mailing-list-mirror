From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 17/19] update_ref(): don't read old reference value before delete
Date: Mon, 22 Jun 2015 16:03:08 +0200
Message-ID: <2104214a318e7bb636507888e4a31c5b739a7f40.1434980615.git.mhagger@alum.mit.edu>
References: <cover.1434980615.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 16:04:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z72Kj-0005vu-LL
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 16:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933682AbbFVOEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 10:04:11 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50099 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933604AbbFVODh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 10:03:37 -0400
X-AuditID: 1207440c-f79e16d000002a6e-2e-558815b82318
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 31.E4.10862.8B518855; Mon, 22 Jun 2015 10:03:36 -0400 (EDT)
Received: from michael.fritz.box (p4FC977DB.dip0.t-ipconnect.de [79.201.119.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5ME3CcF030627
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 22 Jun 2015 10:03:35 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434980615.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqLtDtCPU4EyXvkXXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLA6vH3/cfmDwWbCr1eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M+5//Mlc8J2jYv2MvcwNjLPZuxg5OSQETCSuTJjOCmGLSVy4t56ti5GLQ0jgMqPE74M/
	2CGck0wSRxtawKrYBHQlFvU0M4HYIgJqEhPbDrGAFDELdDBKXFi+DWyssECIxLtFDWwgNouA
	qsS1FxAreAWiJKZ/vsYIsU5O4vzxn8wgNqeAhcT8ff/BeoUEzCUmznzEMoGRdwEjwypGucSc
	0lzd3MTMnOLUZN3i5MS8vNQiXUO93MwSvdSU0k2MkKDi2cH4bZ3MIUYBDkYlHl4H2/ZQIdbE
	suLK3EOMkhxMSqK8B14DhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwtpwFyvGmJFZWpRblw6Sk
	OViUxHlVl6j7CQmkJ5akZqemFqQWwWRlODiUJHj9RDpChQSLUtNTK9Iyc0oQ0kwcnCDDuaRE
	ilPzUlKLEktLMuJB0RFfDIwPkBQP0N6lIO28xQWJuUBRiNZTjIpS4rz+IAkBkERGaR7cWFiq
	eMUoDvSlMO9PYaAqHmCaget+BTSYCWjwl9w2kMEliQgpqQZGoyPe8xR1LJynL1tzLJB/uQHX
	xFsLjqqnS9csCJ3xP+ahEeP9mOz6P9uja3elZO097ry98F2/xdNqm4QzFlw7C9VSFf16pE6x
	T/2kUP5kk+xJ3q69N6f7zd04O/KNhl1v75JvPgdlfl2Z/2fGSu8lJR7/Di0v3LDn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272359>

If we are deleting the reference, then we don't need to read the
reference's old value. It doesn't provide any race safety, because the
value read just before the delete is no "better" than the value that
would be read under lock during the delete. And even if the reference
previously didn't exist, we can call delete_ref() on it if we don't
provide an old_sha1 value.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 fast-import.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 6378726..d7ed065 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1692,13 +1692,13 @@ static int update_branch(struct branch *b)
 	unsigned char old_sha1[20];
 	struct strbuf err = STRBUF_INIT;
 
-	if (read_ref(b->name, old_sha1))
-		hashclr(old_sha1);
 	if (is_null_sha1(b->sha1)) {
 		if (b->delete)
-			delete_ref(b->name, old_sha1, 0);
+			delete_ref(b->name, NULL, 0);
 		return 0;
 	}
+	if (read_ref(b->name, old_sha1))
+		hashclr(old_sha1);
 	if (!force_update && !is_null_sha1(old_sha1)) {
 		struct commit *old_cmit, *new_cmit;
 
-- 
2.1.4
