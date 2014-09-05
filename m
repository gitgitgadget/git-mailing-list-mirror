From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC PATCHv3 4/4] am: add gitk patch format
Date: Fri,  5 Sep 2014 22:06:51 +1200
Message-ID: <1409911611-20370-5-git-send-email-judge.packham@gmail.com>
References: <1409911611-20370-1-git-send-email-judge.packham@gmail.com>
Cc: Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 12:07:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPqQv-0005xN-7t
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 12:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756576AbaIEKHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 06:07:45 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33752 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756543AbaIEKHo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 06:07:44 -0400
Received: by mail-ie0-f176.google.com with SMTP id x19so13634547ier.21
        for <git@vger.kernel.org>; Fri, 05 Sep 2014 03:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g19UFCOTuax8IBD5lC+O/t+dNXuJILXTd4cDsGur9mg=;
        b=hCBHybjYOhtDRtxM9naM/latNcIdzJfCaHY4ZcsCm6/oN63K5GejRub0mpK3jron2I
         iLx+6XC4WXRrCSKwbf4KcoYt5yJPC91CoyG/gXVzmp/VTMyRD4qccF9FyzYm334NcGPQ
         GfKlaCSzUsKveblP1VLLKf2W961nK463ytzJnqrNajHivzjXtUpp57wzrH9aA5ty4Iw4
         ia1WQsspt1Q8s6TvQqXY001r4Ch50PxLAOHRWllpU6BWRzWOphTzW+PdOvczzZOw9x56
         HsuQLwgoa+UJjbzCi3WE5PSXEgtRashTYRicHFCNeW690Zt/29UMMfFF7ZYh0JqgEugX
         IgRw==
X-Received: by 10.70.15.161 with SMTP id y1mr19957933pdc.61.1409911664232;
        Fri, 05 Sep 2014 03:07:44 -0700 (PDT)
Received: from chrisp3-dl.ws.atlnz.lc (2-163-36-202-static.alliedtelesis.co.nz. [202.36.163.2])
        by mx.google.com with ESMTPSA id o2sm1348068pdk.87.2014.09.05.03.07.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 05 Sep 2014 03:07:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1409911611-20370-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256506>

Patches created using gitk's "write commit to file" functionality (which
uses 'git diff-tree -p --pretty' under the hood) need some massaging in
order to apply cleanly. This consists of dropping the 'commit' line
automatically determining the subject and removing leading whitespace.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
This hasn't materially changed from the version Junio expressed
reservations about[1]. It solves my immediate problem but perhaps this
(as well as stgit and hg) belong as external filters in a pipeline
before git am. Or maybe mailsplit should absorb the functionality?

[1] - http://article.gmane.org/gmane.comp.version-control.git/256426

 Documentation/git-am.txt |  3 ++-
 git-am.sh                | 36 ++++++++++++++++++++++++++++++++++++
 t/t4150-am.sh            | 23 +++++++++++++++++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)

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
index fade7f8..5d69c89 100755
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
index 8ee81cf..5d4f7be 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -120,6 +120,7 @@ test_expect_success setup '
 		echo "---" &&
 		git diff-tree --stat -p second | sed -e "1d"
 	} > patch1-hg.eml &&
+	git diff-tree -p --pretty second >patch1-gitk.eml &&
 
 	sed -n -e "3,\$p" msg >file &&
 	git add file &&
@@ -239,6 +240,28 @@ test_expect_failure 'am applies patch using --patch-format=hg' '
 	git diff --exit-code second
 '
 
+test_expect_success 'am applies patch generated by gitk' '
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
+test_expect_failure 'am applies patch using --patch-format=gitk' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	git am --patch-format=gitk <patch1-gitk.eml &&
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
2.1.0.64.gc343089
