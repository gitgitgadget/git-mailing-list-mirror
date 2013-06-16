From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 3/6] rebase -i: prepare to write reflog message for checkout
Date: Sun, 16 Jun 2013 14:15:13 +0530
Message-ID: <1371372316-16059-4-git-send-email-artagnon@gmail.com>
References: <1371372316-16059-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 16 10:47:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo8cf-00028h-LP
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 10:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755025Ab3FPIr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 04:47:29 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:57081 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923Ab3FPIrM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 04:47:12 -0400
Received: by mail-pd0-f174.google.com with SMTP id 10so1826087pdc.33
        for <git@vger.kernel.org>; Sun, 16 Jun 2013 01:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=MMjsGOaKA9tOIy7tLIamhvNT8br7KQqLQ8Js3H4Gg3k=;
        b=rriDixP9BZb+U5FAc89B+KcZWfW23MkC+r+IhgbLADFzi/1Fg0koY4TPtpXo3xwhQg
         L+0H3Y44f2Hu5ys4NW7UtygXFfHoAIyVGs3zzwZeF0VKopcl8IvwaVNXJ5Z9MleHlcwJ
         udAgYcmbQR79nx36iOLsNWlpRqtc+srRFqjQtZTrwBH6c1cGNZ77DJC/8TQiNgaaW+cQ
         QCwM94ysUsHpHYndf09gVcEp+Lv6Iufd5Adha4Exti3+b66ApliF7KANFgDy+uLPZvMo
         ybbeUFszeF4QqmoV9LEt5FYpRPWsJAqBQGCb/KEtaz/87s3sZY0lvg9/TEFv+1hU59Hu
         h4yA==
X-Received: by 10.66.16.197 with SMTP id i5mr1951857pad.51.1371372431675;
        Sun, 16 Jun 2013 01:47:11 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id vu5sm9917919pab.10.2013.06.16.01.47.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 16 Jun 2013 01:47:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.443.g4fd77b9
In-Reply-To: <1371372316-16059-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227996>

The branch-flipping rebase -i internally does is not 'checkout' as far
as the end-user is concerned; therefore, rebase -i should never write
"checkout: " messages to the reflog.  To achieve this, set a sensible
GIT_REFLOG_ACTION; checkout does not respect this variable yet, but a
future patch will change this.

After that patch, rebase -i will write the following line to the reflog
when started:

  rebase -i (start): checkout master

This is much better than the confusing message it currently writes:

  checkout: moving from master to 1462b67

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-rebase--interactive.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f953d8d..0f04425 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -838,6 +838,7 @@ comment_for_reflog start
 
 if test ! -z "$switch_to"
 then
+	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
 	output git checkout "$switch_to" -- ||
 		die "Could not checkout $switch_to"
 fi
@@ -981,6 +982,7 @@ has_action "$todo" ||
 
 test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_picks
 
+GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
 output git checkout $onto || die_abort "could not detach HEAD"
 git update-ref ORIG_HEAD $orig_head
 do_rest
-- 
1.8.3.1.443.g4fd77b9
