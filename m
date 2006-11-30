X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [BUG] git-fetch -k is broken
Date: Thu, 30 Nov 2006 15:11:54 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611301441440.9647@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 30 Nov 2006 20:15:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32796>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpsIv-0007mb-Fe for gcvg-git@gmane.org; Thu, 30 Nov
 2006 21:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031347AbWK3UM4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 15:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031361AbWK3UMV
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 15:12:21 -0500
Received: from relais.videotron.ca ([24.201.245.36]:55521 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1031359AbWK3ULz
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 15:11:55 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9K00LMB83UX740@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Thu,
 30 Nov 2006 15:11:55 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Actually, the .keep file is simply not removed as it should.

But first it appears that commit f64d7fd2 added an && on line 431 of 
git-fetch.sh and that cannot be right.  There is simply no condition for 
not removing the lock file.  It must be removed regardless if the 
previous command succeeded or not.  Junio?

Now for the actual problem.  I instrumented git-fetch.sh to understand 
what's going on as follows:

diff --git a/git-fetch.sh b/git-fetch.sh
index 8365785..042040e 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -397,10 +397,12 @@ fetch_main () {
 		  continue ;;
 	  keep)
 		  pack_lockfile="$GIT_OBJECT_DIRECTORY/pack/pack-$remote_name.keep"
+echo "a $pack_lockfile"
 		  continue ;;
 	  esac
 	  found=
 	  single_force=
+echo "b $pack_lockfile"
 	  for ref in $refs
 	  do
 	      case "$ref" in
@@ -425,10 +427,13 @@ fetch_main () {
 	      esac
 	  done
 	  local_name=$(expr "z$found" : 'z[^:]*:\(.*\)')
+echo "c $pack_lockfile"
 	  append_fetch_head "$sha1" "$remote" \
 		  "$remote_name" "$remote_nick" "$local_name" \
 		  "$not_for_merge" || exit
-      done &&
+echo "d $pack_lockfile"
+      done
+echo "e $pack_lockfile"
       if [ "$pack_lockfile" ]; then rm -f "$pack_lockfile"; fi
     ) || exit ;;
   esac

And performing a fetch -k produced the following output:

a .git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.keep
b .git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.keep
c .git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.keep
* refs/heads/next: fast forward to branch 'next' of 
git://git.kernel.org/pub/scm/git/git
  old..new: ede546b..c41921b
d .git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.keep
b .git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.keep
c .git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.keep
d .git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.keep
b .git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.keep
c .git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.keep
d .git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.keep
b .git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.keep
c .git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.keep
d .git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.keep
b .git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.keep
c .git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.keep
d .git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.keep
b .git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.keep
c .git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.keep
d .git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.keep
b .git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.keep
c .git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.keep
d .git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.keep
e

So....... How the heck could pack_lockfile become empty on the line with 
the "e" mark?

$ /bin/sh --version
GNU bash, version 3.1.17(1)-release (i686-redhat-linux-gnu)


