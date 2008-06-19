From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH 1/2 v3] t/test-lib.sh: add test_external and test_external_without_stderr
Date: Thu, 19 Jun 2008 20:18:03 +0200
Message-ID: <d5ac06cabb7eb235ca82525fad2e96cdab205469.1213899000.git.LeWiemann@gmail.com>
References: <48596EE7.90202@free.fr>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 20:19:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9OjK-00082X-DO
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 20:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759083AbYFSSSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 14:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758709AbYFSSSG
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 14:18:06 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:42715 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757461AbYFSSSF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 14:18:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so451938fgg.17
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 11:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:from;
        bh=LIBPoAj01VEUko/Zmv9RaOLlPtzy9Y4KZtboSOcjQNU=;
        b=ILDTfiXrDuxRZI7nIaaC0VAQQuGvcNM9D+Uqiy3/gcpBCGwKj7XiGpMUMLIp4GGSMx
         JZ128K8/TzcMWqS7iSFmWSKYlIS25qUw8OiLsoMxPZqoQ9FKklnkdrttCf1R7ADKLjk2
         YSWLzYDk2+X8WLeGjuMJpmmoJvSeybRVTeo2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=Oi5snXDBNiMqztS95jUs7luhgpDNcuBa+O96WyOsGpK2OjP8z7DQOtHpM6f8KGNxpX
         zpG7RyrXINxwY3Dj1RlbKOwuVNo00tEAqdLxAbA9uMU+DWk6jJICl5uA20wKZAogYd7C
         YKiNP66P7ZGazFs+s7Xj2QJO0XyzbwRP8HY1c=
Received: by 10.86.58.3 with SMTP id g3mr2560939fga.21.1213899481278;
        Thu, 19 Jun 2008 11:18:01 -0700 (PDT)
Received: from fly ( [91.33.204.94])
        by mx.google.com with ESMTPS id 12sm1631544fgg.0.2008.06.19.11.17.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Jun 2008 11:17:35 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <lea@fly>)
	id 1K9Ohw-0008BS-Km; Thu, 19 Jun 2008 20:18:04 +0200
X-Mailer: git-send-email 1.5.6.149.g06c04.dirty
In-Reply-To: <48596EE7.90202@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85504>

This is for running external test scripts in other programming
languages that provide continuous output about their tests.  Using
test_expect_success (like "test_expect_success 'description' 'perl
test-script.pl'") doesn't suffice here because test_expect_success
eats stdout in non-verbose mode, which is not fixable without major
file descriptor trickery.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Olivier Marin wrote:
> Just a typo here: s/eror/error/

Thanks for spotting this, and also the missing ampersand in the other
patch!

(This typo is the only change since v2.)

 t/test-lib.sh |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3ac8755..dc2736e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -304,6 +304,64 @@ test_expect_code () {
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
+		fi
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
+	[ -f "$stderr" ] || error "Internal error: $stderr disappeared."
+	descr="no stderr: $1"
+	shift
+	say >&3 "expecting no stderr from previous command"
+	if [ ! -s "$stderr" ]; then
+		rm "$stderr"
+		test_ok_ "$descr"
+	else
+		if [ "$verbose" = t ]; then
+			output=`echo; echo Stderr is:; cat "$stderr"`
+		else
+			output=
+		fi
+		# rm first in case test_failure exits.
+		rm "$stderr"
+		test_failure_ "$descr" "$@" "$output"
+	fi
+}
+
 # This is not among top-level (test_expect_success | test_expect_failure)
 # but is a prefix that can be used in the test script, like:
 #
-- 
1.5.6.149.g06c04.dirty
