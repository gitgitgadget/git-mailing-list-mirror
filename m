From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 10/12] t4150: tests for am --[no-]scissors
Date: Tue,  7 Jul 2015 22:08:32 +0800
Message-ID: <1436278114-28057-11-git-send-email-pyokagan@gmail.com>
References: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:09:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTZL-000610-2j
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757355AbbGGOJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:09:44 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35441 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265AbbGGOJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:09:16 -0400
Received: by pactm7 with SMTP id tm7so113969107pac.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rLOUcS9uU9t9V92WI7Ukw1wTz6x//buF0bbRo1xUMXI=;
        b=gywx5drS9pUikh2VTTh/42Wqo5tKQSuEubnd0lYs471Qontw0/1Ac4VV4QEYetvbGw
         Q8MWPaLrN+olWK/cWfz3uMItLskRmZQHgdXLNHuY8kDmTKJH2KsDSdmgucvmJe7vyX+b
         ORCCx7Uv9OBVzu4LdEP9rGeHBkaH8ZmdDBqNwehlGAsWR+WRbWkWvAvdDRl0IAevOEn+
         gzFSrQmPtFABNTaKOBP2TKcuFjeCtlJxGasI0gTQZxPSYfknNHdsJLPDn6vlV0+3fWg3
         vIKJDjlz1BYDYjNWkwr5xzoL9SOK0hSQoNqEWMJ3EcBb+jQMjvw7d7HVJNXw8idkmD85
         wpYw==
X-Received: by 10.68.179.163 with SMTP id dh3mr9613104pbc.22.1436278156300;
        Tue, 07 Jul 2015 07:09:16 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id im7sm22004766pbc.25.2015.07.07.07.09.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:09:15 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273516>

Since 017678b (am/mailinfo: Disable scissors processing by default,
2009-08-26), git-am supported the --[no-]scissors option, passing it to
git-mailinfo.

Add tests to ensure that git-am will pass the --scissors option to
git-mailinfo, and that --no-scissors will override the configuration
setting of mailinfo.scissors.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t4150-am.sh | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 7494240..67fbf0e 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -67,6 +67,19 @@ test_expect_success 'setup: messages' '
 
 	EOF
 
+	cat >scissors-msg <<-\EOF &&
+	Test git-am with scissors line
+
+	This line should be included in the commit message.
+	EOF
+
+	cat - scissors-msg >no-scissors-msg <<-\EOF &&
+	This line should not be included in the commit message with --scissors enabled.
+
+	 - - >8 - - remove everything above this line - - >8 - -
+
+	EOF
+
 	signoff="Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
 '
 
@@ -105,6 +118,20 @@ test_expect_success setup '
 		git format-patch --stdout first | sed -e "1d"
 	} > patch1-ws.eml &&
 
+	echo scissors-file >scissors-file &&
+	git add scissors-file &&
+	git commit -F scissors-msg &&
+	git tag scissors &&
+	git format-patch --stdout scissors^ >scissors-patch.eml &&
+	git reset --hard HEAD^ &&
+
+	echo no-scissors-file >no-scissors-file &&
+	git add no-scissors-file &&
+	git commit -F no-scissors-msg &&
+	git tag no-scissors &&
+	git format-patch --stdout no-scissors^ >no-scissors-patch.eml &&
+	git reset --hard HEAD^ &&
+
 	sed -n -e "3,\$p" msg >file &&
 	git add file &&
 	test_tick &&
@@ -305,6 +332,27 @@ test_expect_success 'am with failing post-applypatch hook' '
 	test_cmp head.expected head.actual
 '
 
+test_expect_success 'am --scissors cuts the message at the scissors line' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout second &&
+	git am --scissors scissors-patch.eml &&
+	test_path_is_missing .git/rebase-apply &&
+	git diff --exit-code scissors &&
+	test_cmp_rev scissors HEAD
+'
+
+test_expect_success 'am --no-scissors overrides mailinfo.scissors' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout second &&
+	test_config mailinfo.scissors true &&
+	git am --no-scissors no-scissors-patch.eml &&
+	test_path_is_missing .git/rebase-apply &&
+	git diff --exit-code no-scissors &&
+	test_cmp_rev no-scissors HEAD
+'
+
 test_expect_success 'setup: new author and committer' '
 	GIT_AUTHOR_NAME="Another Thor" &&
 	GIT_AUTHOR_EMAIL="a.thor@example.com" &&
-- 
2.5.0.rc1.76.gf60a929
