Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFD6CE79AC
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 07:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjITHAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 03:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjITHAK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 03:00:10 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C2FAD
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 00:00:02 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B30C61A1857;
        Wed, 20 Sep 2023 02:59:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=vbm2MwyCq4Go+BkTj8zLtYv4a/VZtVA0qLZ009
        QoJ1k=; b=Ew52sstalLKrD+PLRBJSrVkkS5IN0DWJGCFkBS6q4hrYuXJ+guoILn
        8qp2RnFJn8UjIfOliP74iwOVB1GUxa0HQN+vU9ZI088aQ9HhLn9kNPcyAVc7+xZ2
        4VX68Dt3hKA7mIToqhbbMy6DFRG7yiBpW/w+LAo/5Weabiz7RNJ1U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A86361A1856;
        Wed, 20 Sep 2023 02:59:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1EDB31A1855;
        Wed, 20 Sep 2023 02:59:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric W. Biederman" <ebiederm@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>
Subject: Re: [PATCH v2] bulk-checkin: only support blobs in index_bulk_checkin
In-Reply-To: <878r918ps3.fsf@gmail.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Tue, 19 Sep 2023 22:52:28 -0500")
References: <878r918ps3.fsf@gmail.froward.int.ebiederm.org>
Date:   Tue, 19 Sep 2023 23:59:57 -0700
Message-ID: <xmqqr0mtcosy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F836F8E-5783-11EE-9FBF-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric W. Biederman" <ebiederm@gmail.com> writes:

> As the code is written today index_bulk_checkin only accepts blobs.
> Remove the enum object_type parameter and rename index_bulk_checkin to
> index_blob_bulk_checkin, index_stream to index_blob_stream,
> deflate_to_pack to deflate_blob_to_pack, stream_to_pack to
> stream_blobk_to_pack, to make this explicit.

> Not supporting commits, tags, or trees has no downside as it is not
> currently supported now, and commits, tags, and trees being smaller by
> design do not have the problem that the problem that index_bulk_checkin
> was built to solve.

Exactly.  The streaming was primarily to help dealing with huge
blobs that cannot be held in-core.  Of course other parts (like
comparing them) of the system would require to hold them in-core
so some things may not work for them, but at least it is a start
to be able to _hash_ them to store them in the object store and to
give them names.

> What is more this is very desiable from the context of the hash function
> transition.

A bit hard to parse; perhaps want a comma before "this"?

> For blob objects it is straight forward to compute multiple hash
> functions during index_bulk_checkin as the object header and content of
> a blob is the same no matter which hash function is being used to
> compute the oid of a blob.

OK.

> For commits, tress, and tags the object header and content that need to
> be hashed ard different for different hashes.  Even worse the object
> header can not be known until the size of the content that needs to be
> hashed is known.  The size of the content that needs to be hashed can
> not be known until a complete pass is made through all of the variable
> length entries of the original object.

"tress" -> "trees".  Also a comma after "worse".

> As far as I can tell this extra pass defeats most of the purpose of
> streaming, and it is much easier to implement with in memory buffers.

The purpose of streaming being the ability to hash and compute the
object name without having to hold the entirety of the object, I am
not sure the above is a good argument.  You can run multiple passes
by streaming the same data twice if you needed to, and how much
easier the implementation may become if you can assume that you can
hold everything in-core, what you cannot fit in-core would not fit
in-core, so ...

> So if it is needed to write commits, trees, and tags directly to pack
> files writing a separate function to do the would be needed.

But I am OK with this conclusion.  As the way to compute the
fallback hashes for different types of objects are very different,
compared to a single-hash world where as long as you come up with a
serialization you have only a single way to hash and name the
object.  We would end up having separate helper functions per target
type anyway, even if we kept a single entry point function like
index_stream().  The single entry point function will only be used
to just dispatch to type specific ones, so renaming what we have today
and making it clear they are for "blobs" does make sense.
