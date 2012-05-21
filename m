From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 3/4] submodule: verify support for superproject URLs of the form foo/bar.
Date: Mon, 21 May 2012 23:31:41 +1000
Message-ID: <1337607102-14737-3-git-send-email-jon.seymour@gmail.com>
References: <1337607102-14737-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 21 15:32:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWSie-0005qO-3h
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 15:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756369Ab2EUNcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 09:32:10 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41980 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864Ab2EUNcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 09:32:09 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so6944386pbb.19
        for <git@vger.kernel.org>; Mon, 21 May 2012 06:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hIBFZQPOEBAFKgG0guxgPbZWqWQEA4AOHgvaDEZLvf8=;
        b=VCH4m3QVl/qw95r6n2TbA4AXLjpHSKv2M1fG+esv/mapMKSLdpIjahvBG/lIb54Zry
         2g9slgcGVWn/Wjrmo8PBRTzNhA1nK5cc8r1S5vlfy3zVzYoGp7fJk9LTG4ich69C9CSz
         +xY4VPOV6s8zpS1P8nsij3om7+mas/ZJhBwAsJYV+rX43po3M5XX2Jyuh5qdUst/R+Hv
         r7lpTd8E87DE6iRl33EeJwVzFbsN4ImAu4zdBkkBE/xQczoDY6vyHUxUCx3EnP7y5SUX
         BpHI57Z7DT3bLPg5one+KetrzA4UM1urWA8uKF3ci5BQ1/zEW4wOEordGjEsju/d73+f
         kpGw==
Received: by 10.68.200.68 with SMTP id jq4mr24340104pbc.42.1337607128789;
        Mon, 21 May 2012 06:32:08 -0700 (PDT)
Received: from ubuntu.au.ibm.com ([110.173.237.195])
        by mx.google.com with ESMTPS id wi8sm23153721pbc.11.2012.05.21.06.32.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 May 2012 06:32:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.594.g5c52315
In-Reply-To: <1337607102-14737-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198102>

This test shows that git submodule add produces the wrong submodule URL
when the origin URL of the superproject is of the form: foo/bar.

The problem is fixed by a subsequent patch.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t7400-submodule-basic.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index b838f43..71f30d8 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -533,6 +533,23 @@ test_expect_sucess 'test that submodule add creates the correct url when super o
 		test "$(git config submodule.sub.url)" = ../../relative/subrepo
 	)
 '
+test_expect_failure 'test that submodule add creates the correct url when super origin url is relative/repo' '
+	mkdir reladd &&
+	(
+		cd reladd &&
+		git init &&
+		git remote add origin relative/repo
+		mkdir sub &&
+		(
+			cd sub &&
+			git init &&
+			test_commit foo
+		) &&
+		git submodule add ../subrepo ./sub &&
+		test "$(git config submodule.sub.url)" = ../relative/subrepo
+	)
+'
+
 test_expect_success 'moving the superproject does not break submodules' '
 	(
 		cd addtest &&
-- 
1.7.10.2.594.g5c52315
