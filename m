From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 6/6] git-stash: use git-reflog instead of creating files
Date: Thu, 25 Jun 2015 16:45:10 -0400
Message-ID: <1435265110-6414-6-git-send-email-dturner@twopensource.com>
References: <1435265110-6414-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jun 25 22:45:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8E1o-0006BT-3w
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 22:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbbFYUpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 16:45:39 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36045 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbbFYUpc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 16:45:32 -0400
Received: by iecvh10 with SMTP id vh10so62848950iec.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 13:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ChSQlP3sCp8rFajz5TH+TrTCYYD13e0rZxBQIT6FB24=;
        b=KEnI38k+tbBnnp/DYXI9RivrkPjN+73Gp0RYvqIY13wcY7K4UZhNi/DB7Gy8YsCDAq
         g494D2FDoL1NaambHGrpowRpTUpedIJ2u4CPhZaHbPhrHdUfaFhWQt4KRnLRamC9Vlqe
         WoRVPo8KiO0OFe2LJ/UbMw2U8/dPZ8h/up+xDUJSLSl5yHHLnD31xkQqil5QOYJlXTGa
         1FWrMst2uXEyh9mCQFhvDJVNtJPCU9ERu1LY+nBdteFsFItJiPAZVDYt7Xi7C2K02KaG
         J/lAhiXVYLmeluno890lvzF5840WFofLwi26VfVwEdfmFa/L7AMNTzlcH0R+8MZE8DFM
         mnJQ==
X-Gm-Message-State: ALoCoQl6UvesMVZE31cBnGV1TaDEuJZjnZsqOSNWo/0vsgaI+k9HsGphihFGB1s/qvO69qSLw8hp
X-Received: by 10.50.111.167 with SMTP id ij7mr6554568igb.49.1435265131757;
        Thu, 25 Jun 2015 13:45:31 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id fv2sm4042683igb.22.2015.06.25.13.45.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 13:45:30 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.314.gdbf7a51-twtrsrc
In-Reply-To: <1435265110-6414-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272729>

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
index 7b02c45..e11a32b 100644
--- a/refs.c
+++ b/refs.c
@@ -3123,6 +3123,7 @@ static int should_autocreate_reflog(const char *refname)
 	return starts_with(refname, "refs/heads/") ||
 		starts_with(refname, "refs/remotes/") ||
 		starts_with(refname, "refs/notes/") ||
+		!strcmp(refname, "refs/stash") ||
 		!strcmp(refname, "HEAD");
 }
 
-- 
2.0.4.314.gdbf7a51-twtrsrc
