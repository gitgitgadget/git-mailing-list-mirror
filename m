From: Lukas Fleischer <git@cryptocrack.de>
Subject: [PATCH v2 3/3] convert.c: Remove duplicate code
Date: Sat, 13 Apr 2013 15:28:32 +0200
Message-ID: <1365859712-8400-3-git-send-email-git@cryptocrack.de>
References: <1365787573-597-1-git-send-email-git@cryptocrack.de>
 <1365859712-8400-1-git-send-email-git@cryptocrack.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 13 15:28:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UR0Vj-00028h-9G
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 15:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486Ab3DMN2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Apr 2013 09:28:38 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:47912 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab3DMN2h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 09:28:37 -0400
Received: from localhost (p57B40B0C.dip.t-dialin.net [87.180.11.12])
	by elnino.cryptocrack.de (OpenSMTPD) with ESMTP id 6fba877c
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128)
	for <git@vger.kernel.org>; Sat, 13 Apr 2013 15:28:35 +0200 (CEST)
X-Mailer: git-send-email 1.8.2.675.gda3bb24.dirty
In-Reply-To: <1365859712-8400-1-git-send-email-git@cryptocrack.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221061>

has_cr_in_index() is an almost 1:1 copy of
read_blob_data_from_index_path() with some additions. Invoke
read_blob_data_from_index_path() instead of using copy-pasted code.

Signed-off-by: Lukas Fleischer <git@cryptocrack.de>
---
 convert.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/convert.c b/convert.c
index 3520252..a12bc78 100644
--- a/convert.c
+++ b/convert.c
@@ -153,36 +153,13 @@ static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
 
 static int has_cr_in_index(const char *path)
 {
-	int pos, len;
 	unsigned long sz;
-	enum object_type type;
 	void *data;
 	int has_cr;
-	struct index_state *istate = &the_index;
 
-	len = strlen(path);
-	pos = index_name_pos(istate, path, len);
-	if (pos < 0) {
-		/*
-		 * We might be in the middle of a merge, in which
-		 * case we would read stage #2 (ours).
-		 */
-		int i;
-		for (i = -pos - 1;
-		     (pos < 0 && i < istate->cache_nr &&
-		      !strcmp(istate->cache[i]->name, path));
-		     i++)
-			if (ce_stage(istate->cache[i]) == 2)
-				pos = i;
-	}
-	if (pos < 0)
+	data = read_blob_data_from_index_path(path, NULL, &sz);
+	if (!data)
 		return 0;
-	data = read_sha1_file(istate->cache[pos]->sha1, &type, &sz);
-	if (!data || type != OBJ_BLOB) {
-		free(data);
-		return 0;
-	}
-
 	has_cr = memchr(data, '\r', sz) != NULL;
 	free(data);
 	return has_cr;
-- 
1.8.2.675.gda3bb24.dirty
