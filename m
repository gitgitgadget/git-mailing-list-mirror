From: David Turner <dturner@twopensource.com>
Subject: [PATCH v10 7/7] git-stash: use update-ref --create-reflog instead of creating files
Date: Tue, 21 Jul 2015 17:04:56 -0400
Message-ID: <1437512696-14672-7-git-send-email-dturner@twopensource.com>
References: <1437512696-14672-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhaggerty@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jul 21 23:05:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHejD-0001c2-KC
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 23:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933547AbbGUVFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 17:05:24 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36420 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933522AbbGUVFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 17:05:16 -0400
Received: by qkdv3 with SMTP id v3so141587920qkd.3
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 14:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tmQg66aja/D/oOo8JIaft2HePOtfZWGgrbFCTF2lrUs=;
        b=P4muDsY+5WZa9No7CIUxZoFY7dZvBQi75pA8lrmByXsyduVCaZ7CJWyP99NRcOQ6px
         RqneKQ6+h6bmFxvwCqWUSdN43xt7zUwGcuVPUWUF4JCvynz7GhVHVhwjPfIwsAxFwCto
         /htYI33vkhC6pHVJAqCi7uIB+1sAgx/IhzK52IZEpiqwlsqltfE4PzmqV9r7U8hMkR/Q
         5R8nlsD6ecOBH5Zp6jX1O5br5/wgs7cBBFBZQNcip8tWRZxKzR4IMuBzv7tzEUzbyRem
         xQx5iSZEN3smcbXc8i9uTMZeXSQg4vBwc1jjVeMxkPibh2YmBsEI4lSC5QTRgSckLmzr
         9U7g==
X-Gm-Message-State: ALoCoQkcV8BleM+BtLWkxeHNI75wlHqFTa5uCPtOVSRyeWqnQf6kun/OnCcqeI6vfHfRloj9mZr3
X-Received: by 10.55.17.132 with SMTP id 4mr56998278qkr.108.1437512715660;
        Tue, 21 Jul 2015 14:05:15 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id x137sm13430413qkx.28.2015.07.21.14.05.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jul 2015 14:05:14 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1437512696-14672-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274422>

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
2.0.4.315.gad8727a-twtrsrc
