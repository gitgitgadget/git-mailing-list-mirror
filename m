From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 05/16] commit_lock_file(): use get_locked_file_path()
Date: Mon, 10 Aug 2015 11:47:40 +0200
Message-ID: <9e5665f33adf5d4a23dbd24301c0b502508aed0a.1439198011.git.mhagger@alum.mit.edu>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:48:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjhP-0002HS-60
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773AbbHJJsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:48:47 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:57226 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753216AbbHJJsI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 05:48:08 -0400
X-AuditID: 12074413-f79bd6d000007ac2-8f-55c873529832
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 64.87.31426.25378C55; Mon, 10 Aug 2015 05:48:02 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D4D.dip0.t-ipconnect.de [79.201.125.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7A9lswt021057
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Aug 2015 05:48:01 -0400
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1439198011.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqBtUfCLU4MIDXouuK91MFg29V5gt
	nsy9y2xxe8V8ZgcWj7/vPzB5PHzVxe5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGbvO3mcq
	mMBfseHwJOYGxpM8XYycHBICJhKrj15hhrDFJC7cW8/WxcjFISRwmVGi7dhXKOcEk8S15w1M
	IFVsAroSi3qawWwRATWJiW2HWEBsZoF0iRML2sFsYQEPiZlXFwDVcHCwCKhKXFhmDxLmFYiS
	uLy1nQ0kLCEgJ7HgQjpImFPAQmJ74wZWEFtIwFzi8bzz7BMYeRcwMqxilEvMKc3VzU3MzClO
	TdYtTk7My0st0jXXy80s0UtNKd3ECAke4R2Mu07KHWIU4GBU4uGdsfl4qBBrYllxZe4hRkkO
	JiVRXov8E6FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHjjM4ByvCmJlVWpRfkwKWkOFiVxXrUl
	6n5CAumJJanZqakFqUUwWRkODiUJ3nuFQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYml
	JRnxoLiILwZGBkiKB2jvEZB23uKCxFygKETrKUZFKXHefSAJAZBERmke3FhYSnjFKA70pTDv
	HpAqHmA6get+BTSYCWiwXSDY4JJEhJRUA6Pl7fMLMq6ztct2mrl/+bt5YRBLj+e09w2TVQt/
	1bhofC0PnpJyy3rD7ZV7dLM7JOb2rdH95hcWNumvULL1urlvzpn/3Nb85GqFZCMrl2Lfj3kO
	03LnnznxtOrxZsbLp1b4NWo73unOYrOYwhn6rC/p/ZxDF3Ld/xoFr9g7+4KWeNby 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275603>

First beef up the sanity checking in get_locked_file_path() to match
that in commit_lock_file(). Then rewrite commit_lock_file() to use
get_locked_file_path() for its pathname computation.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 5e954ba..3904803 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -389,8 +389,10 @@ char *get_locked_file_path(struct lock_file *lk)
 {
 	if (!lk->active)
 		die("BUG: get_locked_file_path() called for unlocked object");
-	if (lk->filename.len <= LOCK_SUFFIX_LEN)
+	if (lk->filename.len <= LOCK_SUFFIX_LEN ||
+	    strcmp(lk->filename.buf + lk->filename.len - LOCK_SUFFIX_LEN, LOCK_SUFFIX))
 		die("BUG: get_locked_file_path() called for malformed lock object");
+	/* remove ".lock": */
 	return xmemdupz(lk->filename.buf, lk->filename.len - LOCK_SUFFIX_LEN);
 }
 
@@ -458,22 +460,16 @@ int commit_lock_file_to(struct lock_file *lk, const char *path)
 
 int commit_lock_file(struct lock_file *lk)
 {
-	static struct strbuf result_file = STRBUF_INIT;
-	int err;
+	char *result_path = get_locked_file_path(lk);
 
-	if (!lk->active)
-		die("BUG: attempt to commit unlocked object");
-
-	if (lk->filename.len <= LOCK_SUFFIX_LEN ||
-	    strcmp(lk->filename.buf + lk->filename.len - LOCK_SUFFIX_LEN, LOCK_SUFFIX))
-		die("BUG: lockfile filename corrupt");
-
-	/* remove ".lock": */
-	strbuf_add(&result_file, lk->filename.buf,
-		   lk->filename.len - LOCK_SUFFIX_LEN);
-	err = commit_lock_file_to(lk, result_file.buf);
-	strbuf_reset(&result_file);
-	return err;
+	if (commit_lock_file_to(lk, result_path)) {
+		int save_errno = errno;
+		free(result_path);
+		errno = save_errno;
+		return -1;
+	}
+	free(result_path);
+	return 0;
 }
 
 void rollback_lock_file(struct lock_file *lk)
-- 
2.5.0
