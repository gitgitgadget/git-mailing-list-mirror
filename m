Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10D622018B
	for <e@80x24.org>; Wed, 20 Jul 2016 11:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818AbcGTLcv (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 07:32:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:47368 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753621AbcGTLcc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 07:32:32 -0400
Received: (qmail 3574 invoked by uid 102); 20 Jul 2016 11:32:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 07:32:31 -0400
Received: (qmail 19643 invoked by uid 107); 20 Jul 2016 11:32:55 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 07:32:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jul 2016 05:32:26 -0600
Date:	Wed, 20 Jul 2016 05:32:26 -0600
From:	Jeff King <peff@peff.net>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] t5541: fix url scrubbing test when GPG is not set
Message-ID: <20160720113226.GA18700@sigill.intra.peff.net>
References: <xmqqk2ghdysg.fsf@gitster.mtv.corp.google.com>
 <CBEE46F3-5497-43D6-BA5A-217C7AD55B48@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CBEE46F3-5497-43D6-BA5A-217C7AD55B48@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 20, 2016 at 10:20:33AM +0200, Lars Schneider wrote:

> > * jk/push-scrub-url (2016-07-14) 1 commit
> >  (merged to 'next' on 2016-07-19 at 6ada3f1)
> > + push: anonymize URL in status output
>
> t5541-http-push-smart.sh "push status output scrubs password" fails on 
> next using Travis CI OS X:
> https://travis-ci.org/git/git/jobs/145960712
> https://api.travis-ci.org/jobs/145960712/log.txt?deansi=true (non JS)
> 
> I think the test either fails because of OS X or because of the
> used Apache version (Travis CI Linux uses 2.2.22 and OS X uses 2.2.26).
> I haven't done any further investigation.

It's the lack of GPG. Here's a patch.

-- >8 --
Subject: t5541: fix url scrubbing test when GPG is not set

When the GPG prereq is not set, we do not run test 34. That
test changes the directory of the test script as a side
effect (something we usually frown on, but which matches the
style of the rest of this script). When test 35 (the
url-scrubbing test) runs, it expects to be in the directory
from test 34. If it's not, the test fails; we are in a
different sub-repo, our test-commit is built on a different
history, and the push becomes a non-fast-forward.

We can fix this by unconditionally moving to the directory
we expect (again, against our usual style but matching how
the rest of the script operates).

As an additional protection, let's also switch from "make a
new commit and push to master" to just "push to a new
branch". We don't care about the branch name; we just want
_some_ ref update to trigger the status output. Pushing to a
new branch is less likely to run into problems with
force-updates, changing the checked-out branch, etc.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5541-http-push-smart.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 8068bd2..4840c71 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -369,8 +369,10 @@ test_expect_success GPG 'push with post-receive to inspect certificate' '
 '
 
 test_expect_success 'push status output scrubs password' '
-	test_commit scrub &&
-	git push --porcelain "$HTTPD_URL_USER_PASS/smart/test_repo.git" >status &&
+	cd "$ROOT_PATH/test_repo_clone" &&
+	git push --porcelain \
+		"$HTTPD_URL_USER_PASS/smart/test_repo.git" \
+		+HEAD:scrub >status &&
 	# should have been scrubbed down to vanilla URL
 	grep "^To $HTTPD_URL/smart/test_repo.git" status
 '
-- 
2.9.2.505.g2705bb6

