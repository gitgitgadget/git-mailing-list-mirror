Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAB4E7F145
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 22:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjIZWwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 18:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjIZWuA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 18:50:00 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF33723113
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 15:05:26 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E5E22C68D;
        Tue, 26 Sep 2023 17:48:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=BnL58fLp60k4zXUFkqOMZ2OpbGcARPU3eowwRJ
        qe9nI=; b=DW+WjdtAINFThrB8d9eJggMccm6b0vhAw8oUEy+fauX3UcltkhVBvH
        HrLO3gaXcSWoFKffXq0M9FQmA8hLaih5+EQsJFKbEdQKQLq0jrrGcl/gIf0ghS4w
        sY2jprp+gHGQTqqk61pgBUabOuczOnU15qrSoHDGkZB4AiJbLyA9s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 86C0D2C68C;
        Tue, 26 Sep 2023 17:48:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 262CE2C68B;
        Tue, 26 Sep 2023 17:48:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric W. Biederman" <ebiederm@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>
Subject: Re: [PATCH v3] bulk-checkin: only support blobs in index_bulk_checkin
In-Reply-To: <87msx99b9o.fsf_-_@gmail.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Tue, 26 Sep 2023 10:58:43 -0500")
References: <878r918ps3.fsf@gmail.froward.int.ebiederm.org>
        <xmqqr0mtcosy.fsf@gitster.g>
        <87zg1h58xa.fsf@gmail.froward.int.ebiederm.org>
        <87msx99b9o.fsf_-_@gmail.froward.int.ebiederm.org>
Date:   Tue, 26 Sep 2023 14:48:31 -0700
Message-ID: <xmqqmsx8mwr4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 703A9256-5CB6-11EE-AFC5-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric W. Biederman" <ebiederm@gmail.com> writes:

> As the code is written today index_bulk_checkin only accepts blobs.
> Remove the enum object_type parameter and rename index_bulk_checkin to
> index_blob_bulk_checkin, index_stream to index_blob_stream,
> deflate_to_pack to deflate_blob_to_pack, stream_to_pack to
> stream_blob_to_pack, to make this explicit.
>
> Not supporting commits, tags, or trees has no downside as it is not
> currently supported now, and commits, tags, and trees being smaller by
> design do not have the problem that the problem that index_bulk_checkin
> was built to solve.
>
> Before we start adding code to support the hash function transition
> supporting additional objects types in index_bulk_checkin has no real
> additional cost, just an extra function parameter to know what the
> object type is.  Once we begin the hash function transition this is not
> the case.
>
> The hash function transition document specifies that a repository with
> compatObjectFormat enabled will compute and store both the SHA-1 and
> SHA-256 hash of every object in the repository.
>
> What makes this a challenge is that it is not just an additional hash
> over the same object.  Instead the hash function transition document
> specifies that the compatibility hash (specified with
> compatObjectFormat) be computed over the equivalent object that another
> git repository whose storage hash (specified with objectFormat) would
> store.  When comparing equivalent repositories built with different
> storage hash functions, the oids embedded in objects used to refer to
> other objects differ and the location of signatures within objects
> differ.
>
> As blob objects have neither oids referring to other objects nor stored
> signatures their storage hash and their compatibility hash are computed
> over the same object.
>
> The other kinds of objects: trees, commits, and tags, all store oids
> referring to other objects.  Signatures are stored in commit and tag
> objects.  As oids and the tags to store signatures are not the same size
> in repositories built with different storage hashes the size of the
> equivalent objects are also different.
>
> A version of index_bulk_checkin that supports more than just blobs when
> computing both the SHA-1 and the SHA-256 of every object added would
> need a different, and more expensive structure.  The structure is more
> expensive because it would be required to temporarily buffering the
> equivalent object the compatibility hash needs to be computed over.
>
> A temporary object is needed, because before a hash over an object can
> computed it's object header needs to be computed.  One of the members of
> the object header is the entire size of the object.  To know the size of
> an equivalent object an entire pass over the original object needs to be
> made, as trees, commits, and tags are composed of a variable number of
> variable sized pieces.  Unfortunately there is no formula to compute the
> size of an equivalent object from just the size of the original object.
>
> Avoid all of those future complications by limiting index_bulk_checkin
> to only work on blobs.

Thanks.  Will queue.
