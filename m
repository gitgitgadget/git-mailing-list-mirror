From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 17/20] delete_ref_loose(): derive loose reference path from lock
Date: Thu, 25 Feb 2016 14:16:16 +0100
Message-ID: <592eaa8e9ccebb38df8fd60e35b23892bdc92648.1456405699.git.mhagger@alum.mit.edu>
References: <cover.1456405698.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 14:17:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYvn3-0003w4-RE
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 14:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760586AbcBYNRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 08:17:01 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:52854 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760327AbcBYNRA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 08:17:00 -0500
X-AuditID: 1207440f-d9fff70000007e44-10-56cefecabd50
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 04.9C.32324.ACEFEC65; Thu, 25 Feb 2016 08:16:58 -0500 (EST)
Received: from michael.fritz.box (p548D63F1.dip0.t-ipconnect.de [84.141.99.241])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1PDGPrv024973
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 25 Feb 2016 08:16:57 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1456405698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqHv637kwg42L2SzmbzrBaNF1pZvJ
	oqH3CrPFh7WH2Cx6J/eyWtxeMZ/Z4kdLD7MDu8ff9x+YPJ5un8Ls8eJ8hcez3j2MHhcvKXss
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7owPi2YwFbxkq9jW/4qxgfEwaxcjJ4eEgInEx/Y/
	jF2MXBxCAlsZJZb9uwLlnGCSuNZ0nhmkik1AV2JRTzMTiC0ioCYxse0QC0gRs8AjRomu/duB
	Ojg4hAWCJb7+YASpYRFQlbj3ZzEbiM0rECXxa85RdohtchItP3aDbeYUsJC4eHI62HwhAXOJ
	VTf2sE9g5FnAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdELzezRC81pXQTIyTE+Hcwdq2X
	OcQowMGoxMPL8PNsmBBrYllxZe4hRkkOJiVR3j3Pz4UJ8SXlp1RmJBZnxBeV5qQWH2KU4GBW
	EuFd8Rcox5uSWFmVWpQPk5LmYFES51Vfou4nJJCeWJKanZpakFoEk5Xh4FCS4N0E0ihYlJqe
	WpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPioH4YmAUgKR4gPbmgu0tLkjMBYpCtJ5i1OVY
	8OP2WiYhlrz8vFQpcV4jkCIBkKKM0jy4FbCE8opRHOhjYd5XIFU8wGQEN+kV0BImoCUzN4At
	KUlESEk1MJZa9HNpp/RFbNa9Lz53Q/K5YzNrzA7KSJgJf7w588XEN0e7pkl3uYX8XzJzdsuC
	rS/j/ymoTVt/ymOFz8vJvwpnTkjuO6/mZml/wHdWXi+bktftBwrRnEdSfyyLDL9f 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287375>

It is simpler to derive the path to the file that must be deleted from
"lock->ref_name" than from the lock_file object.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 46dcc23..7e825bd 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2345,10 +2345,7 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 		 * loose.  The loose file name is the same as the
 		 * lockfile name, minus ".lock":
 		 */
-		char *loose_filename = get_locked_file_path(lock->lk);
-		int res = unlink_or_msg(loose_filename, err);
-		free(loose_filename);
-		if (res)
+		if (unlink_or_msg(git_path("%s", lock->ref_name), err))
 			return 1;
 	}
 	return 0;
-- 
2.7.0
