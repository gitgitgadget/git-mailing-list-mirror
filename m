From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/2] stash drops the stash even if creating the branch fails because it already exists
Date: Tue, 28 Sep 2010 23:19:51 +1000
Message-ID: <1285679992-7638-2-git-send-email-jon.seymour@gmail.com>
References: <1285673120-43354-1-git-send-email-tom@dbservice.com>
Cc: tla@land.ru, tom@dbservice.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 28 15:17:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0a44-0005zY-3S
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 15:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760Ab0I1NRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 09:17:32 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:40215 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731Ab0I1NRa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 09:17:30 -0400
Received: by pvg2 with SMTP id 2so1545209pvg.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 06:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4fnZ0gk9grtQDaWRG14rCuwM/jzkxOdYKT0ugo7GVxY=;
        b=NFHKipNVZgo2UFIOV6vcVq/9lvJWixdRlrUX2PFtPHb/61zKJy2gWAEOwYcGUFfbHM
         MBcWZwuaJrNYk0SbtzOSEXLrqfwIUlJNx3tF3xUbKN/uQypztvBqlErgy05JqQwF9HGk
         Ub8FPmmo0Vp3JH8WWkmUxkjc1uuvlGPg9pSzI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dsLlEtkLQ2pobzF+u3MMZp7rNO1xaoWC/8GOkMz6r8G6E+W9C9vW1BQDRQUob/nKAp
         /NOBpIgs3dOAF/sFBrKsy3wfmlhEkyklJanB3L52bwFD4RPVDqZgk4acr9/BJZwuzHHp
         120j/UId9DY8KU4yfEYtZwsDZjN4XfB3Wbb1A=
Received: by 10.142.14.19 with SMTP id 19mr7017181wfn.290.1285679849933;
        Tue, 28 Sep 2010 06:17:29 -0700 (PDT)
Received: from localhost.localdomain (203-158-55-77.dyn.iinet.net.au [203.158.55.77])
        by mx.google.com with ESMTPS id o16sm8820470wfh.19.2010.09.28.06.17.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 06:17:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.5.g7cfb7
In-Reply-To: <1285673120-43354-1-git-send-email-tom@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157419>

From: Tomas Carnecky <tom@dbservice.com>

This bug was disovered by someone on IRC when he tried to 'git stash branch <branch> <stash>'
while <branch> already existed. In that case the stash is dropped even though it isn't
applied on any branch, so the stash is effectively lost. I think that shouldn't happen,
so here is a test.
---
 t/t3903-stash.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 9ed2396..0f6b2e4 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -545,4 +545,15 @@ test_expect_success 'invalid ref of the form stash@{n}, n >= N' '
 	git stash drop
 '
 
+test_expect_failure 'stash branch should not drop the stash if the branch exists' '
+	git stash clear &&
+	echo foo > file &&
+	git add file &&
+	git commit -m initial &&
+	echo bar > file &&
+	git stash &&
+	test_must_fail git stash branch master stash@{0} &&
+	git rev-parse stash@{0} --
+'
+
 test_done
-- 
1.7.3.4.g787b.dirty
