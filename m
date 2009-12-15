From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] octopus: make merge process simpler to follow
Date: Mon, 14 Dec 2009 22:49:15 -0800
Message-ID: <1260859755-3990-1-git-send-email-bebarino@gmail.com>
References: <7vk4wrrkce.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 07:49:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKRDp-00061D-6O
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 07:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbZLOGtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 01:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbZLOGtU
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 01:49:20 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:49009 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbZLOGtT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 01:49:19 -0500
Received: by yxe17 with SMTP id 17so3392484yxe.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 22:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7QQyluTKXZa9SAv4WP1JbGGfsp0tJ7lOteWBhs7EKjk=;
        b=dqPICQPAUWzMdfiMPietzhJnBA4kFNfblGBz+G5STLzv3ZeJbMX22UIRaVcas3hPqN
         BUCMRVGTRFr84qt0F23cQDhAgJP84WZ5qF0UwqlFkgKprhupvYPFFiAJod3jLHjmr6zL
         Dzsn43m38IwJLGiWnvt+3Fw5CL8Mo2Pxk+Zy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wIdgAm9Wyca2aLfI0LOWNcF7QnTSFNa0+A4dVaIUFD+uQMIMdGaVaT16hk4NGkkOji
         543UtzrGNN5I7WtP578ZoV6p8urPO7EYlXREyHI5daR8W/1NvtoJDi/Ilk6/62Q24yjc
         5jLGo59+la8ms+ohWeGvxH+Stc+JV9Bs/xeME=
Received: by 10.90.58.20 with SMTP id g20mr2313088aga.36.1260859758767;
        Mon, 14 Dec 2009 22:49:18 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 22sm1843655ywh.30.2009.12.14.22.49.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 22:49:17 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc2.5.g49666
In-Reply-To: <7vk4wrrkce.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135273>

Its not very easy to understand what heads are being merged given
the current output of an octopus merge. Fix this by replacing the
sha1 with the (usually) better description in GITHEAD_<SHA1>.

Suggested-by: Jari Aalto <jari.aalto@cante.net>
Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Thanks both. Here's a replacement. Let me know if you want a reroll.

 git-merge-octopus.sh          |   11 +++++++----
 t/t7602-merge-octopus-many.sh |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
index 825c52c..417e8fb 100755
--- a/git-merge-octopus.sh
+++ b/git-merge-octopus.sh
@@ -61,12 +61,15 @@ do
 		exit 2
 	esac
 
+	eval pretty_name="\$GITHEAD_$SHA1"
+	: ${pretty_name:=$SHA1}
+
 	common=$(git merge-base --all $SHA1 $MRC) ||
-		die "Unable to find common commit with $SHA1"
+		die "Unable to find common commit with $pretty_name"
 
 	case "$LF$common$LF" in
 	*"$LF$SHA1$LF"*)
-		echo "Already up-to-date with $SHA1"
+		echo "Already up-to-date with $pretty_name"
 		continue
 		;;
 	esac
@@ -81,7 +84,7 @@ do
 		# tree as the intermediate result of the merge.
 		# We still need to count this as part of the parent set.
 
-		echo "Fast-forwarding to: $SHA1"
+		echo "Fast-forwarding to: $pretty_name"
 		git read-tree -u -m $head $SHA1 || exit
 		MRC=$SHA1 MRT=$(git write-tree)
 		continue
@@ -89,7 +92,7 @@ do
 
 	NON_FF_MERGE=1
 
-	echo "Trying simple merge with $SHA1"
+	echo "Trying simple merge with $pretty_name"
 	git read-tree -u -m --aggressive  $common $MRT $SHA1 || exit 2
 	next=$(git write-tree 2>/dev/null)
 	if test $? -ne 0
diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many.sh
index 01e5415..7377033 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -49,4 +49,37 @@ test_expect_success 'merge c1 with c2, c3, c4, ... c29' '
 	done
 '
 
+cat >expected <<\EOF
+Trying simple merge with c2
+Trying simple merge with c3
+Trying simple merge with c4
+Merge made by octopus.
+ c2.c |    1 +
+ c3.c |    1 +
+ c4.c |    1 +
+ 3 files changed, 3 insertions(+), 0 deletions(-)
+ create mode 100644 c2.c
+ create mode 100644 c3.c
+ create mode 100644 c4.c
+EOF
+
+test_expect_success 'merge output uses pretty names' '
+	git reset --hard c1 &&
+	git merge c2 c3 c4 >actual &&
+	test_cmp actual expected
+'
+
+cat >expected <<\EOF
+Already up-to-date with c4
+Trying simple merge with c5
+Merge made by octopus.
+ c5.c |    1 +
+ 1 files changed, 1 insertions(+), 0 deletions(-)
+ create mode 100644 c5.c
+EOF
+
+test_expect_success 'merge up-to-date output uses pretty names' '
+	git merge c4 c5 >actual &&
+	test_cmp actual expected
+'
 test_done
-- 
1.6.6.rc2.5.g49666
