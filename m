From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH v3 12/9] t7800: add tests for difftool --dir-diff
Date: Wed, 21 Mar 2012 15:36:00 -0400
Message-ID: <1332358560-13774-6-git-send-email-tim.henigan@gmail.com>
References: <1332358560-13774-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 21 20:37:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SARLv-0001E6-Fr
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 20:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755689Ab2CUTha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 15:37:30 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:53854 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754237Ab2CUThZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 15:37:25 -0400
Received: by mail-qa0-f46.google.com with SMTP id b19so1925406qae.19
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 12:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ri2tAFUz3wA1r4+vKiTEiVW0HmUqbIIWUScwAV+iAw0=;
        b=N2bgIattHUEtTa/8f3KsiWS60wQ0KUkWS/+nn2BiXw19i8S+t1wwkjqf66TY5XWSrh
         Y/gB6NN8zjV1WY9byGQTSlQNnBLK1pRKS32kXfr1Vj9gmv4SeqBbQJoJfWDInA29XvoO
         e5oAkJ7D/w/v6NscIbGKJNw4k5EI8yeOLw9/HTg+jTgfq7HByxqECJWzGH4X/aN5EkFM
         U2w+4k2Trga2iVm2onaeT6nMMSKh/v5HsdWAh6yLhBkHY4wNdFAjOQaIaDNx2IxrUUPV
         TqEfh3Mgjmy6c4blJ/sQ4/gZgslszfTrJGC3NOgVrvIacdO+S3k37UQHZo8Ku/uMRvUW
         wXlg==
Received: by 10.224.31.18 with SMTP id w18mr7484676qac.44.1332358645169;
        Wed, 21 Mar 2012 12:37:25 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id 1sm4425038qac.3.2012.03.21.12.37.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Mar 2012 12:37:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.39.g6e141f
In-Reply-To: <1332358560-13774-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193606>

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 t/t7800-difftool.sh |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 663247c..fca49d1 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -305,4 +305,42 @@ test_expect_success PERL 'difftool --tool-help' '
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
+	cd sub &&
+	diff=$(git difftool --dir-diff --extcmd ls branch) &&
+	echo "$diff" | stdin_contains sub &&
+	echo "$diff" | stdin_contains file &&
+	cd ..
+'
+
 test_done
-- 
1.7.10.rc1.39.g6e141f
