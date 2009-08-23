From: Thell Fowler <git@tbfowler.name>
Subject: [PATCH-v2/RFC 1/6] Add supplemental test for trailing-whitespace on incomplete lines
Date: Sat, 22 Aug 2009 22:49:12 -0500
Message-ID: <1250999357-10827-1-git-send-email-git@tbfowler.name>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name>
Cc: Johannes.Schindelin@gmx.de, Thell Fowler <git@tbfowler.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 23 05:50:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mf45x-0006Jw-2E
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 05:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933458AbZHWDto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 23:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933456AbZHWDto
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 23:49:44 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:43327 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S933453AbZHWDtn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 23:49:43 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=localhost.localdomain)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1Mf45R-0004jt-Aa; Sat, 22 Aug 2009 22:49:45 -0500
X-Mailer: git-send-email 1.6.4.176.g556a4
In-Reply-To: <1250999285-10683-1-git-send-email-git@tbfowler.name>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps5.pyrapat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tbfowler.name
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126833>

*** For illustrative purposes only and not meant for upstream ***

  - Adds a stand-alone test that loops through A-side B-side with
    and without new-lines from 0 to 3 spaces per side.
    This is a draft test meant to expose the issue with xutils.c
    handling of incomplete lines and trailing-spaces.

Signed-off-by: Thell Fowler <git@tbfowler.name>
---
 t/t4015-diff-trailing-whitespace.sh |   95 +++++++++++++++++++++++++++++++++++
 1 files changed, 95 insertions(+), 0 deletions(-)
 create mode 100755 t/t4015-diff-trailing-whitespace.sh

diff --git a/t/t4015-diff-trailing-whitespace.sh b/t/t4015-diff-trailing-whitespace.sh
new file mode 100755
index 0000000..079fba5
--- /dev/null
+++ b/t/t4015-diff-trailing-whitespace.sh
@@ -0,0 +1,95 @@
+#!/bin/sh
+
+test_description='Test trailing whitespace in diff engine.
+
+'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
+
+# Trailing-space testing with and without newlines.
+prepare_diff_file () {
+	printf "%s%$2s" foo "" >"$1"
+	if [ $3 = "+nl" ]
+	then
+		printf "\n" >>"$1"
+	fi
+}
+
+diff_trailing () {
+	foo="foo___"
+	prepare_diff_file "left" "$2" "$3"
+	lfoo=$( expr substr $foo 1 $((3+$2)) )
+	lfoo=${lfoo}"$3"
+
+	prepare_diff_file "right" "$4" "$5"
+	rfoo=$( expr substr $foo 1 $((3+$4)) )
+	rfoo=${rfoo}"$5"
+
+	label="-$1 $lfoo $rfoo ($6)"
+
+	if [ "$6" != "should_diff" ]
+	then
+		negate='!'
+	else
+		negate=''
+	fi
+
+	if [ -z "$7" ]
+	then
+		test_expect_success "$label" \
+		"$negate git diff --no-index -$1 -- left right | grep -q foo"
+	else
+		test_expect_failure "$label" \
+		"$negate git diff --no-index -$1 -- left right | grep -q foo"
+	fi
+
+	test_debug "git diff --no-index -$1 -- left right | grep foo"
+}
+
+touch diffout
+for arg in -ignore-all-space -ignore-space-at-eol -ignore-space-change
+do
+	for i1 in 0 1 2 3
+	do
+		for i2 in 0 1 2 3
+		do
+			diff_trailing $arg $i1 +nl $i2 -nl should_not_diff >> diffout
+			diff_trailing $arg $i1 -nl $i2 +nl should_not_diff >> diffout
+
+			if [ $i1 -ne $i2 ]
+			then
+				diff_trailing $arg $i1 +nl $i2 +nl should_not_diff >> diffout
+				diff_trailing $arg $i1 -nl $i2 -nl should_not_diff >> diffout
+			fi
+		done
+	done
+done
+
+test_debug 'grep "FAIL" diffout'
+
+for arg in all eol change
+do
+	grep "FAIL" diffout | \
+	grep "$arg" | \
+	cut -d " " -f 4- | \
+
+	##  Playing with filtering to isolate core issue.
+	#sort -k 2,2 -k 3,3 | \
+	#awk '{ forward = $2 " " $3; reverse = $3 " " $2}
+	#	!seen[forward]++ && !seen[reverse]++' | \
+	#sort -k 2,2 | \
+
+	##  Playing with filtering to isolate core issue.
+	##  This seems like the most illustrative output...
+	awk '{ key=$3 ; gsub(/-/, "+", key) ; key=$2 ":" key ; if ( hash[key]++ == 0 ) print ; }'
+
+	##  Playing with filtering to isolate core issue.
+	#awk '{ if ( $3 ~ /.*\-/ )
+	#		print $0
+	#	else
+	#		print $1 " " $3 " " $2 " " $4
+	#	; }' | \
+	#sort -k 2,2 -k 3,3
+done
+
+test_done
-- 
1.6.4.176.g556a4
