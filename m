From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 1/2] t5520-pull: Add testcases showing spurious conflicts from git pull --rebase
Date: Sun,  8 Aug 2010 14:55:16 -0600
Message-ID: <1281300917-5610-2-git-send-email-newren@gmail.com>
References: <1281300917-5610-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, santi@agolina.net, Johannes.Schindelin@gmx.de,
	avarab@gmail.com, Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 08 22:47:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiCmh-00067j-Uu
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 22:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707Ab0HHUrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 16:47:42 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:59942 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154Ab0HHUrh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 16:47:37 -0400
Received: by pxi14 with SMTP id 14so3455744pxi.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 13:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Jif+r3oqzUUHPhHO/KQI59LX8ISjLA3jrMOcOotHRnM=;
        b=o8BSvDbM9AesOm32vPLkxQKp6tQJrYPSgo0TbkckqJBrWaT8/HkfTMr03Ai7uVBxRo
         O31erKhpAU74mx5N+XY8b98bubfeYOR8HNhky7wHwsKGcb4GY3K8enFZUXiL6sVUvQ9x
         fBBTY2YEWzueCVmV/IYIim0vOFzgG2DhDx4gs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Y2kge1y1zYXVEO5VGbvJOXpx7IY1XRItIJlUklqq2sue9+120HpBR3aXrqxjBanVIG
         PY3ORy20s4owGJILtH8kYoUwQ4oQzYWhEJJgLgGVM6zDTcwj8kGxuJ/5vfcsFSeFOh2D
         t4Ni6p0mlHoO5MWlNIjsofuqKBRCrLdyfjr2Q=
Received: by 10.142.132.18 with SMTP id f18mr12818969wfd.28.1281300457350;
        Sun, 08 Aug 2010 13:47:37 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id q27sm5555628wfc.18.2010.08.08.13.47.35
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 13:47:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.28.ga5061
In-Reply-To: <1281300917-5610-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152927>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t5520-pull.sh |   63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 319e389..9099e55 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -4,6 +4,11 @@ test_description='pulling into void'
 
 . ./test-lib.sh
 
+modify () {
+	sed -e "$1" < "$2" > "$2".x &&
+	mv "$2".x "$2"
+}
+
 D=`pwd`
 
 test_expect_success setup '
@@ -160,4 +165,62 @@ test_expect_success 'pull --rebase works on branch yet to be born' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup for detecting upstreamed changes' '
+	mkdir src &&
+	(cd src &&
+	 git init &&
+	 for i in $(seq 1 10); do echo $i; done > stuff &&
+	 git add stuff &&
+	 git commit -m "Initial revision"
+	) &&
+	git clone src dst &&
+	(cd src &&
+	 modify s/5/43/ stuff &&
+	 git commit -a -m "5->43" &&
+	 modify s/6/42/ stuff &&
+	 git commit -a -m "Make it bigger" &&
+	 correct=$(git rev-parse HEAD)
+	) &&
+	(cd dst &&
+	 modify s/5/43/ stuff &&
+	 git commit -a -m "Independent discovery of 5->43"
+	)
+'
+
+test_expect_failure 'git pull --rebase detects upstreamed changes' '
+	(cd dst &&
+	 git pull --rebase &&
+	 test -z "$(git ls-files -u)"
+	)
+'
+
+test_expect_success 'setup for avoiding reapplying old patches' '
+	(cd dst &&
+	 git rebase --abort;
+	 git reset --hard origin/master
+	) &&
+	git clone --bare src src-replace.git &&
+	rm -rf src &&
+	mv src-replace.git src &&
+	(cd dst &&
+	 modify s/2/22/ stuff &&
+	 git commit -a -m "Change 2" &&
+	 modify s/3/33/ stuff &&
+	 git commit -a -m "Change 3" &&
+	 modify s/4/44/ stuff &&
+	 git commit -a -m "Change 4" &&
+	 git push &&
+
+	 modify s/44/55/ stuff &&
+	 git commit --amend -a -m "Modified Change 4"
+	)
+'
+
+test_expect_failure 'git pull --rebase does not reapply old patches' '
+	(cd dst &&
+	 git pull --rebase;
+	 test 1 = $(find .git/rebase-apply -name "000*" | wc -l)
+	)
+'
+
 test_done
-- 
1.7.2.1
