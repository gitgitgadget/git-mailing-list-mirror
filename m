From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: [PATCH COGITO] Do not make cross device hard links
Date: Tue, 26 Apr 2005 11:30:14 +0400
Message-ID: <200504261130.15006.snake@penza-gsm.ru>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_H4ebCGbPSy0BtSH"
X-From: git-owner@vger.kernel.org Tue Apr 26 09:26:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQKRu-00068m-MD
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 09:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVDZHal (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 03:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVDZHal
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 03:30:41 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:36997
	"HELO penza-gsm.ru") by vger.kernel.org with SMTP id S261381AbVDZHaR
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 03:30:17 -0400
Received: (qmail 27100 invoked from network); 26 Apr 2005 07:30:15 -0000
Received: from unknown (HELO snake) (192.168.0.20)
  by fileserver.penza-gsm.ru with SMTP; 26 Apr 2005 07:30:15 -0000
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on fileserver
X-Spam-Level: 
X-Spam-Status: No, score=-105.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	USER_IN_WHITELIST autolearn=ham version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--Boundary-00=_H4ebCGbPSy0BtSH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

cg-clone doesn't work across devices:

cd /tmp # my tmp is on seperate partition
mkdir cg
cd cg
cg-clone /home/snake/cg/
....
`/home/snake/cg/.git/objects/85/eb3d54aeec1d0f4cf3d2de257b8d7e29816147' -> 
`.git/objects/85/eb3d54aeec1d0f4cf3d2de257b8d7e29816147'
cp: cannot create link 
`.git/objects/85/eb3d54aeec1d0f4cf3d2de257b8d7e29816147': Invalid 
cross-device link
-----------

I have decided that problem should be solved by omitting -u flag while 
fetching in cg-pul;:
$fetch -s -d "$uri/objects" ".git/objects" || die "rsync error"

My variant of autodetection is probably very ugly, but it's works for me :)

-- 
Respectfully
Alexey Nezhdanov

--Boundary-00=_H4ebCGbPSy0BtSH
Content-Type: text/x-diff;
  charset="us-ascii";
  name="do-not-link-cross-device.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="do-not-link-cross-device.patch"

Index: cg-pull
===================================================================
--- f262000f302b749e485f5eb971e6aabefbb85680/cg-pull  (mode:100755 sha1:5cd67519fc5399886f22e8758d6d34e0e3014cbb)
+++ uncommitted/cg-pull  (mode:100755)
@@ -69,11 +69,15 @@
 	cp $cp_flags_l "$src" "$dest"
 }
 
+u_flag="-u"
+
 if echo "$uri" | grep -q ":"; then
 	fetch=fetch_rsync
 else
 	[ -d $uri/.git ] && uri=$uri/.git
 	fetch=fetch_local
+	cp -l $uri/branches/origin .cross-device-test 2>/dev/null || u_flag=""
+	[ -r .cross-device-test ] && rm .cross-device-test
 fi
 
 
@@ -95,17 +99,17 @@
 [ "$rsyncerr" ] && die "unable to get the head pointer of branch $rembranch"
 
 [ -d .git/objects ] || mkdir -p .git/objects
-$fetch -s -u -d "$uri/objects" ".git/objects" || die "rsync error"
+$fetch -s $u_flag -d "$uri/objects" ".git/objects" || die "rsync error"
 
 # FIXME: Warn about conflicting tag names?
 # XXX: We now throw stderr to /dev/null since not all repositories
 # may have tags/ and users were confused by the harmless errors.
 [ -d .git/refs/tags ] || mkdir -p .git/refs/tags
 rsyncerr=
-$fetch -s -u -d "$uri/refs/tags" ".git/refs/tags" 2>/dev/null || rsyncerr=1
+$fetch -s $u_flag -d "$uri/refs/tags" ".git/refs/tags" 2>/dev/null || rsyncerr=1
 if [ "$rsyncerr" ]; then
 	rsyncerr=
-	$fetch -s -u -d "$uri/tags" ".git/refs/tags" 2>/dev/null || rsyncerr=1
+	$fetch -s $u_flag -d "$uri/tags" ".git/refs/tags" 2>/dev/null || rsyncerr=1
 fi
 [ "$rsyncerr" ] && echo "unable to get tags list (non-fatal)" >&2
 

--Boundary-00=_H4ebCGbPSy0BtSH--

