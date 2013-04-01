From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] rerere forget: grok files containing NUL
Date: Mon, 01 Apr 2013 23:36:36 +0200
Message-ID: <5159FDE4.2090409@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 23:37:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMmPh-0006Yh-5L
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 23:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758104Ab3DAVgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 17:36:44 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:43581 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758009Ab3DAVgo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 17:36:44 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 862E81000B;
	Mon,  1 Apr 2013 23:36:39 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 5C34B19F480;
	Mon,  1 Apr 2013 23:36:37 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219711>

Using 'git rerere forget .' after a merge that involved binary files
runs into an infinite loop if the binary file contains a zero byte.
Replace a strchrnul by memchr because the former does not make progress
as soon as the NUL is encountered.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 The new test case runs into the infinite loop if you back out
 the code change.

 There's another bug where an uninitialized pointer is accessed
 in the second for-loop in handle_cache(), presumably for a file
 with ADD-ADD conflicts. Will look into that one later this week.

 -- Hannes

 rerere.c                  |  6 ++++--
 t/t2030-unresolve-info.sh | 12 ++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/rerere.c b/rerere.c
index a6a5cd5..4d940cd 100644
--- a/rerere.c
+++ b/rerere.c
@@ -284,8 +284,10 @@ static int rerere_mem_getline(struct strbuf *sb, struct rerere_io *io_)
 	strbuf_release(sb);
 	if (!io->input.len)
 		return -1;
-	ep = strchrnul(io->input.buf, '\n');
-	if (*ep == '\n')
+	ep = memchr(io->input.buf, '\n', io->input.len);
+	if (!ep)
+		ep = io->input.buf + io->input.len;
+	else if (*ep == '\n')
 		ep++;
 	len = ep - io->input.buf;
 	strbuf_add(sb, io->input.buf, len);
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index f262065..0b699f5 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -44,9 +44,13 @@ prime_resolve_undo () {
 
 test_expect_success setup '
 	mkdir fi &&
+	printf "a\0a" >binary &&
+	git add binary &&
 	test_commit initial fi/le first &&
 	git branch side &&
 	git branch another &&
+	printf "a\0b" >binary &&
+	git add binary &&
 	test_commit second fi/le second &&
 	git checkout side &&
 	test_commit third fi/le third &&
@@ -167,4 +171,12 @@ test_expect_success 'rerere and rerere forget (subdirectory)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rerere forget (binary)' '
+	git checkout -f side &&
+	printf "a\0c" >binary &&
+	git commit -a -m binary &&
+	test_must_fail git merge second &&
+	git rerere forget binary
+'
+
 test_done
-- 
1.8.2.383.g5f2fd52
