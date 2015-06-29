From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 7/7] git-stash: use git-reflog instead of creating files
Date: Mon, 29 Jun 2015 13:54:28 -0400
Message-ID: <1435600468-21710-8-git-send-email-dturner@twopensource.com>
References: <1435600468-21710-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Jun 29 19:55:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9dGs-0005zR-6i
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 19:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469AbbF2RzC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 13:55:02 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36399 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbbF2Ryr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 13:54:47 -0400
Received: by qkei195 with SMTP id i195so59870924qke.3
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 10:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aKLlaPvfhCgNc6vSEn1s1yrozYxIpPXu5+lgAmPVl7E=;
        b=eb+vVVj1lYUrW0TC0+kXI3bv+04hhgLA9fVLFSlz2rWqW3QQPFrY0yESI5gyGtnCe6
         iWIRJGZJC/w2YqDvKTJoMFqxWLDqB1vKqkt/I20ys/rxBn6tsgof9wotQFodhCOjoj4Y
         LuoqbwBr4bk2BApxtoiilbVY4gkTK+dwaPLXi4AaZXiZtaPg0KPhqTMQlXcwmnCLbZSX
         r68UOlisdtOeQtKD8aTbbZikthvDSjTArauzFzWwfAcUQITttg0kV+22145B3YToiR9u
         Ymd9Be2thhDi2Gescs3k5eTWdgfDJne3UBaceW6nyuK/2S17KzskLvaCLbgpxsCotBT8
         0tFg==
X-Gm-Message-State: ALoCoQlLOPT0aFO4XJDJ9mJAkSM0Qr+VTG5ep+J37lLl2HELQsZQibJ6CjNAnr6oYS4AZYx8ekdO
X-Received: by 10.140.238.22 with SMTP id j22mr21381564qhc.98.1435600486180;
        Mon, 29 Jun 2015 10:54:46 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by mx.google.com with ESMTPSA id w67sm11860026qgw.41.2015.06.29.10.54.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jun 2015 10:54:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1435600468-21710-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272986>

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
index 0ece8f2..813b1fc 100644
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
