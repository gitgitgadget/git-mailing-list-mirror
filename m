From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 8/8] git-stash: use update-ref --create-reflog instead of creating files
Date: Tue,  7 Jul 2015 20:56:03 -0400
Message-ID: <1436316963-25520-8-git-send-email-dturner@twopensource.com>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Jul 08 02:56:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCdfS-0007J3-QU
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 02:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbbGHA4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 20:56:49 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:33437 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757519AbbGHA4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 20:56:25 -0400
Received: by qgef3 with SMTP id f3so43108588qge.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 17:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uVCEXltwEy510CJxyKJvFzMvtUyzOqCxnyS3tpIrrK4=;
        b=QO7vm2fyot+OxxO2yZDsSvP5wDujIP1hNp8tQYPcauoTdxS2Pox7G1MKuw+aY9cNah
         PNuFHRnlP3Nr7gXjrhi6cnWjh8D4kVyRJeRa8qw9sFEZmbkBUfUnmxT1fKKOybYfjifW
         HZfhvB9LXE+T3rVDejn1vf3x4PhQzTQ8z+w/bh6bJywX2yX+7kmnY92v0y+L+LZCio3F
         4xhgScFGj5nGA2uYBFv8E3UhWRGeNyIhaaz7ozWHeP651khbTssqoz9u4xlmsJIn4fAN
         kt/uf+YvjzlWwVQ/aZOZmF83GgR95XjIj/RpCdHtWIVuH9DVt8lwhFaCGTCFrcquAWzI
         TP4Q==
X-Gm-Message-State: ALoCoQl7AdtfR6vDnceGmcfWrEVCOkXo4Qo1yYxP/3EPhAVfmdH4I5z2O8AEo59h1nP3GqLo7Unv
X-Received: by 10.55.15.144 with SMTP id 16mr11426941qkp.98.1436316985137;
        Tue, 07 Jul 2015 17:56:25 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z135sm278447qhd.29.2015.07.07.17.56.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 17:56:24 -0700 (PDT)
X-Mailer: git-send-email 2.0.5.499.g01f6352.dirty-twtrsrc
In-Reply-To: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273628>

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
