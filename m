From: mhagger@alum.mit.edu
Subject: [PATCH] free_ref_entry(): do not trigger reading of loose refs
Date: Sun, 20 May 2012 08:49:32 +0200
Message-ID: <1337496572-11258-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 20 08:57:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SW05F-0004Iw-Nx
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 08:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843Ab2ETG47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 May 2012 02:56:59 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:53168 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751096Ab2ETG46 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 May 2012 02:56:58 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 May 2012 02:56:58 EDT
X-AuditID: 1207440e-b7f256d0000008c1-74-4fb894149f97
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id BE.30.02241.41498BF4; Sun, 20 May 2012 02:49:56 -0400 (EDT)
Received: from michael.fritz.box (p4FC0ABAB.dip.t-dialin.net [79.192.171.171])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4K6nix4022017
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 20 May 2012 02:49:54 -0400
X-Mailer: git-send-email 1.7.10
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsUixO6iqCsyZYe/wfdzLBZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujH9LXAo6
	2CtWT3vF2MB4gbWLkZNDQsBEYuXhKewQtpjEhXvr2boYuTiEBC4zShxYuJIFwjnHJHH1wGY2
	kCo2ASmJl409YB0iAmoSE9sOsYDYzAIpEq/+7gKyOTiEBdwljr9hBDFZBFQlZh8PB6ngFXCR
	+L/lMRPELnmJp/f72CYwci9gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGusl5tZopeaUrqJ
	ERIKfDsY29fLHGIU4GBU4uEN0t/hL8SaWFZcmXuIUZKDSUmUl3ciUIgvKT+lMiOxOCO+qDQn
	tfgQowQHs5IIr3QWUI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMG7
	YTJQo2BRanpqRVpmTglCmomDE0RwgWzgAdpgDlLIW1yQmFucmQ5RdIpRUUqctx8kIQCSyCjN
	gxsAi9pXjOJA/wjztoBU8QAjHq77FdBgJqDBlWzbQAaXJCKkpBoYZ8Q/crVdkN+2cdL/U/u3
	SUY6uTdEabOrPvxdHp2sd8cua67Apnqn3bPyF7QJ7FQ3+qLU1ivhEBbBlbPDPuOZuNVjxZkO
	B7bJ/j4vniuuIOtx4NhkZ5YzNQG7LXZrTbr35+2TtN83nMOd/taZ5UXVXru1JzLikbrGjnqL
	ov8rOpJz81yTuXYosRRnJBpqMRcVJwIA6+wqkbUCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198051>

From: Michael Haggerty <mhagger@alum.mit.edu>

Do not call get_ref_dir() from within free_ref_entry(), because that
triggers the reading of loose refs, only for them to be freed
immediately.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Fix a silly inefficiency from the lazy-loose changes.

 refs.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index d6bdb47..26c8fcd 100644
--- a/refs.c
+++ b/refs.c
@@ -259,8 +259,13 @@ static void clear_ref_dir(struct ref_dir *dir);
 
 static void free_ref_entry(struct ref_entry *entry)
 {
-	if (entry->flag & REF_DIR)
-		clear_ref_dir(get_ref_dir(entry));
+	if (entry->flag & REF_DIR) {
+		/*
+		 * Do not use get_ref_dir() here, as that might
+		 * trigger the reading of loose refs.
+		 */
+		clear_ref_dir(&entry->u.subdir);
+	}
 	free(entry);
 }
 
-- 
1.7.10
