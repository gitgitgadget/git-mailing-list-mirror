From: Linus Torvalds <torvalds@osdl.org>
Subject: Allow one-way tree merge to remove old files
Date: Sun, 14 May 2006 10:43:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605141040210.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun May 14 19:44:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfKdc-0007hX-Dm
	for gcvg-git@gmane.org; Sun, 14 May 2006 19:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWENRoL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 13:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWENRoL
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 13:44:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18880 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751498AbWENRoK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 13:44:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4EHhptH032202
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 14 May 2006 10:43:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4EHhoLv011579;
	Sun, 14 May 2006 10:43:51 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19972>


For some random reason (probably just because nobody noticed), the one-way 
merge strategy didn't mark deleted files as deleted, so if you used

	git-read-tree -m -u <newtree>

it would update the files that got changed in the index, but it would not 
delete the files that got deleted.

This should fix it, and I can't imagine that anybody depends on the old 
strange "update only existing files" behaviour.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/read-tree.c b/read-tree.c
index e926e4c..11157f4 100644
--- a/read-tree.c
+++ b/read-tree.c
@@ -684,7 +684,7 @@ static int oneway_merge(struct cache_ent
 			     merge_size);
 
 	if (!a)
-		return 0;
+		return deleted_entry(old, NULL);
 	if (old && same(old, a)) {
 		return keep_entry(old);
 	}
