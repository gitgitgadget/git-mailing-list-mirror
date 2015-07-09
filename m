From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 7/7] git-stash: use update-ref --create-reflog instead of creating files
Date: Thu,  9 Jul 2015 18:51:00 -0400
Message-ID: <1436482260-28088-8-git-send-email-dturner@twopensource.com>
References: <1436482260-28088-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, j6t@kdbg.org
X-From: git-owner@vger.kernel.org Fri Jul 10 00:51:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDKfS-0007B6-4m
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 00:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbbGIWvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 18:51:42 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33767 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbbGIWvf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 18:51:35 -0400
Received: by pacws9 with SMTP id ws9so158947997pac.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 15:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uVCEXltwEy510CJxyKJvFzMvtUyzOqCxnyS3tpIrrK4=;
        b=K+9vBFUqm8US6mFSRK4NjyzMTY3TszNreYGQKYoNm4luXJTflY8bw3dLGO6Lw2s8yS
         /FKpk44/Yk72FtaSneyVxHsqz9AVlzM4F1pF05bcZulr3TQKyH53OB5zaJygyGhvxVGc
         gXFC+i7SqkOGBJu4nClNfRbgIB96iWz7KftgDjausYUGZoDUqDoHr4I47wURCVvFNNpc
         sBRM8NAwbfd9j0Fm2DgMmttp9bXYMsSZw8vML/TRdAQfibQOeEdL9afQp2jC8HdfPSUH
         YkL4d1BEkLP3tK3yZA/tbg3O5OmWAVDp4DjJvb/AOQ9MVnu+JDbII935ACZIylaknjHO
         F+TQ==
X-Gm-Message-State: ALoCoQnWBQBCqGb3KbqnzUX5ztAHSUmiYgDCeKrmrPPFUfr6SJyS+yjVhGIq9DRrbYm13tbg8o4F
X-Received: by 10.68.240.7 with SMTP id vw7mr35737767pbc.135.1436482294864;
        Thu, 09 Jul 2015 15:51:34 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id fr2sm7129684pdb.22.2015.07.09.15.51.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Jul 2015 15:51:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.5.499.g01f6352.dirty-twtrsrc
In-Reply-To: <1436482260-28088-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273792>

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
2.0.5.499.g01f6352.dirty-twtrsrc
