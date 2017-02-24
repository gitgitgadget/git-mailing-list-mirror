Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8F22201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 23:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbdBXXjd (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 18:39:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:33721 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751212AbdBXXjc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 18:39:32 -0500
Received: (qmail 22300 invoked by uid 109); 24 Feb 2017 23:39:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 23:39:31 +0000
Received: (qmail 21663 invoked by uid 111); 24 Feb 2017 23:39:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 18:39:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2017 18:39:29 -0500
Date:   Fri, 24 Feb 2017 18:39:29 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org
Subject: Re: SHA1 collisions found
Message-ID: <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 09:32:13AM -0800, Junio C Hamano wrote:

> >  * Therefore the transition needs to be done by giving every object
> >    two names (old and new hash function).  Objects may refer to each
> >    other by either name, but must pick one.  The usual shape of
> 
> I do not think it is necessrily so.  Existing code may not be able
> to read anything new, but you can make the new code understand
> object names in both formats, and for a smooth transition, I think
> the new code needs to.
> 
> For example, a new commit that records a merge of an old and a new
> commit whose resulting tree happens to be the same as the tree of
> the old commit may begin like so:
> 
>     tree 21b97d4c4f968d1335f16292f954dfdbb91353f0
>     parent 20769079d22a9f8010232bdf6131918c33a1bf6910232bdf6131918c33a1bf69
>     parent 22af6fef9b6538c9e87e147a920be9509acf1ddd
> 
> naming the only object whose name was done with new hash with the
> new longer hash, while recording the names of the other existing
> objects with SHA-1.  We would need to extend the object format for
> tag (which would be trivial as the object reference is textual and
> similar to a commit) and tree (much harder), of course.

One thing I worry about in a mixed-hash setting is how often the two
will be mixed. That will lead to interoperability complications, but I
also think it creates security hazards (if I can convince you somehow to
refer to my evil colliding file by its sha1, for example, then I can
subvert the strength of the new hash).

So I'd much rather see strong rules like:

  1. Once a repo has flag-day switched over to the new hash format[1],
     new references are _always_ done with the new hash. Even ones that
     point to pre-flag-day objects!

     So you get a "commit-v2" object instead of a "commit", and it has a
     distinct hash identity from its "commit" counterpart. You can point
     to a classic "commit", but you do so by its new-hash.

     The flag-day switch would probably be a repo config flag based on
     repositoryformatversion (so old versions would just punt if they
     see it). Let's call this flag "newhash" for lack of a better term.

  2. Repos that have new-hash set will consider the new hash
     format as primary, and always use it when writing and referring to
     new objects (e.g., in refs). A (purely local) sha1->new mapping can
     be maintained for doing old-style object lookups, or for quick
     equivalence checks (this mapping might need to be bi-directional
     for some use cases; I haven't thought hard enough about it to say
     either way).

  3. For protocol interop, the rules would be something like[2]:

      a. If upload-pack is serving a newhash repo, it advertises
         so in the capabilities.

	 Recent clients know that the rest of the conversation will
	 involve the new hash format. If they're cloning, they set the
	 newhash flag in their local config.  If they're fetching, they
	 probably abort and say "please enable newhash" (because for an
	 existing repo, it probably needs to migrate refs, for example).

	 An old client would fail to send back the newhash capability,
	 and the server would abort the conversation at that point.

	 A new upload-pack serving a non-newhash repo behaves the same
	 as now (use sha1, happily interoperate with existing and new
	 clients).

      b. receive-pack is more or less the mirror image.

         A server for a newhash-flagged repo has a capability for "this
	 is a newhash repo" and advertises newhash refs. An existing
	 client might still try to push, but the server would reject it
	 unless it advertises "newhash" back to the server.

	 A newhash-enabled client on a non-newhash repo would abort more
	 gracefully ("please upgrade your local repo to newhash").

	 For a newhash-enabled server with a non-newhash repo, it would
	 probably not advertise anything (not even "I understand
	 newhash"). Because the process for converting to newhash is not
	 "just push some newhash objects", but an out-of-band flag-day
	 to convert it over.

That's just a sketch I came up with. There are probably holes. And it
definitely leaves a lot of _possible_ interoperability on the table in
favor of the flag-day approach. But I think the flag-day approach is a
lot easier to reason about. Both in the code, and in terms of the
security properties.

-Peff

[1] I was intentionally vague on "new hash format" here. Obviously there
    are various contenders like SHA-256. But I think there's also an
    open question of whether the new format should be a multi-hash
    format. That would ease further transitions. At the same time, we
    really _don't_ want people picking bespoke hashes for their
    repositories. It creates complications in the code, and it destroys
    a bunch of optimizations (like knowing when we are both talking
    about the same object based on the hash).

    So I am torn between "move to SHA-256 (or whatever)" and "move to a
    hash format that encodes the hash-type in the first byte, but refuse
    to allocate more than one hash for now".

[2] If we're having a flag-day event, this _might_ be time to consider
    some of the breaking protocol changes that have been under
    discussion.  I'm really hesitant to complicate this already-tricky
    issue by throwing in the kitchen sink. But if there's going to be a
    flag day where you need to upgrade Git to access certain repos, it
    might be nice if there's only one. I dunno.
