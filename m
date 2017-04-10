Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 457C820960
	for <e@80x24.org>; Mon, 10 Apr 2017 21:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752974AbdDJVOe (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 17:14:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:59447 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752938AbdDJVOd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 17:14:33 -0400
Received: (qmail 26048 invoked by uid 109); 10 Apr 2017 21:14:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 21:14:27 +0000
Received: (qmail 28871 invoked by uid 111); 10 Apr 2017 21:14:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 17:14:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Apr 2017 17:14:24 -0400
Date:   Mon, 10 Apr 2017 17:14:24 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        David Turner <dturner@twosigma.com>
Subject: Re: [PATCH 4/6] receive-pack: quarantine objects until pre-receive
 accepts
Message-ID: <20170410211424.226psdn7ra3sb3mv@sigill.intra.peff.net>
References: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
 <20160930193630.vwq6n5hjbthrz6fj@sigill.intra.peff.net>
 <20161001091245.jkju5rlytbcb2r52@sigill.intra.peff.net>
 <CACBZZX7Rt4zLGk=iy_Z9+8M-xUexwYA060R-v0nvseY7g+zA0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX7Rt4zLGk=iy_Z9+8M-xUexwYA060R-v0nvseY7g+zA0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 08, 2017 at 04:53:38PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Very late reply, but I have a question about this. Is there anything
> you can do on the plumbing level to figure out which area an object is
> in (of course that's not mutually exclusive).
> 
> The use-case for that is e.g. having a hook that rejects large
> binaries, but has an exception for a binary that's been added in the
> past, before your change there's no optimal way to find that out,
> you'd need to go over the whole history and list all blobs that have
> ever been added, with your change it would be trivial if something
> could give me "this object is in the quarantine area", but AFAICT
> there's no API that'll show me that.

No, I don't think there's a way to ask that. The best API to add it to
would probably be "cat-file --batch-check", which can tell you similar
things about the on-disk storage, like "is it a delta? against what?"
and the on-disk size.

_But_. Like those other things, it would have the big caveat that the
object may appear multiple times. So if somebody sent you an object that
was a duplicate of an existing one, you may or may not see it as being
in the quarantine directory.

I think a better rule for hooks is to complain about history which
introduces new references to problematic objects. IOW, instead of
looking at the object database, actually see what the history
introduces:

  while read old new refname; do
	echo "$new"
	if test "$old" != 0000000000000000000000000000000000000000; then
		echo "^$old"
	fi
  done |
  git rev-list --objects --stdin |
  while read sha1 fn; do
    # various object checks against $sha1
  done

However, if large binaries are your interest, I will suggest one other
thing: it's much cheaper to find them during index-pack, rather than by
traversing history. At GitHub we run with a patch to index-pack that
dumps the sha1s of any large blobs into .large-objects in the quarantine
directory. You can abort there, of course, but it's hard to produce a
implement any other policy or produce a nice message. But if you just
note them and leave it to the pre-receive hook, then that hook can do
the traversal to find, e.g., which pathnames reference the large blobs.
And it only has to run at all when we know there's at least one such
blob (and it can quit immediately when it finds it).

I can share those patches, but they need some cleanup to be ready for
inclusion.

> Also, I think this whole thing could really do with some documentation
> in githooks(5). E.g. what hooks does it apply for? The test is just
> for pre-receive but the patch changes run_update_hook(), does it also
> take effect for update? Ditto the caveat about update-ref.

My thinking was that the cases where the effects were user-visible were
sufficiently insane that nobody would need to know or care when the
feature was in use.

It isn't in use for the update hook. It can't be, because that is run
per-ref. So the objects need to be pulled out of the quarantine before
the first ref is updated (I think the call in run_update_hook is
leftover cruft from before I realized that; it should be a noop because
we'll always have migrated the objects by then, and tmp_objdir_env()
will just return NULL).

-Peff
