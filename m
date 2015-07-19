From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 02/12] t4150: am fails if index is dirty
Date: Sun, 19 Jul 2015 23:49:08 +0800
Message-ID: <1437320958-11192-3-git-send-email-pyokagan@gmail.com>
References: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 17:49:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGqqS-0005a9-H6
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 17:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596AbbGSPtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 11:49:35 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34954 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326AbbGSPtd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 11:49:33 -0400
Received: by pabkd10 with SMTP id kd10so16949561pab.2
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 08:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TB5Dv+rjnrN2gqnK4qbG5K2J5hrvNrm6MCCw7EPB+mU=;
        b=VQj8ni6womUpwbhyDuIcrSBnX3mq0tn3rx0BH5oN6F/UATPOvGiqvqhxpJaTR3VkHg
         l6bmnBdF/AR9N7xeioJTZeW1VIgOOV9TqU5dMazSji8/MbIfzA28j62SbY0CCZAhUUkX
         r8oGOysRMsXbeLJfA1OV7QE23CwNNh8UL/lIPiDN1qwHzNNtFzd62picvaZj3dshW1sr
         SSS1C085Hx2cgaOYznEm6uWMwiE/mmYr8TzAKY1e+0P6S3Wkj0gGeJ0lOCyflPBHH1Pc
         bB3MYZVSdDSRovIVSjh2XkQz8Jj3ZdvH1gH1A8fXcXu234jHPj891+XCdVtWsnNPupFS
         gpaw==
X-Received: by 10.68.221.70 with SMTP id qc6mr49231054pbc.76.1437320973295;
        Sun, 19 Jul 2015 08:49:33 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id j9sm17216516pdl.65.2015.07.19.08.49.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 08:49:32 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gf2a5fc6
In-Reply-To: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274212>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
will ensure that the index is clean before applying the patch. This is
to prevent changes unrelated to the patch from being committed.

Add a test for this check.

Reviewed-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t4150-am.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 264f53f..a85e06a 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -154,6 +154,18 @@ test_expect_success 'am applies patch correctly' '
 	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
 '
 
+test_expect_success 'am fails if index is dirty' '
+	test_when_finished "rm -f dirtyfile" &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	echo dirtyfile >dirtyfile &&
+	git add dirtyfile &&
+	test_must_fail git am patch1 &&
+	test_path_is_dir .git/rebase-apply &&
+	test_cmp_rev first HEAD
+'
+
 test_expect_success 'am applies patch e-mail not in a mbox' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
-- 
2.5.0.rc2.110.gf2a5fc6
