From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 21/25] commit_lock_file(): use a strbuf to manage temporary space
Date: Mon,  7 Apr 2014 01:34:03 +0200
Message-ID: <1396827247-28465-22-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:36:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwc6-00074B-7i
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713AbaDFXgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:36:15 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:64154 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754660AbaDFXfW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:35:22 -0400
X-AuditID: 12074413-f79076d000002d17-15-5341e4bab188
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 34.08.11543.AB4E1435; Sun,  6 Apr 2014 19:35:22 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbX8011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:35:20 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqLvriWOwwcUZshZdV7qZLBp6rzBb
	3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IHXh6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO+PXqfWsBas5Kzbc2c7cwHidvYuRk0NCwERi+Yw/
	zBC2mMSFe+vZuhi5OIQELjNKnF7bxAThHGeSaNvVBNbBJqArsainmQnEFhFQk5jYdogFpIhZ
	4AajxLt9h1lAEsICIRLrjp0AK2IRUJXY1v0QrJlXwFXiwcdJrBDr5CROHpsMZnMCxddNngvW
	KyTgAjTnHtsERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9XIzS/RSU0o3MUKCT3gH
	466TcocYBTgYlXh4Vx5yDBZiTSwrrsw9xCjJwaQkyvvgMVCILyk/pTIjsTgjvqg0J7X4EKME
	B7OSCO+BG0A53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IErzswyoQE
	i1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQdERXwyMD5AUD9BeN5B23uKCxFygKETr
	KUZFKXFedpCEAEgiozQPbiwspbxiFAf6Upg3DqSKB5iO4LpfAQ1mAhrcEGYHMrgkESEl1cAo
	2iRz82hsaHDGjHjmGR+q887NLpuy4aSkMofCtZMubE9ue0Ux9b1a+9Mxav4288DCRZX/JXhM
	nr9bkFu/0JKpKlzioJf7vtaUCT3vVy/KE7KW2fSTKTaF59LnH9G2Ex7+vzr9A7f+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245825>

Avoid relying on the filename length restrictions that are currently
checked by lock_file().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index b955cca..bf018b5 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -316,7 +316,8 @@ int close_lock_file(struct lock_file *lk)
 
 int commit_lock_file(struct lock_file *lk)
 {
-	char result_file[PATH_MAX];
+	static struct strbuf result_file = STRBUF_INIT;
+	int err;
 
 	if (lk->fd >= 0 && close_lock_file(lk))
 		return -1;
@@ -324,11 +325,12 @@ int commit_lock_file(struct lock_file *lk)
 	if (!(lk->flags & LOCK_FLAGS_LOCKFILE_ACTIVE))
 		return 0;
 
-	strcpy(result_file, lk->filename);
 	/* remove ".lock": */
-	result_file[strlen(result_file) - LOCK_SUFFIX_LEN] = 0;
-
-	if (rename(lk->filename, result_file))
+	strbuf_add(&result_file, lk->filename,
+		   strlen(lk->filename) - LOCK_SUFFIX_LEN);
+	err = rename(lk->filename, result_file.buf);
+	strbuf_reset(&result_file);
+	if (err)
 		return -1;
 	lk->flags &= ~LOCK_FLAGS_LOCKFILE_ACTIVE;
 	lk->filename[0] = 0;
-- 
1.9.1
