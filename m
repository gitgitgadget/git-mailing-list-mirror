From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/3] am: learn passing -b to mailinfo
Date: Wed, 11 Jan 2012 21:13:43 +0100
Message-ID: <19539098c07a207f3bd24f5a145ba3b6c5e46766.1326312730.git.trast@student.ethz.ch>
References: <e915a551c9bbf12f4d8fd929e9ed24f3223790ee.1326312730.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 11 21:14:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl4Yg-0007T9-Ml
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 21:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758033Ab2AKUNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 15:13:55 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:50441 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758025Ab2AKUNw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 15:13:52 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 11 Jan
 2012 21:13:48 +0100
Received: from thomas.inf.ethz.ch (129.132.210.223) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 11 Jan
 2012 21:13:48 +0100
X-Mailer: git-send-email 1.7.9.rc0.168.g3847c
In-Reply-To: <e915a551c9bbf12f4d8fd929e9ed24f3223790ee.1326312730.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.210.223]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188393>

git-am could pass -k to mailinfo, but not -b.  Introduce an option
that does so.  We change the meaning of the 'keep' state file, but are
careful not to cause a problem unless you downgrade in the middle of
an 'am' run.

This uncovers a bug in mailinfo -b, hence the failing test.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Someone on IRC asked about git-am support for passing through the -b
flag to mailinfo.  And so it began...

 Documentation/git-am.txt |    3 +++
 git-am.sh                |   11 +++++++----
 t/t4150-am.sh            |   14 ++++++++++++--
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 887466d..ee6cca2 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -40,6 +40,9 @@ OPTIONS
 --keep::
 	Pass `-k` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
 
+--keep-non-patch::
+	Pass `-b` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
+
 --keep-cr::
 --no-keep-cr::
 	With `--keep-cr`, call 'git mailsplit' (see linkgit:git-mailsplit[1])
diff --git a/git-am.sh b/git-am.sh
index 1c13b13..8dfad7a 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -15,6 +15,7 @@ q,quiet         be quiet
 s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
 k,keep          pass -k flag to git-mailinfo
+keep-non-patch  pass -b flag to git-mailinfo
 keep-cr         pass --keep-cr flag to git-mailsplit for mbox format
 no-keep-cr      do not pass --keep-cr flag to git-mailsplit independent of am.keepcr
 c,scissors      strip everything before a scissors line
@@ -386,7 +387,9 @@ do
 	--no-utf8)
 		utf8= ;;
 	-k|--keep)
-		keep=t ;;
+		keep=-k ;;
+	--keep-non-patch)
+		keep=-b ;;
 	-c|--scissors)
 		scissors=t ;;
 	--no-scissors)
@@ -398,7 +401,7 @@ do
 	--abort)
 		abort=t ;;
 	--rebasing)
-		rebasing=t threeway=t keep=t scissors=f no_inbody_headers=t ;;
+		rebasing=t threeway=t keep=-k scissors=f no_inbody_headers=t ;;
 	-d|--dotest)
 		die "$(gettext "-d option is no longer supported.  Do not use.")"
 		;;
@@ -571,8 +574,8 @@ then
 else
 	utf8=-n
 fi
-if test "$(cat "$dotest/keep")" = t
-then
+keep=$(cat "$dotest/keep")
+if test "$keep" = t
 	keep=-k
 fi
 case "$(cat "$dotest/scissors")" in
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index d7d9ccc..7e7c83c 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -237,7 +237,7 @@ test_expect_success 'am stays in branch' '
 
 test_expect_success 'am --signoff does not add Signed-off-by: line if already there' '
 	git format-patch --stdout HEAD^ >patch3 &&
-	sed -e "/^Subject/ s,\[PATCH,Re: Re: Re: & 1/5 v2," patch3 >patch4 &&
+	sed -e "/^Subject/ s,\[PATCH,Re: Re: Re: & 1/5 v2] [foo," patch3 >patch4 &&
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
 	git checkout HEAD^ &&
@@ -259,7 +259,17 @@ test_expect_success 'am --keep really keeps the subject' '
 	git am --keep patch4 &&
 	! test -d .git/rebase-apply &&
 	git cat-file commit HEAD >actual &&
-	grep "Re: Re: Re: \[PATCH 1/5 v2\] third" actual
+	grep "Re: Re: Re: \[PATCH 1/5 v2\] \[foo\] third" actual
+'
+
+test_expect_failure 'am --keep-non-patch really keeps the non-patch part' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout HEAD^ &&
+	git am --keep-non-patch patch4 &&
+	! test -d .git/rebase-apply &&
+	git cat-file commit HEAD >actual &&
+	grep "^\[foo\] third" actual
 '
 
 test_expect_success 'am -3 falls back to 3-way merge' '
-- 
1.7.9.rc0.168.g3847c
