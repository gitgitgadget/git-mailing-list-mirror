From: Jeff King <peff@peff.net>
Subject: [RFC/PATCHv2 4/6] pretty: support %G to show the generation number
 of a commit
Date: Wed, 13 Jul 2011 03:05:52 -0400
Message-ID: <20110713070552.GD18566@sigill.intra.peff.net>
References: <20110713064709.GA18499@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 09:06:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgtWB-00068r-Px
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 09:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961Ab1GMHFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 03:05:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43230
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856Ab1GMHFy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 03:05:54 -0400
Received: (qmail 21212 invoked by uid 107); 13 Jul 2011 07:06:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Jul 2011 03:06:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2011 03:05:52 -0400
Content-Disposition: inline
In-Reply-To: <20110713064709.GA18499@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177002>

This might be useful for external programs doing topological
sorting or other graph analysis. It's also handy for testing
the generation calculation code.

Signed-off-by: Jeff King <peff@peff.net>
---
This now includes some basic tests.

 Documentation/pretty-formats.txt |    1 +
 pretty.c                         |    3 ++
 t/t6070-commit-generations.sh    |   41 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 0 deletions(-)
 create mode 100755 t/t6070-commit-generations.sh

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 561cc9f..c58ab52 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -133,6 +133,7 @@ The placeholders are:
 - '%gD': reflog selector, e.g., `refs/stash@\{1\}`
 - '%gd': shortened reflog selector, e.g., `stash@\{1\}`
 - '%gs': reflog subject
+- '%G': generation number (i.e., distance of path to farthest root ancestor)
 - '%Cred': switch color to red
 - '%Cgreen': switch color to green
 - '%Cblue': switch color to blue
diff --git a/pretty.c b/pretty.c
index f45eb54..8f1b321 100644
--- a/pretty.c
+++ b/pretty.c
@@ -965,6 +965,9 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 			return 2;
 		}
 		return 0;	/* unknown %g placeholder */
+	case 'G':
+		strbuf_addf(sb, "%lu", commit_generation(commit));
+		return 1;
 	case 'N':
 		if (c->pretty_ctx->show_notes) {
 			format_display_notes(commit->object.sha1, sb,
diff --git a/t/t6070-commit-generations.sh b/t/t6070-commit-generations.sh
new file mode 100755
index 0000000..3e0f2ad
--- /dev/null
+++ b/t/t6070-commit-generations.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description='calculate and cache commit generations'
+. ./test-lib.sh
+
+test_expect_success 'setup history' '
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	test_commit four &&
+	git checkout -b other two &&
+	test_commit five &&
+	git checkout master &&
+	git merge other &&
+	test_commit six
+'
+
+cat >expect <<'EOF'
+5 six
+4 Merge branch 'other'
+2 five
+3 four
+2 three
+1 two
+0 one
+EOF
+test_expect_success 'check commit generations' '
+	git log --format="%G %s" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cache file was created' '
+	test_path_is_file .git/cache/generations
+'
+
+test_expect_success 'cached values are the same' '
+	git log --format="%G %s" >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.7.6.37.g989c6
