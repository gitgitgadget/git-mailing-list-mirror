From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 32/47] remote-hg: add test for bookmark diverge
Date: Mon, 13 May 2013 23:36:55 -0500
Message-ID: <1368506230-19614-33-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:40:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc72i-0004oJ-TL
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888Ab3ENEk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:40:29 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:55881 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863Ab3ENEkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:40:25 -0400
Received: by mail-ob0-f172.google.com with SMTP id tb18so96933obb.31
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=SUzPcX0xVY3BlUep4ry2V/2qOAb4nC9DxiWXtwWBXmA=;
        b=o4dAY3KZqgb6AJnTyRx38ExPTZETFQQ9OBLM0DGHOmFdKOfS2+llaUhdOfLCA56Ljw
         vfvGOMlkzF0cN3ZdvY+elB+z0H4b1QMZQrvX94pK3XYZWP1XF+woQWnKNP0bm+C+swHk
         jFK1jfz+4OoxbAcDtTu7F/0abWp2IPN2HkGhsyYGgbXwhb4rYbLEN1ikt9o6oAkFj1m8
         AKF0F/7aUMeHfvlNK0eIlVsRF6K1FlryiIUocSbwkxrhKFylaK1Mbjo87nxaOBJ1VCbT
         iO2L1g5T4lYqwzSoa1l1oRsab9qC97RSnO9rf86CEU09nmqCTweTJ8XWjHoiJyyy4eE/
         uvIA==
X-Received: by 10.60.144.99 with SMTP id sl3mr15581109oeb.0.1368506424557;
        Mon, 13 May 2013 21:40:24 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jt1sm818190oeb.5.2013.05.13.21.40.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:40:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224264>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 06700a8..f4e3807 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -281,4 +281,33 @@ test_expect_failure 'remote push diverged' '
 	check_branch hgrepo default bump
 '
 
+test_expect_failure 'remote update bookmark diverge' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	cd hgrepo &&
+	hg bookmark diverge -r tip^
+	hg checkout diverge
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+
+	(
+	cd hgrepo &&
+	echo "bump bookmark" > content &&
+	hg commit -m "bump bookmark"
+	) &&
+
+	(
+	cd gitrepo &&
+	git checkout --quiet diverge &&
+	echo diverge > content &&
+	git commit -a -m diverge &&
+	test_expect_code 1 git push 2> error &&
+	grep "^ ! \[rejected\] *diverge -> diverge (non-fast-forward)$" error
+	) &&
+
+	check_bookmark hgrepo diverge "bump bookmark"
+'
+
 test_done
-- 
1.8.3.rc1.579.g184e698
