From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 09/23] Teach prepare_attr_stack() to figure out dirlen itself
Date: Thu,  4 Aug 2011 06:36:19 +0200
Message-ID: <1312432593-9841-10-git-send-email-mhagger@alum.mit.edu>
References: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:37:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QopgT-0005Mu-Cd
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535Ab1HDEhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:37:13 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39650 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab1HDEhA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:37:00 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744agHn029203;
	Thu, 4 Aug 2011 06:36:57 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178675>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 attr.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/attr.c b/attr.c
index bfa1f43..7f0f390 100644
--- a/attr.c
+++ b/attr.c
@@ -535,11 +535,18 @@ static void bootstrap_attr_stack(void)
 	}
 }
 
-static void prepare_attr_stack(const char *path, int dirlen)
+static void prepare_attr_stack(const char *path)
 {
 	struct attr_stack *elem, *info;
-	int len;
+	int dirlen, len;
 	struct strbuf pathbuf;
+	const char *cp;
+
+	cp = strrchr(path, '/');
+	if (!cp)
+		dirlen = 0;
+	else
+		dirlen = cp - path;
 
 	strbuf_init(&pathbuf, dirlen+2+strlen(GITATTRIBUTES_FILE));
 
@@ -709,20 +716,14 @@ static int macroexpand_one(int attr_nr, int rem)
 int git_checkattr(const char *path, int num, struct git_attr_check *check)
 {
 	struct attr_stack *stk;
-	const char *cp;
-	int dirlen, pathlen, i, rem;
+	int pathlen, i, rem;
 
 	bootstrap_attr_stack();
 	for (i = 0; i < attr_nr; i++)
 		check_all_attr[i].value = ATTR__UNKNOWN;
 
 	pathlen = strlen(path);
-	cp = strrchr(path, '/');
-	if (!cp)
-		dirlen = 0;
-	else
-		dirlen = cp - path;
-	prepare_attr_stack(path, dirlen);
+	prepare_attr_stack(path);
 	rem = attr_nr;
 	for (stk = attr_stack; 0 < rem && stk; stk = stk->prev)
 		rem = fill(path, pathlen, stk, rem);
-- 
1.7.6.8.gd2879
