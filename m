From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v8 7/7] bisect: support --update-ref <ref>
Date: Sun, 31 Jul 2011 21:55:21 +1000
Message-ID: <1312113321-28760-8-git-send-email-jon.seymour@gmail.com>
References: <1312113321-28760-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 13:57:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnUdv-0002zC-6Q
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 13:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381Ab1GaL5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 07:57:09 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:33709 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377Ab1GaL5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 07:57:07 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so9556049pzk.1
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 04:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3kmNtoOrfOklb2WBt+F2Fdxa9l/bmtoFSo9/2clfhtQ=;
        b=sHx7pMQlpditlvIRpxneP/zwBx0tihcefx/YJZUOPO4PNnCUqInMUilEgDbY8lm/6d
         eP+uJ8fRqH61CjaV9DvAdrhje0lta09C81ciF04RzlWuHtV1r4EXZ1imRgsmTBpP3c9f
         pB8bkBVatQXUHknfrb9uOW8vQBnZtdsehYjAI=
Received: by 10.68.0.131 with SMTP id 3mr6032288pbe.147.1312113426975;
        Sun, 31 Jul 2011 04:57:06 -0700 (PDT)
Received: from localhost.localdomain ([120.16.239.154])
        by mx.google.com with ESMTPS id g4sm4306620pbj.41.2011.07.31.04.57.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 04:57:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.352.g62761
In-Reply-To: <1312113321-28760-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178244>

Adds sugar to allow --update-ref=<ref> to be expressed as
--update-ref <ref> instead.

Suggested-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-bisect.sh               |   13 +++++++++++--
 t/t6030-bisect-porcelain.sh |   16 ++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 24ac859..ec70cd2 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -79,8 +79,17 @@ bisect_start() {
 		shift; break ;;
 	    --no-checkout)
 		BISECT_UPDATE_REF=HEAD; shift ;;
-	    --update-ref=*)
-		BISECT_UPDATE_REF=${arg#--update-ref=}; shift ;;
+	    --update-ref*)
+		case "$#,$arg" in
+		*,*=*)
+			BISECT_UPDATE_REF=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+		;;
+		1,*)
+			usage ;;
+		*)
+			BISECT_UPDATE_REF="$2";	shift ;;
+		esac
+		shift ;;
 	    --*)
 		die "$(eval_gettext "unrecognised option: '\$arg'")" ;;
 	    *)
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 69d77fa..fa4366f 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -705,6 +705,22 @@ test_expect_success 'bisect: --no-checkout --update-ref=CURSOR - check HEAD is u
 	check_same broken $BROKEN
 '
 
+test_expect_success 'bisect: --no-checkout --update-ref CURSOR' '
+	git bisect reset &&
+	git checkout broken &&
+	BROKEN=$(git rev-parse broken) &&
+	git bisect start broken BROKEN_HASH4 --no-checkout --update-ref CURSOR &&
+	check_same CURSOR BROKEN_HASH6 &&
+	test "refs/heads/broken" = "$(git rev-parse --symbolic-full-name HEAD)"
+'
+
+test_expect_success 'bisect: --no-checkout --update-ref -> fails' '
+	git bisect reset &&
+	git checkout broken &&
+	BROKEN=$(git rev-parse broken) &&
+	test_must_fail git bisect start broken BROKEN_HASH4 --no-checkout --update-ref
+'
+
 test_expect_success 'bisect: demonstrate identification of damage boundary' "
 	git bisect reset &&
 	git checkout broken &&
-- 
1.7.6.391.g168d0.dirty
