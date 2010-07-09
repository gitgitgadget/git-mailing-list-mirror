From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 2/6] Add a rename + D/F conflict testcase
Date: Fri,  9 Jul 2010 07:10:52 -0600
Message-ID: <1278681056-31460-3-git-send-email-newren@gmail.com>
References: <1278681056-31460-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, agladysh@gmail.com,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 09 15:03:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXDEc-0008K3-Iw
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 15:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756167Ab0GINDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 09:03:09 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40579 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755535Ab0GINDH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 09:03:07 -0400
Received: by pzk26 with SMTP id 26so433270pzk.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 06:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UWnXiQkmO1nXMJX0Pz8GbyZVpW7gq38R/Dsj9Xj2iUI=;
        b=Ubl/CiIAvI8ibo8Tq9Pyr7UVx2DANce2+hhK73FRy5zPOsw+VDiDCSFpX7YLDW9PJ9
         vH6iuXZ/K9qCO2B+9wkrGrbf02gYpud9m/pAjoH9hodl34ntxNl3/3ojqHkiaz3sygtw
         cV/WSd5BRxeB4YEzqCJh2cOC/g72asz0HwBC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fBqgQ7FmfZM8Fv+bf0fv/w4jLjftT6MO8hti20u0rwb67dVb1JWMQSuYVM8wtjwBSd
         IYyH0Pkept4ESTxraPOc3XJ/jPthVRPo/Hy4CgORk0YBxNE+OuDpeF5gMxTrJpZAuApf
         kX8hNHOp7go3MQsjkNUH3bEEj2kqufFyA3cXc=
Received: by 10.114.103.4 with SMTP id a4mr11300888wac.52.1278680584755;
        Fri, 09 Jul 2010 06:03:04 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id b1sm700259rvn.2.2010.07.09.06.03.02
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 06:03:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1.23.gafea6
In-Reply-To: <1278681056-31460-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150659>

From: Alexander Gladysh <agladysh@gmail.com>

This is a simple testcase where both sides of the rename are paths involved
in (separate) D/F merge conflicts

Signed-off-by: Alexander Gladysh <agladysh@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Junio was also curious in the last round how well the resolve strategy
handled this testcase.  It passes.  I could add it as a testcase, but use
of the --strategy option for cherry-pick would make the series no longer
apply to maint.  However, if that is wanted, I can add it.

 t/t3509-cherry-pick-merge-df.sh |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)
 create mode 100755 t/t3509-cherry-pick-merge-df.sh

diff --git a/t/t3509-cherry-pick-merge-df.sh b/t/t3509-cherry-pick-merge-df.sh
new file mode 100755
index 0000000..7c05e16
--- /dev/null
+++ b/t/t3509-cherry-pick-merge-df.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+
+test_description='Test cherry-pick with directory/file conflicts'
+. ./test-lib.sh
+
+test_expect_success 'Setup rename across paths each below D/F conflicts' '
+	mkdir a &&
+	>a/f &&
+	git add a &&
+	git commit -m a &&
+
+	mkdir b &&
+	ln -s ../a b/a &&
+	git add b &&
+	git commit -m b &&
+
+	git checkout -b branch &&
+	rm b/a &&
+	mv a b/a &&
+	ln -s b/a a &&
+	git add . &&
+	git commit -m swap &&
+
+	>f1 &&
+	git add f1 &&
+	git commit -m f1
+'
+
+test_expect_failure 'Cherry-pick succeeds with rename across D/F conflicts' '
+	git reset --hard &&
+	git checkout master^0 &&
+	git cherry-pick branch
+'
+
+test_done
-- 
1.7.1.1.23.gafea6
