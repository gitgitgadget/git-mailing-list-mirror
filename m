From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 2/2] t1020-subdirectory.sh: check hook pwd, $GIT_PREFIX
Date: Sat, 10 Jan 2015 18:11:43 -0500
Message-ID: <1420931503-22857-3-git-send-email-rhansen@bbn.com>
References: <54B0E1EE.2020301@kdbg.org>
 <1420931503-22857-1-git-send-email-rhansen@bbn.com>
Cc: git@vger.kernel.org, rhansen@bbn.com
To: 6t@kdbg.org
X-From: git-owner@vger.kernel.org Sun Jan 11 00:12:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YA5CP-0001v6-1M
	for gcvg-git-2@plane.gmane.org; Sun, 11 Jan 2015 00:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbbAJXMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 18:12:00 -0500
Received: from smtp.bbn.com ([128.33.1.81]:23940 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087AbbAJXL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 18:11:58 -0500
Received: from socket.bbn.com ([192.1.120.102]:35763)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1YA5CG-0003hv-8A; Sat, 10 Jan 2015 18:11:56 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id DA6A73FF91
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1420931503-22857-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262279>

Make sure hooks are executed at the top-level directory and that
GIT_PREFIX is set (as documented).

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 t/t1020-subdirectory.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 2edb4f2..0ccbb7e 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -128,6 +128,17 @@ test_expect_success !MINGW '!alias expansion' '
 	test_cmp expect actual
 '
 
+test_expect_success 'hook pwd' '
+	rm -f actual &&
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/post-checkout <<-\EOF &&
+		pwd >actual
+	EOF
+	test_when_finished "rm -f .git/hooks/post-checkout actual" &&
+	(cd dir && git checkout -- two) &&
+	test_path_is_file actual
+'
+
 test_expect_success 'GIT_PREFIX for !alias' '
 	printf "dir/" >expect &&
 	(
@@ -154,6 +165,18 @@ test_expect_success 'GIT_PREFIX for built-ins' '
 	test_cmp expect actual
 '
 
+test_expect_success 'GIT_PREFIX for hooks' '
+	printf "dir/" >expect &&
+	rm -f actual &&
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/post-checkout <<-\EOF &&
+		printf %s "$GIT_PREFIX" >actual
+	EOF
+	test_when_finished "rm -f .git/hooks/post-checkout expect actual" &&
+	(cd dir && git checkout -- two) &&
+	test_cmp expect actual
+'
+
 test_expect_success 'no file/rev ambiguity check inside .git' '
 	git commit -a -m 1 &&
 	(
-- 
2.2.1
