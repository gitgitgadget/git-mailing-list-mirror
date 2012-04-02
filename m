From: Ivan Todoroski <grnch@gmx.net>
Subject: [PATCH v3 3/4] fetch-pack: test cases for the new --stdin option
Date: Mon, 02 Apr 2012 17:16:24 +0200
Message-ID: <4F79C2C8.3020009@gmx.net>
References: <4F79C195.6090905@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 17:16:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEizI-0006Zt-R8
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 17:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141Ab2DBPP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 11:15:58 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:32947 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752194Ab2DBPP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 11:15:56 -0400
Received: (qmail invoked by alias); 02 Apr 2012 15:15:54 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.163.38]
  by mail.gmx.net (mp020) with SMTP; 02 Apr 2012 17:15:54 +0200
X-Authenticated: #7905487
X-Provags-ID: V01U2FsdGVkX18R7D0aEaIRUC7dNtQ0RvWPHscOrBHFkDbRiHR4RO
	+/nLTGuHVLSIv8
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <4F79C195.6090905@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194519>

These test cases focus only on testing the parsing of refs on stdin,
without bothering with the rest of the fetch-pack machinery. We pass in
the refs using different combinations of command line and stdin and then
we watch fetch-pack's stdout to see whether it prints all the refs we
specified (but we ignore their order).

Signed-off-by: Ivan Todoroski <grnch@gmx.net>
---
 t/t5500-fetch-pack.sh |   66 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 9bf69e9a0f..feaa222c78 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -248,4 +248,70 @@ test_expect_success 'clone shallow object count' '
 	grep "^count: 52" count.shallow
 '
 
+test_expect_success 'setup tests for the --stdin parameter' '
+	for head in C D E F
+	do
+		add $head
+	done &&
+	for head in A B C D E F
+	do
+		git tag $head $head
+	done
+	cat >input <<EOF
+refs/heads/C
+refs/heads/A
+refs/heads/D
+refs/tags/C
+refs/heads/B
+refs/tags/A
+refs/heads/E
+refs/tags/B
+refs/tags/E
+refs/tags/D
+EOF
+	sort <input >expect
+	(
+	echo refs/heads/E &&
+	echo refs/tags/E &&
+	cat input
+	) >input.dup
+'
+
+test_expect_success 'fetch refs from cmdline, make sure it still works OK' '
+	(
+	cd client &&
+	git fetch-pack --no-progress .. $(cat ../input)
+	) >output &&
+	cut -d " " -f 2 <output | sort >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'fetch refs from stdin' '
+	(
+	cd client &&
+	git fetch-pack --stdin --no-progress .. <../input
+	) >output &&
+	cut -d " " -f 2 <output | sort >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'fetch mixed refs from cmdline and stdin' '
+	(
+	cd client &&
+	tail -n +5 ../input |
+	git fetch-pack --stdin --no-progress .. $(head -n 4 ../input)
+	) >output &&
+	cut -d " " -f 2 <output | sort >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'test duplicate refs from stdin' '
+	(
+	cd client &&
+	test_must_fail git fetch-pack --stdin --no-progress .. <../input.dup
+	) >output &&
+	cut -d " " -f 2 <output | sort >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.9.5.4.g4f508
