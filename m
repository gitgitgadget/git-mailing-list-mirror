From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: [PATCH] make git-prune-script actually work
Date: Sun, 24 Apr 2005 08:58:55 -0500
Message-ID: <1114351135.4997.18.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:54:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPhZ3-0004DG-6K
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 15:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbVDXN7P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 09:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbVDXN7O
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 09:59:14 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:61157 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262332AbVDXN7I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 09:59:08 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id j3ODwvA30452;
	Sun, 24 Apr 2005 09:58:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I find this script very useful to get back to where I started from after
test merges, and also for cloning trees from a non-current base.  The
functionality is altered so it now takes an optional commit argument
(and a -q flag to make it be quiet).

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

--- a/git-prune-script
+++ b/git-prune-script
@@ -1,2 +1,23 @@
 #!/bin/sh
-fsck-cache --unreachable $(cat .git/HEAD ) | grep unreachable | cut -d' ' -f3 | sed 's:^\(..\):.git/objects/\1/:' | xargs rm
+verbose=true
+case $1 in 
+	-q)	verbose=false
+		shift;;
+esac
+head=$1
+if [ -z "$head" ]; then
+	head=$(cat .git/HEAD)
+fi
+f=$(fsck-cache --unreachable $head | awk '/^unreachable /{print $3}'| sed 's:^\(..\):.git/objects/\1/:')
+if [ -z "$f" ]; then
+	echo "Nothing to remove"
+	exit 0
+fi
+
+for g in $f; do
+	if $verbose; then
+		echo $g
+	fi
+	rm -f $g
+done
+echo $head > .git/HEAD


