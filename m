From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 12/9 v5] t7800: add tests for difftool --dir-diff
Date: Thu, 22 Mar 2012 11:02:20 -0400
Message-ID: <1332428541-24878-2-git-send-email-tim.henigan@gmail.com>
References: <1332428541-24878-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 22 16:08:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAjdI-0008Q2-Bb
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 16:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373Ab2CVPIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 11:08:49 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:43136 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030280Ab2CVPIs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 11:08:48 -0400
Received: by mail-qc0-f174.google.com with SMTP id w6so1367266qcq.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 08:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1Sc7QlEFqLqA5GOaTR9PL9wuVQFxxwp1L3xbMPJacw8=;
        b=er8aKw/l86lWtsST0DmN6acBgdpWPqowZcI+MIr/4k4IQ7oCaokl0xvgs3aZkr8FBj
         pyzptRD3N3KJM+TPzF7BavL52eWMw2LPIzI/U1A0hnCmmqjklZ3nGgwc4dGcu1MhKB13
         QCsIvnBrp7W1tQczXw5yuJIs407oMThZSBQ7jbYceM3DM1V7jt/97VvdSi73a83vwOp7
         OcNSE4hdvNDgCNQJOpm8RNcRDfzkJTHTZskfhJRgLGZtzwR4QnwNnEOjp/WdKIj/YhNS
         J2eY4ed9P19eSKy7SDe4GqbQdjxb2koFyfNMqU9aeENbVE0gffEZu9R9DMkOAg5edj0S
         e7OQ==
Received: by 10.229.77.131 with SMTP id g3mr3185553qck.147.1332428927994;
        Thu, 22 Mar 2012 08:08:47 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id w9sm8844100qao.0.2012.03.22.08.08.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 08:08:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.40.g756bbcd
In-Reply-To: <1332428541-24878-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193662>

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This replaces 12/9 in the previous version of the series.

Changes in v5:

Based on an example provided by David Aguilar on the Git developer
list, the 'difftool --dir-diff from subdirectory' test is now wrapped
in parentheses "()".

>From David's email:
> If we wrap the subdir operations in parentheses, then the sub-shell
> saves us from having to do "cd ..".  It also helps prevent leakage
> from earlier failures, which is helpful when writing new tests.


 t/t7800-difftool.sh |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 41d8399..5f3ad3f 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -311,4 +311,43 @@ test_expect_success PERL 'difftool --tool-help' '
 	echo "$tool_help" | stdin_contains tool
 '
 
+test_expect_success PERL 'setup change in subdirectory' '
+	git checkout master &&
+	mkdir sub &&
+	echo master >sub/sub &&
+	git add sub/sub &&
+	git commit -m "added sub/sub" &&
+	echo test >>file &&
+	echo test >>sub/sub &&
+	git add . &&
+	git commit -m "modified both"
+'
+
+test_expect_success PERL 'difftool -d' '
+	diff=$(git difftool -d --extcmd ls branch) &&
+	echo "$diff" | stdin_contains sub &&
+	echo "$diff" | stdin_contains file
+'
+
+test_expect_success PERL 'difftool --dir-diff' '
+	diff=$(git difftool --dir-diff --extcmd ls branch) &&
+	echo "$diff" | stdin_contains sub &&
+	echo "$diff" | stdin_contains file
+'
+
+test_expect_success PERL 'difftool --dir-diff ignores --prompt' '
+	diff=$(git difftool --dir-diff --prompt --extcmd ls branch) &&
+	echo "$diff" | stdin_contains sub &&
+	echo "$diff" | stdin_contains file
+'
+
+test_expect_success PERL 'difftool --dir-diff from subdirectory' '
+	(
+		cd sub &&
+		diff=$(git difftool --dir-diff --extcmd ls branch) &&
+		echo "$diff" | stdin_contains sub &&
+		echo "$diff" | stdin_contains file
+	)
+'
+
 test_done
-- 
1.7.10.rc1.40.g756bbcd
