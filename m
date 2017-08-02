Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7B6C20899
	for <e@80x24.org>; Wed,  2 Aug 2017 20:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752342AbdHBUvs (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 16:51:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57066 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752173AbdHBUvr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 16:51:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9E1393F20;
        Wed,  2 Aug 2017 16:51:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+1iAjsz9ElQ/PPTvguzQWiyIqgE=; b=kAqqqo
        N0ZKYy6C2KWf6802iBJ2UHdWfEy/M9su/13hcPuo8OEo5vbfsO5GcZjJqKtwVxa8
        j2CqYoUwtvInyMGbQPcSj19IIZ/sqF0p6TVZnY0Nme6oSR5/1+fBwStkRtIvJWqJ
        kF6AhgKbl3UDnWePpNOsagLDVqtWDNp5YVBgg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dJbSrJHUqBxlcJhgQdirQqXriC3VIgHb
        qzrtbEfjCkqdsCZe2J2t41U6G4gt5QcPfjTvjrWNkRZTsZhQaP2J1vOYCRtNkwDa
        PMn+1iKz9jWeE17Bv6uHb9gNFylnKTTr+wfpoLlD3Ra7Kp/vIG8EJcoSwy+V45Mp
        e296go0QMuk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE2B993F1E;
        Wed,  2 Aug 2017 16:51:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 045DB93F1B;
        Wed,  2 Aug 2017 16:51:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        peartben@gmail.com, christian.couder@gmail.com
Subject: Re: [PATCH v2 0/5] Fsck for lazy objects, and (now) actual invocation of loader
References: <cover.1501111615.git.jonathantanmy@google.com>
        <cover.1501532294.git.jonathantanmy@google.com>
        <xmqq4ltsi9or.fsf@gitster.mtv.corp.google.com>
        <20170731160533.0a446244@twelve2.svl.corp.google.com>
        <xmqq379bgqlx.fsf@gitster.mtv.corp.google.com>
        <20170801171944.7690a63f@twelve2.svl.corp.google.com>
        <xmqqefsudjqk.fsf@gitster.mtv.corp.google.com>
        <20170802173857.GU13924@aiede.mtv.corp.google.com>
Date:   Wed, 02 Aug 2017 13:51:37 -0700
In-Reply-To: <20170802173857.GU13924@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 2 Aug 2017 10:38:57 -0700")
Message-ID: <xmqq8tj1snfq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6173E8CC-77C4-11E7-A5C3-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Jonathan Tan <jonathantanmy@google.com> writes:
>
>>> One possibility to conceptually have the same thing without the overhead
>>> of the list is to put the obtained-from-elsewhere objects into its own
>>> alternate object store, so that we can distinguish the two.
>>
>> Now you are talking.  Either a separate object store, or a packfile
>> that is specially marked as such, would work.
>
> Jonathan's not in today, so let me say a few more words about this
> approach.
>
> This approach implies a relaxed connectivity guarantee, by creating
> two classes of objects:
>
>  1. Objects that I made should satisfy the connectivity check.  They
>     can point to other objects I made, objects I fetched, or (*) objects
>     pointed to directly by objects I fetched.  More on (*) below.

Or objects that are referred to by objects I fetched.  If you
narrowly clone while omitting a subdirectory, updated a file
that is outside the subdirectory, and created a new commit, while
recording the same tree object name for the directory you do not
know its contents (becaues you didn't fetch), then it is OK for the
top-level tree of the resulting commit you created to be pointing
at the tree that represents the subdirectory you never touched.

> The complication is in the "git gc" operation for the case (*).
> Today, "git gc" uses a reachability walk to decide which objects to
> remove --- an object referenced by no other object is fair game to
> remove.  With (*), there is another kind of object that must not be
> removed: if an object that I made, M, points to a missing/promised
> object, O, pointed to by a an object I fetched, F, then I cannot prune
> F unless there is another fetched object present to anchor O.

Absolutely.  Lazy-objects support comes with certain cost and this
is one of them.  

But I do not think it is realistic to expect that you can prune
anything you fetched from the "other place" (i.e. the source
'lazy-objects' hook reads from).  After all, once they give out
objects to their clients (like us in this case), they cannot prune
it, if we take the "implicit promise" approach to avoid the cost to
transmit and maintain a separate "object list".

> For example: suppose I have a sparse checkout and run
>
> 	git fetch origin refs/pulls/x
> 	git checkout -b topic FETCH_HEAD
> 	echo "Some great modification" >> README
> 	git add README
> 	git commit --amend
>
> When I run "git gc", there is nothing pointing to the commit that was
> pointed to by the remote ref refs/pulls/x, so it can be pruned.  I
> would naively also expect that the tree pointed to by that commit
> could be pruned.  But pruning it means pruning the promise that made
> it permissible to lack various blobs that my topic branch refers to
> that are outside the sparse checkout area.  So "git gc" must notice
> that it is not safe to prune that tree.
>
> This feels hacky.  I prefer the promised object list over this
> approach.

I think they are moral equivalents implemented differently with
different assumptions.  The example we are discussing makes an extra
assumption: In order to reduce the cost of transferring and
maintaining the list, we assume that all objects that came during
that transfer are implicitly "promised", i.e. everything behind each
of these objects will later be available on demand.  How these
objects are marked is up to the exact mechanism (my preference is to
mark the resulting packfile as special; Jon Tan's message to which
my message was a resopnse alluded to using an alternate object
store).  If you choose to maintain a separate "object list" and have
the "other side" explicitly give it, perhaps you can lift that
assumption and replace it with some other assumption that assumes
less.

> Can you spell this out more?  To be clear, are you speaking as a
> reviewer or as the project maintainer?  In other words, if other
> reviewers are able to settle on a design that involves a relaxed
> guarantee for fsck in this mode that they can agree on, does this
> represent a veto meaning the patch can still not go through?

Consider it a veto over punting without making sure that we can
later come up with a solution to give such a guarantee.  I am not
getting a feeling that "other reviewers" are even seeking a "relaxed
guarantee"---all I've seen in the thread is to give up any guarantee
and to hope for the best.

