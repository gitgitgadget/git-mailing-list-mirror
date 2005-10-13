From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 3/3] Add "-l" flag for repacking only local packs
Date: Thu, 13 Oct 2005 14:30:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510131427030.23590@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Oct 13 23:33:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQAes-0006Zd-Nl
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 23:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbVJMVag (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 17:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbVJMVag
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 17:30:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63939 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964864AbVJMVaf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2005 17:30:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9DLUU4s024181
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 13 Oct 2005 14:30:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9DLUTWB003247;
	Thu, 13 Oct 2005 14:30:30 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.124 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10092>


This uses the new "--local" flag to git-pack-objects.  It currently only
makes a difference together with "-a", since a normal incremental repack
won't pack any packed objects at all (whether local or remote). 

Eventually, it might end up skipping any objects that aren't local to
the current object directory, but for now it only knows to skip packed
objects. 

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Ok, that was the last of it. I tested it out by doing a

	git clone -l -s git newgit
	cd newgit
	.. do a dummy commit ..
	git repack -a -d -l

and then

	cd ../git
	git repack -a -d

	cd ../newgit
	git repack -a -d -l

and verified that the repacks in "newgit" all seemed to do the right thing 
(ie they only repacked objects that weren't packed in the original git, 
and repacking the original git archive caused the repack in the new one to 
shrink considerably).

This means that my suggested automatic repacking should work fine with 
alternate object directories too, except my second script (the periodic 
full repack) would needs to be updated to use the new "-l" flag.

diff --git a/git-repack.sh b/git-repack.sh
index b395d0e..49547a7 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -5,13 +5,14 @@
 
 . git-sh-setup || die "Not a git archive"
 	
-no_update_info= all_into_one= remove_redundant=
+no_update_info= all_into_one= remove_redundant= local=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
 	-n)	no_update_info=t ;;
 	-a)	all_into_one=t ;;
 	-d)	remove_redandant=t ;;
+	-l)	local=t ;;
 	*)	break ;;
 	esac
 	shift
@@ -37,6 +38,9 @@ case ",$all_into_one," in
 	    find . -type f \( -name '*.pack' -o -name '*.idx' \) -print`
 	;;
 esac
+if [ "$local" ]; then
+	pack_objects="$pack_objects --local"
+fi
 name=$(git-rev-list --objects $rev_list $(git-rev-parse $rev_parse) |
 	git-pack-objects --non-empty $pack_objects .tmp-pack) ||
 	exit 1
