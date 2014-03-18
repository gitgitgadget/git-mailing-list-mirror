From: Othman Darraz <darrazo16@gmail.com>
Subject: [PATCH] fsck.c:fsck_commit()  use starts_with() and skip_prefix()
Date: Tue, 18 Mar 2014 23:41:52 +0100
Message-ID: <1395182512-17179-1-git-send-email-darrazo16@gmail.com>
Cc: Othman Darraz <darrazo16@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 18 23:42:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ2iB-00011n-DO
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 23:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758305AbaCRWmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 18:42:15 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:49984 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758300AbaCRWmN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 18:42:13 -0400
Received: by mail-we0-f169.google.com with SMTP id w62so6514427wes.0
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 15:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=tsXknhz+SscqJUmsI1OzyJjeCb5v6wWI32zYuLg23fM=;
        b=YcelXtuERK19foFRD9qnc4TaYyx0PZq0CFAu/W8xPgRv2GlZlRgXOe/gw4oU//YrHx
         HdiiVmPRYyrraJoD4PqWTe117FoVAWceISDi/xWHl2GBLcbcbxLD7RWXlB/ACl51TpD4
         TNVGsHf7JdJU4njQRdl2tAJ+eTEJX/tufw35jUCViJSLFhK43Eg/lF2HebwK1l7OTW6O
         smSbG/2vOAVSNSTG1071HegsMoyVTzvcYoogjeAoiZqlD5FVP3REpnfS8WLyJp4O5qc8
         2wBskx7M160roGT+AsU1mfWOoQC4Sqwa3lzcDSXCNxEGz0/e1r2LNFt4DeSWFVuDOVAe
         OfnA==
X-Received: by 10.194.90.107 with SMTP id bv11mr25545749wjb.11.1395182532939;
        Tue, 18 Mar 2014 15:42:12 -0700 (PDT)
Received: from localhost.localdomain (mut38-h01-31-32-140-164.dsl.sta.abo.bbox.fr. [31.32.140.164])
        by mx.google.com with ESMTPSA id fb6sm37968916wib.2.2014.03.18.15.42.11
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Mar 2014 15:42:12 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.258.g00eda23.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244392>

use of starts_with() instead of memcmp()

use of skip_prefix instead of memcmp() and strlen()

Signed-off-by: Othman Darraz <darrazo16@gmail.com>
---

I am planning to apply to GSOC 214
 fsck.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index 64bf279..5eae856 100644
--- a/fsck.c
+++ b/fsck.c
@@ -290,7 +290,7 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
 	int parents = 0;
 	int err;
 
-	if (memcmp(buffer, "tree ", 5))
+	if (starts_with(buffer, "tree "))
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
 	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
 		return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
@@ -322,15 +322,15 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
 		if (p || parents)
 			return error_func(&commit->object, FSCK_ERROR, "parent objects missing");
 	}
-	if (memcmp(buffer, "author ", 7))
+	if (starts_with(buffer, "author "))
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
 	buffer += 7;
 	err = fsck_ident(&buffer, &commit->object, error_func);
 	if (err)
 		return err;
-	if (memcmp(buffer, "committer ", strlen("committer ")))
+	buffer = (char* )skip_prefix(buffer,"committer ");
+	if (!buffer)
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
-	buffer += strlen("committer ");
 	err = fsck_ident(&buffer, &commit->object, error_func);
 	if (err)
 		return err;
-- 
1.9.0.258.g00eda23.dirty
