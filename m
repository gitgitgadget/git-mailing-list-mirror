From: Linus Torvalds <torvalds@osdl.org>
Subject: Be marginally more careful about removing objects
Date: Fri, 28 Oct 2005 09:45:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510280935130.4664@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Oct 28 18:48:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVXMv-0005WX-Mm
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 18:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbVJ1QqK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Oct 2005 12:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbVJ1QqK
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Oct 2005 12:46:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28872 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030247AbVJ1QqJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Oct 2005 12:46:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9SGjsFC017870
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 28 Oct 2005 09:45:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9SGjrH6005338;
	Fri, 28 Oct 2005 09:45:54 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10768>


The git philosophy when it comes to disk accesses is "Laugh in the face of 
danger".

Notably, since we never modify an existing object, we don't really care 
that deeply about flushing things to disk, since even if the machine 
crashes in the middle of a git operation, you can never really have lost 
any old work. At most, you'd need to figure out the proper heads (which 
git-fsck-objects can do for you) and re-do the operation.

However, there's two exceptions to this: pruning and repacking. Those 
operations will actually _delete_ old objects that they know about in 
other ways (ie that they just repacked, or that they have found in other 
places).

However, since they actually modify old state, we should thus be a bit 
more careful about them. If the machine crashes and the duplicate new 
objects haven't been flushed to disk, you can actually be in trouble.

This is trivially stupid about it by calling "sync" before removing the 
objects. Not very smart, but we're talking about special operations than 
are usually done once a week if that.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/git-prune.sh b/git-prune.sh
index b28630c..ef31bd2 100755
--- a/git-prune.sh
+++ b/git-prune.sh
@@ -15,6 +15,7 @@ do
     shift;
 done
 
+sync
 git-fsck-objects --full --cache --unreachable "$@" |
 sed -ne '/unreachable /{
     s/unreachable [^ ][^ ]* //
diff --git a/git-repack.sh b/git-repack.sh
index 49547a7..d341966 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -62,6 +62,7 @@ then
 	# all-into-one is used.
 	if test "$all_into_one" != '' && test "$existing" != ''
 	then
+		sync
 		( cd "$PACKDIR" &&
 		  for e in $existing
 		  do
diff --git a/prune-packed.c b/prune-packed.c
index 16685d1..26123f7 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -71,6 +71,7 @@ int main(int argc, char **argv)
 		/* Handle arguments here .. */
 		usage(prune_packed_usage);
 	}
+	sync();
 	prune_packed_objects();
 	return 0;
 }
