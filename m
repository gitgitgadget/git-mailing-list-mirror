From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 3/4] t4041 (diff-submodule-option): rewrite add_file() routine
Date: Fri, 30 Nov 2012 17:07:35 +0530
Message-ID: <1354275456-11104-4-git-send-email-artagnon@gmail.com>
References: <1354275456-11104-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 12:38:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeOv7-0002nU-Bs
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 12:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756553Ab2K3Lhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 06:37:53 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55701 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757809Ab2K3Lhu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 06:37:50 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so291681pad.19
        for <git@vger.kernel.org>; Fri, 30 Nov 2012 03:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EYtmzrfdJQpCkjSFgaM4NZbA4uEan89qsaDIjYcpAu4=;
        b=x0j6DJ3LiY2e1d91s69P3R3tzb1lk9Hz5cJN8rqftZ9qRFpaC/sFcS2iIdExmlMGDA
         NLBtxFySd3zTl8jdD0v9YRqMrKiP81hXlzilD7smDZrP1mHbmgLZwFWqqb4wLwlAdJ6z
         eoiKVgAQqcJ/4t5hZnlVl8mHXMqEyf5/n+BrrVniWda+MK2HChfz9Fg6YXIbUa3MW+Jj
         vll4/MAucDwmcKm8tbytbkJ/DeyjCDCNeJfxosAPjMh4Y/REGRdSGVjKMXe/NoFP0RLx
         fCcO5EQW7nMhCSEj9itnyFq8Ivly6R6/CSrJy+2bPaG2yh+oy6vCiunOgPIteCUCYio3
         3Ing==
Received: by 10.66.77.196 with SMTP id u4mr2309542paw.84.1354275470383;
        Fri, 30 Nov 2012 03:37:50 -0800 (PST)
Received: from fran.foss.conf ([59.90.224.156])
        by mx.google.com with ESMTPS id ok8sm2923120pbb.42.2012.11.30.03.37.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Nov 2012 03:37:49 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1354275456-11104-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of "cd there and then come back", use the "cd there in a
subshell" pattern.  Also fix '&&' chaining in one place.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t4041-diff-submodule-option.sh |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 08d549a..d745197 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -11,18 +11,17 @@ This test tries to verify the sanity of the --submodule option of git diff.
 . ./test-lib.sh
 
 add_file () {
-	sm=$1
-	shift
-	owd=$(pwd)
-	cd "$sm"
-	for name; do
-		echo "$name" > "$name" &&
-		git add "$name" &&
-		test_tick &&
-		git commit -m "Add $name"
-	done >/dev/null
-	git rev-parse --short --verify HEAD
-	cd "$owd"
+	(
+		cd "$1" &&
+		shift &&
+		for name; do
+			echo "$name" > "$name" &&
+			git add "$name" &&
+			test_tick &&
+			git commit -m "Add $name" || exit
+		done >/dev/null &&
+		git rev-parse --short --verify HEAD
+	)
 }
 commit_file () {
 	test_tick &&
-- 
1.7.8.1.362.g5d6df.dirty
