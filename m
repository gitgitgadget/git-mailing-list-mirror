From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 (resend) 4/4] git-am: refactor 'cleaning up and aborting'
Date: Tue,  2 Jun 2009 01:10:41 +0200
Message-ID: <1243897841-8923-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1243897841-8923-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1243897841-8923-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1243897841-8923-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1243897841-8923-4-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 01:11:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBGf3-0003zM-60
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 01:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755616AbZFAXK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 19:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755585AbZFAXK5
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 19:10:57 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:57382 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755967AbZFAXKz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 19:10:55 -0400
Received: by mail-fx0-f168.google.com with SMTP id 12so6124507fxm.37
        for <git@vger.kernel.org>; Mon, 01 Jun 2009 16:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=31w1j34KlW07XZTAAv4r9mhUrIgK5j37oBaY5k4ahWg=;
        b=QM3UIaIPcvAFajVbzFhvCXwdaiAh+JKh5p1SSbLxZfNPRr0ZnBKpfttAefJ+p6+rLT
         CQdZOAySddjBp2OuPf4rsE1FdqTbcnhPluFqAkE9QJW6vywpzOryZ7vtm68rySKoSVH1
         gIBwaNwoJfKTMofGGcnZm6+kNEgdRfI4ukSAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DIC1aam3BfsOJsMijhbVa3wDmJ9QQhf0N89H0Ej1ThFBLVR6ZxqdRzSevYGY96An9b
         5QjrzMY/ZvPfzbm0OzWWynL9AFVlFbtOMy7ZcWyk1n/Bu1xU94H8l4BM9ffdcEIi8AqB
         uhdkLbNGqTLC04b0h6PUmaNDmsI82dk++aHWM=
Received: by 10.204.121.194 with SMTP id i2mr6211978bkr.101.1243897857245;
        Mon, 01 Jun 2009 16:10:57 -0700 (PDT)
Received: from localhost (host-78-13-53-56.cust-adsl.tiscali.it [78.13.53.56])
        by mx.google.com with ESMTPS id 26sm103840fks.1.2009.06.01.16.10.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 16:10:56 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.282.g9f93
In-Reply-To: <1243897841-8923-4-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120487>

Introduce a clean_abort function that echoes an optional error message
to standard error, removes the dotest directory and exits with status 1.

Use it when patch format detection or patch splitting fails early.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-am.sh |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index d05c9b4..e8b2bc2 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -134,6 +134,15 @@ It does not apply to blobs recorded in its index."
     unset GITHEAD_$his_tree
 }
 
+clean_abort () {
+	if test $# -gt 0
+	then
+		echo "$@" > /dev/stderr
+	fi
+	rm -fr "$dotest"
+	exit 1
+}
+
 patch_format=
 
 check_patch_format () {
@@ -180,22 +189,18 @@ check_patch_format () {
 			esac
 			;;
 		esac
-	} < "$1"
+	} < "$1" || clean_abort
 }
 
 split_patches () {
 	case "$patch_format" in
 	mbox)
-		git mailsplit -d"$prec" -o"$dotest" -b -- "$@" > "$dotest/last" ||  {
-			rm -fr "$dotest"
-			exit 1
-		}
+		git mailsplit -d"$prec" -o"$dotest" -b -- "$@" > "$dotest/last" || clean_abort
 		;;
 	stgit-series)
 		if test $# -ne 1
 		then
-			echo "Only one StGIT patch series can be applied at once"
-			exit 1
+			clean_abort "Only one StGIT patch series can be applied at once"
 		fi
 		series_dir=`dirname "$1"`
 		series_file="$1"
@@ -210,7 +215,7 @@ split_patches () {
 			shift
 			# remove the arg coming from the first-line comment
 			shift
-		} < "$series_file"
+		} < "$series_file" || clean_abort
 		# set the patch format appropriately
 		patch_format=stgit
 		# now handle the actual StGIT patches
@@ -239,18 +244,14 @@ split_patches () {
 					print "Subject: ", $_ ;
 					$subject = 1;
 				}
-			' < "$stgit" > "$dotest/$msgnum" || {
-				echo "Failed to import $patch_format patch $stgit"
-				exit 1
-			}
+			' < "$stgit" > "$dotest/$msgnum" || clean_abort
 		done
 		echo "$this" > "$dotest/last"
 		this=
 		msgnum=
 		;;
 	*)
-		echo "Patch format $patch_format is not supported."
-		exit 1
+		clean_abort "Patch format $patch_format is not supported."
 		;;
 	esac
 }
-- 
1.6.3.1.282.g9f93
