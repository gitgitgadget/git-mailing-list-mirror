From: Iustin Pop <iusty@k1024.org>
Subject: [PATCH] Pass $verbosity from git pull to git rebase
Date: Sat, 26 May 2012 03:00:39 +0200
Message-ID: <20120526010038.GA16694@hq.k1024.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 03:01:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY5NK-0003uu-Pb
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 03:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364Ab2EZBAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 21:00:55 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33494 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745Ab2EZBAm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 21:00:42 -0400
Received: by wibhn6 with SMTP id hn6so40292wib.1
        for <git@vger.kernel.org>; Fri, 25 May 2012 18:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:x-linux:x-header:user-agent:x-gm-message-state;
        bh=xsGKsXd/AY42vXnoStnUqt0uuevNpK0ui48MNvcmc2I=;
        b=eXXL7Ek4m1HhEEf4k2aWdzK9c6Dn8Seha8/KW+KRyJf/z29qhx9+39SKwtVgJnooXg
         xnRcrT2YvF3ltDKVVeD1DxFZfRJWPrFzY0LI60BHfRYQDWIIIQGhMpaAnLYhcTv5eQsn
         zE3WodmkJwTRSCLTq3Aqd2QTPJW5Wd7oBFgyKlusqYgqqKzGXPxAvMsJcoT6G/6wVXMw
         C0TvhrIDrkvxXPKU+h8wFpZltqswWc2b+3OTIhFKD/6rpeENqaRB/PUD4lE9SKAZaLRy
         gfB2DzsF4Tx7IZCj6y2Tr4FX32xYhHPvPVXuqV+s/L9quapgSzPm3spq0Q9L9NUrga0f
         7n1w==
Received: by 10.216.131.223 with SMTP id m73mr466543wei.76.1337994041602;
        Fri, 25 May 2012 18:00:41 -0700 (PDT)
Received: from teal.hq.k1024.org (46-126-106-189.dynamic.hispeed.ch. [46.126.106.189])
        by mx.google.com with ESMTPS id eo5sm1160620wib.0.2012.05.25.18.00.40
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 25 May 2012 18:00:40 -0700 (PDT)
Received: from ruru.hq.k1024.org (ruru.hq.k1024.org [10.1.167.27])
	by teal.hq.k1024.org (Postfix) with ESMTP id 1B2E3246B2B
	for <git@vger.kernel.org>; Sat, 26 May 2012 03:00:39 +0200 (CEST)
Received: by ruru.hq.k1024.org (Postfix, from userid 4004)
	id 14AE562B445; Sat, 26 May 2012 03:00:39 +0200 (CEST)
Content-Disposition: inline
X-Linux: This message was written on Linux
X-Header: /usr/include gives great headers
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQnZnXcnjxsn6zra7ULv89amOQ18KFLKw7kHhyoxSL8fh7/KM+LQiOYFXOj6iW7wlNVGQrdy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198533>

Currently "git pull -q" only takes effect in merge mode, as commit
7f87aff2 (which introduced "git pull -q") only passes it to
git-merge. This is not nice as a "git pull --rebase -q" will result in
the "Current branch master is up to date.", instead of being quiet.

The patch adds a simple unit-test that checks that the initial pull, a
pull that forwards the head, and a no-op pull are all silent.

Signed-off-by: Iustin Pop <iusty@k1024.org>
---
 Please keep me CC-ed, not subscribed to the list.

 git-pull.sh             |    2 +-
 t/t5521-pull-options.sh |   15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 2a10047..2920c69 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -278,7 +278,7 @@ fi
 merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 case "$rebase" in
 true)
-	eval="git-rebase $diffstat $strategy_args $merge_args"
+	eval="git-rebase $diffstat $strategy_args $merge_args $verbosity"
 	eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
 	;;
 *)
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 1b06691..9735fb4 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -8,7 +8,9 @@ test_expect_success 'setup' '
 	mkdir parent &&
 	(cd parent && git init &&
 	 echo one >file && git add file &&
-	 git commit -m one)
+	 git commit -m one &&
+	 echo two >file && git add file &&
+	 git commit -m two)
 '
 
 test_expect_success 'git pull -q' '
@@ -19,6 +21,17 @@ test_expect_success 'git pull -q' '
 	test ! -s out)
 '
 
+test_expect_success 'git pull -q --rebase' '
+	mkdir clonedqr &&
+	(cd clonedqr && git init &&
+	git pull -q --rebase "../parent" >out 2>err &&
+	git reset --hard -q HEAD^ >>out 2>>err &&
+	git pull -q --rebase "../parent" >>out 2>>err &&
+	git pull -q --rebase "../parent" >>out 2>>err &&
+	test ! -s err &&
+	test ! -s out)
+'
+
 test_expect_success 'git pull' '
 	mkdir cloned &&
 	(cd cloned && git init &&
-- 
1.7.10
