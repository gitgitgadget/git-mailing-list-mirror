From: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH] git-add--interactive: never skip files included in index
Date: Sat, 10 Oct 2009 18:51:45 +0300
Message-ID: <1255189906-16049-1-git-send-email-pav@iki.fi>
Cc: Pauli Virtanen <pav@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 10 18:04:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MweQs-00009K-AO
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 18:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756062AbZJJQEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2009 12:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754536AbZJJQEM
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 12:04:12 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:54677 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbZJJQEM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2009 12:04:12 -0400
X-Greylist: delayed 663 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Oct 2009 12:04:12 EDT
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id C5639EF454;
	Sat, 10 Oct 2009 18:52:30 +0300 (EEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A05E14906BC; Sat, 10 Oct 2009 18:52:30 +0300
Received: from localhost.localdomain (a91-152-176-153.elisa-laajakaista.fi [91.152.176.153])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id AD95A158A68;
	Sat, 10 Oct 2009 18:52:28 +0300 (EEST)
Received: by localhost.localdomain (Postfix, from userid 1001)
	id C2DB4141E16; Sat, 10 Oct 2009 18:52:26 +0300 (EEST)
X-Mailer: git-send-email 1.6.3.3
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129889>

Make "git add -p" to not skip files that are in index even if they are
excluded (by .gitignore etc.). This fixes the contradictory behavior
that "git status" and "git commit -a" listed such files as modified, but
"git add -p FILENAME" ignored them.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 git-add--interactive.perl  |    2 +-
 t/t3701-add-interactive.sh |   18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 392efb9..69aeaf0 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -259,7 +259,7 @@ sub list_modified {
 		@tracked = map {
 			chomp $_;
 			unquote_path($_);
-		} run_cmd_pipe(qw(git ls-files --exclude-standard --), @ARGV);
+		} run_cmd_pipe(qw(git ls-files --), @ARGV);
 		return if (!@tracked);
 	}
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 62fd65e..89bfdcb 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -138,6 +138,24 @@ test_expect_success 'real edit works' '
 	test_cmp expected output
 '
 
+cat >.gitignore <<EOF
+file
+EOF
+cat >file <<EOF
+changed
+EOF
+test_expect_success 'skip files similarly as commit -a' '
+	git reset
+	echo y | git add -p file &&
+	git diff >output &&
+	git reset &&
+	git commit -am commit &&
+	git diff >expected &&
+	test_cmp expected output &&
+	git reset --hard HEAD^
+'
+rm -f .gitignore
+
 if test "$(git config --bool core.filemode)" = false
 then
 	say 'skipping filemode tests (filesystem does not properly support modes)'
-- 
1.6.3.3
