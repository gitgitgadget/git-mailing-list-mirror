From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/4] transport-helper: check if remote helper is alive
Date: Mon,  1 Apr 2013 15:46:42 -0600
Message-ID: <1364852804-31875-3-git-send-email-felipe.contreras@gmail.com>
References: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 01 23:48:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMmaW-0003mS-Ga
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 23:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758955Ab3DAVrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 17:47:47 -0400
Received: from mail-gh0-f179.google.com ([209.85.160.179]:57705 "EHLO
	mail-gh0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758702Ab3DAVrp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 17:47:45 -0400
Received: by mail-gh0-f179.google.com with SMTP id z12so467809ghb.38
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 14:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=BAT5QbCH+PqwTchzBIJeOWFu8IUhAbp1VweJc9YANpE=;
        b=WIBWoK7hH2hFAk5CmEG50O9rDjioYl6FHy3kwSn8qNxtXBpu73eE1JrHOaG5v1+dKU
         hRKZlmRPODrVIin2cpxQTR1Nr0X9BYQu+tjazwBLf7+mBYTq4We0Is0zd7YxDec9fTeA
         zpD6bFMbT9Z2pYTloGfETgoJMwCxdNqFyfsldduOeSUA/QtDDLc1JCw3JTDQp9nnBK9C
         HCWnGfs9boZih2MXkgd/aTab3n/2oCIlzowHQwzITvxN/fwcRjlovVdgjlnOvw4H79SV
         Ex/4ynZhkc125HMsnv+vahz94OcujiGAttWqmbIF7UqPRZB52V41KiK5wIlbh/a1HoEd
         vrFA==
X-Received: by 10.236.208.34 with SMTP id p22mr12127460yho.114.1364852865147;
        Mon, 01 Apr 2013 14:47:45 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id w69sm30015824yhe.4.2013.04.01.14.47.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Apr 2013 14:47:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219714>

Otherwise transport-helper will continue checking for refs and other
things what will confuse the user more.
---
 git-remote-testgit        | 11 +++++++++++
 t/t5801-remote-helpers.sh | 19 +++++++++++++++++++
 transport-helper.c        |  8 ++++++++
 3 files changed, 38 insertions(+)

diff --git a/git-remote-testgit b/git-remote-testgit
index b395c8d..ca0cf09 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -61,12 +61,23 @@ do
 			echo "feature import-marks=$gitmarks"
 			echo "feature export-marks=$gitmarks"
 		fi
+
+		if test -n "$GIT_REMOTE_TESTGIT_FAILURE"
+		then
+			exit -1
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
+			exit -1
+		fi
+
 		before=$(git for-each-ref --format='%(refname) %(objectname)')
 
 		git fast-import "${testgitmarks_args[@]}" --quiet
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index f387027..26e9a5b 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -166,4 +166,23 @@ test_expect_success 'push ref with existing object' '
 	compare_refs local dup server dup
 '
 
+test_expect_success 'proper failure checks for fetching' '
+	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
+	export GIT_REMOTE_TESTGIT_FAILURE &&
+	cd local &&
+	test_must_fail git fetch 2>&1 | \
+		grep "Error while running helper"
+	)
+'
+
+# We sleep to give fast-export a chance to catch the SIGPIPE
+test_expect_failure 'proper failure checks for pushing' '
+	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
+	export GIT_REMOTE_TESTGIT_FAILURE &&
+	cd local &&
+	test_must_fail git push --all 2>&1 | \
+		grep "Error while running helper"
+	)
+'
+
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index cb3ef7d..dfdfa7a 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -460,6 +460,10 @@ static int fetch_with_import(struct transport *transport,
 
 	if (finish_command(&fastimport))
 		die("Error while running fast-import");
+
+	if (!check_command(data->helper))
+		die("Error while running helper");
+
 	argv_array_free_detached(fastimport.argv);
 
 	/*
@@ -818,6 +822,10 @@ static int push_refs_with_export(struct transport *transport,
 
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
+
+	if (!check_command(data->helper))
+		die("Error while running helper");
+
 	push_update_refs_status(data, remote_refs);
 	return 0;
 }
-- 
1.8.2
