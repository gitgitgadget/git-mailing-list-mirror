Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B459A20281
	for <e@80x24.org>; Tue,  3 Oct 2017 05:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750830AbdJCFka (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 01:40:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52269 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750787AbdJCFk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 01:40:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E693B609F;
        Tue,  3 Oct 2017 01:40:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6f9tqAXvn/QPc803UlC3oapelFk=; b=qT/VLP
        tiiQo8o+QZgvqIGBiq9wZX+ceMYpWyOSxNMP/sxtv6lXdBg9z4bQTg5RLMb/F7m0
        13wRLHxCi0DvBQw8136O2R3mGLRDS1t3pQYit4RvgbWAMJ2hXIIgSKduHU+48M5G
        D5MAur5vsbMxkYX3yK8eV5BX4XbXLknNCgKcM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nluXszouga+3jSbwo6hKIa4LC2CAIgMt
        e6w+jUGvhATXnuOgGqsfpT1p0M9LsbLdSSANbI3MlyKFzsaaDJN7T9D0C+s6+qfV
        hxdMje33c/xxHQGCYHTPxsDUL1vzUqDR8Y6OG//28ChK0lGpnX8TTnOooDFVDq5s
        QFVn5GP6KzE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 23CC2B609E;
        Tue,  3 Oct 2017 01:40:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4BD24B609B;
        Tue,  3 Oct 2017 01:40:27 -0400 (EDT)
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
Date:   Tue, 03 Oct 2017 14:40:26 +0900
In-Reply-To: <20170928044320.GA84719@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 27 Sep 2017 21:43:21 -0700")
Message-ID: <xmqqbmlokcvp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C38FAF0-A7FD-11E7-A60B-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> +Signed Tags
> +~~~~~~~~~~~
> +We add a new field "gpgsig-newhash" to the tag object format to allow
> +signing tags without relying on SHA-1. Its signed payload is the
> +newhash-content of the tag with its gpgsig-newhash field and "-----BEGIN PGP
> +SIGNATURE-----" delimited in-body signature removed.
> +
> +This means tags can be signed
> +1. using SHA-1 only, as in existing signed tag objects
> +2. using both SHA-1 and NewHash, by using gpgsig-newhash and an in-body
> +   signature.
> +3. using only NewHash, by only using the gpgsig-newhash field.

I have the same issue with signed commit.

The signed parts for SHA-1 contents exclude the in-body signature
(obviously) and all the headers including gpgsig-newhash that is not
known to our old clients are included.  The signed parts for NewHash
contents exclude the in-body signature and gpgsig-newhash header,
but all other headers.  I somehow feel that we should just reserve
gpgsig-* to prepare for the day when we introduce newhash2 and later
and exclude all of them from the computation.  Treat the difference
between how SHA-1 contents excludes _only_ it knows about and how
NewHash contents excludes _all_ possible signatures, just like the
differece between where SHA-1 and NewHash contents has the
signature.  That is, yes, we didn't know better when we designed
SHA-1 contents, but now we know better and are correcting the
mistakes by moving the signature from in-body tail to a header, and
by excluding anything gpgsig-*, not just the known ones.

> +Mergetag embedding
> +~~~~~~~~~~~~~~~~~~
> +The mergetag field in the sha1-content of a commit contains the
> +sha1-content of a tag that was merged by that commit.
> +
> +The mergetag field in the newhash-content of the same commit contains the
> +newhash-content of the same tag.

OK.  

We do not have a tool that extracts them and creates a tag object,
but if such a tool is invented in the future, it would only have to
worry about newhash content, as it would be a local operation.
Makes sense.

> +Submodules
> +~~~~~~~~~~
> +To convert recorded submodule pointers, you need to have the converted
> +submodule repository in place. The translation table of the submodule
> +can be used to look up the new hash.

OK, I earlier commented on a paragraph that I couldn't tell what it
was talking about, but this is a lot more understandable.  Perhaps
the earlier one can be removed?

We saw earlier what happens during "fetch".  This seems to hint that
we would need to do a "recursive" fetch in the bottom-up direction,
but without fetching the superproject, you wouldn't know what submodules
are needed and from where, so there is a bit of chicken-and-egg problem
we need to address, as we further make the design more detailed.

> +Loose objects and unreachable objects
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ...
> +"git gc --auto" currently waits for there to be 50 packs present
> +before combining packfiles. Packing loose objects more aggressively
> +may cause the number of pack files to grow too quickly. This can be
> +mitigated by using a strategy similar to Martin Fick's exponential
> +rolling garbage collection script:
> +https://gerrit-review.googlesource.com/c/gerrit/+/35215

Yes, concatenating into the latest pack that still is small may be a
reasonable way, as there won't be many good chances to create good
deltas anyway until you have blobs and trees at sufficiently numbers
of different versions, to do a "quick GC whose only purpose is to
keep the number of loose object down".

> +To avoid a proliferation of UNREACHABLE_GARBAGE packs, they can be
> +combined under certain circumstances. If "gc.garbageTtl" is set to
> +greater than one day, then packs created within a single calendar day,
> +UTC, can be coalesced together. The resulting packfile would have an
> +mtime before midnight on that day, so this makes the effective maximum
> +ttl the garbageTtl + 1 day. If "gc.garbageTtl" is less than one day,
> +then we divide the calendar day into intervals one-third of that ttl
> +in duration. Packs created within the same interval can be coalesced
> +together. The resulting packfile would have an mtime before the end of
> +the interval, so this makes the effective maximum ttl equal to the
> +garbageTtl * 4/3.

OK.  

Is the use of mtime essential, or because packs are "write once and
from there access read-only", would a timestamp written somewhere in
the header or the trailer of the file, if existed, work equally
well?  Not a strong objection, but a mild suggestion that not
relying on mtime may be a good idea (it will keep an accidental /
unintended "touch" from keeping garbage alive longer than you want).

> +The UNREACHABLE_GARBAGE setting goes in the PSRC field of the pack
> +index. More generally, that field indicates where a pack came from:
> +
> + - 1 (PACK_SOURCE_RECEIVE) for a pack received over the network
> + - 2 (PACK_SOURCE_AUTO) for a pack created by a lightweight
> +   "gc --auto" operation
> + - 3 (PACK_SOURCE_GC) for a pack created by a full gc
> + - 4 (PACK_SOURCE_UNREACHABLE_GARBAGE) for potential garbage
> +   discovered by gc
> + - 5 (PACK_SOURCE_INSERT) for locally created objects that were
> +   written directly to a pack file, e.g. from "git add ."
> +
> +This information can be useful for debugging and for "gc --auto" to
> +make appropriate choices about which packs to coalesce.

Would this be the direction we want to take to reduce the number of
auxiliary files like *.keep, *.promised, etc., or we do not envision
these to be useful for anything other than "gc"?

> +Caveats
> +-------
> +Invalid objects
> +...
> +More profoundly broken objects (e.g., a commit with a truncated "tree"
> +header line) cannot be converted but were not usable by current Git
> +anyway.

Fair enough.

> +Shallow clone and submodules
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Because it requires all referenced objects to be available in the
> +locally generated translation table, this design does not support
> +shallow clone or unfetched submodules. Protocol improvements might
> +allow lifting this restriction.

OK, I think it is sensible to leave them outside the scope at the
moment.  All we need is a reliable way to learn the NewHash name of
the objects immediately beyond the cut-off points, but it will have
to become a huge discussion how to ensure that reliability, without
trusting the remote too much.

> +Alternates
> +~~~~~~~~~~
> +For the same reason, a newhash repository cannot borrow objects from a
> +sha1 repository using objects/info/alternates or
> +$GIT_ALTERNATE_OBJECT_REPOSITORIES.

Correct.  In addition, if the alternate has already fully migrated
away from SHA-1 compatiblity, we can only use it for local operation.

    ... goes back and thinks

No, we cannot use such an alternate even for local operation.  So a
newhash repository cannot borrow objects from a SHA-1 repository,
and from a newhash repository that lost SHA-1 compatiblity if it
itself wants to retain SHA-1 compatiblity.

Which again is "fair enough", I'd say.

> +git notes
> +~~~~~~~~~
> +The "git notes" tool annotates objects using their sha1-name as key.
> +This design does not describe a way to migrate notes trees to use
> +newhash-names. That migration is expected to happen separately (for
> +example using a file at the root of the notes tree to describe which
> +hash it uses).

To be consistent with the remainder of the design, I think they
should also be translated to NewHash, but punting it is OK to limit
the scope of the initial migration.

> +Server-side cost
> +~~~~~~~~~~~~~~~~
> +Until Git protocol gains NewHash support, using NewHash based storage
> +on public-facing Git servers is strongly discouraged. Once Git
> +protocol gains NewHash support, NewHash based servers are likely not
> +to support SHA-1 compatibility, to avoid what may be a very expensive
> +hash reencode during clone and to encourage peers to modernize.

I doubt that the first sentence is needed.  We as git-core community
will not help people to run Git service backed by NewHash storage
that talks SHA-1 over the wire, by limiting the scope to "NewHash
Git fetching from SHA-1 Git" and "NewHash Git pushing to SHA-1 Git"
and not including the other two combinations.  That may be worth
saying here.  Masochist server operators are still welcome to build
and operate such a service and we don't really care.  It's not our
business.

> +The design described here allows fetches by SHA-1 clients of a
> +personal NewHash repository because it's not much more difficult than
> +allowing pushes from that repository.

Does the design described here really allow that?

I thought what I read was "everybody talks SHA-1 over the wire, and
those who want to use NewHash converts".  So a user may be able to
push from a personal NewHash repository to a personal SHA-1
repository (to simulate a fetch going in the reverse direction).

In any case, I do not think I saw conversion issues discussed for a
fetch from NewHash repository earlier in the document, where
conversion considerations for other two modes (fetch to NewHash, and
push from NewHash) were reasonably well described.  If we are to
allow this third mode, we'd need to make sure "because it's not much
more difficult" is true.

> This support needs to be guarded
> +by a configuration option --- servers like git.kernel.org that serve a
> +large number of clients would not be expected to bear that cost.

Yes, of course.  And if these 6 lines are not unintended leftover
from earlier round of the design that we wanted to remove but forget
to do so, then the first paragraph I doubted its validity of starts
to make sense.

> +Meaning of signatures
> +~~~~~~~~~~~~~~~~~~~~~
> +The signed payload for signed commits and tags does not explicitly
> +name the hash used to identify objects. If some day Git adopts a new
> +hash function with the same length as the current SHA-1 (40
> +hexadecimal digit) or NewHash (64 hexadecimal digit) objects then the
> +intent behind the PGP signed payload in an object signature is
> +unclear:
> +
> +	object e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7
> +	type commit
> +	tag v2.12.0
> +	tagger Junio C Hamano <gitster@pobox.com> 1487962205 -0800
> +
> +	Git 2.12
> +
> +Does this mean Git v2.12.0 is the commit with sha1-name
> +e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7 or the commit with
> +new-40-digit-hash-name e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7?
> +
> +Fortunately NewHash and SHA-1 have different lengths. If Git starts
> +using another hash with the same length to name objects, then it will
> +need to change the format of signed payloads using that hash to
> +address this issue.

This is not just signatures, is it?  The reference to parent commits
and its tree in a commit object would also have ambiguity between
SHA-1 and new-40-digit-hash.  And the "no mixed repository" rule
resolved that for us---isn't that sufficient for the signed tag (or
commit), too?  If such a signed-tag appears in a SHA-1 content of a
tag, then the "object" reference is made with SHA-1.  If the tag is
in NewHash40 content, "object" reference is made with NewHash40, no?

> +Object names on the command line
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +To support the transition (see Transition plan below), this design
> +supports four different modes of operation:
> +
> + 1. ("dark launch") Treat object names input by the user as SHA-1 and
> +    convert any object names written to output to SHA-1, but store
> +    objects using NewHash.  This allows users to test the code with no
> +    visible behavior change except for performance.  This allows
> +    allows running even tests that assume the SHA-1 hash function, to
> +    sanity-check the behavior of the new mode.

Oooooh.  That's ambitious.

> + 2. ("early transition") Allow both SHA-1 and NewHash object names in
> +    input. Any object names written to output use SHA-1. This allows
> +    users to continue to make use of SHA-1 to communicate with peers
> +    (e.g. by email) that have not migrated yet and prepares for mode 3.

This and others also make sense.

> +Transition plan
> +---------------
> +Some initial steps can be implemented independently of one another:
> +...
> +- introducing index v3

Just making sure; this is pack .idx v3?

> +The infrastructure supporting fetch also allows converting an existing
> +repository. In converted repositories and new clones, end users can
> +gain support for the new hash function without any visible change in
> +behavior (see "dark launch" in the "Object names on the command line"
> +section). In particular this allows users to verify NewHash signatures
> +on objects in the repository, and it should ensure the transition code
> +is stable in production in preparation for using it more widely.
> +
> +Over time projects would encourage their users to adopt the "early
> +transition" and then "late transition" modes to take advantage of the
> +new, more futureproof NewHash object names.
> +
> +When objectFormat and compatObjectFormat are both set, commands
> +generating signatures would generate both SHA-1 and NewHash signatures
> +by default to support both new and old users.
> +
> +In projects using NewHash heavily, users could be encouraged to adopt
> +the "post-transition" mode to avoid accidentally making implicit use
> +of SHA-1 object names.
> +
> +Once a critical mass of users have upgraded to a version of Git that
> +can verify NewHash signatures and have converted their existing
> +repositories to support verifying them, we can add support for a
> +setting to generate only NewHash signatures. This is expected to be at
> +least a year later.
> +
> +That is also a good moment to advertise the ability to convert
> +repositories to use NewHash only, stripping out all SHA-1 related
> +metadata. This improves performance by eliminating translation
> +overhead and security by avoiding the possibility of accidentally
> +relying on the safety of SHA-1.
> +
> +Updating Git's protocols to allow a server to specify which hash
> +functions it supports is also an important part of this transition. It
> +is not discussed in detail in this document but this transition plan
> +assumes it happens. :)

All of the above sounds sensible to me.

> +Alternatives considered
> +-----------------------

This message stops here...
