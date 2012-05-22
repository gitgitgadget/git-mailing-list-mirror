From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/3] refs: convert parameter of search_ref_dir() to length-limited
 string
Date: Tue, 22 May 2012 20:50:39 +0200
Message-ID: <4FBBDFFF.8050207@lsrfire.ath.cx>
References: <1337692566-3718-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue May 22 20:51:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWuAx-0000xY-Sa
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 20:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760125Ab2EVSvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 14:51:13 -0400
Received: from india601.server4you.de ([85.25.151.105]:33061 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305Ab2EVSut (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 14:50:49 -0400
Received: from [192.168.2.105] (p579BE06F.dip.t-dialin.net [87.155.224.111])
	by india601.server4you.de (Postfix) with ESMTPSA id 6FE352F8058;
	Tue, 22 May 2012 20:50:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <1337692566-3718-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198226>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 refs.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index d6bdb47..c028333 100644
--- a/refs.c
+++ b/refs.c
@@ -319,19 +319,19 @@ static void sort_ref_dir(struct ref_dir *dir);
  * (non-recursively), sorting dir if necessary.  Return NULL if no
  * such entry is found.  dir must already be complete.
  */
-static struct ref_entry *search_ref_dir(struct ref_dir *dir, const char *refname)
+static struct ref_entry *search_ref_dir(struct ref_dir *dir,
+					const char *refname, size_t len)
 {
 	struct ref_entry *e, **r;
-	int len;
 
 	if (refname == NULL || !dir->nr)
 		return NULL;
 
 	sort_ref_dir(dir);
 
-	len = strlen(refname) + 1;
-	e = xmalloc(sizeof(struct ref_entry) + len);
+	e = xmalloc(sizeof(struct ref_entry) + len + 1);
 	memcpy(e->name, refname, len);
+	e->name[len] = '\0';
 
 	r = bsearch(&e, dir->entries, dir->nr, sizeof(*dir->entries), ref_entry_cmp);
 
@@ -353,7 +353,8 @@ static struct ref_entry *search_ref_dir(struct ref_dir *dir, const char *refname
 static struct ref_dir *search_for_subdir(struct ref_dir *dir,
 					 const char *subdirname, int mkdir)
 {
-	struct ref_entry *entry = search_ref_dir(dir, subdirname);
+	size_t len = strlen(subdirname);
+	struct ref_entry *entry = search_ref_dir(dir, subdirname, len);
 	if (!entry) {
 		if (!mkdir)
 			return NULL;
@@ -412,7 +413,7 @@ static struct ref_entry *find_ref(struct ref_dir *dir, const char *refname)
 	dir = find_containing_dir(dir, refname, 0);
 	if (!dir)
 		return NULL;
-	entry = search_ref_dir(dir, refname);
+	entry = search_ref_dir(dir, refname, strlen(refname));
 	return (entry && !(entry->flag & REF_DIR)) ? entry : NULL;
 }
 
-- 
1.7.10.2
