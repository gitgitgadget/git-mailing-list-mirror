From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 2/5] rebase --root: print usage on too many args
Date: Tue, 26 Jun 2012 07:51:55 -0700
Message-ID: <1340722318-24392-3-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1340722318-24392-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 16:52:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjX8R-0006Bd-Ff
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 16:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757946Ab2FZOwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 10:52:42 -0400
Received: from mail-lb0-f202.google.com ([209.85.217.202]:52873 "EHLO
	mail-lb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757798Ab2FZOwk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 10:52:40 -0400
Received: by mail-lb0-f202.google.com with SMTP id gp10so12021lbb.1
        for <git@vger.kernel.org>; Tue, 26 Jun 2012 07:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=z82C/e5aMuQm+NEjFyJm38NLDn8dtr/GFqOLxaQObck=;
        b=dwgLTz4bzqvFOvRy1QN0GEmdyq8V0Vg7LpYh7wzRTZL8pTPJ8yLjpkLD3Vx4zYN4US
         0loM9cvW1KtyOUbp/cPVapTIvYOt0odWcfUABC0zxqGkg2pvsS0qXP+rhrsOricPn8aB
         ZUc7Nh4zu1JjgbFOyI0Rlt3eL1tamPrqQhaLSGi3DNhNMc3sknzXumfxeI2wYFErUk5v
         YVScbqpEamxMT5V0mcxRavSJsZuhmHcR6MYlBVce6fg7pd2XlFMOqZlwpldiLkwEEwCn
         jql01qfWVBUlJsSVVeiMEhL5pZ4uFaZ+AE3P+b0N1S3cHbb1LKjN4l/SVqB2AFBbJiJj
         BwHA==
Received: by 10.14.99.75 with SMTP id w51mr4870757eef.8.1340722359370;
        Tue, 26 Jun 2012 07:52:39 -0700 (PDT)
Received: by 10.14.99.75 with SMTP id w51mr4870754eef.8.1340722359300;
        Tue, 26 Jun 2012 07:52:39 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id b15si37903948een.0.2012.06.26.07.52.39
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 26 Jun 2012 07:52:39 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 1DCDF5C0050;
	Tue, 26 Jun 2012 07:52:39 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 79544C0EA5; Tue, 26 Jun 2012 07:52:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.3.327.g2980b
In-Reply-To: <1340722318-24392-1-git-send-email-martin.von.zweigbergk@gmail.com>
X-Gm-Message-State: ALoCoQnTj7+rTEwYt18X+Zyb/F5CMbHguH4jZbjKFA5n3RKVn/+mlDvW+M2F6mNQlg1ChQntGp5N8Nay1uWPVQXTC644EQO5HaqXpVMQNa6M6Yu9xnWVMfsKKvO0KB0wdePm096tYpJ6hgl40YsWuww2/e3QJhndws34wHUboE4PUpiHD/rKoJcOpUgNgwIMY4GtxY4IyyS0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200647>

Just like

  git rebase --onto newbase upstream branch error

displays the usage message, so should clearly

  git rebase --onto newbase --root branch error

, but it doesn't. Instead, it ignores both "branch" and "error" and
rebases the current HEAD. This is because we try to match the number
of remainging arguments "$#", which fails to match "1" argument and
matches the "*" that really should have been a "0".

Make sure we display usage information when too many arguments are
given. Also fail-fast in case of similar bugs in the future by
matching on exactly 0 arguments and failing on unknown numbers.
---
 git-rebase.sh          |    6 +++++-
 t/t3412-rebase-root.sh |    8 +++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index e616737..6df06c4 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -400,6 +400,7 @@ else
 	test -z "$onto" && die "You must specify --onto when using --root"
 	unset upstream_name
 	unset upstream
+	test $# -gt 1 && usage
 	upstream_arg=--root
 fi
 
@@ -450,7 +451,7 @@ case "$#" in
 		die "fatal: no such branch: $1"
 	fi
 	;;
-*)
+0)
 	# Do not need to switch branches, we are already on it.
 	if branch_name=`git symbolic-ref -q HEAD`
 	then
@@ -462,6 +463,9 @@ case "$#" in
 	fi
 	orig_head=$(git rev-parse --verify "${branch_name}^0") || exit
 	;;
+*)
+	die "BUG: unexpected number of arguments left to parse"
+	;;
 esac
 
 require_clean_work_tree "rebase" "Please commit or stash them."
diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 086c91c..1e9d1a7 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -23,9 +23,15 @@ test_expect_success 'prepare repository' '
 '
 
 test_expect_success 'rebase --root expects --onto' '
+	git checkout -B fail other &&
 	test_must_fail git rebase --root
 '
 
+test_expect_success 'rebase --root fails with too many args' '
+	git checkout -B fail other &&
+	test_must_fail git rebase --onto master --root fail fail
+'
+
 test_expect_success 'setup pre-rebase hook' '
 	mkdir -p .git/hooks &&
 	cat >.git/hooks/pre-rebase <<EOF &&
@@ -42,7 +48,7 @@ cat > expect <<EOF
 EOF
 
 test_expect_success 'rebase --root --onto <newbase>' '
-	git checkout -b work &&
+	git checkout -b work other &&
 	git rebase --root --onto master &&
 	git log --pretty=tformat:"%s" > rebased &&
 	test_cmp expect rebased
-- 
1.7.9.3.327.g2980b
