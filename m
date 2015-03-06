From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3] git: make "git -C '' <cmd>" not to barf
Date: Fri,  6 Mar 2015 12:35:34 +0530
Message-ID: <1425625534-11869-1-git-send-email-karthik.188@gmail.com>
Cc: gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 08:06:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTmKw-0003th-90
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 08:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbbCFHGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 02:06:13 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:37516 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbbCFHGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 02:06:09 -0500
Received: by pdbnh10 with SMTP id nh10so47033833pdb.4
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 23:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Dnja50K5PJD+PB203kUC65ty+RXmu484OlHZ5s6DEBk=;
        b=t0JWQuN2b8nb/5s15nu3/4IT3DUnJtD4Ey0gAqJDWo4Hx1k9gpG9szpyduXZDPWmGp
         mrEr4Tv+TiAIuJzw/TeVjBRr2mcFszwrByWH41F6HhHPxvI1+Oy5l+qo6iAGYgQZ/OR6
         qY2SAsP3VA1SsoBXE8c5nPaPKw43mhtPSp/8wLkFZPgK0Lm/KkvULsL2YPvyRIhT3V0Y
         jtSUWHgk5aUisM9n+RiAJ5GQJoS/i5tOARaWrDyrdSjbAQ71kK8w38pJl18L3E/QVpT2
         IASP6FoYwMl9VLeY9SPYsd481xYLUOkkqYb6tRY8lUo6N51XsVTk9YilsHHl1WiZVROi
         e28g==
X-Received: by 10.68.134.5 with SMTP id pg5mr22929095pbb.31.1425625569189;
        Thu, 05 Mar 2015 23:06:09 -0800 (PST)
Received: from ashley.localdomain ([182.48.234.2])
        by mx.google.com with ESMTPSA id bl2sm8805135pad.15.2015.03.05.23.06.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Mar 2015 23:06:08 -0800 (PST)
X-Mailer: git-send-email 2.3.1.167.g7f4ba4b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264892>

It now acts like "cd ''" and does not barf and treats
it as a no-op. This is useful if a caller function
does not want to change directory and hence gives no
path value, which would have generally caused git to
output an undesired error message.

Included a simple test to check the same, as suggested
by Junio.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 git.c            | 12 ++++++++----
 t/t0056-git-C.sh |  8 ++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/git.c b/git.c
index 8c7ee9c..d734afa 100644
--- a/git.c
+++ b/git.c
@@ -204,10 +204,14 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				fprintf(stderr, "No directory given for -C.\n" );
 				usage(git_usage_string);
 			}
-			if (chdir((*argv)[1]))
-				die_errno("Cannot change to '%s'", (*argv)[1]);
-			if (envchanged)
-				*envchanged = 1;
+			if (*((*argv)[1]) == 0)
+				; /* DO not change directory if no directory is given*/
+			else {
+				if (chdir((*argv)[1]))
+					die_errno("Cannot change to '%s'", (*argv)[1]);
+				if (envchanged)
+					*envchanged = 1;
+			}
 			(*argv)++;
 			(*argc)--;
 		} else {
diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
index 99c0377..a6b52f1 100755
--- a/t/t0056-git-C.sh
+++ b/t/t0056-git-C.sh
@@ -14,6 +14,14 @@ test_expect_success '"git -C <path>" runs git from the directory <path>' '
 	test_cmp expected actual
 '
 
+test_expect_success '"git -C <path>" with an empty <path> is a no-op' '
+	mkdir -p dir1/subdir &&
+	cd dir1/subdir &&
+	git -C "" rev-parse --show-prefix >actual &&
+	echo subdir/ >expect
+	test_cmp expect actual
+'
+
 test_expect_success 'Multiple -C options: "-C dir1 -C dir2" is equivalent to "-C dir1/dir2"' '
 	test_create_repo dir1/dir2 &&
 	echo 1 >dir1/dir2/b.txt &&
-- 
2.3.1.167.g7f4ba4b.dirty
