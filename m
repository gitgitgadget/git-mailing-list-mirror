Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 598701F462
	for <e@80x24.org>; Thu, 23 May 2019 20:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbfEWUuM (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 16:50:12 -0400
Received: from thyrsus.com ([71.162.243.5]:55572 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731462AbfEWUuM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 16:50:12 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id 37AB84704887; Thu, 23 May 2019 16:50:09 -0400 (EDT)
Date:   Thu, 23 May 2019 16:50:09 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: RFC: Separate commit identification from Merkle hashing
Message-ID: <20190523205009.GA69096@thyrsus.com>
Reply-To: esr@thyrsus.com
References: <20190521013250.3506B470485F@snark.thyrsus.com>
 <86h89lq96v.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86h89lq96v.fsf@gmail.com>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com>:
> You want both more (stable IDs for all commits, not only those signed)
> and less (you don't need verification down the tree using IDs used for
> commit ID).

That's right.  My assumption is that future VCSes will do their own
hash chaining in ways we don't really want to try to anticipate or
constrain.

> Currently Git makes use of the fact that SHA-1 and SHA-256 identifiers
> are of different lengths to distinguish them (see section "Meaning of
> signatures") in Documentation/technical/hash-function-transition.txt

That's the obvious hack.  As a future-proofing issue, though, I think
it would be unwise to count on all future hashes being of distinguishable
lengths. Explicit algorithm tagging is better, at least internally.

> There might be, I think, the problem for "tree" objects.  As opposed to
> all other places, "tree" objects use binary representation of hash, and
> not hexadecimal textual representation (some consider that a design
> mistake).

I'm inclined to agree that it was a mistake.  But whether it gets
replaced by a binary struct holding an {algorithm-tag,value} pair or a
textual representation of same is not something I care about a lot.

> I think Documentation/technical/hash-function-transition.txt misses
> considerations for fast-import format

You can count on me to stay on top of that; fast-import format is utterly
critical to how reposurgeon works, so I have a strong incentive to make
sure it stays healthy.

(Some of you may not know - reposurgeon solves the thorny problems of
editing repositories by sidestepping to the textual serialized
representation of them.  It's basically a structure editor for
fast-import streams that fools the outside world into thinking it
edits live repositories by having importers and exporters at either
end of its data flow.)

> All right.  Looks sensible on first glance.

I am very relieved to hear that. My view of git is outside-in; I was quite
worried I might have missed some crucial issue.

> For security, all references in Merkle-tree of hashes must use strong
> verification hash.  This means that you need to be able to refer to any
> object, including commit, by its verification hash name of its
> verification hash form (where all references inside object, like
> "parent" and "tree" headers in commit objects, use verification hashes).

Fair enough. One minor way in which my thinking has evolved since
I wrote the RFC is that I now think it might be fruitful not to throw away
the idea of the verification hash as naming a commit, but rather to think
of the separated commit-ID as an alias for the verification hash.

This reframing won't make any difference to the code, but it clarifies
what to do if, for example, an import stream declares the same commit
ID for multiple commits, or fails to declare a commit ID at all.  In both
cases the commit is still uniquely named by its verification hash. Commit-ID
namespace-management failures become annoying but not critical.

> You need to store this commit ID somewhere.  Current proposal for
> transitional period in Documentation/technical/hash-function-transition.txt
> talks about loose object index ($GIT_OBJECT_DIR/loose-object-idx) with
> the following format:
> 
>   # loose-object-idx
>   (sha256-name SP sha1-name LF)*
> 
> In packfile index contains separate SHA-1 indices and SHA-256 indices
> into packfile, providing fast mapping from SHA-1 name or SHA-256 name to
> position (index) of object in the packfile.

I would generalize this to something like

(hash-algorithm-tag:value SP sha1-name LF)

> Something similar might have been needed for commit IDs mapping.

I think so, yes.

> One problem is that neither loose object index, not the packfile index
> are transported alongside with the objects.  So we may need to put
> commit ID elsewhere...
> 
> Note that we cannot put X-hash identifier into X-hash object form, that
> is you cannot add "id" header to object (though you might add "other-id"
> header, assuming that if ID is hash based it is on the other-id form
> without other-id header).
> 
>   id <sha-1 identifier of this object>
>   tree 0fa044a4d161254a3eae0bd06c0452d79e489593
>   parent 6505413ad94ddfc01f9e2f5c1b79ea6b8ffbabbb
>   author A U Thor <author@example.com> 1558619302 +0200
>   committer C O Mitter <committer@example.com> 1558628753 -0500
> 
>   fixes

Implementation details. Let's get the design right and properly specified
before worrying too hard about this level of the problem.

I may do another RFC about how to avoid having this problem ever
again.  In truth, I think git objects should have open property lists,
like bzr, with a property namespace reserved for system
expansion. That way, when you need objects to have new semantics, you
can do it without having an object-format flag day

> > Notice several important properties of this design.
> >
> > A. Git becomes absolutely future-proofed against hash-algorithm
> >    changes. It can even support the use of multiple hash types over
> >    the lifetime of one repo.
> >
> > B. All SHA-1 commit references will resolve forever even after git
> >    stops generating them.  All future hash-based commit references will
> >    also be good forever.
> 
> We might need to be able to distinguish commit IDs from hash-based
> object identifier of commit on command line, perhaps with something like
> 
>   <commit-id>^{id}
> 
> This is similar to proposed
> 
>   git --output-format=sha1 log abac87a^{sha1}..f787cac^{sha256}

Reasonable.

> > C. The id/verification split will be invisible from clients at start,
> >    because initially they coincide and will continue to do so unless
> >    an explicit decision changes either the verification-hash algorithm
> >    or the way commit-IDs are initialized.
> 
> The problem may be with reusing command output for input (to refer to
> objects and commits).

Solvable, I think.

> > D. My wish for forward-portable unique commit IDs is granted.
> >    They're not by default eyeball-friendly, but I can live with that.
> >    Furthermore, because they're preserved in streams they can be
> >    eternally stable even as hash algorithms and preferred ID
> >    formats change.
> 
> Good.

Oh, man, you have no idea how good yet.  You won't until you've done a
few repo conversions yourself.

/me needs a cross-eyed emoji here

> > E. There is now a unique total order on the repo, modulo highly
> >    unlikely (and in priciple completely avoidable) commit-ID
> >    collisions. It's commit date tie-broken by commit-ID sort order.
> >    It too survives hash-function changes.
> 
> Nice.

One thing I will commit to do if we get this far is write the fast-export
code that does canonical order.  I need this badly for reposurgeon tests.

> > F. There's no need for timestamp uniqueness any more.
> >
> > G. When a repository is imported from (say) Subversion, the Subversion
> >    IDs *don't have to break*!  They can be used to initialize the
> >    commit-ID fields. Many users migrating from other VCSes will be
> >    deeply, deeply grateful for this feature.
> 
> There would also need to be some support to retrieve commits using their
> "commit ID" stable identifiers.  It may not need to be very fast.

Agreed.

OK, what do we do next?  Who needs to sign off on this?  Should I prepare
an edit for the hash-function-transition.txt describing the splitting off
of commit IDs?
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>


