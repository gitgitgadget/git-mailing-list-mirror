From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9 7/7] git-stash: use update-ref --create-reflog instead of creating files
Date: Tue, 21 Jul 2015 11:45:04 -0400
Message-ID: <1437493504-3699-8-git-send-email-dturner@twopensource.com>
References: <1437493504-3699-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jul 21 17:45:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHZjW-0003yK-7e
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 17:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933158AbbGUPpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 11:45:21 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:36531 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932967AbbGUPpT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 11:45:19 -0400
Received: by qgy5 with SMTP id 5so89598114qgy.3
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 08:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IFenvd80v3Ps2BSirFnfwze16NizSmA79bt9YKEe6LI=;
        b=ZhXCxMQShhGVjZtiq3QUdegg/9lis2UcOKoW+7U4o1jYDHolVtC0t+bhzuxHutG7hB
         4oKHyXPvMeM25pRxZV1sV4vnf5GqHA9HLJUv3tZeiq3no5tSn/uM/7T/Qavx6pSyM6oe
         +odsFQJgjs+USXXD2kJYG6zNmmLiF0aul8/j8C70T7XZtNhKu/voSSVdh1B/9gD7IkQo
         Ulwsoo55p/bcD4ghJQgIVOFywSBLBCKUkDw8K0dk253/dWr8nMHDLVgX1gXiZqV2ndel
         9F9l6DFFd5gu8J22S2nxi+lqr8qHuHTpr0gQuQtb5/apkMA+NQQm1+cSzNygqemiI0Pe
         iWPw==
X-Gm-Message-State: ALoCoQnfKJXwUBSr/G3Bwtlevia59h3ovFEKdXx2Qg/eZBQbqsKfX0g8a5U67IT5w7tZs6kN918A
X-Received: by 10.55.48.18 with SMTP id w18mr55614195qkw.34.1437493518746;
        Tue, 21 Jul 2015 08:45:18 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g33sm12941288qgg.4.2015.07.21.08.45.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jul 2015 08:45:17 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.586.g889ef79-twtrsrc
In-Reply-To: <1437493504-3699-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274382>

This is in support of alternate ref backends which don't necessarily
store reflogs as files.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 git-stash.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 8e9e2cd..1d5ba7a 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -183,9 +183,7 @@ store_stash () {
 		stash_msg="Created via \"git stash store\"."
 	fi
 
-	# Make sure the reflog for stash is kept.
-	: >>"$(git rev-parse --git-path logs/$ref_stash)"
-	git update-ref -m "$stash_msg" $ref_stash $w_commit
+	git update-ref --create-reflog -m "$stash_msg" $ref_stash $w_commit
 	ret=$?
 	test $ret != 0 && test -z $quiet &&
 	die "$(eval_gettext "Cannot update \$ref_stash with \$w_commit")"
@@ -262,7 +260,7 @@ save_stash () {
 		say "$(gettext "No local changes to save")"
 		exit 0
 	fi
-	test -f "$(git rev-parse --git-path logs/$ref_stash)" ||
+	git reflog exists $ref_stash ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
 	create_stash "$stash_msg" $untracked
-- 
2.4.2.586.g889ef79-twtrsrc
