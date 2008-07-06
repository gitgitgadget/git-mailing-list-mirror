From: Stephan Beyer <s-beyer@gmx.net>
Subject: [HACK] t/test-lib.sh HACK: Add -s/--show-hack to test suite.
Date: Sun,  6 Jul 2008 22:22:31 +0200
Message-ID: <1215375751-30853-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 06 22:23:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFalj-0003pE-Li
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 22:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756274AbYGFUWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 16:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756202AbYGFUWh
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 16:22:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:49309 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756185AbYGFUWh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 16:22:37 -0400
Received: (qmail invoked by alias); 06 Jul 2008 20:22:35 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp041) with SMTP; 06 Jul 2008 22:22:35 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19n5pR1JptnwsIPpuv9YF373MIibGzYDvmTYMK6Jc
	LEou8NpRyHbtTp
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KFakh-000820-EU; Sun, 06 Jul 2008 22:22:31 +0200
X-Mailer: git-send-email 1.5.6.363.g7ba71
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87550>

This option realizes a stupid hack that tries to run the test
cases line by line (separated by &&).
Furthermore it shows the line it is testing.
With that information it is easier to find the reason
why a test fails.

This hack works as long as there are no multi-line
for/while/subshell/... in the test cases.

Note, that the -s option should only be used if a test case failed.
It is slow and error-prone.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
Hi,

I wrote that before I started to make the sequencer prototype and
then I used this hack more than expected ;-)
Today I cherry-picked this commit into another branch and then
I thought this could be useful for others, too.
(Explicitly not for inclusion!)

So how to use it?
When running a test case in t/, add the -s option and then it shows
something like this:

--snip--[...]

-------
Testing:
        ! test -d "$SEQDIR"

-------
Testing:
        session_ok

* FAIL 3: "pick", "squash", "ref" from stdin

                next_session squashCE &&
                valgrind git sequencer <todotest1 &&
                ! test -d "$SEQDIR" &&
                session_ok &&
                test -f file2 &&
                test -f file3 &&
                test $(git rev-parse CE) = $(git rev-parse HEAD) &&
                test $(git rev-parse I) = $(git rev-parse HEAD^)
--snap--

Because of the "Testing:" lines you can explicitly see where it failed.

Regards,
  Stephan

 t/test-lib.sh |   45 +++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index c0c5e0e..6f42106 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -86,6 +86,8 @@ do
 		help=t; shift ;;
 	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
 		verbose=t; shift ;;
+	-s|--show-hack)
+		verbose=t; show_hack=t; immediate=t; shift ;;
 	-q|--q|--qu|--qui|--quie|--quiet)
 		quiet=t; shift ;;
 	--no-color)
@@ -225,9 +227,48 @@ test_debug () {
 	test "$debug" = "" || eval "$1"
 }
 
-test_run_ () {
-	eval >&3 2>&4 "$1"
+test_run__ () {
+	eval "$1"
 	eval_ret="$?"
+}
+
+test_run_op_ () {
+	echo "Testing:"
+	printf "%s\n" "$op_"
+	echo
+	eval "$op_"
+	eval_ret="$?"
+}
+
+test_run_hack_ () {
+	i_=1
+	j_=1
+	total_=$(printf '%s' "$1" | wc -l)
+	while test "$j_" -lt $(expr "$total_" + 1)
+	do
+		op_=$(printf '%s' "$1" | sed -n -e "$i_,$j_ p")
+		if test -n "$(printf '%s' "$op_" | sed -n -e '/<<[-\\ A-Za-z]/q;/&& *$/p;')"
+		then
+			i_=$(expr "$j_" + 1)
+			op_=$(printf '%s' "$op_" | sed -e 's/ *&& *$//')
+			test_run_op_
+			test "$eval_ret" -ne 0 && return 0
+			echo -------
+		fi
+		j_=$(expr "$j_" + 1)
+	done
+	op_="$(printf '%s' "$1" | sed -n -e "$i_,$j_ p")"
+	test_run_op_
+	return 0
+}
+
+test_run_ () {
+	if test -z "$show_hack"
+	then
+		test_run__ >&3 2>&4 "$1"
+	else
+		test_run_hack_ >&3 2>&4 "$1"
+	fi
 	return 0
 }
 
-- 
1.5.6.363.g7ba71
