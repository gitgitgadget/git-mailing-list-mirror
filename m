From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 1/2] am: learn passing -b to mailinfo
Date: Mon, 16 Jan 2012 11:53:00 +0100
Message-ID: <a804650f805fd8c89a843302cb92bbbdf36b8c0b.1326710194.git.trast@student.ethz.ch>
References: <8762ghxpxw.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 16 11:53:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmkBm-0004xs-Uq
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 11:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134Ab2APKxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 05:53:08 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:53873 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753228Ab2APKxF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 05:53:05 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 16 Jan
 2012 11:53:00 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 16 Jan
 2012 11:53:01 +0100
X-Mailer: git-send-email 1.7.9.rc0.168.g3847c
In-Reply-To: <8762ghxpxw.fsf@thomas.inf.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188626>

git-am could pass -k to mailinfo, but not -b.  Introduce an option
that does so.  We change the meaning of the 'keep' state file, but are
careful not to cause a problem unless you downgrade in the middle of
an 'am' run.

This uncovers a bug in mailinfo -b, hence the failing test.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This fixes the broken 'if', and the use of 'echo' with an argument
that starts with '-'.

 Documentation/git-am.txt |    3 +++
 git-am.sh                |   12 ++++++++----
 t/t4150-am.sh            |   14 ++++++++++++--
 3 files changed, 23 insertions(+), 6 deletions(-)

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
index 1c13b13..b8adde7 100755
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
@@ -529,7 +532,7 @@ else
 	echo "$threeway" >"$dotest/threeway"
 	echo "$sign" >"$dotest/sign"
 	echo "$utf8" >"$dotest/utf8"
-	echo "$keep" >"$dotest/keep"
+	printf "%s" "$keep" >"$dotest/keep"
 	echo "$scissors" >"$dotest/scissors"
 	echo "$no_inbody_headers" >"$dotest/no_inbody_headers"
 	echo "$GIT_QUIET" >"$dotest/quiet"
@@ -571,7 +574,8 @@ then
 else
 	utf8=-n
 fi
-if test "$(cat "$dotest/keep")" = t
+keep=$(cat "$dotest/keep")
+if test "$keep" = t
 then
 	keep=-k
 fi
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
