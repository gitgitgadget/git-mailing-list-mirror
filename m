From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 02/19] t5800: factor out some ref tests
Date: Wed,  8 Jun 2011 20:48:33 +0200
Message-ID: <1307558930-16074-3-git-send-email-srabbelier@gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>, "Jeff King" <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:50:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNpH-00087c-HA
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161Ab1FHStd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:49:33 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46492 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab1FHSt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:49:29 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so279690eyx.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=0ipRayK/xcptoAjZczfs5YiZdk7KE+WPNXwh5Lv+FvE=;
        b=LfRdTFOJ1qROkxvDnuPb9o2V27k+lXpi4yuCy9jLaDV5Yq7ANNs5pmKm6ryRM8e/AT
         Sr3C39l6EPja2DQrtxEfwwn64dPjQg3N/YnnTYUTP/ztIwV1UsrjHpei4C9W9UPpEoIq
         YN1aLrwxGK/JSa+0zhK/AlyxwxCL/BxmY0mRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Kc0JZJ2jp9yOw+0bbk5A7poG+P5mhH89cvNLGVNCHJNxF/MQSlHoGbb5H6Sb9oZMdz
         WR+CCghF8WDe0Yb9OkFdZW+fg52mU5FkGXC0fhe8ZBYMsVKvuabtw4i2EkTd/y7+7Clw
         3HTbBp+m72lITWq8mX8X2tbS29t2URmDGXbeQ=
Received: by 10.213.27.148 with SMTP id i20mr2134953ebc.145.1307558969080;
        Wed, 08 Jun 2011 11:49:29 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id b1sm729674eeg.19.2011.06.08.11.49.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 11:49:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175435>

From: Jeff King <peff@peff.net>

These are a little hard to read, and I'm about to add more
just like them. Plus the failure output is nicer if we use
test_cmp than a comparison with "test".

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged from Peff's series.

 t/t5800-remote-helpers.sh |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index 1fb6380..3a37ad0 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -17,6 +17,12 @@ then
 	test_set_prereq PYTHON_24
 fi
 
+compare_refs() {
+	git --git-dir="$1/.git" rev-parse --verify $2 >expect &&
+	git --git-dir="$3/.git" rev-parse --verify $4 >actual &&
+	test_cmp expect actual
+}
+
 test_expect_success PYTHON_24 'setup repository' '
 	git init --bare server/.git &&
 	git clone server public &&
@@ -59,8 +65,7 @@ test_expect_success PYTHON_24 'pushing to local repo' '
 	echo content >>file &&
 	git commit -a -m three &&
 	git push) &&
-	HEAD=$(git --git-dir=localclone/.git rev-parse --verify HEAD) &&
-	test $HEAD = $(git --git-dir=server/.git rev-parse --verify HEAD)
+	compare_refs localclone HEAD server HEAD
 '
 
 test_expect_success PYTHON_24 'synch with changes from localclone' '
@@ -73,8 +78,7 @@ test_expect_success PYTHON_24 'pushing remote local repo' '
 	echo content >>file &&
 	git commit -a -m four &&
 	git push) &&
-	HEAD=$(git --git-dir=clone/.git rev-parse --verify HEAD) &&
-	test $HEAD = $(git --git-dir=server/.git rev-parse --verify HEAD)
+	compare_refs clone HEAD server HEAD
 '
 
 test_done
-- 
1.7.5.1.292.g728120
