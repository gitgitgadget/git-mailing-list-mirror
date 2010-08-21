From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v6 5/9] detached-stash: refactor git stash pop implementation
Date: Sat, 21 Aug 2010 14:09:00 +1000
Message-ID: <1282363744-4924-6-git-send-email-jon.seymour@gmail.com>
References: <1282363744-4924-1-git-send-email-jon.seymour@gmail.com>
Cc: j6t@kdbg.org, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 21 06:10:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmfPM-0006qB-4O
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 06:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337Ab0HUEJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 00:09:55 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:37067 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab0HUEJy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 00:09:54 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1481994pxi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 21:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WBCQEcGSyHeT3APY+j/ZkvhqfmmLqJwzUUqpDs2j6uc=;
        b=sz6TWzR6dR1WUk6HXnI9ZInPH0L73h6Rntlg1r5i/FQpDboq2qnsYH2aYtCd9DWctx
         yL0mCjHicALhFeHWGu8X0+wETYb8LS2JceL8WdAG1Yb8+vI16RWq9NtVAicwYYTYivLr
         agCQg4wZ+HPhVZ9EEjyKj4qzdyRGsx+zbpv9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AFcf3kCpkmUR8Wm1Y7DK429H+0Rmgpf+FU4Gd6hTvW08DeC9hd838baQNC59HkkG0C
         tVzl1xEEHqpSsqfe8aBvZqBDbGuK6+Y/uTDFzwAL0gndeQ/kPJmM/kflXlx1QgIt//NM
         V7jNSiwDTg4LlAl3eKmLwt5j/zyN1ezlk2wWE=
Received: by 10.142.140.19 with SMTP id n19mr1734291wfd.347.1282363794558;
        Fri, 20 Aug 2010 21:09:54 -0700 (PDT)
Received: from localhost.localdomain (124-169-98-91.dyn.iinet.net.au [124.169.98.91])
        by mx.google.com with ESMTPS id z1sm4208931wfd.3.2010.08.20.21.09.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 21:09:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.110.g34f32
In-Reply-To: <1282363744-4924-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154106>

git stash pop is abstracted into its own implementation function - pop_stash.

The behaviour is changed so that git stash pop fails early if the
the specified stash reference does not exist or does not refer to
an extant entry in the reflog of the reference stash.

This fixes the case where the apply succeeds, but the drop fails.
Previously this caused caused git stash pop to exit with a non-zero exit code
and a dirty tree.

Now, git stash pop fails with a non-zero exit code, but the working
tree is not modified.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 750f360..ac4c0f6 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -423,6 +423,13 @@ apply_stash () {
 	fi
 }
 
+pop_stash() {
+	assert_stash_ref "$@"
+
+	apply_stash "$@" &&
+	drop_stash "$@"
+}
+
 drop_stash () {
 	assert_stash_ref "$@"
 
@@ -498,10 +505,7 @@ drop)
 	;;
 pop)
 	shift
-	if apply_stash "$@"
-	then
-		drop_stash "$applied_stash"
-	fi
+	pop_stash "$@"
 	;;
 branch)
 	shift
-- 
1.7.2.1.110.g34f32
