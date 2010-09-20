From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 13/37] t6036: Add testcase for undetected conflict
Date: Mon, 20 Sep 2010 02:28:46 -0600
Message-ID: <1284971350-30590-14-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:28:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxbjT-0005rH-9g
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755853Ab0ITI2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:28:00 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39104 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755828Ab0ITI16 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:27:58 -0400
Received: by mail-pz0-f46.google.com with SMTP id 34so1070490pzk.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=etmPP1Ul9rikwfV96n5OktRJZzmIp014a2WDBuHPCc4=;
        b=qx1KLfDmw02TRanknhsM0Tbax605XAnPuSf77/9hBpSL6HA5PcBlIXuAD9jl/skCoU
         g8U8m1jOmNgGP6SpMHXvXap/qyK0wJZVmz8bHqBeAfN6sNLn9ndCkpA9QMY9rpRDyrMq
         S4MwCRG41giOoEulWNBWVfin3zySB0wpDQEr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GgSp1yt0FeeGcDokYT75rrianumPORUyV8KH0Qz8v+R1xRJizxxU6o+gwOvKX+57Vy
         dehukwys5xNyGijBOyWpf05dxr7YZICnxRes8wsVmFAccYQ7epWXQtXAQ3o2Tg8mj8Jn
         n6Ly63UTAc+pYH0LBDil/Jp/RgmpITZFZJlQs=
Received: by 10.142.245.21 with SMTP id s21mr7320781wfh.329.1284971278211;
        Mon, 20 Sep 2010 01:27:58 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.27.56
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:27:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156571>

If merging two lines of development involves a rename/add conflict, and two
different people make such a merge but resolve it differently, and then
someone tries to merge the resulting two merges, then they should clearly
get a conflict due to the different resolutions from the previous
developers.  However, in some such cases the conflict would not be detected
and git would silently accept one of the two versions being merged as the
final merge resolution.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh |   85 +++++++++++++++++++++++++++++++++++++
 1 files changed, 85 insertions(+), 0 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 9206c22..6c2b2bf 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -146,4 +146,89 @@ test_expect_failure 'merge criss-cross + rename merges with basic modification'
 	test $(git rev-parse :1:three) = $(git hash-object merged)
 '
 
+#
+# For the next test, we start with three commits in two lines of development
+# which setup a rename/add conflict:
+#   Commit A: File 'a' exists
+#   Commit B: Rename 'a' -> 'new_a'
+#   Commit C: Modify 'a', create different 'new_a'
+# Later, two different people merge and resolve differently:
+#   Commit D: Merge B & C, ignoring separately created 'new_a'
+#   Commit E: Merge B & C making use of some piece of secondary 'new_a'
+# Finally, someone goes to merge D & E.  Does git detect the conflict?
+#
+#      B   D
+#      o---o
+#     / \ / \
+#  A o   X   ? F
+#     \ / \ /
+#      o---o
+#      C   E
+#
+
+test_expect_success 'setup differently handled merges of rename/add conflict' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	printf "0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n" >a &&
+	git add a &&
+	test_tick && git commit -m A &&
+
+	git branch B &&
+	git checkout -b C &&
+	echo 10 >>a &&
+	echo "other content" >>new_a &&
+	git add a new_a &&
+	test_tick && git commit -m C &&
+
+	git checkout B &&
+	git mv a new_a &&
+	test_tick && git commit -m B &&
+
+	git checkout B^0 &&
+	test_must_fail git merge C &&
+	git clean -f &&
+	test_tick && git commit -m D &&
+	git tag D &&
+
+	git checkout C^0 &&
+	test_must_fail git merge B &&
+	rm new_a~HEAD new_a &&
+	printf "Incorrectly merged content" >>new_a &&
+	git add -u &&
+	test_tick && git commit -m E &&
+	git tag E
+'
+
+test_expect_failure 'git detects differently handled merges conflict' '
+	git reset --hard &&
+	git checkout D^0 &&
+
+	git merge -s recursive E^0 && {
+		echo "BAD: should have conflicted"
+		test "Incorrectly merged content" = "$(cat new_a)" &&
+			echo "BAD: Silently accepted wrong content"
+		return 1
+	}
+
+	test 3 = $(git ls-files -s | wc -l) &&
+	test 3 = $(git ls-files -u | wc -l) &&
+	test 0 = $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :2:new_a) = $(git rev-parse D:new_a) &&
+	test $(git rev-parse :3:new_a) = $(git rev-parse E:new_a) &&
+
+	git cat-file -p B:new_a >>merged &&
+	git cat-file -p C:new_a >>merge-me &&
+	>empty &&
+	test_must_fail git merge-file \
+		-L "Temporary merge branch 2" \
+		-L "" \
+		-L "Temporary merge branch 1" \
+		merged empty merge-me &&
+	test $(git rev-parse :1:new_a) = $(git hash-object merged)
+'
+
 test_done
-- 
1.7.3.271.g16009
