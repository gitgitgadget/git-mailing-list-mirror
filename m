Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11147C433ED
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 18:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF7F861056
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 18:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhCaS7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 14:59:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:38916 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235282AbhCaS7O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 14:59:14 -0400
Received: (qmail 30749 invoked by uid 109); 31 Mar 2021 18:59:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 31 Mar 2021 18:59:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6599 invoked by uid 111); 31 Mar 2021 18:59:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Mar 2021 14:59:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Mar 2021 14:59:12 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 10/10] tag: don't misreport type of tagged objects in
 errors
Message-ID: <YGTGgFI19fS7Uv6I@coredump.intra.peff.net>
References: <20210308200426.21824-1-avarab@gmail.com>
 <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
 <patch-10.11-a84f670ac24-20210328T021238Z-avarab@gmail.com>
 <xmqq35wdfaw5.fsf@gitster.g>
 <YGRWqX+qF+Rtqr20@coredump.intra.peff.net>
 <87k0pnkwej.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k0pnkwej.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 31, 2021 at 08:31:16PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Ævar's patch tries to improve the case where we might _know_ which is
> > correct (because we're actually parsing the object contents), but of
> > course it covers only a fraction of cases. I'm not really opposed to
> > that per se, but I probably wouldn't bother myself.
> 
> What fraction of cases? As far as I can tell it covers all cases where
> we get this error.
> 
> If there is a case like what you're describing I haven't found it.

It would happen any time somebody calls lookup_foo() because they saw an
object referenced, but _doesn't_ parse it. And then somebody later calls
lookup_bar() in the same way. Neither of them consulted the actual
object database.

Try this with your patches:

-- >8 --
git init repo
cd repo

# just for making things deterministic
export GIT_COMMITTER_NAME='A U Thor'
export GIT_COMMITTER_EMAIL='author@example.com'
export GIT_COMMITTER_DATE='@1234567890 +0000'

blob=$(echo foo | git hash-object -w --stdin)
git tag -m 'tag of blob' tag-of-blob $blob
git update-ref refs/tags/tag-of-commit $(
  git cat-file tag tag-of-blob |
  sed s/blob/commit/g |
  git hash-object -w --stdin -t tag
)
git update-ref refs/tags/tag-of-tree $(
  git cat-file tag tag-of-blob |
  sed s/blob/tree/g |
  git hash-object -w --stdin -t tag
)

git fsck
-- >8 --

That fsck produces (257cc5642 is the blob):

  error: object 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 is a blob, not a commit
  error: 257cc5642cb1a054f08cc83f2d943e56fd3ebe99: object could not be parsed: .git/objects/25/7cc5642cb1a054f08cc83f2d943e56fd3ebe99
  error: object 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 is a commit, not a tree
  error: bad tag pointer to 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 in aaff0d42df150e1a734f6a8516878b2ea315ee0a
  error: aaff0d42df150e1a734f6a8516878b2ea315ee0a: object could not be parsed: .git/objects/aa/ff0d42df150e1a734f6a8516878b2ea315ee0a
  error: object 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 is a commit, not a blob
  error: bad tag pointer to 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 in bbd2b7077cd91ee6175cdc0e4c477c25c230cdc7
  error: bbd2b7077cd91ee6175cdc0e4c477c25c230cdc7: object could not be parsed: .git/objects/bb/d2b7077cd91ee6175cdc0e4c477c25c230cdc7

So we claim "is X, not Y" in multiple directions for the same object.

It might just be that there are spots in the fsck code that need to be
adjusted to use your new function (if they are indeed parsing the
referred-to object). But there are lots of places that don't actually
parse the object at the moment they're parsing the tag. E.g.:

  $ git for-each-ref --format='%(*objectname)'
  error: object 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 is a commit, not a tree
  error: bad tag pointer to 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 in aaff0d42df150e1a734f6a8516878b2ea315ee0a
  Segmentation fault

Neither of those types is the correct one. And the segfault is just a
bonus! :)

I'd expect similar cases with parsing commit parents and tree pointers.
And probably tree entries whose modes are wrong.

> I.e. it happens when we have an un-parsed "struct object" whose type is
> inferred, and parse it to find out it's not what we expected.
> 
> It's not ambigious at all what the object actually is. It's just that
> the previous code was leaking the *assumption* about the type at the
> time of emitting the error, due to an apparent oversight with parsed
> v.s. non-parsed.
> 
> Or in other words, we're leaking the implementation detail that we
> pre-allocated an object struct of a given type in anticipation of
> holding a parsed version of that object soon.

Right. In the case that you are indeed parsing the object later, you can
say definitively "it is X in the odb, but seen as Y previously". But we
do not always hit the "is X, not Y" error when parsing the object. It
might be caused by two of these "pre-allocations" (though really I think
it is not just an implementation detail; the pre-allocation happened
because some other object referred to us as a given type, so it really
is a corruption in the repository. Just not in the object we mention).

> > @@ -169,10 +169,16 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
> >  		return obj;
> >  	}
> >  	else {
> > -		if (!quiet)
> > -			error(_("object %s is a %s, not a %s"),
> > -			      oid_to_hex(&obj->oid),
> > -			      type_name(obj->type), type_name(type));
> > +		if (!(flags & OBJECT_AS_TYPE_QUIET)) {
> > +			if (flags & OBJECT_AS_TYPE_EXPECT_PARSED)
> > +				error(_("object %s is a %s, but was referred to as a %s"),
> > +				      oid_to_hex(&obj->oid), type_name(obj->type),
> > +				      type_name(type));
> > +			else
> > +				error(_("object %s referred to as both a %s and a %s"),
> > +				      oid_to_hex(&obj->oid),
> > +				      type_name(obj->type), type_name(type));
> > +		}
> >  		return NULL;
> >  	}
> >  }
> 
> Per the above I don't understand how you think there's any uncertainty
> here.
> 
> If I'm right and there isn't then first of all I don't see how we could
> emit 1/2 of those errors. The whole problem here is that we don't know
> the type of the un-parsed object (and presumably don't want to eagerly
> know, it would mean hitting the object store).

Forgetting for a moment how to trigger it with actual Git commands, the
root of the problem is that:

  lookup_tree(&oid);
  lookup_blob(&oid);

is going to produce an error message. But we cannot know which object
type is wrong and which is right (if any). So we'd want to produce the
"referred to as both" message.

_If_ the caller happens to know that it has just parsed the object
contents and got a tree, then it would call lookup_parsed_tree(&oid),
which would pass along OBJECT_AS_TYPE_EXPECT_PARSED, and produce the
other message.

In practice, of course those two lookup_foo() calls are not right next
to each other. But they may be triggered on an identical oid by two
references from different objects.

> But when we do know why would we beat around the bush and say "was
> referred to as X and Y" once we know what it is. 
> 
> AFAICT there's no more reason to think that parse_object_buffer() will
> be wrong about the type than "git cat-file -t" will be. They both use
> the same underlying functions to get that information.

My point is that we are not always coming from parse_object_buffer()
when we see these error messages.

-Peff
