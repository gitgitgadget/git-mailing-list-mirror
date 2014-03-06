From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 1/6] test patch hunk editing with "commit -p -m"
Date: Thu,  6 Mar 2014 15:50:19 +0100
Message-ID: <1394117424-29780-2-git-send-email-benoit.pierre@gmail.com>
References: <1394117424-29780-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 15:50:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLZd9-0004yY-28
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 15:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbaCFOuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 09:50:35 -0500
Received: from mail-we0-f171.google.com ([74.125.82.171]:58252 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbaCFOue (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 09:50:34 -0500
Received: by mail-we0-f171.google.com with SMTP id t61so3255951wes.30
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 06:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=cKLblYGUM6+uMe9Sh+mi3+3Eri3yC9esh4WiUl2n8uI=;
        b=r5GHWHyzjSA/sGatgObQhvU1GuyUZSF9XQCKIUwakf3aCe1BXctpuDNrObUEHYl4b9
         ZGJNvRYst+nuvP0NQrug8c2kEEIRFOpqsplyOvd4zxltnw2diWZjliNohy+S9pwZ4ULj
         Y7Ovz74DlePhAlgKl+hFSYwKxILlj2dkLIygBhwi+pAV0utNgPKlS2yn8xuCR3qkmfZu
         P41xKcAghdnznseg7Nzxr3FXTde9bDTEBMAieZ6/wvNLk2J8Ynbo5gTe/RZlQs5X87Ln
         1YAP7+VxSL3bkXDjPnTiPyxrnxLY5ApFPQhII8L4ysIkpnwye28Xs6LUCGXCWVqwKKKQ
         Ya1A==
X-Received: by 10.194.86.233 with SMTP id s9mr10729760wjz.44.1394117433629;
        Thu, 06 Mar 2014 06:50:33 -0800 (PST)
Received: from localhost (109.12.70.86.rev.sfr.net. [86.70.12.109])
        by mx.google.com with ESMTPSA id t5sm18039280wjw.15.2014.03.06.06.50.32
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Mar 2014 06:50:33 -0800 (PST)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394117424-29780-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243512>

Add (failing) test: with commit changing the environment to let hooks
now that no editor will be used (by setting GIT_EDITOR to ":"), the
"edit hunk" functionality does not work (no editor is launched and the
whole hunk is committed).

Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
---
 t/t7513-commit_-p_-m_hunk_edit.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100755 t/t7513-commit_-p_-m_hunk_edit.sh

diff --git a/t/t7513-commit_-p_-m_hunk_edit.sh b/t/t7513-commit_-p_-m_hunk_edit.sh
new file mode 100755
index 0000000..e0ad905
--- /dev/null
+++ b/t/t7513-commit_-p_-m_hunk_edit.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='hunk edit with "commit -p -m"'
+. ./test-lib.sh
+
+if ! test_have_prereq PERL
+then
+	skip_all="skipping '$test_description' tests, perl not available"
+	test_done
+fi
+
+test_expect_success 'setup (initial)' '
+	echo line1 >file &&
+	git add file &&
+	git commit -m commit1
+	echo line3 >>file
+'
+
+test_expect_success 'setup expected' '
+cat >expected <<EOF
+diff --git a/file b/file
+index a29bdeb..c0d0fb4 100644
+--- a/file
++++ b/file
+@@ -1 +1,2 @@
+ line1
++line2
+EOF
+'
+
+test_expect_failure 'edit hunk "commit -p -m message"' '
+	echo e | env GIT_EDITOR="sed s/+line3\$/+line2/ -i" git commit -p -m commit2 file &&
+	git diff HEAD^ HEAD >diff &&
+	test_cmp expected diff
+'
+
+test_done
-- 
1.9.0
