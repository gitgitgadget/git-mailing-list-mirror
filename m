From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/1] tests: Allow customization of how say_color() prints
Date: Sat, 15 Dec 2012 19:12:06 +0000
Message-ID: <50CCCB86.5080701@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 20:28:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjxPL-0004LJ-Vq
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 20:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342Ab2LOT2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 14:28:00 -0500
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:41593 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab2LOT16 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 14:27:58 -0500
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id DB527384081;
	Sat, 15 Dec 2012 19:27:56 +0000 (GMT)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 0F0C8384080;	Sat, 15 Dec 2012 19:27:56 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;	Sat, 15 Dec 2012 19:27:55 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211563>


Since commit 7bc0911d ("test-lib: Fix say_color () not to interpret
\a\b\c in the message", 11-10-2012), the "--no-color" version of
say_color() has been using the (bash builtin) printf function, rather
than echo, to print the testsuite output. Due to an intermittent (and
rare) failure of the printf builtin function on some older versions
of cygwin, this leads to several (currently 7) test failures.

In order the fix the test failures, we provide a means to customize
the function used by say_color() to print the output. The function
is customized using GIT_TEST_PRINT[_LN] variables, which are set by
default to keep the current behaviour unchanged, but may used from
(say) the config.mak file to re-instate the use of echo. This could
be done by adding the following to config.mak:

    GIT_TEST_PRINT=echo -nE
    GIT_TEST_PRINT_LN=echo -E
    export GIT_TEST_PRINT GIT_TEST_PRINT_LN

Note that the GIT_TEST_PRINT variable is used in the "--color" version
of say_color(), and does not provide the line termination character.
In contrast, the GIT_TEST_PRINT_LN variable is used by the "--no-color"
version of say_color() and does provide the line termination.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 Makefile      |  6 ++++++
 t/test-lib.sh | 13 +++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 736ecd4..4f7803e 100644
--- a/Makefile
+++ b/Makefile
@@ -2603,6 +2603,12 @@ GIT-BUILD-OPTIONS: FORCE
 ifdef GIT_TEST_OPTS
 	@echo GIT_TEST_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_OPTS)))'\' >>$@
 endif
+ifdef GIT_TEST_PRINT
+	@echo GIT_TEST_PRINT=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_PRINT)))'\' >>$@
+endif
+ifdef GIT_TEST_PRINT_LN
+	@echo GIT_TEST_PRINT_LN=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_PRINT_LN)))'\' >>$@
+endif
 ifdef GIT_TEST_CMP
 	@echo GIT_TEST_CMP=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_CMP)))'\' >>$@
 endif
diff --git a/t/test-lib.sh b/t/test-lib.sh
index f50f834..9dcf3c1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -202,6 +202,15 @@ do
 	esac
 done
 
+if test -z "$GIT_TEST_PRINT"
+then
+	GIT_TEST_PRINT="printf %s"
+fi
+if test -z "$GIT_TEST_PRINT_LN"
+then
+	GIT_TEST_PRINT_LN="printf %s\n"
+fi
+
 if test -n "$color"
 then
 	say_color () {
@@ -221,7 +230,7 @@ then
 			test -n "$quiet" && return;;
 		esac
 		shift
-		printf "%s" "$*"
+		$GIT_TEST_PRINT "$*"
 		tput sgr0
 		echo
 		)
@@ -230,7 +239,7 @@ else
 	say_color() {
 		test -z "$1" && test -n "$quiet" && return
 		shift
-		printf "%s\n" "$*"
+		$GIT_TEST_PRINT_LN "$*"
 	}
 fi
 
-- 
1.8.0
