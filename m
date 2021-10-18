Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A82DC433F5
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 19:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC2AD603E5
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 19:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhJRThP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 15:37:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:41136 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231542AbhJRThP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 15:37:15 -0400
Received: (qmail 3187 invoked by uid 109); 18 Oct 2021 19:35:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Oct 2021 19:35:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1463 invoked by uid 111); 18 Oct 2021 19:35:02 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Oct 2021 15:35:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Oct 2021 15:34:59 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] handling REF_STATUS_EXPECTING_REPORT over http
Message-ID: <YW3MY6lAI5l+BOnP@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently saw a case where GitHub's server implementation failed to
correctly report ref statuses. In this case it was because it hit an
internal timeout, but the root cause doesn't really matter; the server
is doing the wrong thing.

But what's interesting on the Git client side is that we produce quite a
confusing message for http. For ssh, we correctly say something like (in
this example, I'm pushing an absurd number of tags that causes the
timeout):

   To ssh://github.com/some/repo
    ! [remote failure]  tag-1 -> tag-1 (remote failed to report status)
   [...etc...]
    ! [remote failure]  tag-999 -> tag-999 (remote failed to report status)
   error: failed to push some refs to 'ssh://github.com/some/repo'

but for http, I get just:

  Everything up-to-date

Which is misleading to say the least. The issue is communication between
send-pack and remote-curl on the client side.

The first patch does the minimal fix. The second one has some cosmetic
improvements. They arguably could be squashed together, but I think
keeping them split shows exactly what the second patch is actually
accomplishing (especially with the minor change to the expected output
in the test).

This bug has been around since smart http was added in 2009. I just
prepared it on master, but I expect it could also go to maint.

  [1/2]: send-pack: complain about "expecting report" with --helper-status
  [2/2]: transport-helper: recognize "expecting report" error from send-pack

 builtin/send-pack.c            |  4 ++++
 t/lib-httpd.sh                 |  1 +
 t/lib-httpd/apache.conf        |  4 ++++
 t/lib-httpd/error-no-report.sh |  6 ++++++
 t/t5541-http-push-smart.sh     | 16 ++++++++++++++++
 transport-helper.c             |  4 ++++
 6 files changed, 35 insertions(+)
 create mode 100644 t/lib-httpd/error-no-report.sh

-Peff
