Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5FCA2018F
	for <e@80x24.org>; Wed, 13 Jul 2016 23:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbcGMXg7 (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 19:36:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:44414 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751092AbcGMXg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 19:36:57 -0400
Received: (qmail 24611 invoked by uid 102); 13 Jul 2016 23:36:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jul 2016 19:36:58 -0400
Received: (qmail 18511 invoked by uid 107); 13 Jul 2016 23:37:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jul 2016 19:37:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2016 19:36:53 -0400
Date:	Wed, 13 Jul 2016 19:36:53 -0400
From:	Jeff King <peff@peff.net>
To:	ervion <ervion@cryptolab.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>, jch2355@gmail.com
Subject: Re: Https password present in git output
Message-ID: <20160713233653.GA9900@sigill.intra.peff.net>
References: <2908abd39c722c080ec37a987a79e32f@cryptolab.net>
 <xmqqd1mh1kbd.fsf@gitster.mtv.corp.google.com>
 <CAPc5daXq-WBEYTyi2M7kMoZtQCYgucCRQ=GFVt8U_H_vRYyZPw@mail.gmail.com>
 <2bd57007f21ab1154d3bcc1e9bc8664e@cryptolab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2bd57007f21ab1154d3bcc1e9bc8664e@cryptolab.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 01:36:52AM +0300, ervion wrote:

> It is in fact the case, that git fetch output is scrubbed, sorry I did not
> notice previously.
> But (on my device: git version 2.9.0 arch linux) git push is not.
> $ git push origin --all

Maybe this?

-- >8 --
Subject: [PATCH] push: anonymize URL in status output

Commit 47abd85 (fetch: Strip usernames from url's before
storing them, 2009-04-17) taught fetch to anonymize URLs.
The primary purpose there was to avoid sticking passwords in
merge-commit messages, but as a side effect, we also avoid
printing them to stderr.

The push side does not have the merge-commit problem, but it
probably should avoid printing them to stderr. We can reuse
the same anonymizing function.

Note that for this to come up, the credentials would have to
appear either on the command line or in a git config file,
neither of which is particularly secure. So people _should_
be switching to using credential helpers instead, which
makes this problem go away. But that's no excuse not to
improve the situation for people who for whatever reason end
up using credentials embedded in the URL.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5541-http-push-smart.sh | 7 +++++++
 transport.c                | 7 +++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index fd7d06b..8d08e06 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -368,5 +368,12 @@ test_expect_success GPG 'push with post-receive to inspect certificate' '
 	test_cmp expect "$HTTPD_DOCUMENT_ROOT_PATH/push-cert-status"
 '
 
+test_expect_success 'push status output scrubs password' '
+	test_commit scrub &&
+	git push --porcelain "$HTTPD_URL_USER_PASS/smart/test_repo.git" >status &&
+	# should have been scrubbed down to vanilla URL
+	grep "^To $HTTPD_URL/smart/test_repo.git" status
+'
+
 stop_httpd
 test_done
diff --git a/transport.c b/transport.c
index 095e61f..be4a63e 100644
--- a/transport.c
+++ b/transport.c
@@ -359,8 +359,11 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 
 static int print_one_push_status(struct ref *ref, const char *dest, int count, int porcelain)
 {
-	if (!count)
-		fprintf(porcelain ? stdout : stderr, "To %s\n", dest);
+	if (!count) {
+		char *url = transport_anonymize_url(dest);
+		fprintf(porcelain ? stdout : stderr, "To %s\n", url);
+		free(url);
+	}
 
 	switch(ref->status) {
 	case REF_STATUS_NONE:
-- 
2.9.1.356.g3c37bc7

