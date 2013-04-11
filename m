From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5] transport-helper: report errors properly
Date: Thu, 11 Apr 2013 12:47:14 -0500
Message-ID: <1365702434-24704-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 19:48:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQLbt-0007Bv-1f
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 19:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935655Ab3DKRsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 13:48:19 -0400
Received: from mail-qe0-f54.google.com ([209.85.128.54]:55755 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934868Ab3DKRsS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 13:48:18 -0400
Received: by mail-qe0-f54.google.com with SMTP id s14so1042769qeb.41
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 10:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=+vENWOLjTkYkEO8neDh96mwo5rbNQmaxUzdeQnDteTk=;
        b=cmCi5I6plOnANFns5rxVV5W/0iETNYwrveOrl5spbZGQYkF50PVeK4xbMqNwD7qoCx
         979xV2CGSAg696MTkTcYD2FqIuUsPUgKrIEfCy8AYafdYFcG25VEpOutqv7l9ah+iuCD
         +Na7UQV2Bh91MuKYX9E6y/dNagy5BfzTkZeXzeP4yQyYU4nxquxc9X0dkc5pVWC5o+ck
         5BRJvd798nY6/H3YfYnLp6Bm5Br0zrJjq3ZtAPXrc3Wm0Ib2UMaYODhsFz1wfJO4IiXA
         i6mVF7LRjmY436RQtpXJ6AkrjhaERRrva/NNRcyGG7+eghST1AOt94t8/nK+z8fpxD9e
         uoAQ==
X-Received: by 10.49.11.178 with SMTP id r18mr9133110qeb.56.1365702498297;
        Thu, 11 Apr 2013 10:48:18 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id 10sm8648925qax.13.2013.04.11.10.48.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 10:48:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220899>

If a push fails because the remote-helper died (with fast-export), the
user might not see any error message. So let's add one.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-testgit        | 11 +++++++++++
 t/t5801-remote-helpers.sh | 10 ++++++++++
 transport-helper.c        |  2 +-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/git-remote-testgit b/git-remote-testgit
index b395c8d..472ab1a 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -67,6 +67,17 @@ do
 		echo "done"
 		;;
 	export)
+		if test -n "$GIT_REMOTE_TESTGIT_FAILURE"
+		then
+			# consume input so fast-export doesn't get SIGPIPE; we
+			# want to test the remote-helper's code after
+			# fast-export.
+			while read line; do
+				test "done" = "$line" && break
+			done
+			exit 1
+		fi
+
 		before=$(git for-each-ref --format='%(refname) %(objectname)')
 
 		git fast-import "${testgitmarks_args[@]}" --quiet
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index f387027..8d61702 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -166,4 +166,14 @@ test_expect_success 'push ref with existing object' '
 	compare_refs local dup server dup
 '
 
+test_expect_success 'proper failure checks for pushing' '
+	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
+	export GIT_REMOTE_TESTGIT_FAILURE &&
+	cd local &&
+	test_must_fail git push --all 2> error &&
+	cat error &&
+	grep -q "Reading from remote helper failed" error
+	)
+'
+
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index cb3ef7d..96081cc 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -54,7 +54,7 @@ static int recvline_fh(FILE *helper, struct strbuf *buffer)
 	if (strbuf_getline(buffer, helper, '\n') == EOF) {
 		if (debug)
 			fprintf(stderr, "Debug: Remote helper quit.\n");
-		exit(128);
+		die("Reading from remote helper failed");
 	}
 
 	if (debug)
-- 
1.8.2.1
