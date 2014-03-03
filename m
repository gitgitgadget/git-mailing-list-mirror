From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: [PATCH 2/2] test-lib: GIT_TEST_ONLY to run only specific tests
Date: Mon,  3 Mar 2014 02:24:58 -0800
Message-ID: <1393842298-5944-2-git-send-email-ilya.bobyr@gmail.com>
References: <1393842298-5944-1-git-send-email-ilya.bobyr@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>,
	Ilya Bobyr <ilya.bobyr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 11:25:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKQ4F-0003gp-Sw
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 11:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218AbaCCKZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 05:25:48 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:57004 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbaCCKZr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 05:25:47 -0500
Received: by mail-pa0-f45.google.com with SMTP id kl14so1216183pab.18
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 02:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m7X0AAJg4DqpnKbNeUqpygZ3NPwQ4kju2jobrxJIpEA=;
        b=Clb4LodrO2fzAce71RCunbUo/duc6UWD+UcGq4jY5t/HCJ3Iez4IXFIes62RcF5JM4
         nboGut8FVadnx0k/f6pK6l1Yn/jwg0WU6vOzDJ75LigyoGDCBMI+cJJ4DgBcUmo9a7Cc
         9bk0SoxqC7897Fcle/P7/iNykeBK+HyhFDFPcKJCx/0dyncEX3fPuXDKPr6iiz5dMg5e
         OipkKOmepS5HsYAsAU3LVETcu6TNja1pw9MSIFjFTd9JXM7g95+lD56hSB9Nw0FXBcV9
         t5gIYFkrFHpCcrCQI2T+L4/+sSAixxi9ROA5jBHgosUNDSmn2TcX4Vw7XQm8pniEp8F4
         CGiw==
X-Received: by 10.68.66.103 with SMTP id e7mr5485392pbt.120.1393842346444;
        Mon, 03 Mar 2014 02:25:46 -0800 (PST)
Received: from localhost.localdomain (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id kc9sm34578578pbc.25.2014.03.03.02.25.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Mar 2014 02:25:45 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1393842298-5944-1-git-send-email-ilya.bobyr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243215>

This is a counterpart to GIT_SKIP_TESTS.  Mostly useful when debugging.
---
 t/README      |   15 +++++++++++++++
 t/test-lib.sh |    8 ++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index caeeb9d..f939987 100644
--- a/t/README
+++ b/t/README
@@ -187,6 +187,21 @@ and either can match the "t[0-9]{4}" part to skip the whole
 test, or t[0-9]{4} followed by ".$number" to say which
 particular test to skip.
 
+Sometimes the opposite is desired - ability to execute only one or
+several tests.  Mostly while debugging tests.  For that you can say
+
+    $ GIT_TEST_ONLY=t9200.8 sh ./t9200-git-cvsexport-commit.sh
+
+or, similrary to GIT_SKIP_TESTS
+
+    $ GIT_TEST_ONLY='t[0-4]??? t91?? t9200.8' make
+
+In additiona to matching against "<test suite number>.<test number>"
+GIT_TEST_ONLY is matched against just the test numbes.  This comes
+handy when you are running only one test:
+
+    $ GIT_TEST_ONLY='[0-8]' sh ./t9200-git-cvsexport-commit.sh
+
 Note that some tests in the existing test suite rely on previous
 test item, so you cannot arbitrarily disable one and expect the
 remainder of test to check what the test originally was intended
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 89a405b..12bf436 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -464,6 +464,14 @@ test_skip () {
 		fi
 		skipped_reason="missing $missing_prereq${of_prereq}"
 	fi
+	if test -z "$to_skip" && test -n "$GIT_TEST_ONLY" &&
+		! match_pattern_list $this_test.$test_count $GIT_TEST_ONLY &&
+		! match_pattern_list $test_count $GIT_TEST_ONLY
+	then
+		to_skip=t
+		skipped_reason="not in GIT_TEST_ONLY"
+	fi
+
 	case "$to_skip" in
 	t)
 		say_color skip >&3 "skipping test: $@"
-- 
1.7.9
