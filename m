From: Jeff King <peff@peff.net>
Subject: [PATCH v2 3/5] prune: turn on ref_paranoia flag
Date: Fri, 20 Mar 2015 14:43:09 -0400
Message-ID: <20150320184309.GC23849@peff.net>
References: <20150320184215.GA26368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 19:45:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ1uu-0003tP-WA
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 19:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbbCTSpD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 14:45:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:36033 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751120AbbCTSnM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 14:43:12 -0400
Received: (qmail 29034 invoked by uid 102); 20 Mar 2015 18:43:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 13:43:12 -0500
Received: (qmail 26946 invoked by uid 107); 20 Mar 2015 18:43:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 14:43:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 14:43:09 -0400
Content-Disposition: inline
In-Reply-To: <20150320184215.GA26368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265934>

Prune should know about broken objects at the tips of refs,
so that we can feed them to our traversal rather than
ignoring them. It's better for us to abort the operation on
the broken object than it is to start deleting objects with
an incomplete view of the reachability namespace.

Note that for missing objects, aborting is the best we can
do. For a badly-named ref, we technically could use its sha1
as a reachability tip. However, the iteration code just
feeds us a null sha1, so there would be a reasonable amount
of code involved to pass down our wishes. It's not really
worth trying to do better, because this is a case that
should happen extremely rarely, and the message we provide:

  fatal: unable to parse object: refs/heads/bogus:name

is probably enough to point the user in the right direction.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/prune.c             | 1 +
 t/t5312-prune-corruption.sh | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index 04d3b12..17094ad 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -115,6 +115,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	expire = ULONG_MAX;
 	save_commit_buffer = 0;
 	check_replace_refs = 0;
+	ref_paranoia = 1;
 	init_revisions(&revs, prefix);
 
 	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
index 496a9f5..5ffb817 100755
--- a/t/t5312-prune-corruption.sh
+++ b/t/t5312-prune-corruption.sh
@@ -25,7 +25,7 @@ test_expect_success 'create history reachable only from a bogus-named ref' '
 	git reset --hard HEAD^
 '
 
-test_expect_failure 'pruning does not drop bogus object' '
+test_expect_success 'pruning does not drop bogus object' '
 	test_when_finished "git hash-object -w -t commit saved" &&
 	test_might_fail git prune --expire=now &&
 	verbose git cat-file -e $bogus
@@ -72,7 +72,7 @@ test_expect_success 'create history with missing tip commit' '
 	test_must_fail git cat-file -e $missing
 '
 
-test_expect_failure 'pruning with a corrupted tip does not drop history' '
+test_expect_success 'pruning with a corrupted tip does not drop history' '
 	test_when_finished "git hash-object -w -t commit saved" &&
 	test_might_fail git prune --expire=now &&
 	verbose git cat-file -e $recoverable
-- 
2.3.3.520.g3cfbb5d
