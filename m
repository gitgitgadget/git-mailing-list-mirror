Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF4EC433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 05:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355423AbhLBFeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 00:34:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:41654 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355397AbhLBFeH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 00:34:07 -0500
Received: (qmail 18625 invoked by uid 109); 2 Dec 2021 05:30:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Dec 2021 05:30:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14545 invoked by uid 111); 2 Dec 2021 05:30:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Dec 2021 00:30:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 2 Dec 2021 00:30:43 -0500
From:   Jeff King <peff@peff.net>
To:     Josh Rampersad <josh.rampersad@voiceflow.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 0/2] log: handle --decorate-ref without explicit --decorate
Message-ID: <YahaA/ve7W5Y83Iu@coredump.intra.peff.net>
References: <C29F5770-5092-40A6-9604-DA5F7166575D@voiceflow.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <C29F5770-5092-40A6-9604-DA5F7166575D@voiceflow.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 01, 2021 at 05:31:03PM -0500, Josh Rampersad wrote:

> Ran the command: `git log origin/master --no-walk --grep='my-package' --tags='*my-package*' --decorate-refs='*my-package*'  --format='format:%ct %H %D'`
> The output was as expected with the tags not relating to my-package being filtered out from the output by the decorate-refs option.
> I then, wanted to pipe this output to a separate program.
> [...]
> The filtering I got from the decorate-refs flag was no longer being applied. Thus giving me a bunch of tags I did not want

Thanks for a clear description. As a quick reproduction in git.git, you
can see this with:

  $ git log --no-walk --format='%s%d' --decorate-refs=*/v2.0.0 v2.1.0 v2.0.0
  Git 2.1
  Git 2.0 (tag: v2.0.0)

  $ git log --no-walk --format='%s%d' --decorate-refs=*/v2.0.0 v2.1.0 v2.0.0 | cat
  Git 2.1 (tag: v2.1.0)
  Git 2.0 (tag: v2.0.0)

The problem is that without an explicit --decorate, git-log doesn't
realize it needs to initialize the decorations with the --decorate-refs
argument. Later code realizes that "%d" requires decorations, so we load
them then, but fail to pay attention to the extra arguments.

The reason it's different with a pipe is that the default is
--decorate=auto, so it behaves as if --decorate is given depending on
whether stdout is a terminal.

Here are two patches. The first fixes the bug you saw, and the second is
a similar bug with --simplify-by-decoration. In the meantime, a
workaround is to specify --decorate along with --decorate-refs.

  [1/2]: log: handle --decorate-refs with userformat "%d"
  [2/2]: log: load decorations with --simplify-by-decoration

 builtin/log.c  | 23 +++++++++++++++++++----
 t/t4202-log.sh | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 4 deletions(-)

-Peff
