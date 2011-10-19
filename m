From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/6] revert: fix buffer overflow in insn sheet parser
Date: Thu, 20 Oct 2011 02:33:25 +0530
Message-ID: <1319058208-17923-4-git-send-email-artagnon@gmail.com>
References: <1319058208-17923-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 23:06:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdL4-0000Gz-Cj
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 23:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130Ab1JSVGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 17:06:07 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35033 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559Ab1JSVGF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 17:06:05 -0400
Received: by pzk36 with SMTP id 36so5339523pzk.1
        for <git@vger.kernel.org>; Wed, 19 Oct 2011 14:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fFNEDqxm63RUK5GTEgy+jkyiVtjNuRvDplseLCOfZ+E=;
        b=bpR8ssfbPx0FhQ44dsfUEtrrDIEWlyMXlG06rJsvWIubbg1NYyYFgbura5ADaQtWD8
         Len7CpIiTtQJHlWx8p5MOO931lFwD7NiueLR5MHhitGMb1m9+y55pCBvM+kGaAHcPgk8
         +ohQkyC+Kn08gurSz3IdZqQnbFDD/mISuaao8=
Received: by 10.68.1.199 with SMTP id 7mr14870375pbo.127.1319058364811;
        Wed, 19 Oct 2011 14:06:04 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id jm5sm11111752pbc.1.2011.10.19.14.06.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Oct 2011 14:06:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1319058208-17923-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183966>

Check that the commit name argument to a "pick" or "revert" action in
'.git/sequencer/todo' is not too long, to avoid overflowing an
on-stack buffer.  This fixes a regression introduced by 5a5d80f4
(revert: Introduce --continue to continue the operation, 2011-08-04).

Reported-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/revert.c                |    2 +-
 t/t3510-cherry-pick-sequence.sh |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index acb357d..474dda1 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -705,7 +705,7 @@ static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
 		return NULL;
 
 	q = strchr(p, ' ');
-	if (!q)
+	if (!q || q - p + 1 > sizeof(sha1_abbrev))
 		return NULL;
 	q++;
 
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 3bca2b3..2113308 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -12,6 +12,9 @@ test_description='Test cherry-pick continuation features
 
 . ./test-lib.sh
 
+# Repeat first match 10 times
+_r10='\1\1\1\1\1\1\1\1\1\1'
+
 pristine_detach () {
 	git cherry-pick --reset &&
 	git checkout -f "$1^0" &&
@@ -211,4 +214,15 @@ test_expect_success 'malformed instruction sheet 2' '
 	test_must_fail git cherry-pick --continue
 '
 
+test_expect_success 'malformed instruction sheet 3' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	echo "resolved" >foo &&
+	git add foo &&
+	git commit &&
+	sed "s/pick \([0-9a-f]*\)/pick $_r10/" .git/sequencer/todo >new_sheet &&
+	cp new_sheet .git/sequencer/todo &&
+	test_must_fail git cherry-pick --continue
+'
+
 test_done
-- 
1.7.6.351.gb35ac.dirty
