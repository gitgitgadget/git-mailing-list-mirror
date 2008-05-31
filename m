From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] t/test-lib.sh: add test_external and test_external_without_stderr
Date: Sun,  1 Jun 2008 01:36:15 +0200
Message-ID: <1212276975-27428-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 01 01:37:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2adS-00067K-QI
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 01:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882AbYEaXf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 19:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754879AbYEaXf7
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 19:35:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:43991 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849AbYEaXf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 19:35:58 -0400
Received: by fg-out-1718.google.com with SMTP id 19so397141fgg.17
        for <git@vger.kernel.org>; Sat, 31 May 2008 16:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:from;
        bh=pAH2KtRK80YfCs+X+VF8XG3ezCifg1/Y+Bu3Bd0DVVs=;
        b=YRa/yBwrOajw554sQym/PQmbRKLPxdwEHD41AeEwGFP1zQeWcDToMjE4so6RyY+t6PWUJJcHnCrkb4G7khmdDHGA3CP3iMbUiiKVfeyAZ264MWBQcJFrBDIOqj8WDcsjEfGEJJOzf3vfD9deo7e75mIn9sMPBestYekBMDNfb4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=jTCuuO0Ex7NjD+iqbcdVS7hw7B7xVLfoQpvlMB6qMHQVzpnANnJwXer5aULI+g+TBvgIUKueW98mPhdGwPnLrwEoJXanhcdvSklfKRokAG3lzjKilWtvucZQO7x+QhnRV6Z1IhZLDO9d1rbgxwfRYW1lWAf8+6su6/E1onQJieU=
Received: by 10.86.96.18 with SMTP id t18mr3850303fgb.17.1212276956721;
        Sat, 31 May 2008 16:35:56 -0700 (PDT)
Received: from fly ( [91.33.240.119])
        by mx.google.com with ESMTPS id p9sm5805757fkb.9.2008.05.31.16.35.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 May 2008 16:35:55 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K2acR-00078l-3v; Sun, 01 Jun 2008 01:36:15 +0200
X-Mailer: git-send-email 1.5.5.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83415>

This is for running external test scripts in other programming
languages that provide continuous output about their tests.  Using
test_expect_success (like "test_expect_success 'description' 'perl
test-script.pl'") doesn't suffice here because test_expect_success
eats stdout in non-verbose mode, which is not fixable without major
file descriptor trickery.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
 t/test-lib.sh |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7a8bd27..99b63da 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -302,6 +302,64 @@ test_expect_code () {
 	echo >&3 ""
 }
 
+# test_external runs external test scripts that provide continuous
+# test output about their progress, and succeeds/fails on
+# zero/non-zero exit code.  It outputs the test output on stdout even
+# in non-verbose mode, and announces the external script with "* run
+# <n>: ..." before running it.  When providing relative paths, keep in
+# mind that all scripts run in "trash directory".
+# Usage: test_external description command arguments...
+# Example: test_external 'Perl API' perl ../path/to/test.pl
+test_external () {
+	test "$#" -eq 3 ||
+	error >&5 "bug in the test script: not 3 parameters to test_external"
+	descr="$1"
+	shift
+	if ! test_skip "$descr" "$@"
+	then
+		# Announce the script to reduce confusion about the
+		# test output that follows.
+		say_color "" " run $(expr "$test_count" + 1): $descr ($*)"
+		# Run command; redirect its stderr to &4 as in
+		# test_run_, but keep its stdout on our stdout even in
+		# non-verbose mode.
+		"$@" 2>&4
+		if [ "$?" = 0 ]
+		then
+			test_ok_ "$descr"
+		else
+			test_failure_ "$descr" "$@"
+	  	fi
+	fi
+}
+
+# Like test_external, but in addition tests that the command generated
+# no output on stderr.
+test_external_without_stderr () {
+	# The temporary file has no (and must have no) security
+	# implications.
+	tmp="$TMPDIR"; if [ -z "$tmp" ]; then tmp=/tmp; fi
+	stderr="$tmp/git-external-stderr.$$.tmp"
+	test_external "$@" 4> "$stderr"
+	[ -f "$stderr" ] || eror "Internal error: $stderr disappeared."
+	descr="no stderr: $1"
+	shift
+	say >&3 "expecting no stderr from previous command"
+	if [ ! -s "$stderr" ]; then
+		rm "$stderr"
+		test_ok_ "$descr"
+	else
+		if [ "$verbose" = t ]; then	    	
+		    output=`echo; echo Stderr is:; cat "$stderr"`
+		else
+		    output=
+		fi
+		# rm first in case test_failure exits.
+		rm "$stderr"
+		test_failure_ "$descr" "$@" "$output"
+        fi
+}
+
 # This is not among top-level (test_expect_success | test_expect_failure)
 # but is a prefix that can be used in the test script, like:
 #
-- 
1.5.5.GIT
