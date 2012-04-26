From: mhagger@alum.mit.edu
Subject: [PATCH v2 11/18] find_containing_dir(): use strbuf in implementation of this function
Date: Fri, 27 Apr 2012 00:27:00 +0200
Message-ID: <1335479227-7877-12-git-send-email-mhagger@alum.mit.edu>
References: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 00:27:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNXA1-0007z0-Tg
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 00:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759498Ab2DZW1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 18:27:32 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:37121 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759472Ab2DZW1b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 18:27:31 -0400
Received: from michael.berlin.jpk.com (michael2.berlin.jpk.com [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 83C4F24813F;
	Fri, 27 Apr 2012 00:27:30 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196429>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 989c10d..94b20a3 100644
--- a/refs.c
+++ b/refs.c
@@ -309,20 +309,21 @@ static struct ref_entry *search_for_subdir(struct ref_dir *dir,
 static struct ref_dir *find_containing_dir(struct ref_dir *dir,
 					   const char *refname, int mkdir)
 {
-	char *refname_copy = xstrdup(refname);
-	char *slash;
-	struct ref_entry *entry;
-	for (slash = strchr(refname_copy, '/'); slash; slash = strchr(slash + 1, '/')) {
-		char tmp = slash[1];
-		slash[1] = '\0';
-		entry = search_for_subdir(dir, refname_copy, mkdir);
-		slash[1] = tmp;
+	struct strbuf dirname;
+	const char *slash;
+	strbuf_init(&dirname, PATH_MAX);
+	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
+		struct ref_entry *entry;
+		strbuf_add(&dirname,
+			   refname + dirname.len,
+			   (slash + 1) - (refname + dirname.len));
+		entry = search_for_subdir(dir, dirname.buf, mkdir);
 		if (!entry)
 			break;
 		dir = &entry->u.subdir;
 	}
 
-	free(refname_copy);
+	strbuf_release(&dirname);
 	return dir;
 }
 
-- 
1.7.10
