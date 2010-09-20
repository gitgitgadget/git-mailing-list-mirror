From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 01/37] t3030: Add a testcase for resolvable rename/add conflict with symlinks
Date: Mon, 20 Sep 2010 02:28:34 -0600
Message-ID: <1284971350-30590-2-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: "Schalk, Ken" <ken.schalk@intel.com>,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblF-0006R4-DV
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755738Ab0ITI1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:27:40 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39104 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443Ab0ITI1h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:27:37 -0400
Received: by pzk34 with SMTP id 34so1070490pzk.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OJLfhLSeTndhyO3L+oMV0RZmLsvR/SZlwy5X6krjRDI=;
        b=VwAuyo3u5I+q62JR1TZpMrhjEzcdTnSF5ICRsaoQiYMlXJ51bV39NSRdUUl8afqXxD
         O2PfJ2qREIpuerr9T1MNHfdbTJ6tqCAwBi9PQ3ljv67EAAOjBqf0tNGftsbIbg3JQYYt
         pB5ebdULzVuB+fiSx7vLPSQKxL3VAlEYIYuRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=u2BRoHiLhFTxv0gFKI/yYxIy+xjAiToARXEVry083B0IVvikd3XQcY0eBJe36zKxzJ
         KxyEPZyqYSYnV7VyFI9HTYEC9HtttukgVMiAiMJJI3zZCRJmvP4fwvXyqTTzZFX7yaxG
         ZnwpteSWdmqUT+vsP5j2uE6bMfy9hmCPMpzMs=
Received: by 10.142.246.20 with SMTP id t20mr7347977wfh.252.1284971251432;
        Mon, 20 Sep 2010 01:27:31 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.27.29
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:27:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156576>

From: Schalk, Ken <ken.schalk@intel.com>

d5af510 (RE: [PATCH] Avoid rename/add conflict when contents are identical
2010-09-01) avoided erroring out in a rename/add conflict when the contents
were identical.  A simpler fix could have handled that particular testcase,
but it would not correctly handle the case where a symlink is involved.
Add another testcase using symlinks, to avoid breaking that case.

Signed-off-by: Ken Schalk <ken.schalk@intel.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3030-merge-recursive.sh |   37 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index e66e550..3935c4b 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -25,6 +25,10 @@ test_expect_success 'setup 1' '
 	git branch submod &&
 	git branch copy &&
 	git branch rename &&
+	if test_have_prereq SYMLINKS
+	then
+		git branch rename-ln
+	fi &&
 
 	echo hello >>a &&
 	cp a d/e &&
@@ -255,7 +259,16 @@ test_expect_success 'setup 8' '
 	git mv a e &&
 	git add e &&
 	test_tick &&
-	git commit -m "rename a->e"
+	git commit -m "rename a->e" &&
+	if test_have_prereq SYMLINKS
+	then
+		git checkout rename-ln &&
+		git mv a e &&
+		ln -s e a &&
+		git add a e &&
+		test_tick &&
+		git commit -m "rename a->e, symlink a->e"
+	fi
 '
 
 test_expect_success 'setup 9' '
@@ -615,4 +628,26 @@ test_expect_success 'merge-recursive copy vs. rename' '
 	test_cmp expected actual
 '
 
+if test_have_prereq SYMLINKS
+then
+	test_expect_success 'merge-recursive rename vs. rename/symlink' '
+
+		git checkout -f rename &&
+		git merge rename-ln &&
+		( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+		(
+			echo "100644 blob $o0	b"
+			echo "100644 blob $o0	c"
+			echo "100644 blob $o0	d/e"
+			echo "100644 blob $o0	e"
+			echo "100644 $o0 0	b"
+			echo "100644 $o0 0	c"
+			echo "100644 $o0 0	d/e"
+			echo "100644 $o0 0	e"
+		) >expected &&
+		test_cmp expected actual
+	'
+fi
+
+
 test_done
-- 
1.7.3.271.g16009
