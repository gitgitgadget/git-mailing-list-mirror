Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D77420133
	for <e@80x24.org>; Fri,  3 Mar 2017 22:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbdCCWSl (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 17:18:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:38349 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752118AbdCCWSj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 17:18:39 -0500
Received: (qmail 14298 invoked by uid 109); 3 Mar 2017 22:18:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 22:18:35 +0000
Received: (qmail 951 invoked by uid 111); 3 Mar 2017 22:18:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 17:18:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 17:18:32 -0500
Date:   Fri, 3 Mar 2017 17:18:32 -0500
From:   Jeff King <peff@peff.net>
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc:     Brandon Williams <bmwill@google.com>,
        Jason Cooper <git@lakedaemon.net>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170303221832.brm3gftekmdcubzi@sigill.intra.peff.net>
References: <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
 <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
 <CA+55aFw6BLjPK-F0RGd9LT7X5xosKOXOxuhmKX65ZHn09r1xow@mail.gmail.com>
 <xmqqinnyztqe.fsf@gitster.mtv.corp.google.com>
 <20170226011359.GI11350@io.lakedaemon.net>
 <20170226051834.i37mlqv5wxwz3254@sigill.intra.peff.net>
 <20170302214610.GA86054@google.com>
 <20170303111347.6uzuhvmpdwr27qjw@sigill.intra.peff.net>
 <22713.33728.502854.338516@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22713.33728.502854.338516@chiark.greenend.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 02:54:56PM +0000, Ian Jackson wrote:

> > What _does_ get rewritten is what's in your ref files, your pack .idx,
> > etc. Those are all sha256 (or whatever), and work as sha1's do now.
> 
> This all sounds very similar to my proposal.

Yeah, sorry I haven't reviewed that more carefully yet.

> > Looking up a sha1 reference from an old object just goes through the
> > extra level of indirection.
> 
> I don't understand why this is a level of indirection, rather than
> simply a retention of the existing SHA-1 object database (in parallel,
> but deprecated).

I just meant that we will need to know both the sha1 and the sha-256 of
every object (because the same blob, for example, may be referred to by
either name depending on whether it is a new or a historical tree).  So
one way to do that is to have a table mapping sha1 to sha-256, and then
a lookup of sha-1 goes through that before looking up the object content
on disk via sha-256.

But it may also be fine to just keep an index mapping sha1 directly to
object contents. That makes a sha1 lookup slightly faster, but it's more
expensive to do a sha-256 verification (you have to reverse-index the
object location in the sha-256 list).

(And my usual disclaimer: I am using sha-256 as a placeholder; I don't
have a strong opinion on the actual hash choice).

> Perhaps I have misunderstood what you mean by "graft".  I assume you
> don't mean info/grafts, because that is not conveyed by transfer
> protocols.

No, I just mean there will be a spot in the commit graph (or many spots,
potentially) where a "v2" commit using sha-256 references (by sha-256) a
"v1" commit that is full of sha-1s. I say "graft" only to differentiate
it from the idea of rewriting the content of those commit objects.

> Specifically, the parent reference in the first post-transition commit
> has to refer to something.  What does it refer to ?  The possibilities
> seem to be:
> 
>  1a. It names the SHA1 hash of an old commit object
>  1b. It names the BLAKE[1] hash of an old commit object, which
>     object of course refers to its parents by SHA1.
> 
>  2. It names the BLAKE hash of a translated version of the
>     old commit object.
> 
>  3. It doesn't name the parent, and the old history is not
>     automatically transferred by clone and not readily accessible.
> 
> (1a) and (1b) are different variants of something like my mixed hash
> proposal.  Old and new hashes live side by side.

Thanks for laying out those options. My proposals have definitely been
in the (1b) camp.

I think (1a) is not so bad; it just bumps the transition point one
commit higher. But I think the "rules" for which hash to expect are
easier if they depend on which object the _pointer_ is using, rather
than the _pointee_.

> (2) involves rewriting all of the old history, to recursively generate
> new objects (with BLAKE names, and which in turn refer to other
> rewritten old objects by BLAKE names).  The first time a particular
> tree needs to look up an object by a BLAKE name, it needs to run a
> conversion its own entire existing history.
> 
> For (2) there would have to be some kind of mapping table in every
> tree, which allowed object names to be maped in both directions.  The
> object content translation would have to be reversible, so that the
> actual pre-translation objects would not need to be stored; rather
> they would be reconstructed from the post-translation objects, when
> someone asks for a pre-translation object.  In principle it would be
> possible to convert future BLAKE commits to SHA-1 ones, again by
> recursive rewriting.

Hmm. I had initially rejected this as being pretty nasty for accessing
the old format on the fly. But as long as you keep the bidirectional
mapping from the initial expensive conversion, in most cases you only
need to convert at most a single object. E.g., the two cases that are
really interesting are:

  - I have an old commit sha1 and I want to run "git show" on it. We
    convert the sha1 to the BLAKE name, and then just show the BLAKE
    contents as usual.

  - I want to verify a commit or tag signature. We need the original
    bytes for this. So we convert the sha1 to the BLAKE name to get the
    BLAKE'd contents. Then we rewrite only the _single_ object,
    converting any of its internal BLAKE references back to sha1s via
    the mapping.

That's more appealing than I had originally given it credit for, because
most of the other code just happily uses the BLAKE name internally. Even
a diff across the conversion boundary works at full speed, because it's
using the same names consistently.

The big downside is that the mapping is more expensive to generate than
a 1b-style mapping. In 1b, you just compute both hashes over all
incoming objects and store the sha1 in a side lookup table. But here you
actually need to _rewrite_ each object to come up with its
alternate-universe sha1. And you need to do it in reverse-graph order,
not the arbitrary order that something like index-pack uses.

I had assumed that local repos would generate these tables themselves,
so to not have to trust any other repos. And the alternate-universe
thing is more to ask those local repos to do. But it would also be
workable to distribute the mapping out-of-band (e.g., via a signed tag).

You don't even really need to trust the mapping that much, if it's just
used for historical name lookups.

> I don't think anyone is seriously suggesting (3).

Yeah, agreed.

> Conversely, (2) requires many object names stored elsewhere than in
> git to be updated.  It's possible with (2) to do ad-hoc lookups on
> object names in mailing list messages or commit messages and so on.
> Even if it is possible for the new git to answer questions like "does
> this new branch with BLAKE hash X' contain the commit with SHA1 hash
> Y" by implicitly looking up the corresponding BLAKE commit Y' and
> answering the question with reference to Y', this isn't going to help
> if external code does things like "have git compute the merge base of
> X and Y' and check that it is equal to Z".  Either the external
> database's record of Z would have to be changed to refer to Z', or the
> external code would have to be taught to apply an object name
> normalisation operation to turn Z into Z' each time.

I think the X->X' conversion on input is easy. The universe of objects
whose sha1 we are about is not getting any bigger. Outputting sha1 Z
instead of BLAKE Z' is a bit harder (and at the very least probably
needs the caller to use a specific command-line option).

> Also, (2) has trouble with shallow clones.  This is because it's not
> possible to translate old objects to new ones without descending to
> the roots of the object tree and recursively translating everything
> (or looking up the answer of a previous translation).

Yes. Though if we distribute a partial sha1/BLAKE mapping with the clone
(i.e., just for the objects we're sending) then the client could still
use sha1 names. It not be that big a problem in practice, though. If
you're shallow, then you don't _have_ the old object names to refer to
anyway.

> The main thing here is that, regardless of the choice between (1) or
> (2), we need to choose whether object names specified on the git
> command line, and printed by normal git commands, explicitly identify
> the hash function.
> 
> I think there are roughly three options:
> 
>  (A) Decorate all new hashes with a hash function indication
>      (sha256:<hex> or blake_<hex> or H<hex>)
> 
>  (B) Infer the hash function from the object name length
>      (and do some kind of bodge for abbreviated object names).
> 
>  (C) Hash function is implicit from context.  (This is compatible with
>      (2) only, because (1) requires any object to be able to refer to
>      any hash function.)
> 
> I think (A) is best because it means everything is unambiguous, and it
> allows future hash function changes without further difficulty.

For input, I think we should definitely _support_ A, but in practice I
think people would be happy if an undecorated hash (or partial hash)
looks it up as a BLAKE name, and then falls back to the sha1.

In (2) this is obviously the right thing to do, because all of our
output will be BLAKE names.

In (1) it is less clear if we might output sha1 names for old cases. But
I think we're still better off using the stronger hash when possible.

> (A) has the additional advantage that it becomes possible to make
> object names syntactically distinguishable from ref names.

Sort of. Our get_sha1() parser accepts a lot of random syntax.  E.g.,
"sha256:1234abcd" is ambiguous with a file inside the tree named by
"sha256". In practice I don't mind carving out a namespace and letting
people with a branch named "sha256" rot.

> We don't know what hash function research will look like in 10-20
> years.  We would like to not have a bunch of pain again.  So ideally
> we would deploy a framework now that would let us switch hash function
> again without further history-rewriting.
> 
> (1)(A) and perhaps (1)(B) are the only options which support this
> well.

Yes, I think planning for another migration is a sensible thing.

I just think we should not sacrifice any other properties to the idea
that people could flip on their bespoke hashes and interoperate with
other users. I.e., "git config core.hash sha3 && git push" should not be
a use case we care about at all, because it creates all sorts of _other_
headaches.

But I have no objection to making the 20-years-from-now migration less
painful, and I agree that (1b) is more along those lines.

-Peff
