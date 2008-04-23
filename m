From: Jeff King <peff@peff.net>
Subject: Re: Friendly refspecs
Date: Wed, 23 Apr 2008 05:16:06 -0400
Message-ID: <20080423091606.GC11935@sigill.intra.peff.net>
References: <20080413093102.GC12107@mithlond.arda.local> <20080416034823.GA11727@sigill.intra.peff.net> <alpine.LNX.1.00.0804161126280.19665@iabervon.org> <7vod89pnxx.fsf@gitster.siamese.dyndns.org> <20080422105658.GA11238@sigill.intra.peff.net> <7v63u9zva9.fsf@gitster.siamese.dyndns.org> <20080422200550.GB29313@sigill.intra.peff.net> <7vd4ohy5ym.fsf@gitster.siamese.dyndns.org> <20080423042433.GA3291@mithlond.arda.local> <7v1w4xuni1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 11:17:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Job6C-0006aR-O7
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 11:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbYDWJQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 05:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbYDWJQK
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 05:16:10 -0400
Received: from peff.net ([208.65.91.99]:1054 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795AbYDWJQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 05:16:09 -0400
Received: (qmail 9028 invoked by uid 111); 23 Apr 2008 09:16:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 23 Apr 2008 05:16:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Apr 2008 05:16:07 -0400
Content-Disposition: inline
In-Reply-To: <7v1w4xuni1.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80202>

On Tue, Apr 22, 2008 at 10:52:06PM -0700, Junio C Hamano wrote:

> Historically we did not favor one way or another for the general purpose
> syntax.  I think Jeff's proposed heuristics to favor branch if a branch
> tip is pushed and tag if a tag is pushed makes sense.

OK, here is a cleaned up patch with tests.

-- >8 --
push: allow unqualified dest refspecs to DWIM

Previously, a push like:

  git push remote src:dst

would go through the following steps:

  1. check for an unambiguous 'dst' on the remote; if it
     exists, then push to that ref
  2. otherwise, check if 'dst' begins with 'refs/'; if it
     does, create a new ref
  3. otherwise, complain because we don't know where in the
     refs hierarchy to put 'dst'

However, in some cases, we can guess about the ref type of
'dst' based on the ref type of 'src'. Specifically, before
complaining we now check:

  2.5. if 'src' resolves to a ref starting with refs/heads
       or refs/tags, then prepend that to 'dst'

So now this creates a new branch on the remote, whereas it
previously failed with an error message:

  git push master:newbranch

Note that, by design, we limit this DWIM behavior only to
source refs which resolve exactly (including symrefs which
resolve to existing refs). We still complain on a partial
destination refspec if the source is a raw sha1, or a ref
expression such as 'master~10'.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c              |   32 +++++++++++++++++++++++++++++---
 t/t5516-fetch-push.sh |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index 06ad156..2d9af40 100644
--- a/remote.c
+++ b/remote.c
@@ -812,6 +812,26 @@ static struct ref *make_linked_ref(const char *name, struct ref ***tail)
 	return ret;
 }
 
+static char *guess_ref(const char *name, struct ref *peer)
+{
+	struct strbuf buf = STRBUF_INIT;
+	unsigned char sha1[20];
+
+	const char *r = resolve_ref(peer->name, sha1, 1, NULL);
+	if (!r)
+		return NULL;
+
+	if (!prefixcmp(r, "refs/heads/"))
+		strbuf_addstr(&buf, "refs/heads/");
+	else if (!prefixcmp(r, "refs/tags/"))
+		strbuf_addstr(&buf, "refs/tags/");
+	else
+		return NULL;
+
+	strbuf_addstr(&buf, name);
+	return strbuf_detach(&buf, NULL);
+}
+
 static int match_explicit(struct ref *src, struct ref *dst,
 			  struct ref ***dst_tail,
 			  struct refspec *rs,
@@ -820,6 +840,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	struct ref *matched_src, *matched_dst;
 
 	const char *dst_value = rs->dst;
+	char *dst_guess;
 
 	if (rs->pattern)
 		return errs;
@@ -866,10 +887,15 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	case 0:
 		if (!memcmp(dst_value, "refs/", 5))
 			matched_dst = make_linked_ref(dst_value, dst_tail);
+		else if((dst_guess = guess_ref(dst_value, matched_src)))
+			matched_dst = make_linked_ref(dst_guess, dst_tail);
 		else
-			error("dst refspec %s does not match any "
-			      "existing ref on the remote and does "
-			      "not start with refs/.", dst_value);
+			error("unable to push to unqualified destination: %s\n"
+			      "The destination refspec neither matches an "
+			      "existing ref on the remote nor\n"
+			      "begins with refs/, and we are unable to "
+			      "guess a prefix based on the source ref.",
+			      dst_value);
 		break;
 	default:
 		matched_dst = NULL;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index f93a100..0a757d5 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -273,6 +273,37 @@ test_expect_success 'push with colon-less refspec (4)' '
 
 '
 
+test_expect_success 'push head with non-existant, incomplete dest' '
+
+	mk_test &&
+	git push testrepo master:branch &&
+	check_push_result $the_commit heads/branch
+
+'
+
+test_expect_success 'push tag with non-existant, incomplete dest' '
+
+	mk_test &&
+	git tag -f v1.0 &&
+	git push testrepo v1.0:tag &&
+	check_push_result $the_commit tags/tag
+
+'
+
+test_expect_success 'push sha1 with non-existant, incomplete dest' '
+
+	mk_test &&
+	test_must_fail git push testrepo `git rev-parse master`:foo
+
+'
+
+test_expect_success 'push ref expression with non-existant, incomplete dest' '
+
+	mk_test &&
+	test_must_fail git push testrepo master^:branch
+
+'
+
 test_expect_success 'push with HEAD' '
 
 	mk_test heads/master &&
@@ -311,6 +342,15 @@ test_expect_success 'push with +HEAD' '
 
 '
 
+test_expect_success 'push HEAD with non-existant, incomplete dest' '
+
+	mk_test &&
+	git checkout master &&
+	git push testrepo HEAD:branch &&
+	check_push_result $the_commit heads/branch
+
+'
+
 test_expect_success 'push with config remote.*.push = HEAD' '
 
 	mk_test heads/local &&
-- 
1.5.5.1.69.g9c889.dirty
