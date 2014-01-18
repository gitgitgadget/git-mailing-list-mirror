From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 12/17] remove_dir_recurse(): tighten condition for removing unreadable dir
Date: Sat, 18 Jan 2014 23:48:56 +0100
Message-ID: <1390085341-2553-13-git-send-email-mhagger@alum.mit.edu>
References: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 18 23:50:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4eib-0005Pp-Kf
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 23:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbaARWuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jan 2014 17:50:15 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:48290 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751775AbaARWtn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jan 2014 17:49:43 -0500
X-AuditID: 12074413-b7fc76d000002aba-33-52db05071b8a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 56.04.10938.7050BD25; Sat, 18 Jan 2014 17:49:43 -0500 (EST)
Received: from michael.fritz.box (p4FDD4E9C.dip0.t-ipconnect.de [79.221.78.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0IMnN95030075
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jan 2014 17:49:42 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsUixO6iqMvOejvIYN96NouuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M64dS6yYC9bRcuCk+wNjA2s
	XYycHBICJhJrGqYwQthiEhfurWfrYuTiEBK4zCjx5+cqZgjnBJPEnQlNzCBVbAK6Eot6mplA
	bBEBNYmJbYdYQGxmAQeJzZ8bwSYJC8RKrFrbBGRzcLAIqErM+q8IEuYVcJGYfvc/O0hYQkBB
	YvV1IZAwJ1D4yPwLYBOFBJwlbr5+wj6BkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1z
	vdzMEr3UlNJNjJAwEd7BuOuk3CFGAQ5GJR7eg0y3g4RYE8uKK3MPMUpyMCmJ8iqDhPiS8lMq
	MxKLM+KLSnNSiw8xSnAwK4nwBm+4FSTEm5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQ
	WgSTleHgUJLgvcQMNFSwKDU9tSItM6cEIc3EwQkiuEA28ABtuAVSyFtckJhbnJkOUXSKUVFK
	nHcJSEIAJJFRmgc3ABbRrxjFgf4R5r0PUsUDTAZw3a+ABjMBDRaJvQkyuCQRISXVwLhe83Wv
	937XBlFhrcKZs3Psd7o4nRcqlr7cMWWprbDSXl6/zrkq6wICOCw2PN0T96X6p3HzfsVktahJ
	+vNY5aWulO67lfHSYf7857IXvxzdWvgunfWRyrmZX5tiN2+V+Vqa+u6P9dzs/LddriZJCh7K
	T/lDPQUFVuvFSU2TXLtrPcuZsCWvrimxFGckGmoxFxUnAgCMk/Y2wwIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240666>

If opendir() fails on the top-level directory, it makes sense to try
to delete it anyway--but only if the failure was due to EACCES.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 dir.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index d10a63f..785a83e 100644
--- a/dir.c
+++ b/dir.c
@@ -1511,8 +1511,11 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 	flag &= ~REMOVE_DIR_KEEP_TOPLEVEL;
 	dir = opendir(path->buf);
 	if (!dir) {
-		/* an empty dir could be removed even if it is unreadble */
-		if (!keep_toplevel)
+		if (errno == EACCES && !keep_toplevel)
+			/*
+			 * An empty dir could be removable even if it
+			 * is unreadable:
+			 */
 			return rmdir(path->buf);
 		else
 			return -1;
-- 
1.8.5.2
