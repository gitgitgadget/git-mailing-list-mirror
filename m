From: Iustin Pop <iusty@k1024.org>
Subject: [PATCH] Pass $verbosity from git pull to git rebase
Date: Sat, 26 May 2012 03:00:09 +0200
Message-ID: <20120526010009.GA16666@hq.k1024.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 03:01:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY5NK-0003uu-8W
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 03:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755061Ab2EZBAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 21:00:16 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:44740 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972Ab2EZBAP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 21:00:15 -0400
Received: by wgbdr13 with SMTP id dr13so1322836wgb.1
        for <git@vger.kernel.org>; Fri, 25 May 2012 18:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:x-linux:x-header:user-agent:x-gm-message-state;
        bh=xsGKsXd/AY42vXnoStnUqt0uuevNpK0ui48MNvcmc2I=;
        b=Hl0IxUyObwRA6nu/viSKTJBd1/EsYUUtPR/Nrosl3sjTrJQ+7It+itaaFGIxUaHGKn
         VqGKP3jagqlyK5/5nr1b9xobvk9KLKM0OVkVSltDDQYKhJTpDpl6seDk/BiHwCVBOapm
         w+JF0lCHlxxxeuVAu2TKLbS8yJO4bIToN0yR1VTBtlqUAaNOUsRyZQxcjd/K3crJjZjv
         j3b57OfCLPdgeBG9wUXYexrMx54tisgMpF66tHV3KjUqZnM47flrnqaUJGq5EzAkXhkq
         oA6plCmP0DZyzIK0rClicufdeQL8o4Jr47tq8zKnK9u2uqwHBgFU2XrxwCvMbUzsJZs5
         7t2Q==
Received: by 10.216.198.162 with SMTP id v34mr455711wen.75.1337994012799;
        Fri, 25 May 2012 18:00:12 -0700 (PDT)
Received: from teal.hq.k1024.org (46-126-106-189.dynamic.hispeed.ch. [46.126.106.189])
        by mx.google.com with ESMTPS id z8sm1149209wiy.1.2012.05.25.18.00.11
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 25 May 2012 18:00:12 -0700 (PDT)
Received: from ruru.hq.k1024.org (ruru.hq.k1024.org [10.1.167.27])
	by teal.hq.k1024.org (Postfix) with ESMTP id 2DC0C20E10A
	for <git@vger.kernel.org>; Sat, 26 May 2012 03:00:10 +0200 (CEST)
Received: by ruru.hq.k1024.org (Postfix, from userid 4004)
	id 0020862B445; Sat, 26 May 2012 03:00:09 +0200 (CEST)
Content-Disposition: inline
X-Linux: This message was written on Linux
X-Header: /usr/include gives great headers
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQl+dVtZwDpcyvIj1Z6a8MIH29Yd3RAHlLgWAPGRDkvJ0ujUuxxZbnbxUY370X5ZTrEanQ7J
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198534>

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
