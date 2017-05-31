Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 087612027C
	for <e@80x24.org>; Wed, 31 May 2017 05:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751056AbdEaFSH (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 01:18:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:60392 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbdEaFSH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 01:18:07 -0400
Received: (qmail 16464 invoked by uid 109); 31 May 2017 05:18:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 05:18:05 +0000
Received: (qmail 1838 invoked by uid 111); 31 May 2017 05:18:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 01:18:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 May 2017 01:18:04 -0400
Date:   Wed, 31 May 2017 01:18:04 -0400
From:   Jeff King <peff@peff.net>
To:     Elliott Cable <me@ell.io>
Cc:     Dennis Kaarsemaker <dennis.kaarsemaker@booking.com>,
        Git Mailing List <git@vger.kernel.org>, bmwill@google.com
Subject: [PATCH] docs/config: mention protocol implications of url.insteadOf
Message-ID: <20170531051804.w6f7yvz4k5wkrwvc@sigill.intra.peff.net>
References: <CAPZ477MCsBsfbqKzp69MT_brwz-0aes6twJofQrhizUBV7ZoeA@mail.gmail.com>
 <1495230186.19473.7.camel@kaarsemaker.net>
 <1495230934.19473.10.camel@booking.com>
 <20170520070757.jekykxagzze3t2wy@sigill.intra.peff.net>
 <CAPZ477PoSXqahxaQVpO+m==vng==o4vQahrg_WA8Oeh7wmoW0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPZ477PoSXqahxaQVpO+m==vng==o4vQahrg_WA8Oeh7wmoW0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 26, 2017 at 11:22:37AM -0500, Elliott Cable wrote:

> 1. Most simply, better documentation: mention `GIT_PROTOCOL_FROM_USER`
>    explicitly in the documentation of/near `insteadOf`, most
>    particularly in the README for `contrib/persistent-https`.

I agree that a hint in both places would be helpful.  The patch for that
is below.

> 2. Possibly, special-case “higher-security” porcelain (like
>    `git-submodule`, as described in 33cfccbbf3) to ignore `insteadOf`
>    rewrite-rules without additional, special configuration. This way,
>    `git-submodule` works for ignorant users (like me) out of the box,
>    just as it previously did, and there's no possible security
>    compramise.

I don't think we can do that. Rewrites of "git://" to "ssh://" are
pretty common (and completely harmless). Besides, I think submodules are
a case where you really would want persistent-https to kick in. IIRC,
the original use case for that helper is Android development, where a
user is likely to update a ton of repositories from the same server all
at once. Right now the fetches are all done individually with the "repo"
tool, but in theory the whole thing could be set up as submodules.

-- >8 --
Subject: [PATCH] docs/config: mention protocol implications of url.insteadOf

If a URL rewrite switches the protocol to something
nonstandard (like "persistent-https" for "https"), the user
may be bitten by the fact that the default protocol
restrictions are different between the two. Let's drop a
note in insteadOf that points the user in the right
direction.

It would be nice if we could make this work out of the box,
but we can't without knowing the security implications of
the user's rewrite. Only the documentation for a particular
remote helper can advise one way or the other. Since we do
include the persistent-https helper in contrib/ (and since
it was the helper in the real-world case that inspired that
patch), let's also drop a note there.

Suggested-by: Elliott Cable <me@ell.io>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt        |  7 +++++++
 contrib/persistent-https/README | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 43d830ee3..5218ecd37 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3235,6 +3235,13 @@ url.<base>.insteadOf::
 	the best alternative for the particular user, even for a
 	never-before-seen repository on the site.  When more than one
 	insteadOf strings match a given URL, the longest match is used.
++
+Note that any protocol restrictions will be applied to the rewritten
+URL. If the rewrite changes the URL to use a custom protocol or remote
+helper, you may need to adjust the `protocol.*.allow` config to permit
+the request.  In particular, protocols you expect to use for submodules
+must be set to `always` rather than the default of `user`. See the
+description of `protocol.allow` above.
 
 url.<base>.pushInsteadOf::
 	Any URL that starts with this value will not be pushed to;
diff --git a/contrib/persistent-https/README b/contrib/persistent-https/README
index f784dd2e6..7c4cd8d25 100644
--- a/contrib/persistent-https/README
+++ b/contrib/persistent-https/README
@@ -35,6 +35,16 @@ to use persistent-https:
 [url "persistent-http"]
 	insteadof = http
 
+You may also want to allow the use of the persistent-https helper for
+submodule URLs (since any https URLs pointing to submodules will be
+rewritten, and Git's out-of-the-box defaults forbid submodules from
+using unknown remote helpers):
+
+[protocol "persistent-https"]
+	allow = always
+[protocol "persistent-http"]
+	allow = always
+
 
 #####################################################################
 # BUILDING FROM SOURCE
-- 
2.13.0.678.ga17378094

