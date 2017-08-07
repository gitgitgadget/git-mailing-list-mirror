Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DB0A208B4
	for <e@80x24.org>; Mon,  7 Aug 2017 19:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbdHGTle (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 15:41:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55220 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751589AbdHGTld (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 15:41:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E3DF9E6B5;
        Mon,  7 Aug 2017 15:41:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uhOHuJNouGrk6bXT0BjVrXeOuzE=; b=W1OqCL
        DbxY/TAkU/M+eNtbPHd2KP0IyyX4XfMZGST9vdN9nJWSdqoINK98t4A6i4TOsTre
        H0S+kdaX4ljfQKDMl8frll9DvmM7jTLMaXszpQMJjPBs5s4F5zXrQYpMa13TWs+r
        +3Vl7D5Czpy+SlFpqk3rGq46EYKVIQXVl07cs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ekgTF9hl+u9DjfmwIOadvKdFpKWo64hl
        HDBkF/rv+7qZfiAD+AUhC/y8bac4UPlkv1H64Qm7e+p08Tnmd/sw3E0+1oeS+EAW
        Nof7OEoiFMFPFJFPpA8+uOHaBZM9Q/+JdgwZV5z9AQY6Lloo0511DrJzMVkCsqkN
        eEizjZN77Cs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 555009E6B4;
        Mon,  7 Aug 2017 15:41:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B3C0D9E6B3;
        Mon,  7 Aug 2017 15:41:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        christian.couder@gmail.com
Subject: Re: Partial clone design (with connectivity check for locally-created objects)
References: <20170804145113.5ceafafa@twelve2.svl.corp.google.com>
        <xmqqtw1nrlpf.fsf@gitster.mtv.corp.google.com>
        <20170804172137.42f27653@twelve2.svl.corp.google.com>
        <0633771f-ce19-6211-fabe-3f7f676e53ab@gmail.com>
Date:   Mon, 07 Aug 2017 12:41:23 -0700
In-Reply-To: <0633771f-ce19-6211-fabe-3f7f676e53ab@gmail.com> (Ben Peart's
        message of "Mon, 7 Aug 2017 15:12:11 -0400")
Message-ID: <xmqqwp6fp3mk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 659C18A6-7BA8-11E7-8728-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> My concern with this proposal is the combination of 1) writing a new
> pack file for every git command that ends up bringing down a missing
> object and 2) gc not compressing those pack files into a single pack
> file.

Your noticing these is a sign that you read the outline of the
design correctly, I think.  

The basic idea is that the local fsck should tolerate missing
objects when they are known to be obtainable from that external
service, but should still be able to diagnose missing objects that
we do not know if the external service has, especially the ones that
have been newly created locally and not yet made available to them
by pushing them back.

So we need a way to tell if an object that we do not have (but we
know about) can later be obtained from the external service.
Maintaining an explicit list of such objects obviously is one way,
but we can get the moral equivalent by using pack files.  After
receiving a pack file that has a commit from such an external
service, if the commit refers to its parent commit that we do not
have locally, the design proposes us to consider that the parent
commit that is missing is available at the external service that
gave the pack to us.  Similarly for missing trees, blobs, and any
objects that are supposed to be "reachable" from objects in such a
packfile.  

We can extend the approach to cover loose objects if we wanted to;
just define an alternate object store used internally for this
purpose and drop loose objects obtained from such an external
service in that object store.

Because we do not want to leave too many loose objects and small
packfiles lying around, we will need a new way of packing these.
Just enumerate these objects known to have come from the external
service (by being in packfiles marked as such or being loose objects
in the dedicated alternate object store), and create a single larger
packfile, which is marked as "holding the objects that are known to
be in the external service".  We do not have such a mode of gc, and
that is a new development that needs to happen, but we know that is
doable.

> That thinking did lead me back to wondering again if we could live
> with a repo specific flag.  If any clone/fetch was "partial" the flag
> is set and fsck ignore missing objects whether they came from a
> "partial" remote or not.

The only reason people run "git fsck" is to make sure that their
local repository is sound and they can rely on the objects you have
as the base of building new stuff on top of.  That is why we are
trying to find a way to make sure "fsck" can be used to detect
broken or missing objects that cannot be obtained from the
lazy-object store, without incurring undue overhead for normal
codepath (i.e. outside fsck).

It is OK to go back to wondering again, but I think that essentially
tosses "git fsck" out of the window and declares that it is OK to
hope that local objects will never go bad.  We can make such an
declaration anytime, but I do not want to see us doing so without
first trying to solve the issue without punting.
