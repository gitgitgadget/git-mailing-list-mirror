From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/3] Add git-describe test for "verify annotated tag names on output"
Date: Mon, 3 Mar 2008 20:09:38 -0500
Message-ID: <20080304010938.GC15791@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 02:10:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWLfw-0003DX-3l
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 02:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755588AbYCDBJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 20:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755524AbYCDBJm
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 20:09:42 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52234 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755478AbYCDBJl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 20:09:41 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWLer-0001JY-Jz; Mon, 03 Mar 2008 20:09:29 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 03BFA20FBAE; Mon,  3 Mar 2008 20:09:39 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76009>

Back in 212945d4 ("Teach git-describe to verify annotated tag names
before output") I taught git-describe to output the name shown in the
"tag" header of an annotated tag, rather than the name it is actually
stored under in this repository's ref namespace.

This test case verifies this is working correctly by renaming the ref
for an annotated tag to a different name that what is recorded in the
tag body, and verifying that tag is returned.  We also verify there is
a message shown on stderr to inform the user that the tag is possibly
stored under the wrong name locally.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/t6120-describe.sh |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index cc24477..22425d5 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -15,8 +15,9 @@ test_description='test describe
 check_describe () {
 	expect="$1"
 	shift
-	R=$(git describe "$@")
+	R=$(git describe "$@" 2>err.actual)
 	S=$?
+	cat err.actual >&3
 	test_expect_success "describe $*" '
 	test $S = 0 &&
 	case "$R" in
@@ -98,6 +99,20 @@ check_describe B --tags HEAD^^2^
 
 check_describe B-0-* --long HEAD^^2^
 
+test_expect_success 'rename tag A to Q locally' '
+	mv .git/refs/tags/A .git/refs/tags/Q
+'
+cat - >err.expect <<EOF
+warning: tag 'A' is really 'Q' here
+EOF
+check_describe A-* HEAD
+test_expect_success 'warning was displayed for Q' '
+	git diff err.expect err.actual
+'
+test_expect_success 'rename tag Q back to A' '
+	mv .git/refs/tags/Q .git/refs/tags/A
+'
+
 test_expect_success 'pack tag refs' 'git pack-refs'
 check_describe A-* HEAD
 
-- 
1.5.4.3.529.gb25fb
