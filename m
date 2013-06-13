From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/6] rebase -i: prepare to write reflog message for checkout
Date: Thu, 13 Jun 2013 19:02:26 +0530
Message-ID: <1371130349-30651-4-git-send-email-artagnon@gmail.com>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 13 15:31:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un7cA-0003x5-UD
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 15:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758585Ab3FMNaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 09:30:52 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:41076 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757897Ab3FMNam (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 09:30:42 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so11307668pdj.0
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 06:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Md6ZwE3to7lepHcWk9GQgTrmxA7RLl+LKQYuFPfmxxM=;
        b=W0m9NGdvRT1cD0dfU2Ezyf1J1d8DgOaE+ojwCZASjs+allu6tn+VL2680Xt/TWRoRT
         GjlImzTxLBxHgShy8+PKYOALar7LEkg1tFDR1XbP3HlCilk3ktQYUKATu2hWdqo+rBPw
         XX5XV0wAo2ZkS2au1jJeDuBcctiP3mYVY8qokt/oY9KwBTL3tHalmptgrUyyPK5SUtXJ
         aMT/fHKiy6loGPMriUhmhUdmsma+XyP+dO66aIlM/lWm7sn1D5Jedv74kr03Ia5NlZa+
         +1mQYzYIZCv8Jpc9X46a4dXKMUKDW6bZpnb9O7Rr3cqXpKHUdRfHXvQb2BR3TLxL5KMz
         tf0A==
X-Received: by 10.68.4.9 with SMTP id g9mr767169pbg.217.1371130242508;
        Thu, 13 Jun 2013 06:30:42 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id re16sm4581222pac.16.2013.06.13.06.30.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 06:30:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.384.g7cec0b4
In-Reply-To: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227733>

Interactive rebase should never write "checkout: " messages to the
reflog, since it is highly confusing to the end user, and breaks
grab_nth_branch_checkout(), as demonstrated by failing tests
in t/checkout-last.  Set a sensible GIT_REFLOG_ACTION: checkout does not
respect GIT_REFLOG_ACTION yet, but this defect will be addressed in a
future patch.

When the defect is addressed, rebase -i will write the following line to
the reflog when started:

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
1.8.3.1.384.g7cec0b4
