From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 1/2] t/t7407: demonstrate that the command called by 'submodule foreach' loses stdin
Date: Wed, 29 Jun 2011 19:34:57 -0500
Message-ID: <1309394098-18618-1-git-send-email-drafnel@gmail.com>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 30 02:35:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qc5ES-0002Js-9Y
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 02:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757874Ab1F3Afg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 20:35:36 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58759 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754370Ab1F3Afe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 20:35:34 -0400
Received: by yxi11 with SMTP id 11so685467yxi.19
        for <git@vger.kernel.org>; Wed, 29 Jun 2011 17:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=cP7BXcrbdpffkd2yTeOnJ0v/g8sGw/R/AITkCYrndok=;
        b=Y+aF6Ytp+3lr1yHcDOryjR2QFkShhh7dz82Q3p14gzeaNVNk9qKeb9NUQWFBZfo7sS
         80QjnSEzjEv77ej0hG9egVqCAYaCUiseQxJSOjxh/I5ZmnjYAVHfcTgv9Bo6KkCgY7j8
         l6r3iUe0m4Ek29JCzmGr5Cfqm7N2y9wB5X7Rs=
Received: by 10.236.143.143 with SMTP id l15mr1635785yhj.407.1309394133692;
        Wed, 29 Jun 2011 17:35:33 -0700 (PDT)
Received: from localhost.localdomain ([96.19.140.155])
        by mx.google.com with ESMTPS id c63sm1256009yhe.4.2011.06.29.17.35.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Jun 2011 17:35:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176464>

The user-supplied command spawned by 'submodule foreach' loses its
connection to the original standard input.  Instead, it is connected to the
output of a pipe within the git-submodule script.  This can cause a problem
if the command requires reading from stdin or if it changes its behavior
based on whether stdin is a tty or not (e.g. git shortlog).  Demonstrate
this flaw.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 t/t7407-submodule-foreach.sh |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index e5be13c..e8d21b5 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -292,4 +292,22 @@ test_expect_success 'use "update --recursive nested1" to checkout all submodules
 	)
 '
 
+test_expect_failure 'command passed to foreach retains notion of stdin' '
+	(
+		cd super &&
+		git submodule foreach echo success >../expected &&
+		yes | git submodule foreach "read y && test \"x\$y\" = xy && echo success" >../actual
+	) &&
+	test_cmp expected actual
+'
+
+test_expect_failure 'command passed to foreach --recursive retains notion of stdin' '
+	(
+		cd clone2 &&
+		git submodule foreach --recursive echo success >../expected &&
+		yes | git submodule foreach --recursive "read y && test \"x\$y\" = xy && echo success" >../actual
+	) &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.7.6
