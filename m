From: Benoit Person <benoit.person@gmail.com>
Subject: [PATCH v2] git-remote-mediawiki: bugfix for pages w/ >500 revisions
Date: Mon, 23 Sep 2013 19:26:15 +0200
Message-ID: <1379957175-8606-1-git-send-email-benoit.person@gmail.fr>
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Benoit Person <benoit.person@gmail.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 19:26:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VO9uD-0006ga-Kt
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 19:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938Ab3IWR0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 13:26:37 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:40179 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab3IWR0h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 13:26:37 -0400
Received: by mail-wg0-f47.google.com with SMTP id f12so3447216wgh.14
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 10:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=6co0vi0eGHZXcOxv3jrN1XMjW0suS4irlCYPoZC7DbY=;
        b=E4dNc4Y4iS4r/aVeDjvSDi5S2WpW4q32tMcvZBzozcTi+guGNTagrEtxgVeqw4B8gY
         y2DO42SHxb0graCdH0ti1BUsfU9rEz4Yrg7TEJMzoPh0Y47XtMj9+DDXt/nFfnJJQS9A
         Kendl3Uts2rLiJ2p8p9+jvGVJV6YdUMUdzLYC9fRus7G8z4IjkF9rIFp4tD63NwjUTSZ
         J20v+wBYNbuvntHh/fSHyY5+FrB9BvMXL4/QqSsLDvg51hfZansCeYP9FkSouOFpzy6z
         mQ4IYuqb9LQv3MWkn1KN8l4Nb+74Jcbkf0tMJ4/i6DnKJ71syyhPblNypCuX2muiwv0U
         RXAA==
X-Received: by 10.194.240.197 with SMTP id wc5mr18859835wjc.23.1379957195830;
        Mon, 23 Sep 2013 10:26:35 -0700 (PDT)
Received: from localhost.localdomain (ip-145.net-81-220-163.rev.numericable.fr. [81.220.163.145])
        by mx.google.com with ESMTPSA id b13sm27018290wic.9.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 23 Sep 2013 10:26:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235209>

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

Signed-off-by: Benoit Person <benoit.person@gmail.fr>
Reported-by: Benjamin Cathey
---
 contrib/mw-to-git/git-remote-mediawiki.perl     | 14 ++++++++++++--
 contrib/mw-to-git/t/t9365-continuing-queries.sh | 24 ++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)
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
