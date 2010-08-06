From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/2] t5520-pull: Add testcases showing spurious conflicts from git pull --rebase
Date: Fri,  6 Aug 2010 08:05:02 -0600
Message-ID: <1281103503-27515-2-git-send-email-newren@gmail.com>
References: <1281103503-27515-1-git-send-email-newren@gmail.com>
Cc: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>,
	gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 06 16:03:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhNWR-00022O-9k
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 16:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186Ab0HFODc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 10:03:32 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59052 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756922Ab0HFOD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 10:03:27 -0400
Received: by wwj40 with SMTP id 40so9083219wwj.1
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 07:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Arq3e6W5d/P3rHbBCxms/+sah/X8O2VYUjXCmi9F100=;
        b=Fkskx6A77TAvGfuQahuf10GBpo05ThpjWWBGrkZWLD1fRZYOQPRrTIfyPwWUopQqsM
         grI4tGEWrUs4dwGk5vNUfLODZDe1OQ7buRyBp0Yllf5qu3dyp3BrTvAjsdsbQeSJkzlP
         GH6m2FnqSVA9m6JjjxtzPSX9t6VepDwTUayhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=P2BIBTsK8tuC9KTvRuX/hNmBODq8QNb9LJYRIpSefsfy7WM5Z8laiYzIaN4Yi01awq
         VUthV9bEPziNmv+MWwpAiiO6XhDy3mjmGU286J+zzVrOGlJ1OShEEQyNeJaKU+s72V6u
         6R5vpdP3x5dDDri6CV2SPldMbQevfTTQqPeG4=
Received: by 10.227.147.204 with SMTP id m12mr10725817wbv.131.1281103406432;
        Fri, 06 Aug 2010 07:03:26 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o84sm867954wej.13.2010.08.06.07.03.23
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 07:03:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1281103503-27515-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152784>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t5520-pull.sh |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 319e389..8f76829 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -160,4 +160,63 @@ test_expect_success 'pull --rebase works on branch yet to be born' '
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
+	 sed -i s/5/43/ stuff &&
+	 git commit -a -m "5->43" &&
+	 sed -i s/6/42/ stuff &&
+	 git commit -a -m "Make it bigger" &&
+	 correct=$(git rev-parse HEAD)
+	) &&
+	(cd dst &&
+	 sed -i s/5/43/ stuff &&
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
+	 sed -i s/2/22/ stuff &&
+	 git commit -a -m "Change 2" &&
+	 sed -i s/3/33/ stuff &&
+	 git commit -a -m "Change 3" &&
+	 sed -i s/4/44/ stuff &&
+	 git commit -a -m "Chagne 4" &&
+	 git push &&
+
+	 sed -i s/44/55/ stuff &&
+	 git commit --amend -a -m "Change 4" &&
+	 test_must_fail git push
+	)
+'
+
+test_expect_failure 'git pull --rebase does not reapply old patches' '
+	(cd dst &&
+	 (git pull --rebase || true) &&
+	 test 3 != $(find .git/rebase-apply -name "000*" | wc -l)
+	)
+'
+
 test_done
-- 
1.7.1.1
