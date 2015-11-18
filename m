From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v1] annotate: skip checking working tree if a revision is provided
Date: Tue, 17 Nov 2015 19:20:09 -0600
Message-ID: <1447809609-17556-1-git-send-email-eantoranz@gmail.com>
Cc: sunshine@sunshineco.com, peff@peff.net,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 18 02:20:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyrQ9-0000Fx-84
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 02:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992AbbKRBUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 20:20:20 -0500
Received: from mail-yk0-f181.google.com ([209.85.160.181]:32940 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbbKRBUT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 20:20:19 -0500
Received: by ykdv3 with SMTP id v3so39220295ykd.0
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 17:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=15xdAn/jyg2yPF5SS7pMUzsFSi2YmSTqYWzPAbTTwVk=;
        b=D7J7h7A9VkzsCKfrLf2DnilKxK8xSyH0BbgkFwD9nC7e/ovc2s73xmhA/tQNgXmT0y
         0OvJQpE2Hz7uedekqO1RemJwpJv8bzpwaMEU90hpZuNWICto1QXGxODDhtR99mNokoo3
         wv4rV/nfUmxCclbdOTvc1G65yGwhkKtPBzJmdl6xItt09kxfH2wMsV7RVgCVwZXvWHMO
         4iTPtT1yGvPCvnmD0TYZQzEeiNi2/VspcthAD5IWxPhrMqZp2b+zvwJs/ZzZQ+7i+BND
         wa7bwz4WaVzNdKJG718lXIH+WtZSWadwBJvs+A75U1a1htnEA4H6FMvE2QTdqJmH2Zw9
         o3Iw==
X-Received: by 10.129.110.70 with SMTP id j67mr48165763ywc.180.1447809619455;
        Tue, 17 Nov 2015 17:20:19 -0800 (PST)
Received: from linuxerio.cabletica.com (ip157-11-15-186.ct.co.cr. [186.15.11.157])
        by smtp.gmail.com with ESMTPSA id n76sm428323ywn.0.2015.11.17.17.20.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 17 Nov 2015 17:20:18 -0800 (PST)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281436>

If a file has been deleted/renamed, annotate refuses to work
because the file does not exist on the working tree anymore
(even if the path provided does match a blob on said revision).

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 builtin/blame.c     |  5 +++--
 t/annotate-tests.sh | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 83612f5..856971a 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2683,12 +2683,13 @@ parse_done:
 		argv[argc - 1] = "--";
 
 		setup_work_tree();
-		if (!file_exists(path))
-			die_errno("cannot stat path '%s'", path);
 	}
 
 	revs.disable_stdin = 1;
 	setup_revisions(argc, argv, &revs, NULL);
+	if (!revs.pending.nr && !file_exists(path))
+		die_errno("cannot stat path '%s'", path);
+
 	memset(&sb, 0, sizeof(sb));
 
 	sb.revs = &revs;
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index b1673b3..c99ec41 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -567,3 +567,23 @@ test_expect_success 'blame -L X,-N (non-numeric N)' '
 test_expect_success 'blame -L ,^/RE/' '
 	test_must_fail $PROG -L1,^/99/ file
 '
+
+test_expect_success 'annotate deleted file' '
+	echo hello world > hello_world.txt &&
+	git add hello_world.txt &&
+	git commit -m "step 1" &&
+	git rm hello_world.txt &&
+	git commit -m "step 2" &&
+	git annotate hello_world.txt HEAD~1 &&
+	test_must_fail git annotate hello_world.txt
+'
+
+test_expect_success 'annotate moved file' '
+	echo hello world > hello_world.txt &&
+	git add hello_world.txt &&
+	git commit -m "step 1" &&
+	git mv hello_world.txt not_there_anymore.txt &&
+	git commit -m "step 2" &&
+	git annotate hello_world.txt HEAD~1 &&
+	test_must_fail git annotate hello_world.txt
+'
-- 
2.6.2
