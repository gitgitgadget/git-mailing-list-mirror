Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50B241F463
	for <e@80x24.org>; Mon,  9 Sep 2019 19:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405947AbfIITze (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 15:55:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58460 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730465AbfIITze (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 15:55:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EB4759387B;
        Mon,  9 Sep 2019 15:55:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ywTmuZvOn8NWXd4a1JQzmcOX23Q=; b=dJS0hq
        zgGqabMR0hGXNVVh1nRJNKB2jChXft3aXkvZVRgtOx5yyab5xBP7LpcgUjYzskBa
        qPV8pu+XRZufzXCjJQrm1nK0RywJswhzARGzE0ZxOQvYFO6YhRi/4gw7hodqKTW0
        N5MKIrC8QJScMMwgPGjGzrOOCBJVw89/6EXXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TzKujCs0Clop2VHbY2Vrw4MDuv8kfciC
        wAFzGNnTbAy6W9UndRGASm/RNSTxFFH+r3eOvijqnS39hcsnY7CPpnHZEmzCigBQ
        jkh1YJFxL02mFNnU3ZdlVJkudEc6X+4gdOCdAQVBEFYTNuJ19RPxgftE82yC4VsC
        /NPBX6IaUDk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E369A9387A;
        Mon,  9 Sep 2019 15:55:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0B23693879;
        Mon,  9 Sep 2019 15:55:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH v2] cache-tree: do not lazy-fetch merge tree
References: <20190903194247.217964-1-jonathantanmy@google.com>
        <20190909190130.146613-1-jonathantanmy@google.com>
Date:   Mon, 09 Sep 2019 12:55:26 -0700
In-Reply-To: <20190909190130.146613-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 9 Sep 2019 12:01:30 -0700")
Message-ID: <xmqqsgp5i6s1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C60A7D62-D33B-11E9-87A0-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When cherry-picking (for example), new trees may be constructed. During
> this process, Git constructs the new tree in a struct strbuf, computes
> the OID of the new tree, and checks if the new OID already exists on
> disk. However, in a partial clone, the disk check causes a lazy fetch to
> occur, which is both unnecessary (because we have the tree in the struct
> strbuf) and likely to fail (because the remote probably doesn't have
> this tree).

I somehow smell that the above misses the point of the check in the
first place, though.  The reason why we are computing the tree
object's name and seeing if we have it locally on disk is to decide
if we want to record it in the cache tree, *without* writing the
tree out to our object store, no?

It is not just unnecessary but also against the goal of the codepath
to lazily download it, even if the tree is available remotely.  And
it is irrelevant that there are cases the remote does not have
it---we have no need to mention that we must be prepared to see the
lazy fetch to fail.  Even when they do have one, we do not want to
fetch it and write to our object store.

Isn't that what is going on?  I thought I dug up the original that
introduced the has_object_file() call to this codepath to make sure
we understand why we make the check (and I expected the person who
is proposing this change to do the same and record the finding in
the proposed log message).

I am running out of time today, and will revisit later this week
(I'll be down for at least two days starting tomorrow, by the way).

Thanks.
