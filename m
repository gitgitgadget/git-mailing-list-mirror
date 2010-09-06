From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] t3404 & t7508: cd inside subshell instead of around
Date: Mon, 06 Sep 2010 20:41:06 +0200
Message-ID: <4C8535C2.5050203@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 20:41:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osgd2-0003Gy-1p
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 20:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229Ab0IFSlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 14:41:10 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:56146 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab0IFSlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 14:41:09 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 7481515EED5E6;
	Mon,  6 Sep 2010 20:41:07 +0200 (CEST)
Received: from [93.240.118.225] (helo=[192.168.178.29])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #24)
	id 1Osgct-0002C9-00; Mon, 06 Sep 2010 20:41:07 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+1nvYMXGn6fe24fBe6IfIouLi9ZN3QtEq61Uik
	ZiJ0tpo/ELXTm2CSkLQLeL8/+5YYEMg3rJ0ndTsVxKnaE/X4v+
	23kaYPxAbStcdgxDAIVA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155597>

Fixed all places where it was a straightforward change from cd'ing into a
directory and back via "cd .." to a cd inside a subshell.

Found these places with "git grep -w "cd \.\.".

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

This patch applies on top of master and contains the changes that don't
apply to maint.

 t/t3404-rebase-interactive.sh |    6 +++---
 t/t7508-status.sh             |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index af3b663..7d20a74 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -101,10 +101,10 @@ test_expect_success 'rebase -i with the exec command' '

 test_expect_success 'rebase -i with the exec command runs from tree root' '
 	git checkout master &&
-	mkdir subdir && cd subdir &&
+	mkdir subdir && (cd subdir &&
 	FAKE_LINES="1 exec_>touch-subdir" \
-		git rebase -i HEAD^ &&
-	cd .. &&
+		git rebase -i HEAD^
+	) &&
 	test_path_is_file touch-subdir &&
 	rm -fr subdir
 '
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 18b07d9..c9300f3 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -808,7 +808,7 @@ test_expect_success POSIXPERM,SANITY 'status succeeds in a read-only repository'
 	(exit $status)
 '

-(cd sm && echo > bar && git add bar && git commit -q -m 'Add bar' && cd .. && git add sm)
+(cd sm && echo > bar && git add bar && git commit -q -m 'Add bar') && git add sm
 new_head=$(cd sm && git rev-parse --short=7 --verify HEAD)
 touch .gitmodules

-- 
1.7.3.rc0.181.g885f40
