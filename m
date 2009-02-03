From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 4/8] test-lib.sh: optionally output to test-results/$TEST.out,
 too
Date: Wed, 4 Feb 2009 00:26:12 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902040026120.9822@pacific.mpi-cbg.de>
References: <cover.1233702893u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 00:27:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUUfx-0007K0-5T
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 00:27:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbZBCXZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 18:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbZBCXZl
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 18:25:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:55971 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752338AbZBCXZk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 18:25:40 -0500
Received: (qmail invoked by alias); 03 Feb 2009 23:25:39 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp017) with SMTP; 04 Feb 2009 00:25:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX190ZSl1Lmd0YQKEATyiNwfYXFd0HQoaxA4lypm+on
	E73HvNKvlHiBM3
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1233702893u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108274>

When tests are run in parallel and a few tests fail, it does not help
that the output of the terminal is totally confusing, as you rarely know
which test which line came from.

So introduce the option '--tee' which triggers that the output of the
tests will be written to t/test-results/$TEST.out in addition to the
terminal, where $TEST is the basename of the script.

Unfortunately, there seems to be no way to redirect a given file
descriptor to a specified subprocess in POSIX shell, only redirection
to a file is supported via 'exec > $FILE'.

At least with bash, one might think that 'exec >($COMMAND)' would work
as intended, but it does not.

The common way to work around the lack of proper tools support is to
work with named pipes, alas, one of our most beloved platforms does not
really support named pipes.  Besides, we would need a pipe for every
script, as the whole point of this patch is to allow parallel execution.

Therefore, we handle the redirection in the following way: when '--tee'
was passed to the test script, the variable GIT_TEST_TEE_STARTED is set
(to avoid triggering that code path again) and the script is started
_again_, in a subshell, redirected to the command "tee".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/README      |    6 ++++++
 t/test-lib.sh |   18 ++++++++++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index 7560db5..ed1ebb6 100644
--- a/t/README
+++ b/t/README
@@ -65,6 +65,12 @@ appropriately before running "make".
 	the test script when running under -i).  Valgrind errors
 	go to stderr, so you might want to pass the -v option, too.
 
+--tee::
+	In addition to printing the test output to the terminal,
+	write it to files named 't/test-results/$TEST_NAME.out'.
+	As the names depend on the tests' file names, it is safe to
+	run the tests with this option in parallel.
+
 Skipping Tests
 --------------
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2567c74..2fb2274 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -3,6 +3,22 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
+# if --tee was passed, write the output not only to the terminal, but
+# additionally to the file test-results/$BASENAME.out, too.
+case "$GIT_TEST_TEE_STARTED, $* " in
+done,*)
+	# do not redirect again
+	;;
+*' --tee '*)
+	mkdir -p test-results
+	BASE=test-results/$(basename "$0" .sh)
+	(GIT_TEST_TEE_STARTED=done ${SHELL-sh} "$0" "$@" 2>&1;
+	 echo $? > $BASE.exit) | tee $BASE.out
+	test "$(cat $BASE.exit)" = 0
+	exit
+	;;
+esac
+
 # Keep the original TERM for say_color
 ORIGINAL_TERM=$TERM
 
@@ -96,6 +112,8 @@ do
 		shift ;;
 	--va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind)
 		valgrind=t; shift ;;
+	--tee)
+		shift ;; # was handled already
 	*)
 		break ;;
 	esac
-- 
1.6.1.2.582.g3fdd5
