From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/5] t5801: don't use test_when_finished in a subshell
Date: Sat,  5 Sep 2015 14:12:46 +0100
Message-ID: <41e0d2245954e80135d33acbb616c2a56605759a.1441458341.git.john@keeping.me.uk>
References: <20150905085429.GB25039@sigill.intra.peff.net>
 <cover.1441458341.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 15:13:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYDHc-0008AP-NT
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 15:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbbIENNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 09:13:25 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:57364 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbbIENNY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 09:13:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id B7621CDA5EA;
	Sat,  5 Sep 2015 14:13:23 +0100 (BST)
X-Quarantine-ID: <8cpkAyC3xZv0>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8cpkAyC3xZv0; Sat,  5 Sep 2015 14:13:23 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 4F54ECDA46B;
	Sat,  5 Sep 2015 14:13:06 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
In-Reply-To: <cover.1441458341.git.john@keeping.me.uk>
In-Reply-To: <cover.1441458341.git.john@keeping.me.uk>
References: <cover.1441458341.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277371>

test_when_finished has no effect in a subshell.  Since the cmp_marks
function is only used once, inline it at its call site and move the
test_when_finished invocation to the start of the test.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/t5801-remote-helpers.sh | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index c9d3ed1..362b158 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -242,13 +242,6 @@ clean_mark () {
 	sort >$(basename "$1")
 }
 
-cmp_marks () {
-	test_when_finished "rm -rf git.marks testgit.marks" &&
-	clean_mark ".git/testgit/$1/git.marks" &&
-	clean_mark ".git/testgit/$1/testgit.marks" &&
-	test_cmp git.marks testgit.marks
-}
-
 test_expect_success 'proper failure checks for fetching' '
 	(cd local &&
 	test_must_fail env GIT_REMOTE_TESTGIT_FAILURE=1 git fetch 2>error &&
@@ -258,12 +251,15 @@ test_expect_success 'proper failure checks for fetching' '
 '
 
 test_expect_success 'proper failure checks for pushing' '
+	test_when_finished "rm -rf local/git.marks local/testgit.marks" &&
 	(cd local &&
 	git checkout -b crash master &&
 	echo crash >>file &&
 	git commit -a -m crash &&
 	test_must_fail env GIT_REMOTE_TESTGIT_FAILURE=1 git push --all &&
-	cmp_marks origin
+	clean_mark ".git/testgit/origin/git.marks" &&
+	clean_mark ".git/testgit/origin/testgit.marks" &&
+	test_cmp git.marks testgit.marks
 	)
 '
 
-- 
2.5.0.466.g9af26fa
