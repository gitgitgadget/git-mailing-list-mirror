From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] prune: turn on ref_paranoia flag
Date: Tue, 17 Mar 2015 03:30:52 -0400
Message-ID: <20150317073052.GC25191@peff.net>
References: <20150317072750.GA22155@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 08:31:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXlxr-0005Il-Nf
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 08:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbbCQHa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 03:30:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:33920 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751387AbbCQHaz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 03:30:55 -0400
Received: (qmail 25633 invoked by uid 102); 17 Mar 2015 07:30:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Mar 2015 02:30:55 -0500
Received: (qmail 22821 invoked by uid 107); 17 Mar 2015 07:31:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Mar 2015 03:31:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Mar 2015 03:30:52 -0400
Content-Disposition: inline
In-Reply-To: <20150317072750.GA22155@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265616>

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
Note that we should already be aborting for non-tip objects. I guess we
could test that explicitly, too, but I didn't here.

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
index 167031e..cccab58 100755
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
@@ -62,7 +62,7 @@ test_expect_success 'create history with missing tip commit' '
 	test_must_fail git cat-file -e $missing
 '
 
-test_expect_failure 'pruning with a corrupted tip does not drop history' '
+test_expect_success 'pruning with a corrupted tip does not drop history' '
 	test_when_finished "git hash-object -w -t commit saved" &&
 	test_might_fail git prune --expire=now &&
 	verbose git cat-file -e $recoverable
-- 
2.3.3.520.g3cfbb5d
