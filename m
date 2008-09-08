From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH 2/2] git-rebase--interactive: auto amend only edited commit
Date: Tue,  9 Sep 2008 00:42:49 +0400
Message-ID: <1220906569-26878-2-git-send-email-dpotapov@gmail.com>
References: <1220906569-26878-1-git-send-email-dpotapov@gmail.com>
Cc: Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 22:44:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcnag-0000cu-Q7
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 22:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbYIHUnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 16:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753485AbYIHUnA
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 16:43:00 -0400
Received: from rn-out-0910.google.com ([64.233.170.187]:9390 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869AbYIHUm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 16:42:59 -0400
Received: by rn-out-0910.google.com with SMTP id k40so256942rnd.17
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 13:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=dKmc65EzQFrLIGEKR4N/WysETRvJubYiFpPObrxMDA8=;
        b=ndtYYyuFpQDNX0CpMQzZecSy/gjlWBCRjRmtgHZmkj6MIGKAWnNgEl3kCeWA5PZa/M
         EmEW7jhMXYBoy3Y1X6CCFns6pBBBZP2Rlr4gMm7M/y6ZwLXhPTaxxxayfarrmA1gnnxC
         g8erC9HMcBifu9QM7WQDRGsseuDBQLnx8fNOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SqlZyKxF+4iaR4ruHivlyR6CD1zNcIRw0GceSObDN/hDElYgfvPRc2viMCPUeCYxAD
         f2JOuSuVOXBKq7+NhJBHOQ59Mw15eWiBS5AkLNWsZh7pipeBEY5HFgyvh3lhwBj++hn+
         TJzg5w5AU3MfebRu5F46H+GJ0IqHwSibxkv1U=
Received: by 10.86.4.2 with SMTP id 2mr6459564fgd.21.1220906576657;
        Mon, 08 Sep 2008 13:42:56 -0700 (PDT)
Received: from localhost ( [85.141.189.164])
        by mx.google.com with ESMTPS id 4sm5738791fgg.4.2008.09.08.13.42.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Sep 2008 13:42:55 -0700 (PDT)
X-Mailer: git-send-email 1.6.0
In-Reply-To: <1220906569-26878-1-git-send-email-dpotapov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95300>

"git rebase --continue" issued after git rebase being stop by "edit"
command is trying to amend the last commit using stage changes. However,
if the last commit is not the commit that was marked as "edit" then it
can produce unexpected results.

For instance, after being stop by "edit", I have made some changes to
commit message using "git commit --amend". After that I realized that
I forgot to add some changes to some file. So, I said "git add file"
and the "git rebase --continue". Unfortunately, it caused that the new
commit message was lost.

Another problem is that after being stopped at "edit", the user adds new
commits. In this case, automatic amend behavior of git rebase triggered
by some stage changes causes that not only that the log message of the
last commit is lost but that it will contain also wrong Author and Date
information.

Therefore, this patch restrict automatic amend only to the situation
where HEAD is the commit at which git rebase stop by "edit" command.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 git-rebase--interactive.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5b2b1e5..84721c9 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -284,7 +284,7 @@ do_next () {
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
 		make_patch $sha1
-		: > "$DOTEST"/amend
+		echo $sha1 > "$DOTEST"/amend
 		warn "Stopped at $sha1... $rest"
 		warn "You can amend the commit now, with"
 		warn
@@ -430,6 +430,8 @@ do
 			if test -f "$DOTEST"/amend
 			then
 				amend=$(git rev-parse --verify HEAD)
+				test "$amend" = $(cat "$DOTEST"/amend) ||
+				die "You have uncommitted changes"
 				git reset --soft HEAD^ ||
 				die "Cannot rewind the HEAD"
 			fi
-- 
1.6.0
