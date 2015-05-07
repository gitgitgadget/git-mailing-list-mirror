From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 04/12] t5520: test --rebase with multiple branches
Date: Thu,  7 May 2015 16:44:00 +0800
Message-ID: <1430988248-18285-5-git-send-email-pyokagan@gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 10:44:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqHQ5-0005VW-5x
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 10:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbbEGIob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 04:44:31 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36167 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbbEGIo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 04:44:29 -0400
Received: by pabsx10 with SMTP id sx10so34335985pab.3
        for <git@vger.kernel.org>; Thu, 07 May 2015 01:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d8TIz0jr3jtjVm+rJ9FqjwIeAAGGGX/kMTEgNcfI88s=;
        b=si4xnLjz06YrQFSLe/fmFhsVLab+O4HDBa1LfcIKF89ZIUiBWo0h1nf8kXJoXK0U52
         qa0SvkIhzXSS3S/EPmSO+8GGq1wJnQzEJZE78KomJTSzUDN4vWPpDEw3JU6E/H/FQjT8
         rka74wAmQEidRbYRTReRZocXcHYyaHD76oyJkL9uVMiJ5Eo9vxR9kaOIaUKoCCVLIrrm
         eOQRVcb/d90yOji6vSwWN/lWCD1/nn4LJDD29qjirkIRYyosvAmBo53hzMZvUNn3ci6Q
         i/EvwEVovN3m5f8lIHzUFlcsBFtHJs+wqX8gJrn3pJPL6L9xsDd8QVJCxbRfr9oVI57R
         hd+w==
X-Received: by 10.68.94.193 with SMTP id de1mr4906279pbb.153.1430988268677;
        Thu, 07 May 2015 01:44:28 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id wh6sm1369308pbc.96.2015.05.07.01.44.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 May 2015 01:44:27 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268511>

Since rebasing on top of multiple upstream branches does not make sense,
since commit 51b2ead0 ("disallow providing multiple upstream branches
to rebase, pull --rebase"), git-pull explicitly disallowed specifying
multiple branches in the rebase case.

Implement tests to ensure that git-pull fails and prints out the
user-friendly error message in such a case.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    * Check that when git-pull fails, HEAD was not moved.
    
    * Removed the not-really-required `test_when_finished "rm -f out"`.

 t/t5520-pull.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 99b6f67..05a92a2 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -220,6 +220,15 @@ test_expect_success '--rebase' '
 	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
 	test new = $(git show HEAD:file2)
 '
+
+test_expect_success '--rebase fails with multiple branches' '
+	git reset --hard before-rebase &&
+	test_must_fail git pull --rebase . copy master 2>out &&
+	test $(git rev-parse HEAD) = $(git rev-parse before-rebase) &&
+	test_i18ngrep "Cannot rebase onto multiple branches" out &&
+	test modified = "$(git show HEAD:file)"
+'
+
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
 	test_config pull.rebase true &&
-- 
2.1.4
