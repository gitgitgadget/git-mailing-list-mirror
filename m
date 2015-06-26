From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 7/7] git-stash: use git-reflog instead of creating files
Date: Thu, 25 Jun 2015 20:29:08 -0400
Message-ID: <1435278548-3790-7-git-send-email-dturner@twopensource.com>
References: <1435278548-3790-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Jun 26 02:29:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8HWf-0005AC-95
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 02:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbbFZA3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 20:29:45 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38073 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbbFZA3k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 20:29:40 -0400
Received: by igin14 with SMTP id n14so3492136igi.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 17:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YtzFuD8Lpp6DM6lcY7v8SurWAkqxd8oStrI3desvR+Y=;
        b=i6FM66BaIw5CIAtgvCDvUqaLHHEDj07Iy09Ijr1Ay3VZlW5e37x5kbXkHd2K4tOHTH
         0CHtaA53+4MgGa/JBIYn38g6eUXWwLeniKRNOfjtQBaPsBo66sgWQAou7LpguE5YRhU0
         9j+jRpB799/pEi3d06xrifA6gJ1mIrCWl7E8Wr0L06yef4WolQxucRPLC8eLdkC7Jhsw
         4L35jzmBTVfOcAIQ4BwdP9kcKjb3vDQ1vNa1JBf1D9cn9beLqTQKcNGXiLyEralfb3wi
         poXBBKTZyhoJqbqF9Um9lWcRodJcIzwT3gZ6FhmVZqDl+N76D4OuEo7kozPMPDgYElSo
         Za9A==
X-Gm-Message-State: ALoCoQkX3M8D455kE76UskP2D7aidgxaErl+FQejzIgUUmYGk5N1cwJGqVDDcRW96V81KBrubGXm
X-Received: by 10.50.57.39 with SMTP id f7mr351784igq.35.1435278579456;
        Thu, 25 Jun 2015 17:29:39 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id i85sm20714344iod.41.2015.06.25.17.29.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 17:29:38 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.314.gdbf7a51-twtrsrc
In-Reply-To: <1435278548-3790-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272753>

This is in support of alternate ref backends which don't necessarily
store reflogs as files.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 git-stash.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.0.4.314.gdbf7a51-twtrsrc
