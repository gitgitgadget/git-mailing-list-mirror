From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 3/6] t6300: introduce test_date() helper
Date: Tue,  1 Sep 2015 22:55:41 +0100
Message-ID: <8e869f362971a44bb1f40ca5fed98b658efaa0dd.1441144343.git.john@keeping.me.uk>
References: <20150901083731.GE30659@serenity.lan>
 <cover.1441144343.git.john@keeping.me.uk>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 23:56:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWtXo-0006BP-Qm
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 23:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397AbbIAV4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 17:56:41 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:53922 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbbIAV4k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 17:56:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 27E15CDA5F9;
	Tue,  1 Sep 2015 22:56:40 +0100 (BST)
X-Quarantine-ID: <CTykhYPkDodU>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CTykhYPkDodU; Tue,  1 Sep 2015 22:56:39 +0100 (BST)
Received: from river.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 3CDD6CDA5F8;
	Tue,  1 Sep 2015 22:56:26 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
In-Reply-To: <cover.1441144343.git.john@keeping.me.uk>
In-Reply-To: <cover.1441144343.git.john@keeping.me.uk>
References: <cover.1441144343.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277046>

This moves the setup of the "expected" file inside the test case.  The
helper function has the advantage that we can use SQ in the file content
without needing to escape the quotes.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
I considered moving the test_expect_success into the helper, like with
test_atom earlier in the file, but it doesn't make the code much more
concise and we still need either to setup the output outside the test
case or to escape SQ inside SQ.

 t/t6300-for-each-ref.sh | 73 ++++++++++++++-----------------------------------
 1 file changed, 21 insertions(+), 52 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 7c9bec7..5fdb964 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -146,85 +146,54 @@ test_expect_success 'Check invalid format specifiers are errors' '
 	test_must_fail git for-each-ref --format="%(authordate:INVALID)" refs/heads
 '
 
-cat >expected <<\EOF
-'refs/heads/master' 'Mon Jul 3 17:18:43 2006 +0200' 'Mon Jul 3 17:18:44 2006 +0200'
-'refs/tags/testtag' 'Mon Jul 3 17:18:45 2006 +0200'
-EOF
+test_date () {
+	f=$1
+	committer_date=$2 &&
+	author_date=$3 &&
+	tagger_date=$4 &&
+	cat >expected <<-EOF &&
+	'refs/heads/master' '$committer_date' '$author_date'
+	'refs/tags/testtag' '$tagger_date'
+	EOF
+	(
+		git for-each-ref --shell --format="%(refname) %(committerdate${f:+:$f}) %(authordate${f:+:$f})" refs/heads &&
+		git for-each-ref --shell --format="%(refname) %(taggerdate${f:+:$f})" refs/tags
+	) >actual &&
+	test_cmp expected actual
+}
 
 test_expect_success 'Check unformatted date fields output' '
-	(git for-each-ref --shell --format="%(refname) %(committerdate) %(authordate)" refs/heads &&
-	git for-each-ref --shell --format="%(refname) %(taggerdate)" refs/tags) >actual &&
-	test_cmp expected actual
+	test_date "" "Mon Jul 3 17:18:43 2006 +0200" "Mon Jul 3 17:18:44 2006 +0200" "Mon Jul 3 17:18:45 2006 +0200"
 '
 
 test_expect_success 'Check format "default" formatted date fields output' '
-	f=default &&
-	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
-	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
-	test_cmp expected actual
+	test_date default "Mon Jul 3 17:18:43 2006 +0200" "Mon Jul 3 17:18:44 2006 +0200" "Mon Jul 3 17:18:45 2006 +0200"
 '
 
 # Don't know how to do relative check because I can't know when this script
 # is going to be run and can't fake the current time to git, and hence can't
 # provide expected output.  Instead, I'll just make sure that "relative"
 # doesn't exit in error
-#
-#cat >expected <<\EOF
-#
-#EOF
-#
 test_expect_success 'Check format "relative" date fields output' '
 	f=relative &&
 	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
 	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual
 '
 
-cat >expected <<\EOF
-'refs/heads/master' '2006-07-03' '2006-07-03'
-'refs/tags/testtag' '2006-07-03'
-EOF
-
 test_expect_success 'Check format "short" date fields output' '
-	f=short &&
-	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
-	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
-	test_cmp expected actual
+	test_date short 2006-07-03 2006-07-03 2006-07-03
 '
 
-cat >expected <<\EOF
-'refs/heads/master' 'Mon Jul 3 15:18:43 2006' 'Mon Jul 3 15:18:44 2006'
-'refs/tags/testtag' 'Mon Jul 3 15:18:45 2006'
-EOF
-
 test_expect_success 'Check format "local" date fields output' '
-	f=local &&
-	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
-	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
-	test_cmp expected actual
+	test_date local "Mon Jul 3 15:18:43 2006" "Mon Jul 3 15:18:44 2006" "Mon Jul 3 15:18:45 2006"
 '
 
-cat >expected <<\EOF
-'refs/heads/master' '2006-07-03 17:18:43 +0200' '2006-07-03 17:18:44 +0200'
-'refs/tags/testtag' '2006-07-03 17:18:45 +0200'
-EOF
-
 test_expect_success 'Check format "iso8601" date fields output' '
-	f=iso8601 &&
-	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
-	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
-	test_cmp expected actual
+	test_date iso8601 "2006-07-03 17:18:43 +0200" "2006-07-03 17:18:44 +0200" "2006-07-03 17:18:45 +0200"
 '
 
-cat >expected <<\EOF
-'refs/heads/master' 'Mon, 3 Jul 2006 17:18:43 +0200' 'Mon, 3 Jul 2006 17:18:44 +0200'
-'refs/tags/testtag' 'Mon, 3 Jul 2006 17:18:45 +0200'
-EOF
-
 test_expect_success 'Check format "rfc2822" date fields output' '
-	f=rfc2822 &&
-	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
-	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
-	test_cmp expected actual
+	test_date rfc2822 "Mon, 3 Jul 2006 17:18:43 +0200" "Mon, 3 Jul 2006 17:18:44 +0200" "Mon, 3 Jul 2006 17:18:45 +0200"
 '
 
 test_expect_success 'Check format of strftime date fields' '
-- 
2.5.0.466.g9af26fa
