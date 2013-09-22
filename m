From: Benoit Person <benoit.person@gmail.com>
Subject: [PATCH] git-remote-mediawiki: bugfix for pages w/ >500 revisions
Date: Sun, 22 Sep 2013 20:44:27 +0200
Message-ID: <1379875468-24952-1-git-send-email-benoit.person@gmail.fr>
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Benoit Person <benoit.person@gmail.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 22 20:46:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNofx-0000y1-Uc
	for gcvg-git-2@plane.gmane.org; Sun, 22 Sep 2013 20:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921Ab3IVSpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Sep 2013 14:45:18 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:33784 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708Ab3IVSpF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 14:45:05 -0400
Received: by mail-wg0-f49.google.com with SMTP id l18so2380945wgh.16
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 11:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=tFustgdAcw7Pf7FIf69TmPehbTNWXf7mzkh4h3g1y2w=;
        b=xJL0dtLIMxavGW9llRcqLHxSYnC4049uFNSimFF/5L9cWWiu7i3ZAZsBxQcUeYUoQr
         URoPfBxCLzlpqPJXj/5IYVMEiuBDWV68UTjBFu0r2OnEtRfdC+48ZEyfoimexzVeBjoA
         anPZ+sqLr1wgKKK9d+mCI+yID1BLkysEz6CLl4ATGYgpWQ9j09chXjV5+MIWW/99GKW6
         Wa0pEjjyIbmm/vRpuUOm0exdjIfU6dkL/09YX/qIpkvB+W9FDqn23m9UNip4X7pI3vtg
         bFcsyR6D/TvLkxTtee9tokoP+abEN5PuIFANByvu/wNodQoYqq9kIuCQc6NxKAHR6cLD
         yvaA==
X-Received: by 10.194.75.165 with SMTP id d5mr14088962wjw.18.1379875504954;
        Sun, 22 Sep 2013 11:45:04 -0700 (PDT)
Received: from localhost.localdomain (ip-145.net-81-220-163.rev.numericable.fr. [81.220.163.145])
        by mx.google.com with ESMTPSA id fb9sm20423754wid.7.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 11:45:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235169>

Mediawiki introduced a new API for queries w/ more than 500 results in
version 1.21. That change triggered an infinite loop while cloning a
mediawiki with such a page.

Fix that while still preserving the old behavior for old APIs.

Signed-off-by: Benoit Person <benoit.person@gmail.fr>
Reported-by: Benjamin Cathey
---

Patch tested for all mediawiki versions from 1.19 to 1.21.

For now, if the tests suite is run without the fix, the new test
introduces an infinite loop. I am not sure if this should be handled ?
(a timeout of some kind maybe ?)

 contrib/mw-to-git/git-remote-mediawiki.perl     | 14 ++++++++++++--
 contrib/mw-to-git/t/t9365-continuing-queries.sh | 24 ++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)
 create mode 100755 contrib/mw-to-git/t/t9365-continuing-queries.sh

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index c9a4805..2d7af57 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -625,6 +625,9 @@ sub fetch_mw_revisions_for_page {
 		rvstartid => $fetch_from,
 		rvlimit => 500,
 		pageids => $id,
+
+                # let the mediawiki knows that we support the latest API
+                continue => '',
 	};
 
 	my $revnum = 0;
@@ -640,8 +643,15 @@ sub fetch_mw_revisions_for_page {
 			push(@page_revs, $page_rev_ids);
 			$revnum++;
 		}
-		last if (!$result->{'query-continue'});
-		$query->{rvstartid} = $result->{'query-continue'}->{revisions}->{rvstartid};
+
+                if ($result->{'query-continue'}) { # For legacy APIs
+                    $query->{rvstartid} = $result->{'query-continue'}->{revisions}->{rvstartid};
+                } elsif ($result->{continue}) { # For newer APIs
+                    $query->{rvstartid} = $result->{continue}->{rvcontinue};
+                    $query->{continue} = $result->{continue}->{continue};
+                } else {
+                    last;
+                }
 	}
 	if ($shallow_import && @page_revs) {
 		print {*STDERR} "  Found 1 revision (shallow import).\n";
diff --git a/contrib/mw-to-git/t/t9365-continuing-queries.sh b/contrib/mw-to-git/t/t9365-continuing-queries.sh
new file mode 100755
index 0000000..6fb5df4
--- /dev/null
+++ b/contrib/mw-to-git/t/t9365-continuing-queries.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+test_description='Test the Git Mediawiki remote helper: queries w/ more than 500 results'
+
+. ./test-gitmw-lib.sh
+. ./push-pull-tests.sh
+. $TEST_DIRECTORY/test-lib.sh
+
+test_check_precond
+
+test_expect_success 'creating page w/ >500 revisions' '
+	wiki_reset &&
+	for i in $(seq 1 501)
+	do
+		echo "creating revision $i"
+		wiki_editpage foo "revision $i<br/>" true
+	done
+'
+
+test_expect_success 'cloning page w/ >500 revisions' '
+	git clone mediawiki::'"$WIKI_URL"' mw_dir
+'
+
+test_done
-- 
1.8.4.GIT
