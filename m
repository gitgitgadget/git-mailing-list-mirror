From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 1/3] t6022: New test checking for unnecessary updates of renamed+modified files
Date: Wed,  2 Mar 2011 23:13:10 -0700
Message-ID: <1299132792-17497-2-git-send-email-newren@gmail.com>
References: <1299132792-17497-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 03 07:13:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pv1n0-0003hV-2u
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 07:13:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150Ab1CCGNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 01:13:18 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47814 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055Ab1CCGNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 01:13:16 -0500
Received: by qyk7 with SMTP id 7so4980088qyk.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 22:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=97sGC+CBYb21MD/mbo0IlpPSGIY3DlrmfhU9c1s1RWU=;
        b=lO/PB9EOX3lD3TBJReGbq90/jI8rhyh7EzQgAOIU/ytbemRsXU4NZnpXajji7FLEVe
         Fpj00ZiCC61pldASydPQIgR2D/NJtrEhXa4tUyMQbismzKwLovU+G3v62yMmnTpm+KGH
         7llmn6y975WcHtF9/q8k7U2vzevuDhS5b7xRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=s0ghkHgNks7Q+Z9RWPf5gatauLWvxFqti03YsBbIwb9a3/Km8FwvSzQdF6qN/d4/Lz
         KyvuTG5szoBmptE/4j92TDj4xxYmwa5jYkjFH/mz5+Yfhz6Ck/8M6OS1REwbInigK+lI
         6gs9BnKuOFRm0DBT0S2IKKXfCzoEmoWtgPLJA=
Received: by 10.229.188.144 with SMTP id da16mr573778qcb.158.1299132795281;
        Wed, 02 Mar 2011 22:13:15 -0800 (PST)
Received: from Miney.hsd1.nm.comcast.net. (c-174-56-87-200.hsd1.nm.comcast.net [174.56.87.200])
        by mx.google.com with ESMTPS id s32sm402361qco.38.2011.03.02.22.13.12
        (version=SSLv3 cipher=OTHER);
        Wed, 02 Mar 2011 22:13:14 -0800 (PST)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1299132792-17497-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168377>


Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Jeff King <peff@peff.net>
---
 t/t6022-merge-rename.sh |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 1ed259d..16330a6 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -609,4 +609,35 @@ test_expect_success 'check handling of differently renamed file with D/F conflic
 	! test -f original
 '
 
+test_expect_success 'setup avoid unnecessary update, normal rename' '
+	git reset --hard &&
+	git checkout --orphan avoid-unnecessary-update-1 &&
+	git rm -rf . &&
+	git clean -fdqx &&
+
+	printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" >original &&
+	git add -A &&
+	git commit -m "Common commmit" &&
+
+	git mv original rename &&
+	echo 11 >>rename &&
+	git add -u &&
+	git commit -m "Renamed and modified" &&
+
+	git checkout -b merge-branch-1 HEAD~1 &&
+	echo "random content" >random-file &&
+	git add -A &&
+	git commit -m "Random, unrelated changes"
+'
+
+test_expect_failure 'avoid unnecessary update, normal rename' '
+	git checkout -q avoid-unnecessary-update-1^0 &&
+	test-chmtime =1 rename &&
+	test-chmtime -v +0 rename >expect &&
+	git merge merge-branch-1 &&
+	git diff-files --exit-code &&   # Is "rename" clean, or stat dirty?
+	test-chmtime -v +0 rename >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.4
