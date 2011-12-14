From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 06/10] t3502, t3510: clarify cherry-pick -m failure
Date: Wed, 14 Dec 2011 22:24:33 +0530
Message-ID: <1323881677-11117-7-git-send-email-artagnon@gmail.com>
References: <CALkWK0kbV2WFfGVrA9m_Uwd4J8+U9Yde9Wxb-OZE9Y8K+Ta_4A@mail.gmail.com>
 <1323881677-11117-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 17:55:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ras7C-0004kJ-Fv
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 17:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757620Ab1LNQzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 11:55:11 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61872 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757606Ab1LNQzK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 11:55:10 -0500
Received: by mail-vx0-f174.google.com with SMTP id fk14so763696vcb.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 08:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=geLxQNe27ckBzVPsrf1uDprHOCgyl3WYB2dX3T75T/s=;
        b=EkeJPpr9CwvWQoIZdMdLReZPOZeOJKoG1sc6+Fd2U7e3uhhQCxR8hTDYEEWh+Qnugw
         mlsd7c2U2V3g2jKpZACSyV7UOQNGfQ9ctNvZeHchad5Cp6+g54PcB6rrrlTiKBWE7QXC
         PUgqVuD7hKoMSgo3PEpwB0fyY3S0e12bf/50w=
Received: by 10.52.28.211 with SMTP id d19mr5387353vdh.48.1323881710169;
        Wed, 14 Dec 2011 08:55:10 -0800 (PST)
Received: from localhost.localdomain ([122.174.116.246])
        by mx.google.com with ESMTPS id ir2sm2963127vdb.9.2011.12.14.08.55.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 08:55:09 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1323881677-11117-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187150>

The "cherry-pick persists opts correctly" test in t3510
(cherry-pick-sequence) can cause some confusion, because the command
actually has two points of failure:

1. "-m 1" is specified on the command-line despite the base commit
   "initial" not being a merge-commit.
2. The revision range indicates that there will be a conflict that
   needs to be resolved.

Although the former error is trapped, and cherry-pick die()s with the
exit status 128, the reader may be distracted by the latter.  Fix this
by changing the revision range to something that wouldn't cause a
conflict.  Additionally, explicitly check the exit code in
"cherry-pick a non-merge with -m should fail" in t3502
(cherry-pick-merge) to reassure the reader that this failure has
nothing to do with the sequencer itself.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t3502-cherry-pick-merge.sh    |    2 +-
 t/t3510-cherry-pick-sequence.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3502-cherry-pick-merge.sh b/t/t3502-cherry-pick-merge.sh
index 0ab52da..e37547f 100755
--- a/t/t3502-cherry-pick-merge.sh
+++ b/t/t3502-cherry-pick-merge.sh
@@ -35,7 +35,7 @@ test_expect_success 'cherry-pick a non-merge with -m should fail' '
 
 	git reset --hard &&
 	git checkout a^0 &&
-	test_must_fail git cherry-pick -m 1 b &&
+	test_expect_code 128 git cherry-pick -m 1 b &&
 	git diff --exit-code a --
 
 '
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index b6e822e..163ce7d 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -53,7 +53,7 @@ test_expect_success 'cherry-pick persists data on failure' '
 
 test_expect_success 'cherry-pick persists opts correctly' '
 	pristine_detach initial &&
-	test_expect_code 128 git cherry-pick -s -m 1 --strategy=recursive -X patience -X ours base..anotherpick &&
+	test_expect_code 128 git cherry-pick -s -m 1 --strategy=recursive -X patience -X ours initial..anotherpick &&
 	test_path_is_dir .git/sequencer &&
 	test_path_is_file .git/sequencer/head &&
 	test_path_is_file .git/sequencer/todo &&
-- 
1.7.4.1
