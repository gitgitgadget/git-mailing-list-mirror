From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 08/12] t4150: am with pre-applypatch hook
Date: Tue,  7 Jul 2015 22:08:30 +0800
Message-ID: <1436278114-28057-9-git-send-email-pyokagan@gmail.com>
References: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:09:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTZI-000610-69
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbbGGOJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:09:17 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36360 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757572AbbGGOJL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:09:11 -0400
Received: by pddu5 with SMTP id u5so39060991pdd.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S6aThjV8vncwj/7ca5nyN4kq3IxdOsRX45ROr8wa7CI=;
        b=RJR3I/zvQflRw2G0f/KAeGzsMQGgB0t3kn4aZn4qWsRgq2r9+xgx92qqiL6aK3bmp8
         NjWm4w33XONcZvE1suLo2fPGWcnPrmQJuqsSgiAqqfm865wYeHha3NXS6RfBciENTQKN
         Ryc2RVBeKp5QA6jepx1WYGsALvjLx9CEWovvCbErarVbOSNcO7MME1yWMkjvKNLOH0/V
         qkaLELCJJtHBq6AebKoM0XewHISiA/VhukuYVnqJzNJx9E6lHr3rKnJb5h0trvr1lCcI
         iUDPzIVR2rb1P2uWR0EeA1FC9EO5/RlChJuZ4W7VIsF/TBJtYQh4rmXJlEZaHtnKLbEt
         7dFQ==
X-Received: by 10.68.65.34 with SMTP id u2mr9470766pbs.118.1436278150973;
        Tue, 07 Jul 2015 07:09:10 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id im7sm22004766pbc.25.2015.07.07.07.09.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:09:10 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273514>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07),
git-am.sg will invoke the pre-applypatch hook after applying the patch
to the index, but before a commit is made. Should the hook exit with a
non-zero status, git am will exit.

Add tests for this hook.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v2
    
    * Use write_script() to shave off the shebang line and chmod.

 t/t4150-am.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 7878e32..957c63c 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -234,6 +234,39 @@ test_expect_success 'am with failing applypatch-msg hook' '
 	test_cmp_rev first HEAD
 '
 
+test_expect_success 'am with pre-applypatch hook' '
+	test_when_finished "rm -f .git/hooks/pre-applypatch" &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/pre-applypatch <<-\EOF &&
+	git diff first >diff.actual
+	exit 0
+	EOF
+	git am patch1 &&
+	test_path_is_missing .git/rebase-apply &&
+	git diff --exit-code second &&
+	test_cmp_rev second HEAD &&
+	git diff first..second >diff.expected &&
+	test_cmp diff.expected diff.actual
+'
+
+test_expect_success 'am with failing pre-applypatch hook' '
+	test_when_finished "rm -f .git/hooks/pre-applypatch" &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/pre-applypatch <<-\EOF &&
+	exit 1
+	EOF
+	test_must_fail git am patch1 &&
+	test_path_is_dir .git/rebase-apply &&
+	git diff --exit-code second &&
+	test_cmp_rev first HEAD
+'
+
 test_expect_success 'setup: new author and committer' '
 	GIT_AUTHOR_NAME="Another Thor" &&
 	GIT_AUTHOR_EMAIL="a.thor@example.com" &&
-- 
2.5.0.rc1.76.gf60a929
