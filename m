From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 25/48] remote-hg: add test for diverged push
Date: Fri, 24 May 2013 21:29:41 -0500
Message-ID: <1369449004-17981-26-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:33:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4I8-0002E7-7R
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240Ab3EYCdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:33:01 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:42660 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755301Ab3EYCc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:32:59 -0400
Received: by mail-ob0-f182.google.com with SMTP id va2so6171416obc.41
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=HnbmaXvSEhr1NPsbSC1DAZJwPBH4jnteiXHxUB5IGKc=;
        b=YpbEBBN+fJGjSdF1w8gGOVHfNzTx/zBqpGLRoGpM4JGt99f67VHQjO8vT+qAFKF0hQ
         hp2lHmhR7Jk6hkZb9QpvcMhEqhYxrTNUooRL38LDZjTDxt9APJ/rOygNpJi5jZut4H5l
         ug2H1wNGgP52VGnaIy+YVHw5HtUhTJZ81X4grCYBZStx47ecfwQJ2T/Ruuhh0CBmc2ep
         b4F8LU5A2YcUsbOtdtLj+vrhbOexBCt5Zv4p19poeNLbsh8UZQDfrkyoy4UrsMrp8K09
         t7yB3CQOIb3fGYBWi4+2DETyDn7tuef6GEIKMH1gfzAWVrTUBiqder9QecjmnncAeFiC
         Rh+g==
X-Received: by 10.60.131.164 with SMTP id on4mr13302569oeb.70.1369449178755;
        Fri, 24 May 2013 19:32:58 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id n5sm20062571obi.8.2013.05.24.19.32.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:32:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225439>

Neither mercurial nor git allows pushing to a remote when it's a
non-fast-forward push. We should be able to detect theses errors and
report them properly.

As opposed to throwing an exception stack-trace.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 8b5e191..252553e 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -318,4 +318,27 @@ test_expect_success 'remote new bookmark' '
 	check_bookmark hgrepo feature-b feature-b
 '
 
+test_expect_failure 'remote push diverged' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	git clone "hg::hgrepo" gitrepo &&
+
+	(
+	cd hgrepo &&
+	hg checkout default &&
+	echo bump > content &&
+	hg commit -m bump
+	) &&
+
+	(
+	cd gitrepo &&
+	echo diverge > content &&
+	git commit -a -m diverged &&
+	test_expect_code 1 git push 2> error &&
+	grep "^ ! \[rejected\] *master -> master (non-fast-forward)$" error
+	) &&
+
+	check_branch hgrepo default bump
+'
+
 test_done
-- 
1.8.3.rc3.312.g47657de
