From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 4/4] git-am: refactor 'cleaning up and aborting'
Date: Wed, 27 May 2009 11:25:19 +0200
Message-ID: <1243416319-31477-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1243416319-31477-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1243416319-31477-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1243416319-31477-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1243416319-31477-4-git-send-email-giuseppe.bilotta@gmail.com>
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 11:26:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9FOk-0007o4-KS
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 11:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759031AbZE0JZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 05:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758492AbZE0JZj
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 05:25:39 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:48476 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758670AbZE0JZh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 05:25:37 -0400
Received: by bwz22 with SMTP id 22so4435812bwz.37
        for <git@vger.kernel.org>; Wed, 27 May 2009 02:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=T6RgJe3Yt5aUCM5gyHbHB14dmGY8DZA8ut2orej9pAk=;
        b=CPs37p7wBwaNdXKHBXGadnVJk0eCH2uzAyYKeniLnjubcgNRsi2WnnD3U1TrctSwA3
         Ph+YW2ie7jv3eCxER8VqDA/iX7IPoJ3fE8CZhLT6zGgyJ135VrffbqlCcH+TJHCPbkIb
         vfeEsFQfwtutE8QimLMwQz7vWQ748oBpUGbjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tdAyAOP1VDAYCOcpgEmJydccSG0LnqrlQgDwb86kgrUVnf4SMLN0KTwY3IdpCfWUgV
         bgWNpZki5Nqt6ZRJ6uQD4eS4BdPIvhvK18KGk1Me1V8zHJVCbenUR/WpvTJyFuCC8Y5o
         j92QG9d3OxkKI5Cw4L4CDmGe6QeTQJcLfxQHM=
Received: by 10.103.173.15 with SMTP id a15mr4934052mup.59.1243416337519;
        Wed, 27 May 2009 02:25:37 -0700 (PDT)
Received: from localhost (host-78-15-9-104.cust-adsl.tiscali.it [78.15.9.104])
        by mx.google.com with ESMTPS id j2sm1123093mue.12.2009.05.27.02.25.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 02:25:36 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.274.gd2e8.dirty
In-Reply-To: <1243416319-31477-4-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120054>

Introduce a clean_abort function that echoes an optional error message
to standard error, removes the dotest directory and exits with status 1.

Use it when patch format detection or patch splitting fails early.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-am.sh |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 3757269..588beea 100755
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
1.6.3.1.274.gd2e8.dirty
