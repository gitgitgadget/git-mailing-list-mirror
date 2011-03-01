From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 2/3] t6022: New test checking for unnecessary updates of files in D/F conflicts
Date: Mon, 28 Feb 2011 18:08:51 -0700
Message-ID: <1298941732-19763-3-git-send-email-newren@gmail.com>
References: <1298941732-19763-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, Stephen Rothwell <sfr@canb.auug.org.au>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 02:09:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuE5O-0004v0-Ll
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 02:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986Ab1CABJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 20:09:04 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54983 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507Ab1CABJA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 20:09:00 -0500
Received: by eyx24 with SMTP id 24so1504622eyx.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 17:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=lFChRitKaCDxeOCJnuDitw3oXmQXlJxoP/EQF5fXE60=;
        b=uZ6KjZ1XPsRLlnlbhI8gfx1MufSeSkieGC8VKPLlhdFIbG0gEA2ua5fqR9nqTG/duz
         PDufkSFgTW6vDNjjufW8DE1SXG5VAnRM/Ae8UwvDDfbCdmzFdMINAZUiuWAwbzeIZ7Sf
         gvm4b7eIuKlKmQ+rimw0gSOhXudUU9Dkfgdoo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cN/ZjYVROwmviQX4TiKr9cRuibtSoYEU9drfmfFcTkvi7BE+Lf7FNXUr+Hw9arKyG0
         XWpP/7vAZvbVVgtqxRrd58Cbt/F9IuKhHxdI2Mfux4HWiIE8v2ba/WspJag1u5nHrQ67
         SvG1rNwpcr2p7yPtbfj7gOyp7ZD5HAgoG1gnY=
Received: by 10.213.114.78 with SMTP id d14mr73092ebq.93.1298941739174;
        Mon, 28 Feb 2011 17:08:59 -0800 (PST)
Received: from Miney.hsd1.nm.comcast.net. (c-174-56-87-200.hsd1.nm.comcast.net [174.56.87.200])
        by mx.google.com with ESMTPS id q52sm3692922eei.9.2011.02.28.17.08.56
        (version=SSLv3 cipher=OTHER);
        Mon, 28 Feb 2011 17:08:58 -0800 (PST)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1298941732-19763-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168175>

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6022-merge-rename.sh |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 3667e18..a5d252b 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -641,4 +641,40 @@ test_expect_failure 'avoid unnecessary update, normal rename' '
 	git diff-files --exit-code # Is "rename" clean, or only racily clean?
 '
 
+test_expect_success 'setup avoid unnecessary update, with D/F conflict' '
+	git reset --hard &&
+	git checkout --orphan avoid-unnecessary-update-2 &&
+	git rm -rf . &&
+	git clean -fdqx &&
+
+	mkdir df &&
+	printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" >df/file &&
+	git add -A &&
+	git commit -m "Common commmit" &&
+
+	git mv df/file temp &&
+	rm -rf df &&
+	git mv temp df &&
+	echo 11 >>df &&
+	git add -u &&
+	git commit -m "Renamed and modified" &&
+
+	git checkout -b merge-branch-2 HEAD~1 &&
+	>unrelated-change &&
+	git add unrelated-change &&
+	git commit -m "Only unrelated changes"
+'
+
+test_expect_failure 'avoid unnecessary update, with D/F conflict' '
+	git checkout -q avoid-unnecessary-update-2^0 &&
+	touch -t 197001010000.01 df &&
+	orig=$(stat --format="%Y" df) &&
+	git merge merge-branch-2 &&
+	new=$(stat --format="%Y" df) &&
+	echo "Checking whether stat times are same: $orig vs $new" &&
+	test "$orig" == "$new" &&
+	git diff-files --exit-code # Is "rename" clean, or only racily clean?
+'
+
+
 test_done
-- 
1.7.4
