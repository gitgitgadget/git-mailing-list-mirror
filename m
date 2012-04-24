From: mhagger@alum.mit.edu
Subject: [PATCH 05/30] refs.c: extract function search_for_subdir()
Date: Wed, 25 Apr 2012 00:45:11 +0200
Message-ID: <1335307536-26914-6-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:57:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMofw-0000Gj-Nl
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758442Ab2DXW5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:57:34 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:60966 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758458Ab2DXW47 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:56:59 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 6DBEF248145;
	Wed, 25 Apr 2012 00:45:57 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196271>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 01fcdc7..5e51c10 100644
--- a/refs.c
+++ b/refs.c
@@ -277,6 +277,27 @@ static struct ref_entry *search_ref_dir(struct ref_dir *dir, const char *refname
 }
 
 /*
+ * Search for a directory entry directly within dir (without
+ * recursing).  Sort dir if necessary.  subdirname must be a directory
+ * name (i.e., end in '/').  If mkdir is set, then create the
+ * directory if it is missing; otherwise, return NULL if the desired
+ * directory cannot be found.
+ */
+static struct ref_entry *search_for_subdir(struct ref_dir *dir,
+					   const char *subdirname, int mkdir)
+{
+	struct ref_entry *entry = search_ref_dir(dir, subdirname);
+	if (!entry) {
+		if (!mkdir)
+			return NULL;
+		entry = create_dir_entry(subdirname);
+		add_entry_to_dir(dir, entry);
+	}
+	assert(entry->flag & REF_DIR);
+	return entry;
+}
+
+/*
  * If refname is a reference name, find the ref_dir within the dir
  * tree that should hold refname.  If refname is a directory name
  * (i.e., ends in '/'), then return that ref_dir itself.  dir must
@@ -294,17 +315,10 @@ static struct ref_dir *find_containing_dir(struct ref_dir *dir,
 	for (slash = strchr(refname_copy, '/'); slash; slash = strchr(slash + 1, '/')) {
 		char tmp = slash[1];
 		slash[1] = '\0';
-		entry = search_ref_dir(dir, refname_copy);
-		if (!entry) {
-			if (!mkdir) {
-				dir = NULL;
-				break;
-			}
-			entry = create_dir_entry(refname_copy);
-			add_entry_to_dir(dir, entry);
-		}
+		entry = search_for_subdir(dir, refname_copy, mkdir);
 		slash[1] = tmp;
-		assert(entry->flag & REF_DIR);
+		if (!entry)
+			break;
 		dir = &entry->u.subdir;
 	}
 
-- 
1.7.10
