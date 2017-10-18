Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B2761FF32
	for <e@80x24.org>; Wed, 18 Oct 2017 00:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754685AbdJRADJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 20:03:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60984 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752995AbdJRADJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 20:03:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5CE03A3D89;
        Tue, 17 Oct 2017 20:03:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GxOiBlmEdehGsGuNxL+XHULI/1w=; b=ByrWVL
        4+ZYkbrZHARC8N0nA0KNgu19E79eqFZcDVpMRoUcN3lu7aIQrXInikrfotGUebhe
        zPjQ8+zJcK1m+0cjkDX23+D7ZZ5mh12pnmeggOe6GPKiucLzZRIDu5OgVrpI7n8N
        F3SWcSQpcg4ZCaxn24LIoqvcb8f1lCo6PUdu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vuBQpsJaJJ5KApe0+wQ1ZpoydSxoeJqG
        26OV0zyot30xdpD4KKDgwsudkzWuEfQnT8r2BUagRc+uKdR3DUXfI9ESwbdfZ8f1
        xiXECsxbZdsKKqxLvYB6W2Q3oapFckKVQH8USC+f31FPrHHIWjrQZ4FX2Ct4VY3N
        9uqID4SD10M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5382AA3D88;
        Tue, 17 Oct 2017 20:03:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A81F4A3D87;
        Tue, 17 Oct 2017 20:03:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] implement fetching of moved submodules
References: <20171016135623.GA12756@book.hvoigt.net>
        <20171016135827.GC12756@book.hvoigt.net>
        <CAGZ79kZsQoU8wJk+i5aJOxFtsD=EWu_ycEPLM1KhTaOCWD7Y2w@mail.gmail.com>
Date:   Wed, 18 Oct 2017 09:03:06 +0900
In-Reply-To: <CAGZ79kZsQoU8wJk+i5aJOxFtsD=EWu_ycEPLM1KhTaOCWD7Y2w@mail.gmail.com>
        (Stefan Beller's message of "Tue, 17 Oct 2017 10:47:28 -0700")
Message-ID: <xmqqfuahmif9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8A9F208-B397-11E7-B54F-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> +                       /* make sure name does not collide with existing one */
>> +                       submodule = submodule_from_name(commit_oid, name);
>> +                       if (submodule) {
>> +                               warning("Submodule in commit %s at path: "
>> +                                       "'%s' collides with a submodule named "
>> +                                       "the same. Skipping it.",
>> +                                       oid_to_hex(commit_oid), name);
>> +                               name = NULL;
>> +                       }
>
> This is the ugly part of using one string list and storing names or
> path in it. I wonder if we could omit this warning if we had 2 string lists?

We are keying off of 'name', because that is what will give a module
its identity.  If we have a gitlink whose path is not in .gitmodules
in the same tree, then we are seeing an unregistered submodule.  If
we were to "git add" it, then we'd use its path as the default name,
but if we already have a submodule with that name (the most likely
explanation for its existence is because it started its life there
and then later moved), and the submodule is bound to a different
path, then that is a different submodule.  Skipping and warning both
are sensible thing to do.

I do not know what you see as ugly here, and more importantly, I am
not sure how having two lists would help.
