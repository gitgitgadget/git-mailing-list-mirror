From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] rebase -i: demonstrate incorrect behavior of
 post-rewrite
Date: Fri, 22 May 2015 13:15:50 +0000
Message-ID: <0000014d7bc3f7a5-332dd95f-907f-4f46-a5d6-6b9e5dc70b0a-000000@eu-west-1.amazonses.com>
References: <0000014d7bc3f6bf-72bd5f07-9e26-411a-8484-e9b86a1bf429-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_8_693652891.1432300550013"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 22 15:35:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvn6e-0001F3-Gj
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 15:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946140AbbEVNfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 09:35:15 -0400
Received: from a6-243.smtp-out.eu-west-1.amazonses.com ([54.240.6.243]:56787
	"EHLO a6-243.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946125AbbEVNfN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2015 09:35:13 -0400
X-Greylist: delayed 1161 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 May 2015 09:35:13 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1432300550;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Date:Feedback-ID;
	bh=Aw7Z8HV9lyOOrXYY1xFtHx4eF5+h1X2zNqXxxsv4xlE=;
	b=LrXaGbuMqfzArtWTvnZg2PH4CMCjf5GnM00YYxfvE59EmdC0L7xFTiBoTQDUxHvO
	9yuMoeKGe5KedlK78WBdh5cjHxQqHmEvckMVRdBYdmYZr67XCWKVVvYvQ3Smq+j4XXD
	PlnBhp9swo5RJVVF0fdyuBb01YYqr51l8V+Ilo5M=
In-Reply-To: <0000014d7bc3f6bf-72bd5f07-9e26-411a-8484-e9b86a1bf429-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2015.05.22-54.240.6.243
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269714>

------=_Part_8_693652891.1432300550013
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The 'exec' command is sending the current commit to stopped-sha, which is
supposed to contain the original commit (before rebase). As a result, if
an 'exec' command fails, the next 'git rebase --continue' will send the
current commit as <old-sha1> to the post-rewrite hook.

The test currently fails with :

--- expected.data       2015-05-21 17:55:29.000000000 +0000
+++ [...]post-rewrite.data      2015-05-21 17:55:29.000000000 +0000
@@ -1,2 +1,3 @@
 2362ae8e1b1b865e6161e6f0e165ffb974abf018 488028e9fac0b598b70cbeb594258a917e3f6fab
+488028e9fac0b598b70cbeb594258a917e3f6fab 488028e9fac0b598b70cbeb594258a917e3f6fab
 babc8a4c7470895886fc129f1a015c486d05a351 8edffcc4e69a4e696a1d4bab047df450caf99507
---
 t/t5407-post-rewrite-hook.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index ea2e0d4..53a4062 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -212,4 +212,21 @@ EOF
 	verify_hook_input
 '
 
+test_expect_failure 'git rebase -i (exec)' '
+	git reset --hard D &&
+	clear_hook_input &&
+	FAKE_LINES="edit 1 exec_false 2" git rebase -i B &&
+	echo something >bar &&
+	git add bar &&
+	# Fails because of exec false
+	test_must_fail git rebase --continue &&
+	git rebase --continue &&
+	echo rebase >expected.args &&
+	cat >expected.data <<EOF &&
+$(git rev-parse C) $(git rev-parse HEAD^)
+$(git rev-parse D) $(git rev-parse HEAD)
+EOF
+	verify_hook_input
+'
+
 test_done


---
https://github.com/git/git/pull/138
------=_Part_8_693652891.1432300550013--
