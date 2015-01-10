From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 2/2] t1020-subdirectory.sh: check hook pwd, $GIT_PREFIX
Date: Sat, 10 Jan 2015 01:49:58 -0500
Message-ID: <1420872598-9609-3-git-send-email-rhansen@bbn.com>
References: <1420872598-9609-1-git-send-email-rhansen@bbn.com>
Cc: rhansen@bbn.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 10 07:50:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9psQ-0004lS-4y
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 07:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315AbbAJGuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 01:50:18 -0500
Received: from smtp.bbn.com ([128.33.0.80]:41416 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752651AbbAJGuR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 01:50:17 -0500
Received: from socket.bbn.com ([192.1.120.102]:53656)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Y9psG-000AUn-KV; Sat, 10 Jan 2015 01:50:16 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 631B13FF9A
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1420872598-9609-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262257>

Make sure hooks are executed at the top-level directory and that
GIT_PREFIX is set (as documented).

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 t/t1020-subdirectory.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 2edb4f2..03bb0a2 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -128,6 +128,23 @@ test_expect_success !MINGW '!alias expansion' '
 	test_cmp expect actual
 '
 
+test_expect_success 'hook pwd' '
+	pwd >expect &&
+	(
+		rm -f actual &&
+		mkdir -p .git/hooks &&
+		! test -e .git/hooks/post-checkout &&
+		cat <<-\EOF >.git/hooks/post-checkout &&
+			#!/bin/sh
+			pwd >actual
+		EOF
+		chmod +x .git/hooks/post-checkout &&
+		(cd dir && git checkout -- two) &&
+		rm -f .git/hooks/post-checkout
+	) &&
+	test_cmp expect actual
+'
+
 test_expect_success 'GIT_PREFIX for !alias' '
 	printf "dir/" >expect &&
 	(
@@ -154,6 +171,23 @@ test_expect_success 'GIT_PREFIX for built-ins' '
 	test_cmp expect actual
 '
 
+test_expect_success 'GIT_PREFIX for hooks' '
+	printf "dir/" >expect &&
+	(
+		rm -f actual &&
+		mkdir -p .git/hooks &&
+		! test -e .git/hooks/post-checkout &&
+		cat <<-\EOF >.git/hooks/post-checkout &&
+			#!/bin/sh
+			printf %s "$GIT_PREFIX" >actual
+		EOF
+		chmod +x .git/hooks/post-checkout &&
+		(cd dir && git checkout -- two) &&
+		rm -f .git/hooks/post-checkout
+	)  &&
+	test_cmp expect actual
+'
+
 test_expect_success 'no file/rev ambiguity check inside .git' '
 	git commit -a -m 1 &&
 	(
-- 
2.2.1
