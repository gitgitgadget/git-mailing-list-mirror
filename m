Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D24142047F
	for <e@80x24.org>; Fri,  4 Aug 2017 22:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752001AbdHDWvS (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 18:51:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53601 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751930AbdHDWvR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 18:51:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 145FCA1669;
        Fri,  4 Aug 2017 18:51:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o1Gz9oXUcVopepThkOHEJm0Dg30=; b=h5qKFX
        0viypGAr85cLWbcUpYDY4UVYdPIpJ56Pg4Umlmd2+NfBPim/xN52zl29yPcQYg9V
        S3BgyUblJ70jK369ZhR2VI9m6aY9PbayK9VZBFwKymiH1FXkH9rzgljLGb0kxpFu
        o35/lYOfLg38LED683Uh1EBgF0TaXERM031Ao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F6wUQV0qM9DSFZzfZ2tewmdS6/mPdYv7
        LMxKosJsdaQkSTVcU0tro397U2oZirgHGFZOmqjwTMIymmUzhf06dnKcl4fPMupD
        L7pLNp72Wv6mv3eZkkZTX3heBMqc3WZaCq6eeeFeTWrsIbIg7uCuG1dgCXjPyWJF
        zFhxLVqVkbw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C0E2A1668;
        Fri,  4 Aug 2017 18:51:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5DDABA1667;
        Fri,  4 Aug 2017 18:51:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        peartben@gmail.com, christian.couder@gmail.com
Subject: Re: Partial clone design (with connectivity check for locally-created objects)
References: <20170804145113.5ceafafa@twelve2.svl.corp.google.com>
Date:   Fri, 04 Aug 2017 15:51:08 -0700
In-Reply-To: <20170804145113.5ceafafa@twelve2.svl.corp.google.com> (Jonathan
        Tan's message of "Fri, 4 Aug 2017 14:51:13 -0700")
Message-ID: <xmqqtw1nrlpf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 682FC524-7967-11E7-9027-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> "Imported" objects must be in a packfile that has a "<pack name>.remote"
> file with arbitrary text (similar to the ".keep" file). They come from
> clones, fetches, and the object loader (see below).
> ...
> A "homegrown" object is valid if each object it references:
>  1. is a "homegrown" object,
>  2. is an "imported" object, or
>  3. is referenced by an "imported" object.

Overall it captures what was discussed, and I think it is a good
start.

I doubt you want to treat all fetches/clones the same way as the
"lazy object" loading, though.  You may be critically rely on the
corporate central server that will give the objects it "promised"
when you cloned from it lazily (i.e. it may have given you a commit,
but not its parents or objects contained in its tree--you still know
that the parents and the tree and its contents will later be
available and rely on that fact).  You trust that and build on top,
so the packfile you obtained when you cloned from such a server
should count as "imported".  But if you exchanged wip changes with
your colleages by fetching or pushing peer-to-peer, without the
corporate central server knowing, you would want to treat objects in
packs (or loose objects) you obtained that way as "not imported".

Also I think "imported" vs "homegrown" may be a bit misnomer; the
idea to split objects into two camps sounds like a good idea, and
"imported" probably is an OK name to use for the category that is a
group of objects to which you know/trust are backed by your lazy
loader.  But the other one does not have to be "home"-grown.

Well, the names are not that important, but I think the line between
the two classes should not be "everything that came from clone and
fetch is imported", which is a more important point I am trying to
make.

Thanks.
