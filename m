From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 09/17] safe_create_leading_directories(): add new error value SCLD_VANISHED
Date: Sat, 18 Jan 2014 23:48:53 +0100
Message-ID: <1390085341-2553-10-git-send-email-mhagger@alum.mit.edu>
References: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 18 23:56:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4eoo-0000XF-Vv
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 23:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbaARW4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jan 2014 17:56:43 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:43424 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751436AbaARW4m (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jan 2014 17:56:42 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Jan 2014 17:56:41 EST
X-AuditID: 12074414-b7fb46d000002a4d-1e-52db0503080b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 17.F1.10829.3050BD25; Sat, 18 Jan 2014 17:49:39 -0500 (EST)
Received: from michael.fritz.box (p4FDD4E9C.dip0.t-ipconnect.de [79.221.78.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0IMnN92030075
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jan 2014 17:49:38 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsUixO6iqMvMejvIYOpDLYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M54dPgiU8EBsYrXU+UbGN8I
	djFyckgImEg8mHODEcIWk7hwbz1bFyMXh5DAZUaJsx/+sUA4J5gkTp6eyQxSxSagK7Gop5kJ
	xBYRUJOY2HaIBcRmFnCQ2Py5EWySsECcRN+Cz2BxFgFViQXbprOC2LwCLhILDk4G6uUA2qYg
	sfq6EEiYEyh8ZP4FsJFCAs4SN18/YZ/AyLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6F
	Xm5miV5qSukmRkigiOxgPHJS7hCjAAejEg/vAabbQUKsiWXFlbmHGCU5mJREeZVBQnxJ+SmV
	GYnFGfFFpTmpxYcYJTiYlUR4gzfcChLiTUmsrEotyodJSXOwKInzflus7ickkJ5YkpqdmlqQ
	WgSTleHgUJLgvcQMNFSwKDU9tSItM6cEIc3EwQkiuEA28ABtuAVSyFtckJhbnJkOUXSKUVFK
	nHcJSEIAJJFRmgc3ABbTrxjFgf4R5l0MUsUDTAdw3a+ABjMBDRaJvQkyuCQRISXVwNjT+Hjt
	zH/r7iftS7kixq43vWXBw56Zn4uftx/sr6roYnijtl7R88Dm3b11z9tST5+7Nvn+dRc+q2/f
	4w+azTlh8PTGqkz9QzYVs8oSCubbxxzd/++cUPffaUw7T0yoe3gyfYdjP6vHgrkqB76VLXn5
	ObFhLtfl5M7HTl+n6z7/d9Tz6bSsVb2XlViKMxINtZiLihMB6cAaH8QCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240668>

Add a new possible error result that can be returned by
safe_create_leading_directories() and
safe_create_leading_directories_const(): SCLD_VANISHED.  This value
indicates that a file or directory on the path existed at one point
(either it already existed or the function created it), but then it
disappeared.  This probably indicates that another process deleted the
directory while we were working.  If SCLD_VANISHED is returned, the
caller might want to retry the function call, as there is a chance
that a new attempt will succeed.

Why doesn't safe_create_leading_directories() do the retrying
internally?  Because an empty directory isn't really ever safe until
it holds a file.  So even if safe_create_leading_directories() were
absolutely sure that the directory existed before it returned, there
would be no guarantee that the directory still existed when the caller
tried to write something in it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h     | 10 +++++++++-
 sha1_file.c | 11 +++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 8030e36..c0a7a8a 100644
--- a/cache.h
+++ b/cache.h
@@ -742,12 +742,20 @@ int adjust_shared_perm(const char *path);
  * Create the directory containing the named path, using care to be
  * somewhat safe against races.  Return one of the scld_error values
  * to indicate success/failure.
+ *
+ * SCLD_VANISHED indicates that one of the ancestor directories of the
+ * path existed at one point during the function call and then
+ * suddenly vanished, probably because another process pruned the
+ * directory while we were working.  To be robust against this kind of
+ * race, callers might want to try invoking the function again when it
+ * returns SCLD_VANISHED.
  */
 enum scld_error {
 	SCLD_OK = 0,
 	SCLD_FAILED = -1,
 	SCLD_PERMS = -2,
-	SCLD_EXISTS = -3
+	SCLD_EXISTS = -3,
+	SCLD_VANISHED = -4
 };
 enum scld_error safe_create_leading_directories(char *path);
 enum scld_error safe_create_leading_directories_const(const char *path);
diff --git a/sha1_file.c b/sha1_file.c
index a065308..8b0849f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -132,6 +132,17 @@ enum scld_error safe_create_leading_directories(char *path)
 			if (errno == EEXIST &&
 			    !stat(path, &st) && S_ISDIR(st.st_mode))
 				; /* somebody created it since we checked */
+			else if (errno == ENOENT)
+				/*
+				 * Either mkdir() failed because
+				 * somebody just pruned the containing
+				 * directory, or stat() failed because
+				 * the file that was in our way was
+				 * just removed.  Either way, inform
+				 * the caller that it might be worth
+				 * trying again:
+				 */
+				ret = SCLD_VANISHED;
 			else
 				ret = SCLD_FAILED;
 		} else if (adjust_shared_perm(path)) {
-- 
1.8.5.2
