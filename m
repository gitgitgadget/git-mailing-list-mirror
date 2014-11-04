From: Tzvetan Mikov <tmikov@gmail.com>
Subject: [PATCH v2] line-log: fix crash when --first-parent is used
Date: Tue,  4 Nov 2014 12:33:37 -0800
Message-ID: <1415133217-7824-1-git-send-email-tmikov@gmail.com>
References: <1414784636-43155-1-git-send-email-tmikov@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Vander Weele <ericvw@gmail.com>,
	Tzvetan Mikov <tmikov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 04 21:34:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlkoE-00084B-VQ
	for gcvg-git-2@plane.gmane.org; Tue, 04 Nov 2014 21:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbaKDUeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 15:34:31 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:38683 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbaKDUea (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2014 15:34:30 -0500
Received: by mail-pd0-f175.google.com with SMTP id y13so14407452pdi.34
        for <git@vger.kernel.org>; Tue, 04 Nov 2014 12:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yN/XstDqYKRTIe87BnxeRezVn0m8WNzj2CoH1o4y/hc=;
        b=QNmh5FSILkHNPacB4ZDHBws/Z7mMIXVqBf6wQ7+la0FUt5plNHf4N37XuBvR/tSsgO
         1Jv3h1PPNu5yw8OYjYZ4VoHvOrBG+ylExzmrRLkkvIOb/hFZE7jjPlhEV34jQmQdYEJi
         s/jeWZc9W4zAsJacvx0yCTHoQ9oMvLE/GP6zPZMh507ckugC01C5XEU+NovQM7ZKJhFO
         3Sk/No8NlZKSbQnLGLVkEsYZgYS39eWmpQTV260RhV4Tkbn/BBCmVwIAWPw5Bcqmn9bq
         dTO8znxEyLPiIQip7glxWS0AtaNFyR6bLcWzjBD0EOWkY9A8O0rcK3g2dPU/wcz6BITj
         xZjg==
X-Received: by 10.70.10.195 with SMTP id k3mr51910855pdb.41.1415133270301;
        Tue, 04 Nov 2014 12:34:30 -0800 (PST)
Received: from localhost.localdomain ([67.188.241.113])
        by mx.google.com with ESMTPSA id l5sm1217264pdj.12.2014.11.04.12.34.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Nov 2014 12:34:29 -0800 (PST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1414784636-43155-1-git-send-email-tmikov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

line-log tries to access all parents of a commit, but only the first
parent has been loaded if "--first-parent" is specified, resulting
in a crash.

Limit the number of parents to one if "--first-parent" is specified.

Reported-by: Eric N. Vander Weele <ericvw@gmail.com>
Signed-off-by: Tzvetan Mikov <tmikov@gmail.com>
---
 PATCH v2: Add a test case (thanks Michael J Gruber)

 line-log.c          | 3 +++
 t/t4211-line-log.sh | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/line-log.c b/line-log.c
index 1008e72..86e7274 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1141,6 +1141,9 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 	int i;
 	int nparents = commit_list_count(commit->parents);
 
+	if (nparents > 1 && rev->first_parent_only)
+	    nparents = 1;
+
 	diffqueues = xmalloc(nparents * sizeof(*diffqueues));
 	cand = xmalloc(nparents * sizeof(*cand));
 	parents = xmalloc(nparents * sizeof(*parents));
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 7369d3c..0901b30 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -94,4 +94,9 @@ test_expect_success '-L ,Y (Y == nlines + 2)' '
 	test_must_fail git log -L ,$n:b.c
 '
 
+test_expect_success '-L with --first-parent and a merge' '
+	git checkout parallel-change &&
+	git log --first-parent -L 1,1:b.c
+'
+
 test_done
-- 
1.9.1
