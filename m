From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4] transport-helper: report errors properly
Date: Mon,  8 Apr 2013 09:40:04 -0500
Message-ID: <1365432004-20132-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 18:33:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPEzs-0003oz-OW
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083Ab3DHOlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 10:41:07 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:45859 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935023Ab3DHOlG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 10:41:06 -0400
Received: by mail-oa0-f43.google.com with SMTP id l10so6243112oag.30
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 07:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=XMXSac1mOmhFiz8W/7gIzddrjG9YpW2Ud6Sv/0MhHPU=;
        b=mrO9Kc3HTAe/vBKPfM1QUrBVRVEJuEkm+VROR80d+ClFv4ixQtq7YVOEIqwutA7wkY
         bU1JV1+18R6LzClhCJBWaEksyXRPD9VSQLvJvjD7+FowV96G/J4ICfBiP5O7sPmACy0U
         MRccC5OZf/MSOR73Peva05NHeGcc6k3ANwKf2USidxl/O5ZNmpggT9xKXepzU/EdasWG
         pgN793+v1Dgob4T+22ryfSgZRlHMuYXuLD1060bQWNlHDzOIt9zECwn7c6ZJFa3bPhQ3
         Ipvs8NULwgpqabs06e9wprwLSAQ4qG1q4i9q16UVpE2wIFpKnQBbkOEorIeCgzS/eagy
         fsyQ==
X-Received: by 10.60.95.70 with SMTP id di6mr6164505oeb.10.1365432065427;
        Mon, 08 Apr 2013 07:41:05 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id a3sm25464507oee.8.2013.04.08.07.41.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 07:41:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220427>

If a push fails because the remote-helper died (with fast-export), the
user won't see any error message. So let's add one.

At the same time lets add tests to ensure this error is reported, and
while we are at it, check the error from fast-import

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-testgit        | 13 +++++++++++++
 t/t5801-remote-helpers.sh | 21 +++++++++++++++++++++
 transport-helper.c        |  2 +-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/git-remote-testgit b/git-remote-testgit
index b395c8d..2eb7889 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -61,12 +61,25 @@ do
 			echo "feature import-marks=$gitmarks"
 			echo "feature export-marks=$gitmarks"
 		fi
+
+		if test -n "$GIT_REMOTE_TESTGIT_FAILURE"
+		then
+			echo "feature done"
+			exit 1
+		fi
+
 		echo "feature done"
 		git fast-export "${testgitmarks_args[@]}" $refs |
 		sed -e "s#refs/heads/#${prefix}/heads/#g"
 		echo "done"
 		;;
 	export)
+		if test -n "$GIT_REMOTE_TESTGIT_FAILURE"
+		then
+			sleep 1 # don't let fast-export get SIGPIPE
+			exit 1
+		fi
+
 		before=$(git for-each-ref --format='%(refname) %(objectname)')
 
 		git fast-import "${testgitmarks_args[@]}" --quiet
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index f387027..2dfcf64 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -166,4 +166,25 @@ test_expect_success 'push ref with existing object' '
 	compare_refs local dup server dup
 '
 
+test_expect_success 'proper failure checks for fetching' '
+	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
+	export GIT_REMOTE_TESTGIT_FAILURE &&
+	cd local &&
+	test_must_fail git fetch 2> error &&
+	cat error &&
+	grep -q "Error while running fast-import" error
+	)
+'
+
+# We sleep to give fast-export a chance to catch the SIGPIPE
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
1.8.2
