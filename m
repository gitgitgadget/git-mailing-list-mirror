From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/5] rebase: use 'git stash store' to simplify logic
Date: Fri, 14 Jun 2013 16:02:04 +0530
Message-ID: <1371205924-8982-6-git-send-email-artagnon@gmail.com>
References: <1371205924-8982-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 14 12:30:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnRHO-0000Tc-UK
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 12:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240Ab3FNKah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 06:30:37 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:60202 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094Ab3FNKaY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 06:30:24 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp16so444712pbb.28
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 03:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=82RbJCVQD0W8FnCrpNi/BBdJ2BX9svFZwO53fl2KCZo=;
        b=lEIp2AAzlu0zLYKX7E6v6Wq79xhRsJ8qSG8jXnex6cYw+f7QTPQ1XyYS0lZDhDpDbO
         DiA+co0yz0CM7SlyZxpx0/KOJ7LtD3BizqMDKszs3gb6xwue0Ff2va2sHb3AtfjeQ4K5
         InL4w+QqfUkbXFaXwhPPY6Vm7oyNHdJ5QbUM/FRmQHp06MuekluBjtgmeoiqr9cp7I/e
         a2cGViL81Dyqn3pC5MxDexDXEelHkELN09vrOCMgalAFr2ufnxZDIah5GhdKW0+reQrG
         9ybolMJMFzP0ped5ach2SGu/ZKoGIDfysgX9Szsp49AiGz14mZ1/1+rekYK8L5h0jFfs
         LxVg==
X-Received: by 10.68.189.194 with SMTP id gk2mr1866158pbc.193.1371205824130;
        Fri, 14 Jun 2013 03:30:24 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id xj9sm1809871pbc.16.2013.06.14.03.30.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 03:30:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.383.g0d5ad6b
In-Reply-To: <1371205924-8982-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227806>

rebase has no reason to know about the implementation of the stash.  In
the case when applying the autostash results in conflicts, replace the
relevant code in finish_rebase () to simply call 'git stash store'.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-rebase.sh | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index d0c11a9..bf37259 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -153,11 +153,7 @@ finish_rebase () {
 		then
 			echo "$(gettext 'Applied autostash.')"
 		else
-			ref_stash=refs/stash &&
-			>>"$GIT_DIR/logs/$ref_stash" &&
-			git update-ref -m "autostash" $ref_stash $stash_sha1 ||
-			die "$(eval_gettext 'Cannot store $stash_sha1')"
-
+			git stash store -m "autostash" -e "Cannot store $stash_sha1." $stash_sha1
 			gettext 'Applying autostash resulted in conflicts.
 Your changes are safe in the stash.
 You can run "git stash pop" or "git stash drop" it at any time.
-- 
1.8.3.1.383.g0d5ad6b
