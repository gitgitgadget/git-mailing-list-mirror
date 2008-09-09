From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH v2] git-rebase--interactive: auto amend only edited commit
Date: Tue,  9 Sep 2008 16:05:26 +0400
Message-ID: <1220961926-13235-1-git-send-email-dpotapov@gmail.com>
References: <20080909070055.GB28210@dpotapov.dyndns.org>
Cc: git@vger.kernel.org, Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 14:07:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd1zz-0006wc-4b
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 14:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830AbYIIMFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 08:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753532AbYIIMFf
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 08:05:35 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:64022 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755578AbYIIMFd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 08:05:33 -0400
Received: by yw-out-2324.google.com with SMTP id 9so191133ywe.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 05:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=dqZ59L1um/GZ6YPX1mLMVSWWYQuyqkjSUcsGyUOVepU=;
        b=vkCFhccvOFUDZJpcHVx9QwYx8h9fbkNAkt6cUbGnfGWjdYG8g/96VVhj0Cz2abCRhl
         +zsYG/DQSflM12VGqunD0amGVbKygi49vo86T+0q6cv0Uuy992XNs0F0MY04yTbXAS+3
         xUgNg1SxzyzDY0nqJFL7Rwfw6K6QSYW6g63X8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TsgzrkpXBalFqE0lpw84X9WGLKzmyzxKo032QL/EeEIlq0RC11wV6l+1oI1OmJfb2Z
         TJqPRMqTL4CgQYR517KcxfncMf2A3GfYGIXHgmpI9hLf5koRcse0cB3bZ93fe9+sMCJh
         Ilo6laNXhJneiplTuTPuaTufYl+vi83FUJYp8=
Received: by 10.86.80.17 with SMTP id d17mr337558fgb.41.1220961930820;
        Tue, 09 Sep 2008 05:05:30 -0700 (PDT)
Received: from localhost ( [85.141.189.164])
        by mx.google.com with ESMTPS id l19sm5771215fgb.7.2008.09.09.05.05.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Sep 2008 05:05:29 -0700 (PDT)
X-Mailer: git-send-email 1.6.0
In-Reply-To: <20080909070055.GB28210@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95376>

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

Changes:
 1. I have correct the obvious bug pointed by Junio.
 2. The error message is more verbose now.

 git-rebase--interactive.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5b2b1e5..d2aa954 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -284,7 +284,7 @@ do_next () {
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
 		make_patch $sha1
-		: > "$DOTEST"/amend
+		git rev-parse --verify HEAD > "$DOTEST"/amend
 		warn "Stopped at $sha1... $rest"
 		warn "You can amend the commit now, with"
 		warn
@@ -430,6 +430,10 @@ do
 			if test -f "$DOTEST"/amend
 			then
 				amend=$(git rev-parse --verify HEAD)
+				test "$amend" = $(cat "$DOTEST"/amend) ||
+				die "\
+You have uncommitted changes in your working tree. Please, commit them
+first and then run 'git rebase --continue' again."
 				git reset --soft HEAD^ ||
 				die "Cannot rewind the HEAD"
 			fi
-- 
1.6.0
