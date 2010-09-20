From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 06/37] t6022: Add tests with both rename source & dest involved in D/F conflicts
Date: Mon, 20 Sep 2010 02:28:39 -0600
Message-ID: <1284971350-30590-7-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:28:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxbjQ-0005rH-4k
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755796Ab0ITI1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:27:45 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49332 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773Ab0ITI1n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:27:43 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so1146755pwi.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4lurgY5lF0ln3C9v0KwidTO9Ju8IcSiTfe+QpKojhhY=;
        b=pF6C+TGbhIrE9Cy2ArN/ntwVb6azZUCHha+ms7VppUZRwVivzrzusX0KaJZ9MsiKy4
         sRYM1IJFHHMtTeEfXGkRkGP/ZZNMX8aJ7o0bWTyHCB4wO5cx74h0UDwQj/n5GHps1Urz
         bmZ6e0RdsM3OT8t0+82e5p9x/n073s3go05ro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=H6kmoRjIstNK4WM2IYaMsp2wtt8eESKCiESivNUg+xpaRuKY1BYjrEJSaKRDKcIIEL
         UjjRlXGDuqQTea74SX9ABhwIln33y+AVqq97kWIQAjY6PcCw1H5bx1oWMSzBE9piVgvb
         8mj/1E/WFI9WdTK28iPgrFE/gO8dbhWURoqGU=
Received: by 10.143.40.18 with SMTP id s18mr7342048wfj.283.1284971263638;
        Mon, 20 Sep 2010 01:27:43 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.27.41
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:27:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156563>

Having the source of a rename be involved in a directory/file conflict does
not currently pose any difficulties to the current merge-recursive
algorithm (in contrast to destinations of renames and D/F conflicts).
However, combining the two seemed like good testcases to include for
completeness.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6022-merge-rename.sh |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 2839dfb..2af863c 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -527,4 +527,42 @@ test_expect_failure 'Same as previous, but merged other way' '
 	test_cmp expected dir~renamed-file-has-conflicts
 '
 
+test_expect_success 'setup both rename source and destination involved in D/F conflict' '
+	git reset --hard &&
+	git checkout --orphan rename-dest &&
+	git rm -rf . &&
+	git clean -fdqx &&
+
+	mkdir one &&
+	echo stuff >one/file &&
+	git add -A &&
+	git commit -m "Common commmit" &&
+
+	git mv one/file destdir &&
+	git commit -m "Renamed to destdir" &&
+
+	git checkout -b source-conflict HEAD~1 &&
+	git rm -rf one &&
+	mkdir destdir &&
+	touch one destdir/foo &&
+	git add -A &&
+	git commit -m "Conflicts in the way"
+'
+
+test_expect_failure 'both rename source and destination involved in D/F conflict' '
+	git reset --hard &&
+	rm -rf dir~* &&
+	git checkout -q rename-dest^0 &&
+	test_must_fail git merge --strategy=recursive source-conflict &&
+
+	test 1 = "$(git ls-files -u | wc -l)" &&
+
+	test_must_fail git diff --quiet &&
+
+	test -f destdir/foo &&
+	test -f one &&
+	test -f destdir~HEAD &&
+	test "stuff" = "$(cat destdir~HEAD)"
+'
+
 test_done
-- 
1.7.3.271.g16009
