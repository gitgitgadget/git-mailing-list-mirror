Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2276202A5
	for <e@80x24.org>; Mon,  2 Oct 2017 09:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751104AbdJBJC3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 05:02:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58701 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751090AbdJBJCY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 05:02:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1B3EA6505;
        Mon,  2 Oct 2017 05:02:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X224gj2BZUga4JyJLQOeGbf1ykw=; b=M0IGiF
        U1XBEbYBE8+36hCR2SrVs7HbnWqG8LtXJfbbwFp9F3OFqqAPrhQcq8x16HGP/hpP
        lWxNGY1GLwVV33uWSD019eh9GU9vFrCDE6mbDdAJR4WD7KGD5IPLCHjp0N1BKGW1
        o2cF8KG9G25MKSv2ZWDzYdSUQGug+fgDymjH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DO8ru/KvD1DIylTRoXoqx4hc97vNZaMi
        Nxjxgq7NvloCeCK+2Jio2Ek9wt83d08GLUZMgZdwL6gL3bljWq04EKZDU4nHZjlx
        emwGDIriNe36oxkiT7P5H9hKrzGnThnuulCOiwz4nILxQSO5Uom7iYe3bqippnde
        bYOtsIN4Tpc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C788EA6504;
        Mon,  2 Oct 2017 05:02:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 33ACEA6503;
        Mon,  2 Oct 2017 05:02:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Shawn Pearce <spearce@spearce.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Masaya Suzuki <masayasuzuki@google.com>, demerphq@gmail.com,
        The Keccak Team <keccak@noekeon.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] technical doc: add a design doc for hash function transition
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
        <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
        <20170307001709.GC26789@aiede.mtv.corp.google.com>
        <CAJo=hJtoX9=AyLHHpUJS7fueV9ciZ_MNpnEPHUz8Whui6g9F0A@mail.gmail.com>
        <20170928044320.GA84719@aiede.mtv.corp.google.com>
Date:   Mon, 02 Oct 2017 18:02:21 +0900
In-Reply-To: <20170928044320.GA84719@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 27 Sep 2017 21:43:21 -0700")
Message-ID: <xmqqefqlorc2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66DA4994-A750-11E7-A057-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> +Reading an object's sha1-content
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +The sha1-content of an object can be read by converting all newhash-names
> +its newhash-content references to sha1-names using the translation table.

Sure.

> +Fetch
> +~~~~~
> +Fetching from a SHA-1 based server requires translating between SHA-1
> +and NewHash based representations on the fly.
> +
> +SHA-1s named in the ref advertisement that are present on the client
> +can be translated to NewHash and looked up as local objects using the
> +translation table.
> +
> +Negotiation proceeds as today. Any "have"s generated locally are
> +converted to SHA-1 before being sent to the server, and SHA-1s
> +mentioned by the server are converted to NewHash when looking them up
> +locally.

Any of our alternate object store by definition is a NewHash
repository--otherwise we'd violate "no mixing" rule.  It may or may
note have the translation table for its objects.  If it no longer
has the translation table (because it migrated to NewHash only world
before we did), then we can still use it as our alternate but we
cannot use it for the purpose of common ancestore discovery.

> +After negotiation, the server sends a packfile containing the
> +requested objects.

s/objects.$/& These are all SHA-1 contents./

> +We convert the packfile to NewHash format using
> +the following steps:
> +
> +1. index-pack: inflate each object in the packfile and compute its
> +   SHA-1. Objects can contain deltas in OBJ_REF_DELTA format against
> +   objects the client has locally. These objects can be looked up
> +   using the translation table and their sha1-content read as
> +   described above to resolve the deltas.

That procedure would give us the object's SHA-1 contents for
ref-delta objects.  For an ofs-delta object, by definition, its base
object should appear in the same packstream, so we should eventually
be able to get to the SHA-1 contents of the delta base, and from
there we can apply the delta to obtain the SHA-1 contents.  For a
non-delta object, we already have its SHA-1 contents in the
packstream.

So we can get SHA-1 names and SHA-1 contents of each and every
object in the packstream in this step.

Are we actually writing out a .pack/.idx pair that is usable in the
SHA-1 world at this stage?  Or are we going to read from something
we keep in-core in the step #3 below?

> +2. topological sort: starting at the "want"s from the negotiation
> +   phase, walk through objects in the pack and emit a list of them,
> +   excluding blobs, in reverse topologically sorted order, with each
> +   object coming later in the list than all objects it references.
> +   (This list only contains objects reachable from the "wants". If the
> +   pack from the server contained additional extraneous objects, then
> +   they will be discarded.)

Presumably this is a list of SHA-1 names, as we do not yet have
enough information to compute NewHash names yet at this point.  May
want to spell it out here.

Would it discard the auto-followed tags if we do the "traverse from
wants only"?  Traversing the objects in the packfile to find the
"tips" that are not referenced from any other object in the pack
might be necessary, and it shouldn't be too costly, I'd guess.

> +3. convert to newhash: open a new (newhash) packfile. Read the topologically
> +   sorted list just generated. For each object, inflate its
> +   sha1-content, convert to newhash-content, and write it to the newhash
> +   pack. Record the new sha1<->newhash mapping entry for use in the idx.

Are we doing any deltification here?  If we are computing .pack/.idx
pair that can be usable in the SHA-1 world in step #1, then reusing
blob deltas should be trivial (a good delta-base in the SHA-1 world
is a good delta-base in the NewHash world, too).  Things that have
outgoing references like trees, it might be possible that such a
heuristic may not give us the absolute best delta-base, but I guess
it would still be a good approximation to reuse the delta/base
object relationship in SHA-1 world to NewHash world, assuming that
the server did a good job choosing the bases.

> +4. sort: reorder entries in the new pack to match the order of objects
> +   in the pack the server generated and include blobs. Write a newhash idx
> +   file

OK.

> +5. clean up: remove the SHA-1 based pack file, index, and
> +   topologically sorted list obtained from the server in steps 1
> +   and 2.

Ah, OK, so we do write the SHA_1 pack/idx in the first step.  OK.

> +Push
> +~~~~
> +Push is simpler than fetch because the objects referenced by the
> +pushed objects are already in the translation table. The sha1-content
> +of each object being pushed can be read as described in the "Reading
> +an object's sha1-content" section to generate the pack written by git
> +send-pack.

OK.

> +Signed Commits
> +~~~~~~~~~~~~~~
> +We add a new field "gpgsig-newhash" to the commit object format to allow
> +signing commits without relying on SHA-1. It is similar to the
> +existing "gpgsig" field. Its signed payload is the newhash-content of the
> +commit object with any "gpgsig" and "gpgsig-newhash" fields removed.

Do we prepare for newerhash, too?  IOW, should the signed payload be
the newhash-contents with any field whose name is "gpgsig" or begins
with "gpgsig-" followed by anything?

> +This means commits can be signed
> +1. using SHA-1 only, as in existing signed commit objects
> +2. using both SHA-1 and NewHash, by using both gpgsig-newhash and gpgsig
> +   fields.
> +3. using only NewHash, by only using the gpgsig-newhash field.
> +
> +Old versions of "git verify-commit" can verify the gpgsig signature in
> +cases (1) and (2) without modifications and view case (3) as an
> +ordinary unsigned commit.

For old clients to be able to verify (2), signed payload for SHA-1
is everything in SHA-1 contents minus "gpgsig"; "gpgsig-newhash"
should not get excluded from the computation.  Am I correct?

I am primarily finding it a bit disturbing that there is a bit of
asymmetry here.

> +Signed Tags
> +~~~~~~~~~~~

This message stops here for now.
