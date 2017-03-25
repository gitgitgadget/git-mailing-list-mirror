Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9F9A20958
	for <e@80x24.org>; Sat, 25 Mar 2017 06:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933152AbdCYGiB (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 02:38:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65407 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751754AbdCYGh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 02:37:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D70D7CD1E;
        Sat, 25 Mar 2017 02:37:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0ifK+u475Fp0+KN1LAZzn6v6Dbw=; b=pYU2A+
        aD0FZyK0yZCsg4TrD1GGyygFOIsz5CIEsAcCFWel3wsKd5ZXohf4ik7UIfKCJgaq
        KpEQatSr9C/HLyO3ySdPQSvjLpboVb2gCioVC2UnW2N0Ob6yQp5R40gMLZMcwhUk
        VDI5dN850JHbrIL/5LAQ4mcjrrzh/iBpql4N8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y04Uy8oTfQKmUQyeGjbo0LZ2MbaGhsUm
        SshsRFY8tkuEgoln+/IC+hT00XCRTWaf3I55DsbOCR53l5R+fYVzZmWZQ7RrQ2eG
        AekW9+1sZvzpZIridbu4MpPGgH4DuQhUSJ+Eb3nVGukR5SlgeIVp7EU9/G1Mry1h
        WJ9HSS/s/A4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5445B7CD1D;
        Sat, 25 Mar 2017 02:37:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B1BC57CD1C;
        Sat, 25 Mar 2017 02:37:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/7] PREVIEW: Introduce DC_AND_OPENSSL_SHA1 make flag
References: <cover.1490397869.git.johannes.schindelin@gmx.de>
Date:   Fri, 24 Mar 2017 23:37:54 -0700
In-Reply-To: <cover.1490397869.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Sat, 25 Mar 2017 00:24:42 +0100 (CET)")
Message-ID: <xmqq7f3d6ev1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9449655C-1125-11E7-BF66-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> - the most important part will be the patch turning core.enableSHA1DC
>   into a tristate: "externalOnly" or "smart" or "auto" or something
>   indicating that it switches on collision detection only for commands
>   that accept objects from an outside source into the local repository,
>   such as fetch, fast-import, etc

There are different uses of SHA-1 hashing in Git, and I do agree
that depending on the use, some of them do not need the overhead for
the collision-attack detection.  As DC_SHA1 with attack detection
disabled may still be slower than other implementations, it may make
sense to have a compile-time option to use DC_SHA1 for places that
needs protection, and another implementation [*1*] for places that
don't.

I think the places that MUST use DC variant is anything that hashes
content for a single object to compute its object name.  "git add"
[*2*] that creates a new loose object, "git index-pack" that reads
incoming pack stream over the wire, reconstitutes each object data
while resolving delta and hash them to get their names to construct
the .idx file and "git unpack-objects" that does the same but
explodes the pack contents into loose objects, "git write-tree" that
creates a new tree object given the contents of the index, etc.

One notable exception of the above is "update-index --refresh".  We
already have contents in the index and in the object store, and we
are hashing the contents in the working tree to see if it hashes to
the same value.  When the hash does not match, it won't go in to the
object store.  When the hash does match, it either is indeed the
same content (i.e. no collision), in which case we earlier must have
done the collision-attack detecting hash when we added the object to
the object store.  Or the object we have in the object store and
what is in the working tree are different contents that hash to the
same name, in which case the user already has colliding pair and it
is too late to invoke collision-attack detecting variant ;-)

The running checksum over the whole file csum-file.c computes does
not have to be the collision-attack detecting kind.  This is the
hash at the end of various files like the index, .pack .idx, etc.
These are used to protect us against bit-flipping disks and we are
not fighting with a clever disk that can do collision attack.  For
that matter, some of these checksums do not even have to be SHA-1.
If one hacks his own Git to replace SHA-1 checksum at the end of the
index file with something faster and weaker and use it in one's
repository, nobody else would notice nor care.  The same thing can
be said for the .idx file.  The one at the end of .pack does get
checked at the receiving end when it comes over the wire, so it MUST
be SHA-1, but it does not have to be hashed with collision-attack
detection.

The rerere database is indexed with SHA-1 of (normalized) conflict
text.  This does not have to be hashed with the collision-attack
detection logic.  Thanks to recent update that allows multiple pairs
of conflict and its resolution, the subsystem is prepared to see two
conflicts that share the same hash already (for completely different
reasons).

The hash that names a packfile is constructed by sorting all the
names of the objects contained in the packfile and running SHA-1
hash over it.  I think this MUST be hashed with collision-attack
detection.  A malicious site can feed you a packfile that contains
objects the site crafts so that the sorted object names would result
in a collision-attack, ending up with one pack that contains a sets
of objects different from another pack that happens to have the same
packname, causing Git to say "Ah, this new pack must have the same
set of objects as the pack we already have" and discard it,
resulting in lost objects and a corrupt repository with missing
objects.


[Footnote]

*1* I think this PREVIEW hardcodes OpenSSL only for illustration and
    that is OK for a preview.  Given the recent news on licensing,
    however, if we want to pursue this dual hashing scheme, we must
    consider allowing other implementations as well in the final
    form.

*2* In this paragraph, whenever "git" command is named, I mean both
    the command and its underlying machinery.  When I say "git
    write-tree", for example, write_index_as_tree() obviously is
    included.
