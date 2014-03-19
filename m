From: Hiroyuki Sano <sh19910711@gmail.com>
Subject: [PATCH v3][GSOC] fsck: use bitwise-or assignment operator to set flag
Date: Thu, 20 Mar 2014 08:02:04 +0900
Message-ID: <1395270124-2242-1-git-send-email-sh19910711@gmail.com>
Cc: Hiroyuki Sano <sh19910711@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 00:02:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQPV2-0004i2-CW
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 00:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119AbaCSXCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 19:02:11 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:49554 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755665AbaCSXCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 19:02:09 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so31014pbb.11
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 16:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=IR4CNIRuXK6zB1cRQw5uJcySMH+BuWKcqqst9D8nv7w=;
        b=Hjh2HKiNhZYs/LnS5GyZWW7ruy2YoMXZRmtyC1qMuFh0UaBWR/j1fIn2DPeuWWM0WP
         ur+DxtOaaAZZ5tti7LY39276aMrdT3dXnBi7G9k0ZZ/oSw4r1T4VSAlHxN270fSTOzYJ
         TyJ8WM3X1OpiHKzMVEdblvcMJXvki4KHXvjLnLwDhmPfpcGrGN01RyciZrqUGX+hvACE
         jrcS1SMYBUXLHWcZR2srjZnjbO8iJPM1PA74YJhFOV/48tv5dzmm2dunuBHPrIQSFulx
         FuD9Tdvfri3qM50FiX8vTukLdcTpVMLgrsaxKtLYuyFnWM79VtMIOcM668fZP3CFqH4D
         KVyw==
X-Received: by 10.66.156.4 with SMTP id wa4mr43101819pab.49.1395270129134;
        Wed, 19 Mar 2014 16:02:09 -0700 (PDT)
Received: from localhost (ntfkok023001.fkok.nt.adsl.ppp.infoweb.ne.jp. [218.217.179.1])
        by mx.google.com with ESMTPSA id pv4sm9344pbb.55.2014.03.19.16.02.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Mar 2014 16:02:08 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244506>

fsck_tree() has two different ways to set a flag,
which are the followings:

  1. Using a if-statement that guards assignment.

  2. Using a bitwise-or assignment operator.

Currently, many with the former way,
and one with the latter way.

In this patch, unify them to the latter way,
because it makes the code shorter and easier to read,
and it is brief and to the point.

Signed-off-by: Hiroyuki Sano <sh19910711@gmail.com>
---
 fsck.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fsck.c b/fsck.c
index b3022ad..abed62b 100644
--- a/fsck.c
+++ b/fsck.c
@@ -165,18 +165,12 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 
 		sha1 = tree_entry_extract(&desc, &name, &mode);
 
-		if (is_null_sha1(sha1))
-			has_null_sha1 = 1;
-		if (strchr(name, '/'))
-			has_full_path = 1;
-		if (!*name)
-			has_empty_name = 1;
-		if (!strcmp(name, "."))
-			has_dot = 1;
-		if (!strcmp(name, ".."))
-			has_dotdot = 1;
-		if (!strcmp(name, ".git"))
-			has_dotgit = 1;
+		has_null_sha1 |= is_null_sha1(sha1);
+		has_full_path |= !!strchr(name, '/');
+		has_empty_name |= !*name;
+		has_dot |= !strcmp(name, ".");
+		has_dotdot |= !strcmp(name, "..");
+		has_dotgit |= !strcmp(name, ".git");
 		has_zero_pad |= *(char *)desc.buffer == '0';
 		update_tree_entry(&desc);
 
-- 
1.9.0
