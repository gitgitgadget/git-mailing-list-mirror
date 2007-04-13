From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/3] Teach git list-objects logic to not follow gitlinks
Date: Fri, 13 Apr 2007 09:25:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704130924160.28042@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704130919070.28042@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 18:25:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcOaH-0000cx-Pe
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 18:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbXDMQZJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 12:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754081AbXDMQZJ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 12:25:09 -0400
Received: from smtp.osdl.org ([65.172.181.24]:40267 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754079AbXDMQZF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 12:25:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3DGP2Is024631
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 13 Apr 2007 09:25:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3DGP1lh004062;
	Fri, 13 Apr 2007 09:25:02 -0700
In-Reply-To: <Pine.LNX.4.64.0704130919070.28042@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.957 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44421>


This allows us to pack superprojects and thus clone them (but not yet
check them out on the receiving side.. That's the next patch)

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 list-objects.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 2ba2c95..310f8d3 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -25,6 +25,37 @@ static void process_blob(struct rev_info *revs,
 	add_object(obj, p, path, name);
 }
 
+/*
+ * Processing a gitlink entry currently does nothing, since
+ * we do not recurse into the subproject.
+ *
+ * We *could* eventually add a flag that actually does that,
+ * which would involve:
+ *  - is the subproject actually checked out?
+ *  - if so, see if the subproject has already been added
+ *    to the alternates list, and add it if not.
+ *  - process the commit (or tag) the gitlink points to
+ *    recursively.
+ *
+ * However, it's unclear whether there is really ever any
+ * reason to see superprojects and subprojects as such a
+ * "unified" object pool (potentially resulting in a totally
+ * humongous pack - avoiding which was the whole point of
+ * having gitlinks in the first place!).
+ *
+ * So for now, there is just a note that we *could* follow
+ * the link, and how to do it. Whether it necessarily makes
+ * any sense what-so-ever to ever do that is another issue.
+ */
+static void process_gitlink(struct rev_info *revs,
+			    const unsigned char *sha1,
+			    struct object_array *p,
+			    struct name_path *path,
+			    const char *name)
+{
+	/* Nothing to do */
+}
+
 static void process_tree(struct rev_info *revs,
 			 struct tree *tree,
 			 struct object_array *p,
@@ -56,6 +87,9 @@ static void process_tree(struct rev_info *revs,
 			process_tree(revs,
 				     lookup_tree(entry.sha1),
 				     p, &me, entry.path);
+		else if (S_ISDIRLNK(entry.mode))
+			process_gitlink(revs, entry.sha1,
+					p, &me, entry.path);
 		else
 			process_blob(revs,
 				     lookup_blob(entry.sha1),
-- 
1.5.1.1.786.gdc49a-dirty
