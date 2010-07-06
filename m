From: newren@gmail.com
Subject: [PATCHv2 2/5] Add a rename + D/F conflict testcase
Date: Tue,  6 Jul 2010 12:51:32 -0600
Message-ID: <1278442295-23033-3-git-send-email-newren@gmail.com>
References: <1278442295-23033-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, spearce@spearce.org, agladysh@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 06 20:44:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWD7t-00072l-Vf
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 20:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670Ab0GFSoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 14:44:10 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:42120 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317Ab0GFSoH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 14:44:07 -0400
Received: by pxi14 with SMTP id 14so2299459pxi.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 11:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=AxhoAJLoAzJ9gor0WUpDIVnulrzDt1OVfih0gm/+mG0=;
        b=qPsElD8w8W0qOinoQ7rZ9CGu3OyhQrfqowwJNELeHrpG20izNP+kvoe+df+4Rsy0vL
         JCUVBMmgkgExiGA47z0Ke6lkNxkrx+SlyW3JYNks9nC5ZYi8hG3AugA3ae3BcdFdGn9i
         EmfQ2YYr0tbTrqMuV8IP2yXeqystzXwig8IcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EMjYO+lOlA9CGeUn2JH36UqdcB6ucHuNj7B7X2JszVaGPOlDkl4YQsG3zSJ760cElE
         mr3h7bTwiQ+QpC2eQ1t0O5dBk33ge4zgd29j9JVdxqZZDvs1i+MRd2csdt2IDKeMc2Mb
         J+fw5OHcGBzKTuCBRLk7dxaFUZVPY3H1aYCRc=
Received: by 10.114.112.11 with SMTP id k11mr5801709wac.50.1278441846827;
        Tue, 06 Jul 2010 11:44:06 -0700 (PDT)
Received: from localhost.localdomain ([76.113.59.120])
        by mx.google.com with ESMTPS id c24sm86219693wam.7.2010.07.06.11.44.05
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 11:44:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1.9.g45c1c
In-Reply-To: <1278442295-23033-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150388>

From: Alexander Gladysh <agladysh@gmail.com>

This is a simple testcase where both sides of the rename are paths involved
in (separate) D/F merge conflicts

Signed-off-by: Alexander Gladysh <agladysh@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
As noted previously this is simply a testcase Alexander sent to the list
on March 8 which I'm submitting in the form of a testsuite addition.
He's happy to have his testcase added to the testsuite and/or even
submit it himself if that makes more sense -- just let us know what is
wanted.  I'm less familiar with format-patch and am; hopefully this
submission comes across with him recorded as the author.

Also, I moved the location of this testcase since the last submission;
last time I made it part of t/t6020-merge-df.sh, which probably doesn't
make sense since the testcase invokes cherry-pick rather than merge.

 t/t3508-cherry-pick-merge-df.sh |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)
 create mode 100755 t/t3508-cherry-pick-merge-df.sh

diff --git a/t/t3508-cherry-pick-merge-df.sh b/t/t3508-cherry-pick-merge-df.sh
new file mode 100755
index 0000000..646a56d
--- /dev/null
+++ b/t/t3508-cherry-pick-merge-df.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+test_description='Test cherry-pick with directory/file conflicts'
+. ./test-lib.sh
+
+test_expect_success 'Setup rename across paths each below D/F conflicts' '
+	mkdir a &&
+	touch a/f &&
+	git add a &&
+	git commit -m "a" &&
+
+	mkdir b &&
+	ln -s ../a b/a &&
+	git add b &&
+	git commit -m "b" &&
+
+	git checkout -b branch &&
+	rm b/a &&
+	mv a b/ &&
+	ln -s b/a a &&
+	git add . &&
+	git commit -m "swap" &&
+
+	touch f1 &&
+	git add f1 &&
+	git commit -m "f1"
+'
+
+test_expect_failure 'Cherry-pick succeeds with rename across D/F conflicts' '
+	git checkout master &&
+	git cherry-pick branch
+'
+
+test_done
-- 
1.7.1.1.6.gc3cd6
