From: Thell Fowler <git@tbfowler.name>
Subject: [PATCH 6/6] Add diff tests for trailing-space on incomplete lines
Date: Wed, 19 Aug 2009 18:09:07 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0908191726470.2012@GWPortableVCS>
References: <1249428804.2774.52.camel@GWPortableVCS> <cover.1250719760.git.git@tbfowler.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 20 01:09:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MduHi-00071W-NO
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 01:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbZHSXJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 19:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753424AbZHSXJa
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 19:09:30 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:46076 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753338AbZHSXJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 19:09:29 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1MduHb-0004in-GD; Wed, 19 Aug 2009 18:09:31 -0500
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126596>

  - Adds 7 --no-index tests to t4015-diff-whitespace.sh specifically
    to ensure that xutils.c xdl_hash_record_with_whitespace and
    xdl_recmatch process to the end of the record and handle an
    incomplete line terminator the same as a new-line.

Signed-off-by: Thell Fowler <git@tbfowler.name>
---
 t/t4015-diff-whitespace.sh |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 6d13da30dad5a78fb17a01e86ef33072ea9e6250..193ddbe0659ede17154ffda3b25ebc5e6c686d6e 100755
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
1.6.4.172.g5c0d0.dirty
