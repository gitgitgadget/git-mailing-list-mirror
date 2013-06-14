From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2] prompt: squelch error output from cat
Date: Fri, 14 Jun 2013 13:58:05 +0530
Message-ID: <1371198485-32663-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 14 10:26:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnPL0-0001fP-19
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 10:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049Ab3FNI0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 04:26:18 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35370 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab3FNI0P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 04:26:15 -0400
Received: by mail-pa0-f44.google.com with SMTP id lj1so437972pab.17
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 01:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=bSOt8ZLPXH3+Jh2RAnFc52lGP8wqReyXqQkJFwmDa1o=;
        b=iYioYzOTAlsXk2mVFuq0eaJWfykfSc/Sy2iig6il8li55CyHp/IdKYIM4xjKY+9R6j
         1ERtpIDSgGNp5fZ6wo63TqpUyzOpbobbkc2M+EiPpo80LIfd5KcSo5gGscci7qbN3Krv
         xFD832Ld+xiAONmYIiyAbGBKxz1DZD5QhFTxCzkIV1sn5pCUC+SjqPmtJMlOZ7YW+9Co
         XFYyex21SK3UfauxNWlTaphui7nILJMIv3p76kNI0d9/zEDrvr9AgjyK4s5V1z2YlgjU
         hGxFkaPfglnv2AR8NXP/IU743SZgCopDSRlCTNIw239v6Yz2L6ap2n5rWr5/a9OriOWH
         usmw==
X-Received: by 10.66.255.41 with SMTP id an9mr1454237pad.44.1371198374626;
        Fri, 14 Jun 2013 01:26:14 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id v7sm1408062pbq.32.2013.06.14.01.26.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 01:26:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.383.gbc1f167.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227794>

The files $g/rebase-{merge,apply}/{head-name,msgnum,end} are not
guaranteed to exist.  When attempting to cat them, squelch the error
output.

In addition to guarding against stray directories, this patch addresses
a real problem:

  # on terminal 1
  $ git rebase -i master
  # ignore editor, and switch to terminal 2
  cat: .git/rebase-merge/msgnum: No such file or directory
  cat: .git/rebase-merge/end: No such file or directory
  $

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Better commit message.

 contrib/completion/git-prompt.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 86a4f3f..07a6218 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -347,9 +347,9 @@ __git_ps1 ()
 		local step=""
 		local total=""
 		if [ -d "$g/rebase-merge" ]; then
-			b="$(cat "$g/rebase-merge/head-name")"
-			step=$(cat "$g/rebase-merge/msgnum")
-			total=$(cat "$g/rebase-merge/end")
+			b="$(cat "$g/rebase-merge/head-name" 2>/dev/null)"
+			step=$(cat "$g/rebase-merge/msgnum" 2>/dev/null)
+			total=$(cat "$g/rebase-merge/end" 2>/dev/null)
 			if [ -f "$g/rebase-merge/interactive" ]; then
 				r="|REBASE-i"
 			else
@@ -357,10 +357,10 @@ __git_ps1 ()
 			fi
 		else
 			if [ -d "$g/rebase-apply" ]; then
-				step=$(cat "$g/rebase-apply/next")
-				total=$(cat "$g/rebase-apply/last")
+				step=$(cat "$g/rebase-apply/next" 2>/dev/null)
+				total=$(cat "$g/rebase-apply/last" 2>/dev/null)
 				if [ -f "$g/rebase-apply/rebasing" ]; then
-					b="$(cat "$g/rebase-apply/head-name")"
+					b="$(cat "$g/rebase-apply/head-name" 2>/dev/null)"
 					r="|REBASE"
 				elif [ -f "$g/rebase-apply/applying" ]; then
 					r="|AM"
-- 
1.8.3.1.383.gbc1f167.dirty
