From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 2/2] transport-helper: check if remote helper is alive
Date: Sun,  7 Apr 2013 01:45:06 -0600
Message-ID: <1365320706-13539-3-git-send-email-felipe.contreras@gmail.com>
References: <1365320706-13539-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 09:46:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOkIs-0000uU-Fe
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 09:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161323Ab3DGHqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 03:46:13 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:59354 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756122Ab3DGHqM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 03:46:12 -0400
Received: by mail-ob0-f182.google.com with SMTP id ef5so4908099obb.13
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 00:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=dBXorJjBn5MyNauQMFfQF6Oe4twxaVftpfdGG+zyacA=;
        b=KC9np1cxpWLEN0jqIkMI1caZc0zEOuG+3JN0CwbQcL8Kv4J3/hi43Xu0vTmKxY4JUC
         SVUXy7z/8lr8GeX5Hk3JdLT7jdgADSCmNhXAXNIXkHUWiNrwSpZqit8mdW3S6uYo3Bmf
         Kh20h6SXIi+JiqXqQPtoIsNWORjFw1gG2SmLPg3QGr7RW7dlf01HH/54UCKEgG/iTYTx
         Mm9vlHBkCaeFyBRerovd7Oat5zShPZORLlMgMPG20Fmbj4v9gqnc3HjkN6JhIKrSkBh/
         cffd0HAKhAU/iJItaMdJuVpvXvTtH7YHAuNwdEcQPjLfJG9FbfGF0z57YYUebYReOKYQ
         8V+g==
X-Received: by 10.60.142.103 with SMTP id rv7mr11949642oeb.34.1365320771504;
        Sun, 07 Apr 2013 00:46:11 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id m7sm19233649obk.2.2013.04.07.00.46.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 00:46:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365320706-13539-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220292>

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
index f387027..efe67e2 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -166,4 +166,23 @@ test_expect_success 'push ref with existing object' '
 	compare_refs local dup server dup
 '
 
+test_expect_success 'proper failure checks for fetching' '
+	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
+	export GIT_REMOTE_TESTGIT_FAILURE &&
+	cd local &&
+	test_must_fail git fetch 2> error &&
+	grep "Error while running helper" error
+	)
+'
+
+# We sleep to give fast-export a chance to catch the SIGPIPE
+test_expect_failure 'proper failure checks for pushing' '
+	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
+	export GIT_REMOTE_TESTGIT_FAILURE &&
+	cd local &&
+	test_must_fail git push --all 2> error &&
+	grep "Error while running helper" error
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
