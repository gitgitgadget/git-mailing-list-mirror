From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 7/7] git-stash: use git-reflog instead of creating files
Date: Mon, 29 Jun 2015 16:17:56 -0400
Message-ID: <1435609076-8592-8-git-send-email-dturner@twopensource.com>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Jun 29 22:19:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9fWT-0006v3-39
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 22:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560AbbF2UTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 16:19:08 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:35711 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbbF2USv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 16:18:51 -0400
Received: by qget71 with SMTP id t71so13999622qge.2
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 13:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YY54OJfuH4GS9L0+YKoYuEqLpsvc035ykms0n+8g93o=;
        b=jUGPdJzB3eEvRIDrzEs3skYizqTNis8RL9aON2PgOrxMbcaJ+rQHMYWT+BipuZXdBz
         VM367TlTj5pWKKjGyMAxqh1/NVwurefafucvhbsCr13LYGBxNv2j43yq7LJ5zr2JsbJC
         O0EuqUXPxJhRx+C2qMpfFrIDsJA5bYWGIsDEMBvua/OdodrfO6e1+7gIT0YXRJm0+G/W
         AXTh2z515Y4yA9IiYF01hICoFS0s3lLYz3gvvPBqTsuvEuEN70E33ZgKx2eabsNgDjIG
         /sRKstiDEKQWzrvn6zDEwLjGUPy06Cz5ecs1SeIT3q5DkJWCgylZH/wiPEriHJ27HbHd
         qIEw==
X-Gm-Message-State: ALoCoQlNyljCM44ESgghtuRndDW7ha7BITqyw0rLbsIsuBKp1wvZdWdNH1w6RMkt9qak1hLBixQ5
X-Received: by 10.55.24.94 with SMTP id j91mr7107509qkh.54.1435609128624;
        Mon, 29 Jun 2015 13:18:48 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by mx.google.com with ESMTPSA id 139sm11906090qhx.22.2015.06.29.13.18.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jun 2015 13:18:47 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273008>

This is in support of alternate ref backends which don't necessarily
store reflogs as files.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 git-stash.sh | 4 ++--
 refs.c       | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 8e9e2cd..27155bc 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -184,7 +184,7 @@ store_stash () {
 	fi
 
 	# Make sure the reflog for stash is kept.
-	: >>"$(git rev-parse --git-path logs/$ref_stash)"
+	git reflog create "$ref_stash"
 	git update-ref -m "$stash_msg" $ref_stash $w_commit
 	ret=$?
 	test $ret != 0 && test -z $quiet &&
@@ -262,7 +262,7 @@ save_stash () {
 		say "$(gettext "No local changes to save")"
 		exit 0
 	fi
-	test -f "$(git rev-parse --git-path logs/$ref_stash)" ||
+	git reflog exists $ref_stash ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
 	create_stash "$stash_msg" $untracked
diff --git a/refs.c b/refs.c
index 1e53ef0..0f240c9 100644
--- a/refs.c
+++ b/refs.c
@@ -3125,6 +3125,7 @@ static int should_autocreate_reflog(const char *refname)
 	return starts_with(refname, "refs/heads/") ||
 		starts_with(refname, "refs/remotes/") ||
 		starts_with(refname, "refs/notes/") ||
+		!strcmp(refname, "refs/stash") ||
 		!strcmp(refname, "HEAD");
 }
 
-- 
2.0.4.315.gad8727a-twtrsrc
