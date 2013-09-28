From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 03/44] request-pull: fix annotated tag check
Date: Sat, 28 Sep 2013 17:03:28 -0500
Message-ID: <1380405849-13000-4-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:10:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2iI-0002jN-4Q
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188Ab3I1WKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:10:08 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:55265 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104Ab3I1WKF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:10:05 -0400
Received: by mail-oa0-f45.google.com with SMTP id o17so3029227oag.18
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mhSp9QTuNlPAxyWbr2jVR9gFtx3njXzSuPV02t7zE6E=;
        b=mTjVImtyyyAtoWjc6JoZd0i3c+bBw9dfyF07bEF2D3ggfzgB//9lw7NHkHR+0Rd25+
         PIgnEn1tb5Ss+JUwSgtV98Hc0ieOniJD8xHvRVBjXrm+/MEHUXWC8Q9Bjd4oQMY5RHiU
         cfIGHPfdqy+mb1PUtmbJGmp2dewvsfnAfx47eNLazy8UqTN/GAlLsiIGxunWAYvvm4iy
         BVcJSLl9oKj7/a5BHjNFUX3QrPGI0SOnM7mJ1wsSeoRR83Sy9aIVZFtZA2EGMuvJ1/Vx
         5diBCOx30b6jkCoRMysNhd+c7q1zfUaxnR49+YSESuEIt8aghJ8n8e5gJEOPqTmAEumk
         OonA==
X-Received: by 10.60.136.226 with SMTP id qd2mr12340042oeb.20.1380406205168;
        Sat, 28 Sep 2013 15:10:05 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hs4sm19514248obb.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:10:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235522>

The was just not doing anything, reporting an appropriately tagged ref
worked only by luck.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-request-pull.sh     |  2 +-
 t/t5150-request-pull.sh | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index ebf1269..6348dac 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -89,7 +89,7 @@ find_matching_ref='
 		my ($sha1, $ref, $deref) = /^(\S+)\s+(\S+?)(\^\{\})?$/;
 		next unless ($sha1 eq $ARGV[1]);
 		$found = abbr($ref);
-		if ($deref && $ref eq "tags/$ARGV[2]") {
+		if ($deref && $ref eq "refs/tags/$ARGV[2]") {
 			$tagged = $found;
 			last;
 		}
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 1afa0d5..54f41bf 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -234,4 +234,19 @@ test_expect_success 'request-pull ignores OPTIONS_KEEPDASHDASH poison' '
 
 '
 
+test_expect_success 'pull request when pushed tag' '
+	rm -fr downstream.git &&
+	git init --bare downstream.git &&
+	(
+		cd local &&
+		git checkout initial &&
+		git merge --ff-only master &&
+		git tag zeebra &&
+		git push origin master:for-upstream full zeebra &&
+		git request-pull initial origin 2>../err
+	) &&
+	cat err &&
+	! grep "You locally have .* but it does not (yet)" err
+'
+
 test_done
-- 
1.8.4-fc
