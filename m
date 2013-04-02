From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/4] transport-helper: check if remote helper is alive
Date: Tue,  2 Apr 2013 04:31:47 -0600
Message-ID: <1364898709-21583-3-git-send-email-felipe.contreras@gmail.com>
References: <1364898709-21583-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 12:33:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMyWm-0002P4-7Q
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 12:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762013Ab3DBKcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 06:32:53 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:64091 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761062Ab3DBKcw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 06:32:52 -0400
Received: by mail-yh0-f51.google.com with SMTP id q1so21369yhf.38
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 03:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=dBXorJjBn5MyNauQMFfQF6Oe4twxaVftpfdGG+zyacA=;
        b=PU8rkQHnOZjknDz44YwXWBFuBCB3+1GDtpKQaJrCh4hD2jcan/v7p7awTML9qi6IVm
         hmucXjOZgoUnu+CEULCF3qFsW7ryz7JPgBlxGRz7Qbm29nuU2SSVcDmTjJQ70R/a0+pu
         NKjJGZegSb14ivVI0xtPZYYJQMh6AHR64u8hKjEaazrSWMjQHC7ImM/bYekVhpP9GO4T
         NnilLhoVdzItJm8cqFMtF3kISyiNJsuO5JQKZy/tXEam2wxHmF3T0v19VLpVF4n8nFqW
         cuY2Bcy+VHeoyvc8pPFk2N9f4dDF+sF4EVKEBPMf2rLaOOGGAh7CPGogXJongo6rOBII
         aoeQ==
X-Received: by 10.236.62.130 with SMTP id y2mr13978842yhc.183.1364898771509;
        Tue, 02 Apr 2013 03:32:51 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id v60sm1911631yhh.23.2013.04.02.03.32.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 03:32:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364898709-21583-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219764>

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
