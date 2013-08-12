From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/3] t3404: rebase: interactive: demonstrate short SHA-1 collision
Date: Mon, 12 Aug 2013 00:07:38 -0400
Message-ID: <1376280459-55188-3-git-send-email-sunshine@sunshineco.com>
References: <1376280459-55188-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	David <bouncingcats@gmail.com>,
	Diogo de Campos <campos@esss.com.br>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Yann Dirson <dirson@bertin.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 12 06:08:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8jR6-0006R1-8P
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 06:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572Ab3HLEIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 00:08:43 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:46473 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab3HLEIa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 00:08:30 -0400
Received: by mail-ie0-f177.google.com with SMTP id a11so7502550iee.36
        for <git@vger.kernel.org>; Sun, 11 Aug 2013 21:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QSrmgHaIrkK3VWvlMaBvCgLC/f6Mi8ur0UemY4BD4PA=;
        b=hSuL2oGMnAxP05CxWvyC4f/9YWQCdZWOOeWtuE3tqEziFj769krAUE0oEPAMlVAJXZ
         t1cD/ce3AyPwLhyemmxThefOk1fNSRmguLml+RkvtZkngx14jbjO89gAqlvgaKSn4zyA
         OLP9Y0Kj0GVxPUCgRZDzM2RByXUU3A9StRUn1IT/0JdGFa87s2GFuZNnkZVUwdGOTKxk
         c5Wjpj2sG+94KrkoNFwu5kRJKl721jd3qlscA5OJ24G/aaRRTbVsxByz5Nsjln5bi59p
         VBWCr623aB746jhXhnpt8KmwEEKdhxlXlYv2yGkSv9AIe5EQ8X8+Ao30RDjxq5DdPWKi
         7d8Q==
X-Received: by 10.50.20.232 with SMTP id q8mr7368738ige.0.1376280509926;
        Sun, 11 Aug 2013 21:08:29 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id x2sm11986256igw.0.2013.08.11.21.08.27
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 11 Aug 2013 21:08:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc2.460.ga591f4a
In-Reply-To: <1376280459-55188-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232148>

The 'todo' sheet for interactive rebase shows abbreviated SHA-1's and
then performs its operations upon those shortened values. This can lead
to an abort if the SHA-1 of a reworded or edited commit is no longer
unique within the abbreviated SHA-1 space and a subsequent SHA-1 in the
todo list has the same abbreviated value.

For example:

  edit f00dfad first
  pick badbeef second

If, after editing, the new SHA-1 of "first" is now
badbeef5ba78983324dff5265c80c4490d5a809a, then the subsequent 'pick
badbeef second' will fail since badbeef is no longer a unique SHA-1
abbreviation:

  error: short SHA1 badbeef is ambiguous.
  fatal: Needed a single revision
  Invalid commit name: badbeef

Demonstrate this problem with a couple of specially crafted commits
which initially have distinct abbreviated SHA-1's, but for which the
abbreviated SHA-1's collide after a simple rewording of the first
commit's message.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t3404-rebase-interactive.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index af141be..e5ebec6 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -977,4 +977,21 @@ test_expect_success 'rebase -i with --strategy and -X' '
 	test $(cat file1) = Z
 '
 
+test_expect_success 'short SHA-1 setup' '
+	test_when_finished "git checkout master" &&
+	git checkout --orphan collide &&
+	git rm -rf . &&
+	unset test_tick &&
+	test_commit collide1 collide &&
+	test_commit --notick collide2 collide &&
+	test_commit --notick "collide3 115158b5" collide collide3 collide3
+'
+
+test_expect_failure 'short SHA-1 collide' '
+	test_when_finished "reset_rebase && git checkout master" &&
+	git checkout collide &&
+	FAKE_COMMIT_MESSAGE="collide2 815200e" \
+	FAKE_LINES="reword 1 2" git rebase -i HEAD~2
+'
+
 test_done
-- 
1.8.4.rc2.460.ga591f4a
