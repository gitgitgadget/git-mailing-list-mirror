From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 1/2] t5520-pull: Add testcases showing spurious conflicts from git pull --rebase
Date: Wed, 11 Aug 2010 23:56:08 -0600
Message-ID: <1281592569-740-2-git-send-email-newren@gmail.com>
References: <1281592569-740-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, santi@agolina.net, Johannes.Schindelin@gmx.de,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 12 07:48:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjQeI-00079X-Uq
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 07:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142Ab0HLFsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 01:48:12 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59497 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab0HLFsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 01:48:09 -0400
Received: by qwh6 with SMTP id 6so1046824qwh.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 22:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=VSl2ZTQNSaLe/7JT7mLRW54XKcjLd6SKrkfF8QfHLGw=;
        b=HPSz6cSZQnDuiE3jsvQlDkczRUl/QRU/fOXO7UzwcJNev6qiwOq3CU/z882YTsDYqX
         /8oGsRRUlSOSoSE8Ai8qxO+M60BvcpdpsMN4W31pliiGBw6uRN4HW5L/isyCWybvuPve
         XuPIiSuxZzRjAyXegoTQYLpO/hmXMFch1qgLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TKVRjzCr7xVhi/I0iNG58U3hSVFqGeFOwzOaG8hY12WJc8zBu9B+pMK0In2kfGVE2L
         JMNE5+i5HjIE70FrtHrV5aZIfL58zCwIDogIf7V7k3EMUxjef8RygV1WUYtIw1sw86RI
         4YtQzXX55ydDAI5MRl1pa1ifS7wEth3bMdxPE=
Received: by 10.224.97.15 with SMTP id j15mr11624398qan.199.1281592088929;
        Wed, 11 Aug 2010 22:48:08 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id t24sm1436480qcs.47.2010.08.11.22.48.06
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 22:48:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.43.gbae63
In-Reply-To: <1281592569-740-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153341>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t5520-pull.sh |   62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 319e389..85a6b23 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -4,6 +4,11 @@ test_description='pulling into void'
 
 . ./test-lib.sh
 
+modify () {
+	sed -e "$1" <"$2" >"$2.x" &&
+	mv "$2.x" "$2"
+}
+
 D=`pwd`
 
 test_expect_success setup '
@@ -160,4 +165,61 @@ test_expect_success 'pull --rebase works on branch yet to be born' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup for detecting upstreamed changes' '
+	mkdir src &&
+	(cd src &&
+	 git init &&
+	 printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" > stuff &&
+	 git add stuff &&
+	 git commit -m "Initial revision"
+	) &&
+	git clone src dst &&
+	(cd src &&
+	 modify s/5/43/ stuff &&
+	 git commit -a -m "5->43" &&
+	 modify s/6/42/ stuff &&
+	 git commit -a -m "Make it bigger"
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
+	 test_might_fail git rebase --abort &&
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
+	 test_must_fail git pull --rebase &&
+	 test 1 = $(find .git/rebase-apply -name "000*" | wc -l)
+	)
+'
+
 test_done
-- 
1.7.2.1.43.gbae63
