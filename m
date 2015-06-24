From: David Turner <dturner@twopensource.com>
Subject: [PATCH 6/6] git-stash: use git-reflog instead of creating files
Date: Wed, 24 Jun 2015 15:16:28 -0400
Message-ID: <1435173388-8346-7-git-send-email-dturner@twopensource.com>
References: <1435173388-8346-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Jun 24 21:17:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7qAe-0000N8-Dy
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 21:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbbFXTRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 15:17:12 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:32925 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751AbbFXTRE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 15:17:04 -0400
Received: by igbqq3 with SMTP id qq3so121923715igb.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 12:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r2RSPl3gcydUZYkKYGExE7RTda71k8iORjaDidT7kCU=;
        b=LtQ8RnNt7SvcL/fr7tLs+dZYyGerUAmXknz0qGrzWPxVtqAV2hlOtn8TVLNDwGOEdO
         omUOhremCOY/pH0d1Lc6qxcrlrVcCNDlwaZeCAS1BUylCtBYHiwxkYqNBSn8RaGnT5X7
         KyiLx+lr4D9QBA3SUR2JIN/wWlvzk8LxycN4WwcAAaH1QLUwHyDFJNQ9xCaL9r6tjR3c
         +59deXdjnO/jNJZw/pYSdb/V94vcHd/l1wW+IVbSqunSI6CaRDQFgerjphqc9XMP4mF8
         03aWCiiSddRXQKzf3FdP1xwaeBtHVbNWdW25Tx7ZkncN0u/Jw02GI+6vOCD6oIni2fXZ
         b2Lg==
X-Gm-Message-State: ALoCoQlEwuBeSfWY2xHBwVrhcukJgafd9r7ssD8rFxHRMKZ81DfwGYSAbldbnypTDLdncdyCMkMU
X-Received: by 10.107.39.209 with SMTP id n200mr54574473ion.59.1435173423190;
        Wed, 24 Jun 2015 12:17:03 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id p8sm1644609iga.13.2015.06.24.12.17.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Jun 2015 12:17:02 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.314.gdbf7a51-twtrsrc
In-Reply-To: <1435173388-8346-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272586>

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
index 93412ee..f3e3da0 100644
--- a/refs.c
+++ b/refs.c
@@ -3132,6 +3132,7 @@ int create_reflog(const char *refname, struct strbuf *sb_logfile, struct strbuf
 	    (starts_with(refname, "refs/heads/") ||
 	     starts_with(refname, "refs/remotes/") ||
 	     starts_with(refname, "refs/notes/") ||
+	     !strcmp(refname, "refs/stash") ||
 	     !strcmp(refname, "HEAD"))) {
 		if (safe_create_leading_directories(logfile) < 0) {
 			strbuf_addf(err, "unable to create directory for %s. "
-- 
2.0.4.314.gdbf7a51-twtrsrc
