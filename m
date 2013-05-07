From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 2/3] t1514: Demonstrate failure to correctly shorten "refs/remotes/origin/HEAD"
Date: Tue,  7 May 2013 20:54:15 +0200
Message-ID: <1367952856-30729-2-git-send-email-johan@herland.net>
References: <CALKQrgcoz-+5Kb-Y1Ui9LhE=+pvcRUdAS+iRWXAfsYnV6+k34w@mail.gmail.com>
 <1367952856-30729-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, bert.wesarg@googlemail.com,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue May 07 20:54:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZn1x-00014z-PZ
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 20:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757119Ab3EGSyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 14:54:25 -0400
Received: from mail-ea0-f182.google.com ([209.85.215.182]:35246 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273Ab3EGSyX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 14:54:23 -0400
Received: by mail-ea0-f182.google.com with SMTP id z16so511033ead.13
        for <git@vger.kernel.org>; Tue, 07 May 2013 11:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=nI6XTkYjftlc6TNMb6mrjyG5c67GvsDQU5PD0ZDmLtM=;
        b=J1SJ6lSAnGsFstKHP1t6hjueQ04uk8zMCuJxUIPbzFr3t5H8c1713lHRSy3qFdx5s5
         UixnAvlI2QscHM5jfUNYdguwhh0m35tbWuXSZZpGskgnqqA2YcvBRwL/OBd5T2XZ0y9f
         SdCuivkngykm2M8U5F2uiTAdYUP7zZY35HX/NrZwpVq9UXRrIpO9MPc6Ni7oqVezEId8
         50N3smhiYid6RbX7dxtKYHS1536M/e/WZANAYR0Apuk7FYKxjBC0n68gWC1PuQ7Sqn8U
         DxZmIG0K44z63r1Kom7nveYs5Fw01HoG4FcwdboqzjX24vgUrjKmhJMBzYzU9d8OlLIb
         0yuA==
X-Received: by 10.15.48.193 with SMTP id h41mr8154808eew.23.1367952862466;
        Tue, 07 May 2013 11:54:22 -0700 (PDT)
Received: from localhost.localdomain (p57A0A708.dip0.t-ipconnect.de. [87.160.167.8])
        by mx.google.com with ESMTPSA id l6sm41084484eem.9.2013.05.07.11.54.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 07 May 2013 11:54:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1367952856-30729-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223595>

There is currently a bug in refs.c:shorten_unambiguous_ref() that causes
"refs/remotes/origin/HEAD" to be shortened to "origin/HEAD" instead of
"origin" (which is expected from matching against the "refs/remotes/%.*s"
pattern from refs.c:ref_rev_parse_rules).

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t1514-rev-parse-shorten_unambiguous_ref.sh |  8 ++++++--
 t/t6300-for-each-ref.sh                      | 12 ++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/t/t1514-rev-parse-shorten_unambiguous_ref.sh b/t/t1514-rev-parse-shorten_unambiguous_ref.sh
index 41e0162..ad75436 100755
--- a/t/t1514-rev-parse-shorten_unambiguous_ref.sh
+++ b/t/t1514-rev-parse-shorten_unambiguous_ref.sh
@@ -20,6 +20,7 @@ test_expect_success 'setup' '
 	test_commit master_d &&
 	git update-ref refs/master master_d &&
 	test_commit master_e
+	git update-ref refs/remotes/origin/HEAD master_e &&
 	test_commit master_f
 '
 
@@ -27,6 +28,7 @@ cat > expect.show-ref << EOF
 $(git rev-parse master_f) refs/heads/master
 $(git rev-parse master_b) refs/heads/origin/master
 $(git rev-parse master_d) refs/master
+$(git rev-parse master_e) refs/remotes/origin/HEAD
 $(git rev-parse master_a) refs/remotes/origin/master
 $(git rev-parse master_c) refs/tags/master
 $(git rev-parse master_a) refs/tags/master_a
@@ -56,18 +58,20 @@ test_shortname () {
 	test_cmp expect.sha1 actual.sha1
 }
 
-test_expect_success 'shortening refnames in strict mode' '
+test_expect_failure 'shortening refnames in strict mode' '
 	test_shortname refs/heads/master strict heads/master master_f &&
 	test_shortname refs/heads/origin/master strict heads/origin/master master_b &&
 	test_shortname refs/master strict refs/master master_d &&
+	test_shortname refs/remotes/origin/HEAD strict origin master_e &&
 	test_shortname refs/remotes/origin/master strict remotes/origin/master master_a &&
 	test_shortname refs/tags/master strict tags/master master_c
 '
 
-test_expect_success 'shortening refnames in loose mode' '
+test_expect_failure 'shortening refnames in loose mode' '
 	test_shortname refs/heads/master loose heads/master master_f &&
 	test_shortname refs/heads/origin/master loose origin/master master_b &&
 	test_shortname refs/master loose master master_d &&
+	test_shortname refs/remotes/origin/HEAD loose origin master_e &&
 	test_shortname refs/remotes/origin/master loose remotes/origin/master master_a &&
 	test_shortname refs/tags/master loose tags/master master_c
 '
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 752f5cb..5d716c8 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -466,4 +466,16 @@ test_expect_success 'Verify sort with multiple keys' '
 		refs/tags/bogo refs/tags/master > actual &&
 	test_cmp expected actual
 '
+
+cat >expected <<\EOF
+origin
+origin/master
+EOF
+
+test_expect_failure 'Check refs/remotes/origin/HEAD shortens to origin' '
+	git remote set-head origin master &&
+	git for-each-ref --format="%(refname:short)" refs/remotes >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.8.1.3.704.g33f7d4f
