From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] Windows: fix utime() for read-only files
Date: Tue, 30 Mar 2010 09:46:23 +0200
Message-ID: <4BB1AC4F.4020906@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 09:46:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwW9i-0006c7-Jq
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 09:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973Ab0C3Hq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 03:46:29 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:19414 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794Ab0C3Hq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 03:46:28 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NwW9X-0007VU-Sy; Tue, 30 Mar 2010 09:46:24 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A0A601660F;
	Tue, 30 Mar 2010 09:46:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143551>

From: Johannes Sixt <j6t@kdbg.org>

Starting with 5256b00 (Use git_mkstemp_mode instead of plain mkstemp to
create object files, 2010-02-22) utime() is invoked on read-only files.
This is not allowed on Windows and results in many warnings of the form

failed utime() on .git/objects/23/tmp_obj_VlgHlc: Permission denied

during a repack.  Fix it by making the file temporarily writable.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This should go on top of 5256b00 in maint.

 -- Hannes

 PS: First patch submission with a new MUA; I hope it gets through
 undamaged.

 compat/mingw.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index ab65f77..59b18dc 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -259,8 +259,17 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
 	int fh, rc;
 
 	/* must have write permission */
-	if ((fh = open(file_name, O_RDWR | O_BINARY)) < 0)
-		return -1;
+	DWORD attrs = GetFileAttributes(file_name);
+	if (attrs != INVALID_FILE_ATTRIBUTES &&
+	    (attrs & FILE_ATTRIBUTE_READONLY)) {
+		/* ignore errors here; open() will report them */
+		SetFileAttributes(file_name, attrs & ~FILE_ATTRIBUTE_READONLY);
+	}
+
+	if ((fh = open(file_name, O_RDWR | O_BINARY)) < 0) {
+		rc = -1;
+		goto revert_attrs;
+	}
 
 	time_t_to_filetime(times->modtime, &mft);
 	time_t_to_filetime(times->actime, &aft);
@@ -270,6 +279,13 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
 	} else
 		rc = 0;
 	close(fh);
+
+revert_attrs:
+	if (attrs != INVALID_FILE_ATTRIBUTES &&
+	    (attrs & FILE_ATTRIBUTE_READONLY)) {
+		/* ignore errors again */
+		SetFileAttributes(file_name, attrs);
+	}
 	return rc;
 }
 
-- 
1.7.0.7.gcaca7
