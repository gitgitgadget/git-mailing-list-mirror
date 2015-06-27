From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 6/6] git-stash: use git-reflog instead of creating files
Date: Sat, 27 Jun 2015 00:23:56 -0400
Message-ID: <1435379036-30894-7-git-send-email-dturner@twopensource.com>
References: <1435379036-30894-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Sat Jun 27 06:24:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8hfd-0005t5-Ag
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 06:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186AbbF0EYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2015 00:24:44 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34640 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246AbbF0EYc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2015 00:24:32 -0400
Received: by iebmu5 with SMTP id mu5so87013055ieb.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 21:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YsropL/mNqpqP+0m0cU/Hg8jK53zZ8imqZuvkY7BQ2k=;
        b=nE/BKLDfPTlZdMNjd4E2kFSLbyH2YzcsJx3XOeBpd8nLOkex4F2MFxpIEGOGDRr7mD
         DlNmGM4UbDRysW5jATNqbZWaOY6L4HG525PDCx1HGxMeIRgoaz/8J4JTm2qdT0RQP+of
         0OOE8vJkNn/NG1hjT1y3fm5/kGQggymafgjCEOh8Lq251OVj/6kJLaDiGeuXIhK2+PFr
         g4EmRMmkBF51IpTh9zqch2tLa00LRMGTW2s6R6hL81elRxfucsLjuqb2Os4A3fSq4c/P
         cdNXollkmk2A7DBYg5t23lRaw8Gr3UcSbYCVez/96NyKS1eWC8QJoxJMntaNEcSx6qdU
         xWWQ==
X-Gm-Message-State: ALoCoQkZpDhnUvKonytVZyut0rGU2NzLFyYsYdo1Usdy/TIQ6S4WLviYbZnapsd3XWSZ1Rfce/YS
X-Received: by 10.42.72.132 with SMTP id o4mr7413775icj.20.1435379071421;
        Fri, 26 Jun 2015 21:24:31 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id k74sm22930720iok.30.2015.06.26.21.24.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jun 2015 21:24:30 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1435379036-30894-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272847>

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
index 2f4c304..8816c9f 100644
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
