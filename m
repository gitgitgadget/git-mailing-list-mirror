From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 1/2] t5520-pull: Add testcases showing spurious conflicts from git pull --rebase
Date: Sun,  8 Aug 2010 13:04:45 -0600
Message-ID: <1281294286-27709-2-git-send-email-newren@gmail.com>
References: <1281294286-27709-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, santi@agolina.net, Johannes.Schindelin@gmx.de,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 08 20:57:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiB3e-0008UE-MC
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 20:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124Ab0HHS5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 14:57:09 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:59573 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553Ab0HHS5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 14:57:07 -0400
Received: by pxi14 with SMTP id 14so3442635pxi.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 11:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OWA6z3Fmw0f89/4SQms4kBgsPPgNbxKomPfykWBDCqQ=;
        b=CcdfoKGikUaHxclsSHxvjIEi3pfxo7IVK6EBAN+MPUYNS8fHLPa5iEtKrvzmdU5xGH
         BrhW8WMtZo/f3xyAPOgXInPsseMRDRLbzDQHmXaSq2CNcvBiARDQYe25J2BgYpO+ct8G
         RA2S+2FZYf2X/7bG7S9Q7hmFdZRb02dNCbdX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OGwov5uKMkaFH8JbdylhPbSNPsX7MVEb0o2K8CBgS7bSjuaW4wg2seKYrulzfLg3Ao
         sVy+ZNx88H9GeXO+kIdzr3R1gLPWkDZtyhzs3Uuj6EYoHDXJ/UcjxzB2oAX+PGn7PvjE
         ZSg6QEI72w3RQDXjPNMzD+mLZhtMy4qaSn66A=
Received: by 10.142.148.10 with SMTP id v10mr12664893wfd.103.1281293827237;
        Sun, 08 Aug 2010 11:57:07 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id w27sm5425196wfd.5.2010.08.08.11.57.05
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 11:57:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.28.g92467.dirty
In-Reply-To: <1281294286-27709-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152919>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t5520-pull.sh |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 319e389..1624dd3 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -160,4 +160,62 @@ test_expect_success 'pull --rebase works on branch yet to be born' '
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
+	 perl -pi -e s/5/43/ stuff &&
+	 git commit -a -m "5->43" &&
+	 perl -pi -e s/6/42/ stuff &&
+	 git commit -a -m "Make it bigger" &&
+	 correct=$(git rev-parse HEAD)
+	) &&
+	(cd dst &&
+	 perl -pi -e s/5/43/ stuff &&
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
+	 (git rebase --abort || true) &&
+	 git reset --hard origin/master
+	) &&
+	git clone --bare src src-replace.git &&
+	rm -rf src &&
+	mv src-replace.git src &&
+	(cd dst &&
+	 perl -pi -e s/2/22/ stuff &&
+	 git commit -a -m "Change 2" &&
+	 perl -pi -e s/3/33/ stuff &&
+	 git commit -a -m "Change 3" &&
+	 perl -pi -e s/4/44/ stuff &&
+	 git commit -a -m "Change 4" &&
+	 git push &&
+
+	 perl -pi -e s/44/55/ stuff &&
+	 git commit --amend -a -m "Modified Change 4"
+	)
+'
+
+test_expect_failure 'git pull --rebase does not reapply old patches' '
+	(cd dst &&
+	 (git pull --rebase || true) &&
+	 test 1 = $(find .git/rebase-apply -name "000*" | wc -l)
+	)
+'
+
 test_done
-- 
1.7.2.1
