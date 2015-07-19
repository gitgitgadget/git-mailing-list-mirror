From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 08/12] t4150: am with pre-applypatch hook
Date: Sun, 19 Jul 2015 23:49:14 +0800
Message-ID: <1437320958-11192-9-git-send-email-pyokagan@gmail.com>
References: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 17:49:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGqqh-0005iY-RG
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 17:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824AbbGSPtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 11:49:52 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35073 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753809AbbGSPtv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 11:49:51 -0400
Received: by pabkd10 with SMTP id kd10so16952185pab.2
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 08:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vIf4tJAQMDsP81ISgSxNFRkEnjzRiqY7PVJA3qRY3n4=;
        b=yBbpgWBDr8oXB7vR6ng5ZPQclSBgAxdX86EcvUty0A+Y4Y/BrIikw//EnStabtaNZ0
         0AC4hYWAk7W5agkKJY1zUpYRfUKojdgJF6TZpdGK4DSN+J8d52PcMROiifsLVwcL36zD
         XlEaqCl8WOsGGpyGMJVpvv4jR2QuN8s6OH3P4T1W1+wlXVnNiE/lrNAHlGwznO4fDJ6k
         PAAJQbIjz+E7yNEzK561GjwZwAdJSQlxoFyfIs6y2eDRpxn72DzdUhB1bdCkVlV3sAxj
         bVUwy35tgrZRdSFSbVDIHSPfzVGkbdnz0vwl2BFQh1RXPmHERdpv31x/KM8K7qRqdR0D
         EH3A==
X-Received: by 10.66.141.42 with SMTP id rl10mr48743891pab.25.1437320991077;
        Sun, 19 Jul 2015 08:49:51 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id j9sm17216516pdl.65.2015.07.19.08.49.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 08:49:49 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gf2a5fc6
In-Reply-To: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274220>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07),
git-am.sg will invoke the pre-applypatch hook after applying the patch
to the index, but before a commit is made. Should the hook exit with a
non-zero status, git am will exit.

Add tests for this hook.

Helped-by: Junio C Hamano <gitster@pobox.com>
Reviewed-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
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
2.5.0.rc2.110.gf2a5fc6
