Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 223BD20133
	for <e@80x24.org>; Fri,  3 Mar 2017 15:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752243AbdCCPV2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 10:21:28 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:47205 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752238AbdCCPV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 10:21:26 -0500
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1cjobg-0004E9-JS; Fri, 03 Mar 2017 14:54:56 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <22713.33728.502854.338516@chiark.greenend.org.uk>
Date:   Fri, 3 Mar 2017 14:54:56 +0000
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Jason Cooper <git@lakedaemon.net>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
In-Reply-To: <20170303111347.6uzuhvmpdwr27qjw@sigill.intra.peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
        <22704.19873.860148.22472@chiark.greenend.org.uk>
        <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
        <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
        <CA+55aFw6BLjPK-F0RGd9LT7X5xosKOXOxuhmKX65ZHn09r1xow@mail.gmail.com>
        <xmqqinnyztqe.fsf@gitster.mtv.corp.google.com>
        <20170226011359.GI11350@io.lakedaemon.net>
        <20170226051834.i37mlqv5wxwz3254@sigill.intra.peff.net>
        <20170302214610.GA86054@google.com>
        <20170303111347.6uzuhvmpdwr27qjw@sigill.intra.peff.net>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King writes ("Re: SHA1 collisions found"):
> I think you've read more into my "conversion" than I intended. The old
> history won't get rewritten. It will just be grafted onto the bottom of
> the commit history you've got, and the new trees will all be written
> with the new hash.
> 
> So you still have those old objects hanging around that refer to things
> by their sha1 (not to mention bug trackers, commit messages, etc, which
> all use commit ids). And you want to be able to quickly resolve those
> references.
> 
> What _does_ get rewritten is what's in your ref files, your pack .idx,
> etc. Those are all sha256 (or whatever), and work as sha1's do now.

This all sounds very similar to my proposal.

> Looking up a sha1 reference from an old object just goes through the
> extra level of indirection.

I don't understand why this is a level of indirection, rather than
simply a retention of the existing SHA-1 object database (in parallel,
but deprecated).

Perhaps I have misunderstood what you mean by "graft".  I assume you
don't mean info/grafts, because that is not conveyed by transfer
protocols.


Stepping back a bit, the key question is what the data structure will
look like after the transition.

Specifically, the parent reference in the first post-transition commit
has to refer to something.  What does it refer to ?  The possibilities
seem to be:

 1a. It names the SHA1 hash of an old commit object
 1b. It names the BLAKE[1] hash of an old commit object, which
    object of course refers to its parents by SHA1.

 2. It names the BLAKE hash of a translated version of the
    old commit object.

 3. It doesn't name the parent, and the old history is not
    automatically transferred by clone and not readily accessible.

(1a) and (1b) are different variants of something like my mixed hash
proposal.  Old and new hashes live side by side.

(2) involves rewriting all of the old history, to recursively generate
new objects (with BLAKE names, and which in turn refer to other
rewritten old objects by BLAKE names).  The first time a particular
tree needs to look up an object by a BLAKE name, it needs to run a
conversion its own entire existing history.

For (2) there would have to be some kind of mapping table in every
tree, which allowed object names to be maped in both directions.  The
object content translation would have to be reversible, so that the
actual pre-translation objects would not need to be stored; rather
they would be reconstructed from the post-translation objects, when
someone asks for a pre-translation object.  In principle it would be
possible to convert future BLAKE commits to SHA-1 ones, again by
recursive rewriting.

I don't think anyone is seriously suggesting (3).


So there is a choice between:

(1) a unified hash tree containing a mixture of different hashes at
different reference points, where each object has one identity and one
name.

(2) parallel hash tree structures, each using only a single hash, with
at least every old object present in both tree structures.

I think (1) is preferable because it provides, to callers of git, the
existing object naming semantics.  Callers need to be taught to accept
an extension to the object name format.  Existing object names stored
elsewhere than in git remain valid.

Conversely, (2) requires many object names stored elsewhere than in
git to be updated.  It's possible with (2) to do ad-hoc lookups on
object names in mailing list messages or commit messages and so on.
Even if it is possible for the new git to answer questions like "does
this new branch with BLAKE hash X' contain the commit with SHA1 hash
Y" by implicitly looking up the corresponding BLAKE commit Y' and
answering the question with reference to Y', this isn't going to help
if external code does things like "have git compute the merge base of
X and Y' and check that it is equal to Z".  Either the external
database's record of Z would have to be changed to refer to Z', or the
external code would have to be taught to apply an object name
normalisation operation to turn Z into Z' each time.

Also, (2) has trouble with shallow clones.  This is because it's not
possible to translate old objects to new ones without descending to
the roots of the object tree and recursively translating everything
(or looking up the answer of a previous translation).


Then there is the question of naming syntax.

The distinction between (1) single unified mixed hash tree, and
(2) multiple parallel homogenous hash trees, is mostly orthogonal to
the command-line (and in-commit-object etc.) representation of new
hashes.

The main thing here is that, regardless of the choice between (1) or
(2), we need to choose whether object names specified on the git
command line, and printed by normal git commands, explicitly identify
the hash function.

I think there are roughly three options:

 (A) Decorate all new hashes with a hash function indication
     (sha256:<hex> or blake_<hex> or H<hex>)

 (B) Infer the hash function from the object name length
     (and do some kind of bodge for abbreviated object names).

 (C) Hash function is implicit from context.  (This is compatible with
     (2) only, because (1) requires any object to be able to refer to
     any hash function.)

I think (A) is best because it means everything is unambiguous, and it
allows future hash function changes without further difficulty.

(B) is a reasonable possibility although the abbreviated object name
bodge would be quite ugly and probably involve thinking about several
annoying edge cases.

I think (C) is really bad, because it instantly makes all existing
application code which calls git to be buggy.  Such application code
would need to be adjusted to know for itself which of the object names
it has recorded are what hash function, and explicitly specify this to
its git operations somehow.

All of these options involve updating many callers of git.  In any
case any git caller which explicitly checks the object name length
will need to be changed.  For (a), many git callers which match object
names using something like [0-9a-f]+ rather than \w+ will need to be
changed - but at least it's a simple change with little semantic
import.

(A) has the additional advantage that it becomes possible to make
object names syntactically distinguishable from ref names.


The final argument I would make is this:

We don't know what hash function research will look like in 10-20
years.  We would like to not have a bunch of pain again.  So ideally
we would deploy a framework now that would let us switch hash function
again without further history-rewriting.

(1)(A) and perhaps (1)(B) are the only options which support this
well.


Ian.

[1] I'm going to keep assuming that the bikeshed will be blue, because
I think BLAKE2b has is a better choice.  It has probably had more
serious people looking at it than SHA-3, at least, and it has good
performance.  The web page has an impressive adoption list - probably
wider than SHA-3.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.

If I emailed you from an address @fyvzl.net or @evade.org.uk, that is
a private address which bypasses my fierce spamfilter.
