From: Thell Fowler <git@tbfowler.name>
Subject: [PATCH-v2/RFC 6/6] t4015: add tests for trailing-space on incomplete line
Date: Sat, 22 Aug 2009 22:49:17 -0500
Message-ID: <1250999357-10827-6-git-send-email-git@tbfowler.name>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name>
Cc: Johannes.Schindelin@gmx.de, Thell Fowler <git@tbfowler.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 23 05:50:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mf460-0006Jw-RT
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 05:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933479AbZHWDt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 23:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933467AbZHWDtt
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 23:49:49 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:43344 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S933468AbZHWDtq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 23:49:46 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=localhost.localdomain)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1Mf45U-0004jt-8O; Sat, 22 Aug 2009 22:49:48 -0500
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126838>

  - Add 7 --no-index tests to t4015-diff-whitespace.sh to check
    that ignore options work on incomplete lines.

Signed-off-by: Thell Fowler <git@tbfowler.name>
---
 t/t4015-diff-whitespace.sh |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 6d13da3..193ddbe 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -395,4 +395,37 @@ test_expect_success 'combined diff with autocrlf conversion' '
 
 '
 
+# Ignore trailing-space testing on incomplete lines.
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
+	label="-$1 $lfoo $rfoo"
+
+	test_expect_success "$label" \
+	"! git diff --no-index -$1 -- left right | grep -q foo"
+}
+
+diff_trailing w 0 +nl 1 -nl
+diff_trailing w 0 -nl 1 -nl
+diff_trailing b 0 +nl 0 -nl
+diff_trailing b 1 +nl 0 -nl
+diff_trailing b 1 -nl 0 -nl
+diff_trailing -ignore-space-at-eol 0 +nl 0 -nl
+diff_trailing -ignore-space-at-eol 2 +nl 2 -nl
+
 test_done
-- 
1.6.4.176.g556a4
