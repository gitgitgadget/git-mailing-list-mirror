From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Wed, 27 Jul 2005 14:58:42 +0200
Message-ID: <200507271458.43063.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jul 27 14:59:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxlUt-0002tw-8o
	for gcvg-git@gmane.org; Wed, 27 Jul 2005 14:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbVG0M6u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jul 2005 08:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVG0M6u
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jul 2005 08:58:50 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:16309 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S262233AbVG0M6t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2005 08:58:49 -0400
To: git@vger.kernel.org
User-Agent: KMail/1.8.1
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

if I clone a remote head other than master via Cogito with

	cg-clone host:path#remoteHead,

work on this branch, and try to push back my changes with

	cg-push,

I get the error

	"pushing to a different head not supported yet".

As far as I can see, there is no support in core GIT to make this ever work 
(at least with get-send-packs), as "git-send-pack" only updates a set of 
heads with the same name both locally and remote.

I suppose the best would be to always keep the same head names in cloned 
repositories - it seems to be easier to handle for users. Perhaps the only 
exception would be "master", as one probably would like to pull masters of 
different remote repositories into a local one (without really working on 
them).

Thus, what about the following: Each time a remote head other than master is 
cloned, a head with the same name is created locally which is an alias to the 
local master. This way, cg-push almost works out of the box. Following patch 
implements this behavior.

Josef

diff --git a/cg-clone b/cg-clone
--- a/cg-clone
+++ b/cg-clone
@@ -69,5 +69,12 @@ cp $_git/refs/heads/origin $_git/refs/he
 git-read-tree HEAD
 git-checkout-cache -a
 git-update-cache --refresh

 echo "Cloned to $dir/ (origin $location available as branch \"origin\")"
+
+if echo "$location" | grep -q "#" ; then
+       rembranch=$(echo "$location" | sed -e "s/.*#//")
+       (cd $_git/refs/heads; ln -s master "$rembranch")
+       echo "Remote head \"$rbranch\" locally available as alias for \"master\""
+fi
+
diff --git a/cg-push b/cg-push
--- a/cg-push
+++ b/cg-push
@@ -28,17 +28,18 @@ uri=$(cat "$_git/branches/$name" 2>/dev/

 rembranch=master
 if echo "$uri" | grep -q '#'; then
        rembranch=$(echo $uri | cut -d '#' -f 2)
        uri=$(echo $uri | cut -d '#' -f 1)
-       die "pushing to a different head not supported yet"
+        [ -s $_git/refs/heads/$rembranch ] || (cd $_git/refs/heads;ln -s master $rembranch)
+        [ $(readlink $_git/refs/heads/$rembranch) = "master" ] || \
+          die "can not push to remote head \"$rembranch\""
 fi

 if echo "$uri" | grep -q "^http://"; then
        die "pushing over HTTP not supported yet"
 elif echo "$uri" | grep -q "^git+ssh://"; then
        git-send-pack "$(echo "$uri" | sed 's#^git+ssh://\([^/]*\)\(/.*\)$#\1:\2#')" $rembranch
-elif echo "$uri" | grep -q ":"; then
+elif echo "$uri" | grep -q "^rsync://"; then
        die "pushing over rsync not supported"
 else
        git-send-pack "$uri" $rembranch
 fi
