From: Thell Fowler <git@tbfowler.name>
Subject: [PATCH 1/6] Add supplemental test for trailing-whitespace on incomplete
 lines.
Date: Wed, 19 Aug 2009 18:06:16 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0908191710570.2012@GWPortableVCS>
References: <1249428804.2774.52.camel@GWPortableVCS> <cover.1250719760.git.git@tbfowler.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 20 01:06:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MduEx-0005v2-Cx
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 01:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbZHSXGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 19:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbZHSXGj
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 19:06:39 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:44207 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753373AbZHSXGi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 19:06:38 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1MduEq-0001TN-Dp; Wed, 19 Aug 2009 18:06:40 -0500
X-X-Sender: almostautomated@GWPortableVCS
In-Reply-To: <cover.1250719760.git.git@tbfowler.name>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126589>

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
index 0000000000000000000000000000000000000000..c4937c1b457c24b35565b09e7b262443a05f9795
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
1.6.4.172.g5c0d0.dirty
