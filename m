Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56348C433DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 21:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37322206E2
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 21:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgFAVkG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:40:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:33670 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbgFAVkF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 17:40:05 -0400
Received: (qmail 30809 invoked by uid 109); 1 Jun 2020 21:40:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Jun 2020 21:40:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14269 invoked by uid 111); 1 Jun 2020 21:40:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Jun 2020 17:40:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 1 Jun 2020 17:40:03 -0400
From:   Jeff King <peff@peff.net>
To:     John Siu <john.sd.siu@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git multiple remotes push stop at first failed connection
Message-ID: <20200601214003.GA3309882@coredump.intra.peff.net>
References: <CAGKX4vGhTbEqZS9+iYA2wZWRRaddQC6O4KV+zLaNYKkZgN36Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGKX4vGhTbEqZS9+iYA2wZWRRaddQC6O4KV+zLaNYKkZgN36Xg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 31, 2020 at 08:28:38PM -0400, John Siu wrote:

> Let say my project has following remotes:
> 
> $ git remote -v
> git.all "server A git url" (fetch)
> git.all "server A git url" (push)
> git.all "server B git url" (push)
> git.all "server C git ur" (push)
> 
> When all serverA/B/C are online, "git push" works.

A slight nomenclature nit, but that's _one_ remote that has several
push urls.

> However "git push" will stop at the first server it failed to connect.
> So if git cannot connect to server A, it will not continue with server
> B/C.
> 
> In the past I have server C turn off from time to time, so failing the
> last push is expected. However recently server A went offline
> completely and we notice git is not pushing to the remaining 2
> remotes.
> 
> Not sure if this is intended behavior or can be improved.

I don't think we've ever documented the error-handling semantics.
Looking at the relevant code in builtin/push.c:do_push():

          url_nr = push_url_of_remote(remote, &url);
          if (url_nr) {
                  for (i = 0; i < url_nr; i++) {
                          struct transport *transport =
                                  transport_get(remote, url[i]);
                          if (flags & TRANSPORT_PUSH_OPTIONS)
                                  transport->push_options = push_options;
                          if (push_with_options(transport, push_refspec, flags))
                                  errs++;
                  }
          } else {
                  struct transport *transport =
                          transport_get(remote, NULL);
                  if (flags & TRANSPORT_PUSH_OPTIONS)
                          transport->push_options = push_options;
                  if (push_with_options(transport, push_refspec, flags))
                          errs++;
          }
          return !!errs;

it does seem to try each one and collect the errors. But the underlying
transport code is so ready to die() on errors, taking down the whole
process, that I suspect it rarely manages to do so. You're probably much
better off defining a separate remote for each push destination, then
running your own shell loop:

  err=0
  for dst in serverA serverB serverC; do
    git push $dst || err=1
  done
  exit $err

There's really no benefit to doing it all in a single Git process, as
we'd connect to each independently, run a separate independent
pack-objects for each, etc.

I'd even suggest that Git implement such a loop itself, as we did for
"git fetch --all", but sadly "push --all" is already taken for a
different meaning (but it might still be worth doing under a different
option name).

-Peff
