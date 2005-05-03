From: Mark Allen <mrallen1@yahoo.com>
Subject: [PATCH] extend cg-export to support release tarball creation
Date: Tue, 3 May 2005 15:57:11 -0700 (PDT)
Message-ID: <20050503225712.74818.qmail@web41211.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 00:51:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT6EV-0007jp-Fx
	for gcvg-git@gmane.org; Wed, 04 May 2005 00:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVECW52 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 18:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVECW52
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 18:57:28 -0400
Received: from web41211.mail.yahoo.com ([66.218.93.44]:54712 "HELO
	web41211.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261896AbVECW5U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 18:57:20 -0400
Received: (qmail 74820 invoked by uid 60001); 3 May 2005 22:57:12 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=gP1UBap+8ncF6MswJmkRlD9HNCKX3QYoWVyGRpaggbgt/B8g8Hgq3gQBz29vaVGx2Iiia7fsZQZkx3w57PHg5T4cXKa8B9s8r/BtbkLoZqGHUyPXEnv31nWHJ2XzDMjjmE2XLz1H7IfBy4UbLV6bJ07uw8Gr450PhELEsqlNGYQ=  ;
Received: from [65.173.207.2] by web41211.mail.yahoo.com via HTTP; Tue, 03 May 2005 15:57:11 PDT
To: Petr Baudis <pasky@ucw.cz>, Chris Wright <chrisw@osdl.org>
In-Reply-To: 6667
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here's a patch for cg-export which supports a "-r RELEASE" option. It will export the
specific ID or HEAD and then create a tar gz and a tar bz2 in your previous working
directory using RELEASE as the tarball name and the directory inside the tarball.

Within cogito itself,

cg-export -r $(cat VERSION) /tmp/foo

seems to work quite nicely to make release tarballs.

Unlike my previous attempt, this one does not make evil tarballs. :-)  One could insert a
script to update the .spec file before the tarfiles get created if desired.

Cheers,

--Mark

Signed-off-by: Mark Allen <mrallen1@yahoo.com>

Index: cg-export
===================================================================
--- aa6233be6d1b8bf42797c409a7c23b50593afc99/cg-export  (mode:100755
sha1:a4497314ab33f6a6387bc278e84f88d4442070ce)
+++ uncommitted/cg-export  (mode:100755 sha1:b0dfdf6049e7a074ef8c8c3f6a43e04a30e5cb89)
@@ -8,10 +8,17 @@

 . cg-Xlib

-destdir=$1
-id=$(tree-id $2)

-([ "$destdir" ] && [ "$id" ]) || die "usage: cg-export DESTDIR [TREE_ID]"
+if [ "$1" = "-r" ]; then
+       release=$2
+       destdir="$3/$2"
+       id=$(tree-id $4)
+else
+       destdir=$1
+       id=$(tree-id $2)
+fi
+
+([ "$destdir" ] && [ "$id" ]) || die "usage: cg-export [-r RELEASE] DESTDIR [TREE_ID]"

 [ -e "$destdir" ] && die "$destdir already exists."

@@ -20,3 +27,14 @@
 git-read-tree $id
 git-checkout-cache "--prefix=$destdir/" -a
 rm $GIT_INDEX_FILE
+
+if [ "$1" = "-r" ]; then
+       origdir=$PWD
+       cd $destdir
+       cd ..
+       tar czf $origdir/$release.tar.gz $release
+       tar cjf $origdir/$release.tar.bz2 $release
+       cd $origdir
+else
+       exit 0
+fi


