From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] pull, rebase: simplify to use die()
Date: Sun, 14 Jun 2009 16:08:56 -0700
Message-ID: <1245020936-7978-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 01:09:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFypV-00087t-IE
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 01:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759215AbZFNXI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 19:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756060AbZFNXI7
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 19:08:59 -0400
Received: from mail-pz0-f181.google.com ([209.85.222.181]:51034 "EHLO
	mail-pz0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290AbZFNXI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 19:08:58 -0400
Received: by pzk11 with SMTP id 11so2551560pzk.4
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 16:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=0U2msqvyKGo/csTHB2kL39gt6vCDYltEYnHDHGHi0ao=;
        b=Ls1KIpNUTF+D/Tw5VdnCK7gMgY16xSBW3sq4zE6VPn238PjEo1kR6G/s+sntNRW2tN
         F9QF0YXGTHRW2UPRcXZEfB8AnA40vDsRRGmb2pyq1Rek+7QreR/7ysLaEnKADFCV8ubL
         Eljefpb7244Le3bBYqIJuMJGeJ1DTc59Cz39I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=l4JRxCmrusaIHS8X3dnzv7ZuXE86228l0Fd7gTD49l/qh98maxmpTsZODcMUyYB6NK
         IXDZcZVFqcq+VG29+TIw33e51JCMW912v1ZgP18zhO8MTnYoZx+vGtB+R/mz5lkgUAgK
         H/N00Ej0EI2bKwqsethdxJyZImL+SzMGCca58=
Received: by 10.114.52.16 with SMTP id z16mr10533029waz.220.1245020940128;
        Sun, 14 Jun 2009 16:09:00 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id j28sm5144849waf.58.2009.06.14.16.08.57
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Jun 2009 16:08:59 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 14 Jun 2009 16:08:56 -0700
X-Mailer: git-send-email 1.6.3.2.306.g4f4fa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121566>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

I noticed these, and they're somewhat unrelated from the quiet
stuff.

 git-pull.sh   |    6 ++----
 git-rebase.sh |    9 +++------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 3526153..cab367a 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -176,13 +176,11 @@ case "$merge_head" in
 ?*' '?*)
 	if test -z "$orig_head"
 	then
-		echo >&2 "Cannot merge multiple branches into empty head"
-		exit 1
+		die "Cannot merge multiple branches into empty head"
 	fi
 	if test true = "$rebase"
 	then
-		echo >&2 "Cannot rebase onto multiple branches"
-		exit 1
+		die "Cannot rebase onto multiple branches"
 	fi
 	;;
 esac
diff --git a/git-rebase.sh b/git-rebase.sh
index b83fd3f..334629f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -168,10 +168,8 @@ run_pre_rebase_hook () {
 	if test -z "$OK_TO_SKIP_PRE_REBASE" &&
 	   test -x "$GIT_DIR/hooks/pre-rebase"
 	then
-		"$GIT_DIR/hooks/pre-rebase" ${1+"$@"} || {
-			echo >&2 "The pre-rebase hook refused to rebase."
-			exit 1
-		}
+		"$GIT_DIR/hooks/pre-rebase" ${1+"$@"} ||
+		die "The pre-rebase hook refused to rebase."
 	fi
 }
 
@@ -359,8 +357,7 @@ fi
 
 # The tree must be really really clean.
 if ! git update-index --ignore-submodules --refresh; then
-	echo >&2 "cannot rebase: you have unstaged changes"
-	exit 1
+	die "cannot rebase: you have unstaged changes"
 fi
 diff=$(git diff-index --cached --name-status -r --ignore-submodules HEAD --)
 case "$diff" in
-- 
1.6.3.2.306.g4f4fa
