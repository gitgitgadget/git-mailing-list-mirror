From: Frank Sorenson <frank@tuxrocks.com>
Subject: [PATCH] git-repack-script: Add option to repack all objects
Date: Sat, 27 Aug 2005 02:41:11 -0600
Message-ID: <43102727.2050206@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 27 10:42:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8wFk-0006g0-8g
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 10:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbVH0IlX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Aug 2005 04:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbVH0IlW
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Aug 2005 04:41:22 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:48653 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1030348AbVH0IlW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Aug 2005 04:41:22 -0400
Received: from [10.0.0.10] (216-190-206-130.customer.csolutions.net [216.190.206.130])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j7R8fCGD027268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 27 Aug 2005 02:41:13 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7846>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch adds an option to git-repack-script to repack all objects,
including both packed and unpacked.  This allows a full repack of
a git archive (current cogito packs from 39MB to 4.5MB, and git packs
from 4.4MB to 3.8MB).

Signed-off-by: Frank Sorenson <frank@tuxrocks.com>

diff --git a/git-repack-script b/git-repack-script
- --- a/git-repack-script
+++ b/git-repack-script
@@ -5,10 +5,12 @@
 
 . git-sh-setup-script || die "Not a git archive"
 	
+repack_all=
 no_update_info=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
+	--all)	repack_all=t ;;
 	-n)	no_update_info=t ;;
 	*)	break ;;
 	esac
@@ -16,13 +18,22 @@ do
 done
 
 rm -f .tmp-pack-*
- -packname=$(git-rev-list --unpacked --objects $(git-rev-parse --all) |
- -	git-pack-objects --non-empty --incremental .tmp-pack) ||
- -	exit 1
- -if [ -z "$packname" ]; then
- -	echo Nothing new to pack
- -	exit 0
- -fi
+case "$repack_all" in
+t)	packname=$(git-rev-list --objects $(git-rev-parse --all) |
+		git-pack-objects .tmp-pack) ||
+		exit 1
+	find "$GIT_OBJECT_DIRECTORY/"?? -type f | xargs rm -f
+	find "$GIT_OBJECT_DIRECTORY/pack" -type f | xargs rm -f
+	;;
+*)	packname=$(git-rev-list --unpacked --objects $(git-rev-parse --all) |
+		git-pack-objects --non-empty --incremental .tmp-pack) ||
+		exit 1
+	if [ -z "$packname" ]; then
+		echo Nothing new to pack
+		exit 0
+	fi
+	;;
+esac
 
 mkdir -p "$GIT_OBJECT_DIRECTORY/pack" &&
 mv .tmp-pack-$packname.pack "$GIT_OBJECT_DIRECTORY/pack/pack-$packname.pack" &&


Frank
- -- 
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDECcnaI0dwg4A47wRAsigAKDEItbKTKAeO+PO8VV0dtMvFl0qfgCffyDc
hL0nAUB0HxeDlDoh9fv2m4o=
=r4gM
-----END PGP SIGNATURE-----
