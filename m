From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 02/12] t4150: am fails if index is dirty
Date: Tue,  7 Jul 2015 22:08:24 +0800
Message-ID: <1436278114-28057-3-git-send-email-pyokagan@gmail.com>
References: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:09:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTYY-0005YQ-K2
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757414AbbGGOIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:08:55 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33702 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756962AbbGGOIy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:08:54 -0400
Received: by pacws9 with SMTP id ws9so115363583pac.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lS+QwmcWS9bnGJ0g45kboogJ1hyu7ln7Z+Liioc0Cpg=;
        b=P2vQWJwAzcixPZnJkw+FFKTs5gwz6yMaZv4Z5cUrhupP5os+p9SfUxVUbDWSsNX2q/
         uNdoG5LiP5HgS4cjO6+Eh6TrljYO/T+Z1K68ok3hlVKedK0fjjsM3y6fHlN8KieHVzWY
         pYaXKBMFCuoUuguTSuq5RpoNCn6ubRtINb/WIwwA4b8++PR+dI6gH4mqRryAgUFXNsqx
         kUqLLeYIw+H4RUITopB69Xo1BMeqf6b01hCrkn0x0fj4UrAPDw2W+UpD+Ma7lCyvJ/pP
         mHIRoBeX/3u3+FaMu1TleDfPNXstIoNiOstqv+rm1IZ18jfEbadOQZVio80x8Ln+VyE7
         Tm5g==
X-Received: by 10.66.181.197 with SMTP id dy5mr9333695pac.87.1436278133783;
        Tue, 07 Jul 2015 07:08:53 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id im7sm22004766pbc.25.2015.07.07.07.08.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:08:52 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273508>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
will ensure that the index is clean before applying the patch. This is
to prevent changes unrelated to the patch from being committed.

Add a test for this check.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v2
    
    * Should be "rm -f dirtyfile" instead of "rm -rf dirtyfile"
    
    * Don't use "git checkout -f" -- it does not discard unmerged entries.
      Use git reset --hard instead.

 t/t4150-am.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 264f53f..a85e06a 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -154,6 +154,18 @@ test_expect_success 'am applies patch correctly' '
 	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
 '
 
+test_expect_success 'am fails if index is dirty' '
+	test_when_finished "rm -f dirtyfile" &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	echo dirtyfile >dirtyfile &&
+	git add dirtyfile &&
+	test_must_fail git am patch1 &&
+	test_path_is_dir .git/rebase-apply &&
+	test_cmp_rev first HEAD
+'
+
 test_expect_success 'am applies patch e-mail not in a mbox' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
-- 
2.5.0.rc1.76.gf60a929
