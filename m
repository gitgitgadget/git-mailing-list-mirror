From: Michal Rokos <michal@rokos.info>
Subject: [cogito] Sync objects only when needed...
Date: Mon, 23 May 2005 09:48:29 +0200
Message-ID: <200505230948.29944.michal@rokos.info>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon May 23 09:48:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Da7eu-00050f-1V
	for gcvg-git@gmane.org; Mon, 23 May 2005 09:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVEWHsx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 03:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVEWHsx
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 03:48:53 -0400
Received: from black.click.cz ([62.141.0.10]:35539 "EHLO click.cz")
	by vger.kernel.org with ESMTP id S261864AbVEWHss (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2005 03:48:48 -0400
Received: from rokos.ack-prg.csas.cz (gprsh1.isp.t-mobile.cz [62.141.24.1])
	by click.cz (8.12.9/8.12.9) with ESMTP id j4N7mf91002321
	for <git@vger.kernel.org>; Mon, 23 May 2005 09:48:45 +0200 (MET DST)
Received: from ip6-localhost (ip6-localhost [IPv6:::1])
	by rokos.ack-prg.csas.cz (Postfix) with ESMTP id 37102F9004
	for <git@vger.kernel.org>; Mon, 23 May 2005 09:48:31 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: KMail/1.8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

during the day I'm usually connected via modem so syncing all the objects via rsync is painful.

So, is there any reason to sync them even if remote and and local origin head are the same?

 Michal

PS: I'm off the list, so please CC me.

Signed-off-by: Michal Rokos <michal@rokos.info>

Index: cg-pull
===================================================================
--- ca5fef50fb68a3afbb35e1a48ac622f7a964f021/cg-pull  (mode:100755)
+++ uncommitted/cg-pull  (mode:100755)
@@ -9,8 +9,14 @@
 
 . ${COGITO_LIB}cg-Xlib
 
-name=$1
+force=
 
+if [ "$1" == "-f" ]; then
+ force=1
+ shift
+fi
+
+name=$1
 
 [ "$name" ] || { [ -s $_git/refs/heads/origin ] && name=origin; }
 [ "$name" ] || die "where to pull from?"
@@ -199,6 +205,22 @@
 fi
 [ "$rsyncerr" ] && die "unable to get the head pointer of branch $rembranch"
 
+new_head=$(cat "$_git/refs/heads/$name")
+
+if [ ! "$orig_head" ]; then
+ echo "New branch: $new_head"
+
+elif [ "$orig_head" != "$new_head" ]; then
+ echo "Tree change: $orig_head:$new_head"
+
+elif [ -n "$force" ]; then
+ echo "Update forced..."
+
+else
+ echo "Up to date."
+ exit
+fi
+
 [ -d $_git_objects ] || mkdir -p $_git_objects
 $pull "$name" "$uri" || die "objects pull failed"
 
@@ -215,8 +237,6 @@
 [ "$rsyncerr" ] && echo "unable to get tags list (non-fatal)" >&2
 
 
-new_head=$(cat "$_git/refs/heads/$name")
-
 if [ ! "$orig_head" ]; then
  echo "New branch: $new_head"
 
