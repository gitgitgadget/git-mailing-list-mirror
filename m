From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC PATCHv2 1/2] am: add gitk patch format
Date: Thu,  4 Sep 2014 10:21:57 +1200
Message-ID: <1409782918-26133-2-git-send-email-judge.packham@gmail.com>
References: <1409736919-22341-1-git-send-email-judge.packham@gmail.com>
 <1409782918-26133-1-git-send-email-judge.packham@gmail.com>
Cc: Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 00:23:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPIxD-0000hP-IE
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 00:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934116AbaICWWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 18:22:47 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:32777 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933912AbaICWWd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 18:22:33 -0400
Received: by mail-pd0-f174.google.com with SMTP id ft15so12052435pdb.19
        for <git@vger.kernel.org>; Wed, 03 Sep 2014 15:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=feZOZal4QtxMf/qQP9uG5JAAPcPZDgnr8e5qI+huWqM=;
        b=UqaoIFIjGmGvX/cQ5WCbRW7RxUempLTQWYs6zukFkM2IRnBGQPm1xulTymejucJCTj
         rZkSzCsj9wngoDqo5Yzw1CpfF7J0iv61hCb7aHYgknvDxI8xVgVd/VZN6vlD/x7HXXxP
         q+0LVtwckSBtHKqILBE0HRxbaOiGcZ5QvFrhNqdQnrffS/C9K++lyyHpBugL7ZueQ+yk
         YQRwFkOrhcNJQNn4ZbCoiEozscMEBFMDc5dlBVJyQUW2u+J4Kark0oNcGDmfmPvVJOX6
         fpmuI0nDcio4+E+pqsKuF3OgOuexg8s2Lm675/8JrQdP0IDcXQppA4lwhUlZzfuinHSx
         8beA==
X-Received: by 10.66.243.208 with SMTP id xa16mr548157pac.41.1409782948313;
        Wed, 03 Sep 2014 15:22:28 -0700 (PDT)
Received: from chrisp3-dl.ws.atlnz.lc (2-163-36-202-static.alliedtelesis.co.nz. [202.36.163.2])
        by mx.google.com with ESMTPSA id we5sm20099548pab.28.2014.09.03.15.22.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 03 Sep 2014 15:22:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1409782918-26133-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256426>

Patches created using gitk's "write commit to file" functionality (which
uses 'git diff-tree -p --pretty' under the hood) need some massaging in
order to apply cleanly. This consists of dropping the 'commit' line
automatically determining the subject and removing leading whitespace.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
 Documentation/git-am.txt |  3 ++-
 git-am.sh                | 36 ++++++++++++++++++++++++++++++++++++
 t/t4150-am.sh            | 13 +++++++++++++
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 9adce37..b59d2b3 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -101,7 +101,8 @@ default.   You can use `--no-utf8` to override this.
 	By default the command will try to detect the patch format
 	automatically. This option allows the user to bypass the automatic
 	detection and specify the patch format that the patch(es) should be
-	interpreted as. Valid formats are mbox, stgit, stgit-series and hg.
+	interpreted as. Valid formats are mbox, stgit, stgit-series, hg and
+	gitk.
 
 -i::
 --interactive::
diff --git a/git-am.sh b/git-am.sh
index ee61a77..f979925 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -227,6 +227,9 @@ check_patch_format () {
 		"# HG changeset patch")
 			patch_format=hg
 			;;
+		'commit '*)
+			patch_format=gitk
+			;;
 		*)
 			# if the second line is empty and the third is
 			# a From, Author or Date entry, this is very
@@ -357,6 +360,39 @@ split_patches () {
 		this=
 		msgnum=
 		;;
+	gitk)
+		# These patches are generates with 'git diff-tree -p --pretty'
+		# we discard the 'commit' line, after that the first line not
+		# starting with 'Author:' or 'Date:' is the subject. We also
+		# need to strip leading whitespace from the message body.
+		this=0
+		for gitk in "$@"
+		do
+			this=$(expr "$this" + 1)
+			msgnum=$(printf "%0${prec}d" $this)
+			@@PERL@@ -ne 'BEGIN { $subject = 0; $diff = 0; }
+				if (!$diff) { s/^    // ; }
+				if ($subject > 1) { print ; }
+				elsif (/^commit\s.*$/) { next ; }
+				elsif (/^\s+$/) { next ; }
+				elsif (/^Author:/) { s/Author/From/ ; print ; }
+				elsif (/^Date:/) { print ;}
+				elsif (/^diff --git/) { $diff = 1 ; print ;}
+				elsif ($subject) {
+					$subject = 2 ;
+					print "\n" ;
+					print ;
+				} else {
+					print "Subject: ", $_ ;
+					$subject = 1;
+				}
+			' <"$gitk" >"$dotest/$msgnum" || clean_abort
+
+		done
+		echo "$this" >"$dotest/last"
+		this=
+		msgnum=
+		;;
 	*)
 		if test -n "$patch_format"
 		then
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 5edb79a..e36cd0b 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -103,6 +103,7 @@ test_expect_success setup '
 		echo "X-Fake-Field: Line Three" &&
 		git format-patch --stdout first | sed -e "1d"
 	} > patch1-ws.eml &&
+	git diff-tree -p --pretty second >patch1-gitk.eml &&
 
 	sed -n -e "3,\$p" msg >file &&
 	git add file &&
@@ -186,6 +187,18 @@ test_expect_success 'am applies patch e-mail with preceding whitespace' '
 	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
 '
 
+test_expect_success 'am applies patch generated by gitk' '
+	cat patch1-gitk.eml &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	git am patch1-gitk.eml &&
+	test_path_is_missing .git/rebase-apply &&
+	git diff --exit-code second &&
+	test "$(git rev-parse second)" = "$(git rev-parse HEAD)" &&
+	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
+'
+
 test_expect_success 'setup: new author and committer' '
 	GIT_AUTHOR_NAME="Another Thor" &&
 	GIT_AUTHOR_EMAIL="a.thor@example.com" &&
-- 
2.0.4.2.gadd452d
