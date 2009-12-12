From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/3] octopus: reenable fast-forward merges
Date: Fri, 11 Dec 2009 16:38:58 -0800
Message-ID: <1260578339-30750-2-git-send-email-bebarino@gmail.com>
References: <87zl5p1gsp.fsf@jondo.cante.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 12 01:39:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJG0t-0006zo-LM
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 01:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761432AbZLLAjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 19:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758460AbZLLAi7
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 19:38:59 -0500
Received: from mail-gx0-f212.google.com ([209.85.217.212]:58000 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761258AbZLLAi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 19:38:58 -0500
Received: by mail-gx0-f212.google.com with SMTP id 4so1681109gxk.8
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 16:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8fnsU8SY1wsNcsCHqlSy7zZ4IlJs9TCSdSAJAn4agLQ=;
        b=b7l1BPjZ5JcmTIqwlm8Sx1DZCwuOShxMd1sqZkcrVZsPuO0GDgXjkPmYZ+D2E+nl0z
         idMLZkkIybEummFa2Wb4ASPSL9SWLjLUUskshByuWn9vDVLtQgSCKUImn5N7PzJhNqcX
         qygiYtDAI3OL90ZjZozFFi46Whn67fc6Locu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Q9HByUn9f0pzgeWLcyZG+f2xJ0AnRGxeKgfTA0y01izHzPAE4FT1CkistpIimNuPZ/
         HgcaI3dW5Adrr2+bmEmVyUvxYhqvF72A+ao14ZHKDzxvbRud8UxD2imV1p6RDOxj8xKy
         +KEzZE1GUjSp5+96weydD2QU0Cf/4rxiNjLwU=
Received: by 10.101.175.15 with SMTP id c15mr3316518anp.84.1260578345416;
        Fri, 11 Dec 2009 16:39:05 -0800 (PST)
Received: from localhost (cpe-72-129-49-143.socal.res.rr.com [72.129.49.143])
        by mx.google.com with ESMTPS id 23sm1514334iwn.3.2009.12.11.16.39.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Dec 2009 16:39:04 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc1.45.g9aadbb
In-Reply-To: <87zl5p1gsp.fsf@jondo.cante.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135108>

The fast-forward logic is never being triggered because $common and
$MRC are never equivalent. $common is initialized to a commit id by
merge-base and MRC is initialized to HEAD. Fix this by initializing
$MRC to the commit id for HEAD so that its possible for $MRC and
$common to be equal.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Found this while making tests up for part 1 of this series.

 git-merge-octopus.sh          |    2 +-
 t/t7602-merge-octopus-many.sh |   18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
index 1c8ee0a..99b6f8a 100755
--- a/git-merge-octopus.sh
+++ b/git-merge-octopus.sh
@@ -44,7 +44,7 @@ esac
 # MRC is the current "merge reference commit"
 # MRT is the current "merge result tree"
 
-MRC=$head MSG= PARENT="-p $head"
+MRC=$(git rev-parse --verify -q $head) MSG= PARENT="-p $head"
 MRT=$(git write-tree)
 CNT=1 ;# counting our head
 NON_FF_MERGE=0
diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many.sh
index 7377033..2746169 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -82,4 +82,22 @@ test_expect_success 'merge up-to-date output uses pretty names' '
 	git merge c4 c5 >actual &&
 	test_cmp actual expected
 '
+
+cat >expected <<\EOF
+Fast-forwarding to: c1
+Trying simple merge with c2
+Merge made by octopus.
+ c1.c |    1 +
+ c2.c |    1 +
+ 2 files changed, 2 insertions(+), 0 deletions(-)
+ create mode 100644 c1.c
+ create mode 100644 c2.c
+EOF
+
+test_expect_success 'merge fast-forward output uses pretty names' '
+	git reset --hard c0 &&
+	git merge c1 c2 >actual &&
+	test_cmp actual expected
+'
+
 test_done
-- 
1.6.6.rc1.45.g9aadbb
