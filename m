Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC6BCA0EC6
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 23:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348999AbjIKVcJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbjIKJg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 05:36:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A2AE4
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 02:36:22 -0700 (PDT)
Received: (qmail 11351 invoked by uid 109); 11 Sep 2023 09:36:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Sep 2023 09:36:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6618 invoked by uid 111); 11 Sep 2023 09:36:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Sep 2023 05:36:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Sep 2023 05:36:16 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] replacing ci/config/allow-ref with a repo variable
Message-ID: <20230911093616.GA1605460@coredump.intra.peff.net>
References: <20230830194919.GA1709446@coredump.intra.peff.net>
 <8624fc43-ab42-442b-a141-851fc35dd24f@gmail.com>
 <20230901173214.GA1947546@coredump.intra.peff.net>
 <d3d1109b-3a1f-4e8b-be8d-6581d45f1b81@gmail.com>
 <20230905072444.GH199565@coredump.intra.peff.net>
 <fcdc682b-cf6c-4db9-9970-be136f48de58@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fcdc682b-cf6c-4db9-9970-be136f48de58@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 07, 2023 at 11:04:33AM +0100, Phillip Wood wrote:

> I scanned the github documentation the other day and wondered if it would be
> possible to use with fromJson with a json array to do a prefx match on each
> element. It all sounds like it is getting a bit complicated though.

I poked around and I don't think this is possible. You can use
contains() to do a full match of items in a json array, but I don't see
any other way to iterate. What we'd really want is a "map" function, to
do something like:

  map { startsWith(github.ref_name, $1) } fromJSON(vars.CI_CONFIG.allow_prefix)

But no such "map" exists (and I guess we'd need to collapse the result
down to "is any item true", similar to perl's "grep" function).

Do you need multiple prefixes, or would one each of allow/reject be
sufficient? I tried this and it works:

jobs:
  ci-config:
    name: config
    if: |
      (fromJSON(vars.CI_CONFIG).allow == '' ||
       contains(fromJSON(vars.CI_CONFIG).allow, github.ref_name)) &&
      (fromJSON(vars.CI_CONFIG).reject == '' ||
       !contains(fromJSON(vars.CI_CONFIG).reject, github.ref_name)) &&
      (fromJSON(vars.CI_CONFIG).allow-prefix == '' ||
       startsWith(github.ref_name, fromJSON(vars.CI_CONFIG).allow-prefix)) &&
      (fromJSON(vars.CI_CONFIG).reject-prefix == '' ||
       !startsWith(github.ref_name, fromJSON(vars.CI_CONFIG).reject-prefix))

And then various values of CI_CONFIG seem to work:

  - allow explicit branch names ("one" and "two" are run, everything
    else is skipped)

    { "allow": ["one", "two"] }

  - reject explicit names (everything except "three" is skipped)

    { "reject": ["three"] }

  - allow by prefix ("ok/* is run, everything else is skipped)

    { "allow-prefix": "ok/" }

  - reject by prefix (everything except "nope/*" is run)

    { "reject-prefix": "nope/" }

  - every key must approve to run, but missing keys default to running.
    So a reject overrides allow ("ok/one" and "ok/two" run, but
    "ok/three" does not)

    {
      "allow-prefix": "ok/",
      "reject", "ok/three"
    }

I suppose one hacky way to support multiple prefixes is to just unroll
the loop ourselves (since missing keys are ignored). I didn't test it,
but something like:

      (fromJSON(vars.CI_CONFIG).allow-prefix[0] == '' ||
       startsWith(github.ref_name, fromJSON(vars.CI_CONFIG).allow-prefix[0])) &&
      (fromJSON(vars.CI_CONFIG).allow-prefix[1] == '' ||
       startsWith(github.ref_name, fromJSON(vars.CI_CONFIG).allow-prefix[1])) &&
      (fromJSON(vars.CI_CONFIG).allow-prefix[2] == '' ||
       startsWith(github.ref_name, fromJSON(vars.CI_CONFIG).allow-prefix[2])) &&
       ...etc...

Would allow:

  {
    "allow-prefix": [
      "ok/",
      "also-ok/"
    ]
  }

Looking at the ci-config branch of phillipwood/git.git, I see this in
your allow-refs:

      refs/heads/main|refs/heads/master|refs/heads/maint|refs/heads/next|refs/heads/seen|refs/tags/gitgui-*|refs/tags/pr-[0-9]*|refs/tags/v[1-9].*)

So you do use multiple prefixes, though all in refs/tags/.  Do you
actually push tags for which you do want to run CI, or would it be
sufficient to just reject "refs/tags/" completely (though that implies
using the fully qualified ref and not the short name; it would also be
easy to add a boolean "allow tags" config option).

-Peff
