From: Linus Torvalds <torvalds@osdl.org>
Subject: Allow "git repack" users to specify repacking window/depth
Date: Wed, 19 Apr 2006 10:05:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604191003200.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Apr 19 19:05:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWG7L-0004XB-1b
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 19:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWDSRFX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 13:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWDSRFX
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 13:05:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32457 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750982AbWDSRFW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Apr 2006 13:05:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3JH5DtH030635
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 19 Apr 2006 10:05:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3JH5CGB027189;
	Wed, 19 Apr 2006 10:05:13 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18931>


.. but don't even bother documenting it. I don't think any normal person 
is supposed to ever really care, but it simplifies testing when you want 
to use the "git repack" wrapper rather than forcing you to use the core 
programs (which already do support the window/depth arguments, of course).

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/git-repack.sh b/git-repack.sh
index a5d349f..7a72c2c 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -7,7 +7,7 @@ USAGE='[-a] [-d] [-f] [-l] [-n] [-q]'
 . git-sh-setup
 	
 no_update_info= all_into_one= remove_redundant=
-local= quiet= no_reuse_delta=
+local= quiet= no_reuse_delta= extra=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
@@ -17,6 +17,8 @@ do
 	-q)	quiet=-q ;;
 	-f)	no_reuse_delta=--no-reuse-delta ;;
 	-l)	local=--local ;;
+	--window=*) extra="$extra $1" ;;
+	--depth=*) extra="$extra $1" ;;
 	*)	usage ;;
 	esac
 	shift
@@ -40,7 +42,7 @@ case ",$all_into_one," in
 	    find . -type f \( -name '*.pack' -o -name '*.idx' \) -print`
 	;;
 esac
-pack_objects="$pack_objects $local $quiet $no_reuse_delta"
+pack_objects="$pack_objects $local $quiet $no_reuse_delta $extra"
 name=$(git-rev-list --objects --all $rev_list 2>&1 |
 	git-pack-objects --non-empty $pack_objects .tmp-pack) ||
 	exit 1
