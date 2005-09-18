From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix archive-destroying "git repack -a -d" bug
Date: Sat, 17 Sep 2005 18:46:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509171839590.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Sep 18 03:48:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGoHN-0006o6-5l
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 03:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVIRBqs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Sep 2005 21:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbVIRBqr
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Sep 2005 21:46:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23700 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751264AbVIRBqr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Sep 2005 21:46:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8I1khBo009126
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 17 Sep 2005 18:46:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8I1keKZ029717;
	Sat, 17 Sep 2005 18:46:41 -0700
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8772>


Using "git repack -a -d" can destroy your git archive if you use it twice 
in succession.

Why? Because the new pack will be called the same as the old pack. And we 
delete the old packs _after_ we've moved the new pack to the .git/objects/ 
directory, which means that we'll delete the new pack too!

This is a totally untested patch that may or may not fix this.

Signed-off-by: Linus "testing is for suckers" Torvalds <torvalds@osdl.org>
---
diff --git a/git-repack.sh b/git-repack.sh
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -31,10 +31,6 @@ case ",$all_into_one," in
 	rev_list=
 	rev_parse='--all'
 	pack_objects=
-	# This part is a stop-gap until we have proper pack redundancy
-	# checker.
-	existing=`cd "$PACKDIR" && \
-	    find . -type f \( -name '*.pack' -o -name '*.idx' \) -print`
 	;;
 esac
 name=$(git-rev-list --objects $rev_list $(git-rev-parse $rev_parse) |
@@ -54,8 +50,13 @@ exit
 
 if test "$remove_redandant" = t
 then
+	# This part is a stop-gap until we have proper pack redundancy
+	# checker.
 	# We know $existing are all redandant only when
 	# all-into-one is used.
+	existing=`cd "$PACKDIR" && \
+	    find . -type f \( -name '*.pack' -o -name '*.idx' \) -print |
+	    grep -v $name`
 	if test "$all_into_one" != '' && test "$existing" != ''
 	then
 		( cd "$PACKDIR" && rm -f $existing )
