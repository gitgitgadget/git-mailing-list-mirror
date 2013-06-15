From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 5/5] rebase: use 'git stash store' to simplify logic
Date: Sat, 15 Jun 2013 18:43:26 +0530
Message-ID: <1371302006-29775-6-git-send-email-artagnon@gmail.com>
References: <1371302006-29775-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 15 15:15:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnqKd-0007oc-Vo
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 15:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754443Ab3FONPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 09:15:40 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:43472 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754417Ab3FONPc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 09:15:32 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so1472005pac.29
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 06:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Lr7OIFcaqSq30KC0+8JkaFsmx58DQf+kTkqgXUTS9mw=;
        b=AE+CqT4RTzSbZ0zffPmE9upiz478wEZpRRrGPBodZoeYJ4xjBIbcaOnfHDUrMzgKxE
         0PVbGlebDgGEQXc2iWgIWtZnrFm8DfqWRPUowi83WHG6m/WPaCGAoXQo+VpqGEHDAANb
         3xyKP2kDPZwzxbzMqi6v9PjoyGzTC7nXJyW57xw2yT1/sOx5E8aYGSEXJqep3mY0jUcd
         aWws/9jxJlC2iYbsXOXpkFHjDnfEJ45iCSzjNIP184kHxAYjgb8oFSF/F3duXg7VwfxG
         SxVgEy/sAY6eiXIAQyXXH+Nh3MFoi25R0vdqHySL3+0Eo9PptbF5FMJHZJ79wxEdPx9H
         k1DA==
X-Received: by 10.66.8.138 with SMTP id r10mr6331781paa.55.1371302131709;
        Sat, 15 Jun 2013 06:15:31 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id pe9sm6239122pbc.35.2013.06.15.06.15.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Jun 2013 06:15:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.441.gd7d6b72.dirty
In-Reply-To: <1371302006-29775-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227951>

rebase has no reason to know about the implementation of the stash.  In
the case when applying the autostash results in conflicts, replace the
relevant code in finish_rebase () to simply call 'git stash store'.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-rebase.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index d0c11a9..17be392 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -153,11 +153,8 @@ finish_rebase () {
 		then
 			echo "$(gettext 'Applied autostash.')"
 		else
-			ref_stash=refs/stash &&
-			>>"$GIT_DIR/logs/$ref_stash" &&
-			git update-ref -m "autostash" $ref_stash $stash_sha1 ||
-			die "$(eval_gettext 'Cannot store $stash_sha1')"
-
+			git stash store -m "autostash" -q $stash_sha1 ||
+			die "$(eval_gettext "Cannot store \$stash_sha1")"
 			gettext 'Applying autostash resulted in conflicts.
 Your changes are safe in the stash.
 You can run "git stash pop" or "git stash drop" it at any time.
-- 
1.8.3.1.441.gd7d6b72.dirty
