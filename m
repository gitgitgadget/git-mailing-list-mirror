From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 4/5] t2004: demonstrate broken relative path printing
Date: Wed, 24 Dec 2014 04:43:15 -0500
Message-ID: <1419414196-58587-5-git-send-email-sunshine@sunshineco.com>
References: <1419414196-58587-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"Shawn O . Pearce" <spearce@spearce.org>
To: git@vger.kernel.org, Russ Cox <rsc@golang.org>
X-From: git-owner@vger.kernel.org Wed Dec 24 10:44:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3iUQ-00053S-Gy
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 10:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbaLXJoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2014 04:44:12 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:41581 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbaLXJoH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2014 04:44:07 -0500
Received: by mail-ig0-f170.google.com with SMTP id r2so7924707igi.3
        for <git@vger.kernel.org>; Wed, 24 Dec 2014 01:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3rdlXw7s7eI41x7qYV2l45wP6EowJ32zFYKSG8Bqd1o=;
        b=AQ8gJ9+GeBVV2mNy5+pwlrCddVf1uQ8WUg/X4gyxgtf2/D+5Zgspd/1hFA7gN3aW3d
         1aXl3TIP1GZ1hSuD5wVyNipii6DVmnnnw2SpgXdrVFwt5tJPyQbGjsVnl6w+1BPfO4oV
         0lbgoLp4k5OQKh8+0cAflfYNm/PFG2xha4nQM6aQPLk4+L8uc7aryFNnhZsY1OBy/hCY
         HW30ZSIYhcECYJfN1osC1Jrku38iDHxVNaI32XPhOsiZsFDFYkAjd+cp2kA+WbZws11G
         wB25c5Jjri0xVRB7mhoRu0LgpgN4iWkxleEhdsCAYPdm5UQKnxxEdBmalZzt1fZ+aUZJ
         P3YA==
X-Received: by 10.42.239.145 with SMTP id kw17mr25640258icb.55.1419414247453;
        Wed, 24 Dec 2014 01:44:07 -0800 (PST)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id l3sm7575581igj.9.2014.12.24.01.44.06
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Dec 2014 01:44:07 -0800 (PST)
X-Mailer: git-send-email 2.2.1.267.g0ad48de
In-Reply-To: <1419414196-58587-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261799>

checkout-index --temp only properly prints relative paths which are
descendants of the current directory. Paths in ancestor or sibling
directories (or their children) are often printed in mangled form. For
example:

    mkdir a bbb &&
    >file &&
    >bbb/file &&
    git update-index --add file bbb/file &&
    cd a &&
    git checkout-index --temp ../file ../bbb/file

prints:

    .merge_file_ooblek  le
    .merge_file_igloo0  b/file

rather than the correct:

    .merge_file_ooblek  ../file
    .merge_file_igloo0  ../bbb/file

Unfortunately, testing is complicated slightly by relative paths
sometimes _appearing_ to be printed correctly, but this is an accident
of implementation in which a "correct" copy of the string exists in
memory beyond the end of the real string, and that "correct" copy gets
printed. This test takes care to avoid the accidentally "correct"
behavior by testing with a filename longer than the directory name in
which checkout-index is invoked.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t2004-checkout-cache-temp.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t2004-checkout-cache-temp.sh b/t/t2004-checkout-cache-temp.sh
index 602fbc7..3c2b2b9 100755
--- a/t/t2004-checkout-cache-temp.sh
+++ b/t/t2004-checkout-cache-temp.sh
@@ -206,4 +206,16 @@ test_expect_success 'checkout --temp symlink' '
 	test $(cat $p) = path7
 '
 
+test_expect_failure 'emit well-formed relative path' '
+	rm -f path* .merge_* actual .git/index &&
+	>path0123456789 &&
+	git update-index --add path0123456789 &&
+	(
+		cd asubdir &&
+		git checkout-index --temp -- ../path0123456789 >actual &&
+		test_line_count = 1 actual &&
+		test $(cut "-d	" -f2 actual) = ../path0123456789
+	)
+'
+
 test_done
-- 
2.2.1.267.g0ad48de
