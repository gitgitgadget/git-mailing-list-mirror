From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH jk/pkt-line-cleanup] t5700-clone-reference: send trace to
 fd 2, not 3, to please Windows git
Date: Wed, 20 Mar 2013 09:24:44 +0100
Message-ID: <5149724C.3060105@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 20 09:25:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIEKl-00030p-3O
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 09:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934044Ab3CTIYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 04:24:51 -0400
Received: from so.liwest.at ([212.33.55.24]:29546 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933959Ab3CTIYt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 04:24:49 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UIEKD-0001lT-AZ
	for git@vger.kernel.org; Wed, 20 Mar 2013 09:24:45 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B400D1660F
	for <git@vger.kernel.org>; Wed, 20 Mar 2013 09:24:44 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218578>

From: Johannes Sixt <j6t@kdbg.org>

Two tests use GIT_TRACE=3 to dump debugging information of git. On
Windows, however, bash is unable to set up file descriptor 3 correctly
for its child process, so that git reports "Bad file descriptor" on
every trace attempt. The 'git clone' test succeeds nevertheless because
an empty trace file remains, and there is only a check for the
absence of a particular line. But the 'git fetch' process ultimately
hangs (the dynamics that lead to this surprising result have not been
investigated).

Since we do not otherwise use stderr in the test cases, divert the
trace dump to stderr.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This fixes a regression introduced in 

 t/t5700-clone-reference.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 9cd3b4d..8b5c58e 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -55,7 +55,7 @@ cd "$base_dir"
 rm -f "$U.D"
 
 test_expect_success 'cloning with reference (no -l -s)' \
-'GIT_TRACE_PACKET=3 git clone --reference B "file://$(pwd)/A" D 3>"$U.D"'
+'GIT_TRACE_PACKET=2 git clone --reference B "file://$(pwd)/A" D 2>"$U.D"'
 
 test_expect_success 'fetched no objects' \
 '! grep " want" "$U.D"'
@@ -173,7 +173,7 @@ test_expect_success 'fetch with incomplete alternates' '
 	(
 		cd K &&
 		git remote add J "file://$base_dir/J" &&
-		GIT_TRACE_PACKET=3 git fetch J 3>"$U.K"
+		GIT_TRACE_PACKET=2 git fetch J 2>"$U.K"
 	) &&
 	master_object=$(cd A && git for-each-ref --format="%(objectname)" refs/heads/master) &&
 	! grep " want $master_object" "$U.K" &&
-- 
1.8.2.1298.g2825a8e
