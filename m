Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EA5620C39
	for <e@80x24.org>; Fri,  8 Dec 2017 18:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751633AbdLHShL (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 13:37:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58922 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752263AbdLHShK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 13:37:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58F9FAE029;
        Fri,  8 Dec 2017 13:37:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IZPfs/AXqNvr
        zYbSPkjCoyLAecQ=; b=UGCJt8QSwmmRM7FaJBsZWmOapYxbScNhKeGxWAiE4z3u
        u6CjMnjFAXfcTSM3MP84kux+SR1mwqCNXvkCNhjCIXfLc6w0I2kuKSdVHUaT6Exc
        P+WK6+czgay3rSiMuV2+c8L4cJm85beKDK70b3kyF8Nx+3Cnu7JUHxU3plGisYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=P1GSg0
        SU3QFqcRNaD6xwPUGrcU1GmqURtdJRsQ8h8vXhK/5VSaWPMtk4VzG/jKL8CdeEr+
        hP6krtCTcfnIz4h6bjS9S9PXsSpjVze/2rUWwZ8wDfrWrqN1zzSMaHXgYtzq8d4K
        jpipCv6mTSkeJB7UeRarHa6Y1gt0j6MY0s0xc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FBA9AE028;
        Fri,  8 Dec 2017 13:37:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B87A0AE023;
        Fri,  8 Dec 2017 13:37:09 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] fmt-merge-msg: avoid leaking strbuf in shortlog()
References: <b2238da3-9eba-1521-f4ca-3b805f103555@web.de>
        <xmqq4lp2cisd.fsf@gitster.mtv.corp.google.com>
        <20171208101455.GC1899@sigill.intra.peff.net>
        <1654a696-73d5-c9ef-0fc2-bd82aaf2cabb@web.de>
Date:   Fri, 08 Dec 2017 10:37:08 -0800
In-Reply-To: <1654a696-73d5-c9ef-0fc2-bd82aaf2cabb@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 8 Dec 2017 18:29:34 +0100")
Message-ID: <xmqqd13p83sb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CCABC8F8-DC46-11E7-A784-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> I'm not sure it's string-list's fault. Many callers (including this on=
e)
>> ...
> The two modes (dup/nodup) make string_list code tricky.  Not sure
> how far we'd get with something simpler (e.g. an array of char pointers=
),
> but having the caller do all string allocations would make the code
> easier to analyze.

Yes.

It probably would have been more sensible if the API did not have
two modes (instead, have the caller pass whatever string to be
stored, *and* make the caller responsible for freeing them *if* it
passed an allocated string).

For the push_refs_with_push() patch you sent, another possible fix
would be to make cas_options a nodup kind so that the result of
strbuf_detach() does not get an extra strdup to be lost when placed
in cas_options.  With the current string-list API that would not
quite work, because freeing done in _release() is tied to the
"dup/nodup" ness of the string list.  I think there even is a
codepath that initializes a string_list as nodup kind, stuffs string
in it giving the ownership, and then flips it into dup kind just
before calling _release() only to have it free the strings, or
something silly/ugly like that.

In any case, the patch looks sensible.  Thanks for plugging the
leaks.
