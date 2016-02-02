From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] test-lib: limit the output of the yes utility
Date: Tue, 2 Feb 2016 08:28:21 +0100
Message-ID: <56B05A95.3000808@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 02 08:28:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQVO3-0004LI-LE
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 08:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbcBBH20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 02:28:26 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:47738 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753530AbcBBH2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 02:28:24 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pvd6G0zrGz5tlD;
	Tue,  2 Feb 2016 08:28:22 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id AB8DE303E;
	Tue,  2 Feb 2016 08:28:21 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285241>

On Windows, there is no SIGPIPE. A consequence of this is that the
upstream process of a pipe does not notice the death of the downstream
process until the pipe buffer is full and writing more data returns an
error. This behavior is the reason for an annoying delay during the
execution of t7610-mergetool.sh: There are a number of test cases where
'yes' is invoked upstream. Since the utility is basically an endless
loop it runs, on Windows, until the pipe buffer is full. This does take
a few seconds.

The test suite has its own implementation of 'yes'. Modify it to produce
only a limited amount of output that is sufficient for the test suite.
The amount chosen should be sufficiently high for any test case, assuming
that future test cases will not exaggerate their demands of input from
an upstream 'yes' invocation.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This does not fix an error, but only an unnecessary sink of CPU cycles
 and wasted wall clock time.

 t/test-lib.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index bd4b02e..97e6491 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -902,15 +902,15 @@ fi
 yes () {
 	if test $# = 0
 	then
-		y=y
+		set -- y
 	else
-		y="$*"
+		set -- "$*"
 	fi
-
-	while echo "$y"
-	do
-		:
-	done
+	# we do not need an infinite supply of output for tests
+	set -- "$@" "$@" "$@" "$@"	# 4
+	set -- "$@" "$@" "$@" "$@"	# 16
+	set -- "$@" "$@" "$@" "$@"	# 64
+	printf "%s\n" "$@"
 }
 
 # Fix some commands on Windows
-- 
2.7.0.118.g90056ae
