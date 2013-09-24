From: Benoit Person <benoit.person@gmail.com>
Subject: [PATCH v3] git-remote-mediawiki: bugfix for pages w/ >500 revisions
Date: Tue, 24 Sep 2013 21:32:30 +0200
Message-ID: <1380051150-6863-1-git-send-email-benoit.person@gmail.com>
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Benoit Person <benoit.person@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 24 21:32:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOYLs-0003W8-Rq
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 21:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518Ab3IXTct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 15:32:49 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:55434 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015Ab3IXTcs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 15:32:48 -0400
Received: by mail-wg0-f43.google.com with SMTP id z12so4996039wgg.34
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 12:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9bDxld0sTw8XqAaAyi59Ur6lLZkcXwK9xhJJxPNB19k=;
        b=p2bcRV7MS0gzevvknMbvX3yBJA55HTx4nAfC1iKPGa+xIGFB8JawhtATrq8uRRlc+y
         75/+zwUu+r1CNthNfCREnsfVKWpUZ5PW5qY/VeCpHvNz1KQqaWJOByuMQJjRcEu9AM4H
         eWBFH8orBGBLHyEXGbMukiaMjDDwYgyIyhUhBdG+JA8yGuCUOUBye7LSxi9IFiOpObtb
         zFTcLy/PSllB8geUb/0tiHyBZ3pFt3iZZr+dH3lxA3f4ByXJeQ8hsgj4SWk5mZqdlRZV
         rMt0YkCvq08iWKSjTHSj40qOHvaHtii0rZSqYNNzjKeX6weZV25xFPJt9b8cde3EegMC
         4ASg==
X-Received: by 10.194.175.66 with SMTP id by2mr2890455wjc.59.1380051167285;
        Tue, 24 Sep 2013 12:32:47 -0700 (PDT)
Received: from localhost.localdomain (ip-145.net-81-220-163.rev.numericable.fr. [81.220.163.145])
        by mx.google.com with ESMTPSA id iz19sm10543146wic.9.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 24 Sep 2013 12:32:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235311>

Mediawiki introduces a new API for queries w/ more than 500 results in
version 1.21. That change triggered an infinite loop while cloning a
mediawiki with such a page.

The latest API renamed and moved the "continuing" information in the
response, necessary to build the next query. The code failed to retrieve
that information but still detected that it was in a "continuing
query". As a result, it launched the same query over and over again.

If a "continuing" information is detected in the response (old or new),
the next query is updated accordingly. If not, we quit assuming it's not
a continuing query.

Signed-off-by: Benoit Person <benoit.person@gmail.com>
Reported-by: Benjamin Cathey
---
 contrib/mw-to-git/git-remote-mediawiki.perl     | 14 ++++++++++++--
 contrib/mw-to-git/t/t9365-continuing-queries.sh | 23 +++++++++++++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100755 contrib/mw-to-git/t/t9365-continuing-queries.sh

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index c9a4805..f1db5d2 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -625,6 +625,9 @@ sub fetch_mw_revisions_for_page {
 		rvstartid => $fetch_from,
 		rvlimit => 500,
 		pageids => $id,
+
+		# let the mediawiki know that we support the latest API
+		continue => '',
 	};
 
 	my $revnum = 0;
@@ -640,8 +643,15 @@ sub fetch_mw_revisions_for_page {
 			push(@page_revs, $page_rev_ids);
 			$revnum++;
 		}
-		last if (!$result->{'query-continue'});
-		$query->{rvstartid} = $result->{'query-continue'}->{revisions}->{rvstartid};
+
+		if ($result->{'query-continue'}) { # For legacy APIs
+			$query->{rvstartid} = $result->{'query-continue'}->{revisions}->{rvstartid};
+		} elsif ($result->{continue}) { # For newer APIs
+			$query->{rvstartid} = $result->{continue}->{rvcontinue};
+			$query->{continue} = $result->{continue}->{continue};
+		} else {
+			last;
+		}
 	}
 	if ($shallow_import && @page_revs) {
 		print {*STDERR} "  Found 1 revision (shallow import).\n";
diff --git a/contrib/mw-to-git/t/t9365-continuing-queries.sh b/contrib/mw-to-git/t/t9365-continuing-queries.sh
new file mode 100755
index 0000000..27e267f
--- /dev/null
+++ b/contrib/mw-to-git/t/t9365-continuing-queries.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+test_description='Test the Git Mediawiki remote helper: queries w/ more than 500 results'
+
+. ./test-gitmw-lib.sh
+. $TEST_DIRECTORY/test-lib.sh
+
+test_check_precond
+
+test_expect_success 'creating page w/ >500 revisions' '
+	wiki_reset &&
+	for i in `test_seq 501`
+	do
+		echo "creating revision $i" &&
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
