From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 4/4] git-am: refactor 'cleaning up and aborting'
Date: Tue, 26 May 2009 02:38:10 +0200
Message-ID: <1243298290-5909-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1243298290-5909-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1243298290-5909-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1243298290-5909-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1243298290-5909-4-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 02:39:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8khB-0004qX-Ek
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 02:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133AbZEZAi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 20:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753037AbZEZAiZ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 20:38:25 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:54869 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133AbZEZAiX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 20:38:23 -0400
Received: by mail-bw0-f222.google.com with SMTP id 22so3441077bwz.37
        for <git@vger.kernel.org>; Mon, 25 May 2009 17:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6LfR/paYYXjlcfOQisYp+STzBOlSf/EGG5NVtWEXJ3I=;
        b=QRghyt06guCaFqG2W99wTf7Mv6OnQHJYy161u9qSVJbpDfCM5XmDgiJFpfiwR+zN30
         MpAiYIOa0HCi6TActHARWtzzSy3AwZiZSqIdEqvt3VOf5q8gYWeM+5fspg6zNPjI6+gw
         C03drw2ahmhYSbOtYnwe3x4TCE28h3ofLxhGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ei9WdyNC+Y8F2aTurf9d8URP7BHayFEXC5yGoTo884M1fkClcm7gX1l8wDFonP3VEk
         +ApNAjO+5REsdNzvG7Nc7M8AR7NcPddW1WNjf+TfPmApXlqtQhlWYd8A2zhk5Pqs2tow
         MNua6g0rColhg8w954+rijHDKWPA0o+CwwtSA=
Received: by 10.103.252.17 with SMTP id e17mr4060597mus.14.1243298304879;
        Mon, 25 May 2009 17:38:24 -0700 (PDT)
Received: from localhost (host-78-15-9-104.cust-adsl.tiscali.it [78.15.9.104])
        by mx.google.com with ESMTPS id u26sm783989mug.52.2009.05.25.17.38.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 May 2009 17:38:24 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.248.gb44be
In-Reply-To: <1243298290-5909-4-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119988>

Introduce a clean_abort function that echoes an optional error message
to standard error, removes the dotest directory and exits with status 1.

Use it when patch format detection or patch splitting fails early.
---
 git-am.sh |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 1a00830..057acfe 100755
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
@@ -192,22 +201,18 @@ check_patch_format () {
 				fi
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
@@ -222,7 +227,7 @@ split_patches () {
 			shift
 			# remove the arg coming from the first-line comment
 			shift
-		} < "$series_file"
+		} < "$series_file" || clean_abort
 		# set the patch format appropriately
 		patch_format=stgit
 		# now handle the actual StGIT patches
@@ -254,18 +259,14 @@ split_patches () {
 					print "Subject:", $0 ;
 					subject = 1;
 				}
-			}' "$stgit" > "$dotest/$msgnum" || {
-				echo "Failed to import $patch_format patch $stgit"
-				exit 1
-			}
+			}' "$stgit" > "$dotest/$msgnum" || clean_abort
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
1.6.3.1.248.gb44be
