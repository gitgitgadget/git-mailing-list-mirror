From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 03/12] t4151: am --abort will keep dirty index intact
Date: Sun, 19 Jul 2015 23:49:09 +0800
Message-ID: <1437320958-11192-4-git-send-email-pyokagan@gmail.com>
References: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 17:49:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGqqT-0005a9-4J
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 17:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611AbbGSPti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 11:49:38 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34730 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326AbbGSPtg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 11:49:36 -0400
Received: by pacan13 with SMTP id an13so89690859pac.1
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 08:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oyII2rqi/utO+oIRgRHWVVTzJxXTDYBSteV8FCkXA3s=;
        b=r6d5CK0BAf+QeD/QPfoI1xjWvV5mCxHgDuyewF0cu07xZnezuScmNxdNgGY3VWUxUw
         UU52fkZ5k4DBnnLLFb65nW+WMWRqMpr/PV4wgstVgz6w9ud3vaofYk4vmpt1LrDdMZ35
         wvbHquir2kHBv0s2DKrfdCwz7kIU0EBNvvlwoJLN8595gTnjYjQT+PryE/RngXFRikHr
         pqHSiRBwROh9GIsapzegKn/uDGxA5alrElpEo8u8dDuzeWre5X146SE6uIuASu/wg9Y3
         +hl5cC8j1H0M+ees/nGEFGBNUGlho5bVtsBTwVu4dxIImB8FMLDy3pjvOb1rb4CEHz5K
         0kHw==
X-Received: by 10.68.244.73 with SMTP id xe9mr49335649pbc.98.1437320976238;
        Sun, 19 Jul 2015 08:49:36 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id j9sm17216516pdl.65.2015.07.19.08.49.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 08:49:35 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gf2a5fc6
In-Reply-To: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274216>

Since 7b3b7e3 (am --abort: keep unrelated commits since the last failure
and warn, 2010-12-21), git-am --abort will not touch the index if on the
previous invocation, git-am failed because the index is dirty. This is
to ensure that the user's modifications to the index are not discarded.

Add a test for this.

Reviewed-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t4151-am-abort.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 833e7b2..05bdc3e 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -95,6 +95,21 @@ test_expect_success 'am --abort will keep the local commits intact' '
 	test_cmp expect actual
 '
 
+test_expect_success 'am --abort will keep dirty index intact' '
+	git reset --hard initial &&
+	echo dirtyfile >dirtyfile &&
+	cp dirtyfile dirtyfile.expected &&
+	git add dirtyfile &&
+	test_must_fail git am 0001-*.patch &&
+	test_cmp_rev initial HEAD &&
+	test_path_is_file dirtyfile &&
+	test_cmp dirtyfile.expected dirtyfile &&
+	git am --abort &&
+	test_cmp_rev initial HEAD &&
+	test_path_is_file dirtyfile &&
+	test_cmp dirtyfile.expected dirtyfile
+'
+
 test_expect_success 'am -3 stops on conflict on unborn branch' '
 	git checkout -f --orphan orphan &&
 	git reset &&
-- 
2.5.0.rc2.110.gf2a5fc6
