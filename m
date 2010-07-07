From: newren@gmail.com
Subject: [PATCHv3 2/6] Add a rename + D/F conflict testcase
Date: Tue,  6 Jul 2010 23:20:30 -0600
Message-ID: <1278480034-22939-3-git-send-email-newren@gmail.com>
References: <1278480034-22939-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, spearce@spearce.org, agladysh@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 07 07:13:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWMwd-0002Ar-Au
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 07:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637Ab0GGFNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 01:13:09 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47654 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab0GGFNE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 01:13:04 -0400
Received: by gxk23 with SMTP id 23so3440291gxk.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 22:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WKFrNoykgnaIIJg1rQnFUAzJVXd2YIeemEpDy3Belr0=;
        b=VdrIytJwUMff3ZDTirQqwo/RCyIBddTreddW3/grmfXARqgbJMNCBVFzy13klfs95C
         UvObyi3qR8c4zv63vz2yumyH6DWWquHfj51fbe4761sea4oJKQtMYTjlAg0p2cMCh/M7
         eNPRda+xaIZ7Rpd5rkKBcRXJOzuPjzI52opG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=utn3vQS/HNSrVa+3tx8dszNsOdFk5jO4PUGqtEtk0dZ7sSjJf8pu5VZAJuI47xjIR3
         ixL/rxRZ0fCJ/FfGURhlQyZ537CorFUVHZixn3pv6s73KzPu3KU2Tzga2T131Brjd95L
         zUw+0cp5WLC/2am8vcMH86IEOIyGTs4V/i6jU=
Received: by 10.100.121.12 with SMTP id t12mr1860615anc.82.1278479583878;
        Tue, 06 Jul 2010 22:13:03 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id h5sm60464675anb.28.2010.07.06.22.13.01
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 22:13:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1.10.g6dbc5
In-Reply-To: <1278480034-22939-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150440>

From: Alexander Gladysh <agladysh@gmail.com>

This is a simple testcase where both sides of the rename are paths involved
in (separate) D/F merge conflicts

Signed-off-by: Alexander Gladysh <agladysh@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
Copying my additional comments from round 2:

  As noted previously this is simply a testcase Alexander sent to the
  list on March 8 which I'm submitting in the form of a testsuite
  addition.  He's happy to have his testcase added to the testsuite
  and/or even submit it himself if that makes more sense -- just let
  us know what is wanted.  I'm less familiar with format-patch and am;
  hopefully this submission comes across with him recorded as the
  author.

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
1.7.1.1.10.g2e807
