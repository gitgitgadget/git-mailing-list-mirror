From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] git-am: record full index line in the patch used while
 rebasing
Date: Thu, 31 Jan 2013 20:32:03 -0800
Message-ID: <1359693125-22357-2-git-send-email-gitster@pobox.com>
References: <20130130224904.GB1053@book.hvoigt.net>
 <1359693125-22357-1-git-send-email-gitster@pobox.com>
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 01 05:32:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U18Is-0002r0-RM
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 05:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063Ab3BAEcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 23:32:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57499 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752492Ab3BAEcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 23:32:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F914C7FC;
	Thu, 31 Jan 2013 23:32:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=UAue
	ogMsKdS63ePE+il2UuEsjaY=; b=vBgBrXUCME4VtoVaIUEIcs2Xxb39rm/y+Da/
	+Iv2VpWDf1ccCRuNF1f/QaWB4DhEBJl+mnXsf5crRN9XhThvbBmdRVBvFl2jwJ2m
	PYGO4JGW8MVAHGXVR2K4FiHxGKG+V9TU6x7eIVEBpLvuPILH7Wju8KICsyf/jEN0
	ARHFa7k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	nHjQdfUvbJP9fHeg3VE4rlOptirUP+Ujqw9BRgytvFe1lCPiRJTaTmcOvk86hYqu
	Pskj65qpxayaQbdam4o8oAxQXXXlUeO0IA/B67o8rwIAC+mWAa52BeaPO7sub1YK
	huWHxhhi/aXjBUbvP4mAHnL6TFVku9wQCTL8ian9/9A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54132C7FB;
	Thu, 31 Jan 2013 23:32:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C3DAC7F9; Thu, 31 Jan 2013
 23:32:08 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.612.g09f4be5
In-Reply-To: <1359693125-22357-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 56DECB40-6C28-11E2-931D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215199>

Earlier, a230949 (am --rebasing: get patch body from commit, not
from mailbox, 2012-06-26) learned to regenerate patch body from the
commit object while rebasing, instead of reading from the rebase-am
front-end.  While doing so, it used "git diff-tree" but without
giving it the "--full-index" option.

This does not matter for in-repository objects; during rebasing, any
abbreviated object name should uniquely identify them.

But we may be rebasing a commit that contains a change to a gitlink,
in which case we usually should not have the object (it names a
commit in the submodule).  A full object name is necessary to later
reconstruct a fake ancestor index for them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-am.sh                   |  2 +-
 t/t7402-submodule-rebase.sh | 30 ++++++++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index c682d34..0e0a096 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -664,7 +664,7 @@ do
 			sed -e '1,/^$/d' >"$dotest/msg-clean"
 			echo "$commit" >"$dotest/original-commit"
 			get_author_ident_from_commit "$commit" >"$dotest/author-script"
-			git diff-tree --root --binary "$commit" >"$dotest/patch"
+			git diff-tree --root --binary --full-index "$commit" >"$dotest/patch"
 		else
 			git mailinfo $keep $no_inbody_headers $scissors $utf8 "$dotest/msg" "$dotest/patch" \
 				<"$dotest/$msgnum" >"$dotest/info" ||
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
index f919c8d..8e32f19 100755
--- a/t/t7402-submodule-rebase.sh
+++ b/t/t7402-submodule-rebase.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2008 Johannes Schindelin
 #
 
-test_description='Test rebasing and stashing with dirty submodules'
+test_description='Test rebasing, stashing, etc. with submodules'
 
 . ./test-lib.sh
 
@@ -20,7 +20,8 @@ test_expect_success setup '
 	echo second line >> file &&
 	(cd submodule && git pull) &&
 	test_tick &&
-	git commit -m file-and-submodule -a
+	git commit -m file-and-submodule -a &&
+	git branch added-submodule
 
 '
 
@@ -89,4 +90,29 @@ test_expect_success 'stash with a dirty submodule' '
 
 '
 
+test_expect_success 'rebasing submodule that should conflict' '
+	git reset --hard &&
+	git checkout added-submodule &&
+	git add submodule &&
+	test_tick &&
+	git commit -m third &&
+	(
+		cd submodule &&
+		git commit --allow-empty -m extra
+	) &&
+	git add submodule &&
+	test_tick &&
+	git commit -m fourth &&
+
+	test_must_fail git rebase --onto HEAD^^ HEAD^ HEAD^0 &&
+	git ls-files -s submodule >actual &&
+	(
+		cd submodule &&
+		echo "160000 $(git rev-parse HEAD^) 1	submodule" &&
+		echo "160000 $(git rev-parse HEAD^^) 2	submodule" &&
+		echo "160000 $(git rev-parse HEAD) 3	submodule"
+	) >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.1.2.612.g09f4be5
