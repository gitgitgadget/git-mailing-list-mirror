From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 07/12] t4150: am with applypatch-msg hook
Date: Tue,  7 Jul 2015 22:08:29 +0800
Message-ID: <1436278114-28057-8-git-send-email-pyokagan@gmail.com>
References: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:09:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTYn-0005gv-3R
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbbGGOJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:09:14 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:34735 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757540AbbGGOJI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:09:08 -0400
Received: by pdbep18 with SMTP id ep18so126543724pdb.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=McEeTYNdSFEljQUtHVO2Lc6az7GXwFyCt+LH8NVm4fI=;
        b=vA80YnFZnEBYsV2tQPU5oJVl6LtCHKcdLTUu6ZVElkiJhh8N3bFKmV/f0gVfo9Krk+
         YEupJmnkbm30aPg/UmaJUEUwZE9lvFQayTtyMLDtUfT93+26ReClnsg1JIH8UsLHuDFR
         SkoX0fPClEihVFhANvDCrzaTwC+foga5jn/6X+igwAyDHlKCu41qgDUvjxNf2ZHI0qTP
         iOLiGPoEfpvYdOXH+VnQjriZAJbQsP0lXc1gYRSdGwDdrcJbZkV0ZQCfeefldm92oddp
         0XZSgUUvLbpTnqdMbj3CX1pJkpNWGd7Yf9iGyXZtDh52zPZXh7Kj4A6WbwJO6ASEf6V5
         8o6g==
X-Received: by 10.70.91.79 with SMTP id cc15mr9483077pdb.10.1436278148403;
        Tue, 07 Jul 2015 07:09:08 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id im7sm22004766pbc.25.2015.07.07.07.09.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:09:07 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273511>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
will invoke the applypatch-msg hooks just after extracting the patch
message. If the applypatch-msg hook exits with a non-zero status, git-am
abort before even applying the patch to the index.

Add tests for this hook.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v2
    
    * Use write_script() to shave off the shebang line and chmod.

 t/t4150-am.sh | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index c1ec4d5..7878e32 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -199,6 +199,41 @@ test_expect_success 'am applies patch e-mail with preceding whitespace' '
 	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
 '
 
+test_expect_success 'am with applypatch-msg hook' '
+	test_when_finished "rm -f .git/hooks/applypatch-msg" &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/applypatch-msg <<-\EOF &&
+	cat "$1" >actual-msg &&
+	echo hook-message >"$1"
+	EOF
+	git am patch1 &&
+	test_path_is_missing .git/rebase-apply &&
+	git diff --exit-code second &&
+	echo hook-message >expected &&
+	git log -1 --format=format:%B >actual &&
+	test_cmp expected actual &&
+	git log -1 --format=format:%B second >expected &&
+	test_cmp expected actual-msg
+'
+
+test_expect_success 'am with failing applypatch-msg hook' '
+	test_when_finished "rm -f .git/hooks/applypatch-msg" &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/applypatch-msg <<-\EOF &&
+	exit 1
+	EOF
+	test_must_fail git am patch1 &&
+	test_path_is_dir .git/rebase-apply &&
+	git diff --exit-code first &&
+	test_cmp_rev first HEAD
+'
+
 test_expect_success 'setup: new author and committer' '
 	GIT_AUTHOR_NAME="Another Thor" &&
 	GIT_AUTHOR_EMAIL="a.thor@example.com" &&
-- 
2.5.0.rc1.76.gf60a929
