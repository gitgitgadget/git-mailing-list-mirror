From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH] t0008: use named pipe (FIFO) to test check-ignore streaming
Date: Mon, 29 Apr 2013 23:55:25 +0100
Message-ID: <1367276125-15239-1-git-send-email-git@adamspiers.org>
References: <20130424080235.GC17889@pacific.linksys.moosehall>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 30 00:55:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWwyx-0006YR-Tt
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 00:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759133Ab3D2Wz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 18:55:29 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:41095 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759103Ab3D2Wz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 18:55:28 -0400
Received: from localhost (4.3.1.2.f.7.0.2.5.1.9.5.4.a.0.0.0.d.3.7.6.a.1.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:11a6:73d0:a4:5915:207f:2134])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 6A3282EAD2
	for <git@vger.kernel.org>; Mon, 29 Apr 2013 23:55:26 +0100 (BST)
X-Mailer: git-send-email 1.8.3.rc0.305.g6580fe1
In-Reply-To: <20130424080235.GC17889@pacific.linksys.moosehall>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222875>

sleeps in the check-ignore test suite are not ideal since they can
fail when the system is under load, or when a tool like valgrind is
used which drastically alters the timing.  Therefore we replace them
with a more robust solution using a named pipe (FIFO).

Thanks to Jeff King for coming up with the redirection wizardry
required to make this work.

http://article.gmane.org/gmane.comp.version-control.git/220916

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 t/t0008-ignores.sh | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index fbf12ae..a56db80 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -688,27 +688,23 @@ do
 	'
 done
 
-test_expect_success 'setup: have stdbuf?' '
-	if which stdbuf >/dev/null 2>&1
-	then
-		test_set_prereq STDBUF
-	fi
-'
-
-test_expect_success STDBUF 'streaming support for --stdin' '
-	(
-		echo one
-		sleep 2
-		echo two
-	) | stdbuf -oL git check-ignore -v -n --stdin >out &
-	pid=$! &&
-	sleep 1 &&
-	grep "^\.gitignore:1:one	one" out &&
-	test $( wc -l <out ) = 1 &&
-	sleep 2 &&
-	grep "^::	two" out &&
-	test $( wc -l <out ) = 2 &&
-	( wait $pid || kill $pid || : ) 2>/dev/null
+test_expect_success PIPE 'streaming support for --stdin' '
+	mkfifo in out &&
+	(git check-ignore -n -v --stdin <in >out &) &&
+
+	# We cannot just "echo >in" because check-ignore would get EOF
+	# after echo exited; instead we open the descriptor in our
+	# shell, and then echo to the fd. We make sure to close it at
+	# the end, so that the subprocess does get EOF and dies
+	# properly.
+	exec 9>in &&
+	test_when_finished "exec 9>&-" &&
+	echo >&9 one &&
+	read response <out &&
+	echo "$response" | grep "^\.gitignore:1:one	one" &&
+	echo >&9 two &&
+	read response <out &&
+	echo "$response" | grep "^::	two"
 '
 
 test_done
-- 
1.8.3.rc0.305.g6580fe1
