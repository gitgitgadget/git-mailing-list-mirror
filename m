From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH 1/2 v2] t/test-lib.sh: add test_external and test_external_without_stderr
Date: Tue, 17 Jun 2008 08:59:50 +0200
Message-ID: <d94c2a62edfdec22c32ef5d9649078430b30ecfd.1213685306.git.LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 09:01:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8VBe-0007T3-Bk
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 09:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbYFQG74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 02:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbYFQG7z
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 02:59:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:13854 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbYFQG7z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 02:59:55 -0400
Received: by ug-out-1314.google.com with SMTP id h2so513862ugf.16
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 23:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:from;
        bh=OVcC6BUjgjku/HvVAgTLN7p7Jgy4tRxuQicwqdYB6sM=;
        b=mRZLrqnykQgqQTdqS3ePcUybrWpYe0HwRZCGtAmPbWrxQpCeDWFw6LIDM0uFCGhNzY
         XdbC58JShVOTU4drD9h9hzonQiAxWNvRBvSqvJWsUblS+GnPr89wYpEbq7WBQOW97QO6
         qa2CX2P+L7WyHyDCaQDAjuHuqge3A5DESbMPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=B8nFjhmXh+8jDJ7PEJNHoqNmFfMI7tkpq1ylkmccgRnOwv2lxGF7yfSY8o9Ioqt8t0
         HCJhXAjQqe/kS3pGKQRXEQsO/L16M4fAeWtXM2VInmNEeub0e6dF0VyW+CuUufHhvo82
         UIT46Jp+4VJQfCjBtEhnvi9OT56i6LcLNf7cE=
Received: by 10.210.52.9 with SMTP id z9mr7282873ebz.12.1213685993238;
        Mon, 16 Jun 2008 23:59:53 -0700 (PDT)
Received: from fly ( [91.33.200.72])
        by mx.google.com with ESMTPS id f13sm11679206gvd.2.2008.06.16.23.59.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 23:59:52 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <lea@fly>)
	id 1K8VAW-0004P6-1z; Tue, 17 Jun 2008 08:59:52 +0200
X-Mailer: git-send-email 1.5.6.rc3.7.ged9620
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85266>

This is for running external test scripts in other programming
languages that provide continuous output about their tests.  Using
test_expect_success (like "test_expect_success 'description' 'perl
test-script.pl'") doesn't suffice here because test_expect_success
eats stdout in non-verbose mode, which is not fixable without major
file descriptor trickery.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Changed since v1
<http://article.gmane.org/gmane.comp.version-control.git/83415>: Fixed
whitespace.

Both functions have been tested with real perl tests and are working
fine.

These two patches apply on master.

 t/test-lib.sh |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index c861141..b46fe68 100644
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
+	[ -f "$stderr" ] || eror "Internal error: $stderr disappeared."
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
1.5.6.rc3.7.ged9620
