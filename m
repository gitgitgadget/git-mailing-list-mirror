From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] t1515: add tests for rev-parse out-of-repo helpers
Date: Fri, 26 Feb 2016 18:26:32 -0500
Message-ID: <20160226232632.GA9552@sigill.intra.peff.net>
References: <20160226232507.GA9404@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 00:26:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZRmR-0004s7-34
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 00:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258AbcBZX0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 18:26:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:50418 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755128AbcBZX0f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 18:26:35 -0500
Received: (qmail 9365 invoked by uid 102); 26 Feb 2016 23:26:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 18:26:34 -0500
Received: (qmail 8828 invoked by uid 107); 26 Feb 2016 23:26:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 18:26:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2016 18:26:32 -0500
Content-Disposition: inline
In-Reply-To: <20160226232507.GA9404@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287635>

The git-rev-parse command is a dumping ground for helpers
that let scripts make various queries of git. Many of these
are conceptually independent of being inside a git
repository.

With the exception of --parseopt, we do not directly test
most of these features in our test suite. Let's give them
some basic sanity checks, which reveals that some of them
have been broken for some time when run from outside a
repository.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1515-rev-parse-outside-repo.sh | 45 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100755 t/t1515-rev-parse-outside-repo.sh

diff --git a/t/t1515-rev-parse-outside-repo.sh b/t/t1515-rev-parse-outside-repo.sh
new file mode 100755
index 0000000..ae33093
--- /dev/null
+++ b/t/t1515-rev-parse-outside-repo.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+test_description='check that certain rev-parse options work outside repo'
+. ./test-lib.sh
+
+test_expect_success 'set up non-repo directory' '
+	GIT_CEILING_DIRECTORIES=$(pwd) &&
+	export GIT_CEILING_DIRECTORIES &&
+	mkdir non-repo &&
+	cd non-repo &&
+	# confirm that git does not find a repo
+	test_must_fail git rev-parse --git-dir
+'
+
+# Rather than directly test the output of sq-quote directly,
+# make sure the shell can read back a tricky case, since
+# that's what we really care about anyway.
+tricky="really tricky with \\ and \" and '"
+dump_args () {
+	for i in "$@"; do
+		echo "arg: $i"
+	done
+}
+test_expect_success 'rev-parse --sq-quote' '
+	dump_args "$tricky" easy >expect &&
+	eval "dump_args $(git rev-parse --sq-quote "$tricky" easy)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'rev-parse --local-env-vars' '
+	git rev-parse --local-env-vars >actual &&
+	# we do not want to depend on the complete list here,
+	# so just look for something plausible
+	grep ^GIT_DIR actual
+'
+
+test_expect_failure 'rev-parse --resolve-git-dir' '
+	git init --separate-git-dir repo dir &&
+	test_must_fail git rev-parse --resolve-git-dir . &&
+	echo "$(pwd)/repo" >expect &&
+	git rev-parse --resolve-git-dir dir/.git >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.7.2.767.g705917e
