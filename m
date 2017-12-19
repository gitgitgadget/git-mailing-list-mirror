Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82AE51F406
	for <e@80x24.org>; Tue, 19 Dec 2017 18:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751110AbdLSSeC (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 13:34:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58138 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751098AbdLSSeA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 13:34:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E25BD5575;
        Tue, 19 Dec 2017 13:33:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lGOprcpBdJV5
        rNjQ0Ohd0Z5BerY=; b=m7Phogdq3VHcfaTXTKTCGdoslv6qqrY5Idky20Say/EK
        kdfqKnj4miMxpnEdHeU7Ezea+L5njyhoVcnVhtlKCsFZUo7HOAmg8r5a74aH79qW
        LmGY7z8R65s7pADlfp88o6MWQVXaCJNkAr5ciMBsoaz7ly+HzjXQ5rksgz3TXkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=S8IwNV
        k/el+21uloFWhdm6fGXKZQOIIMM2JNV0lGRfKnXMHga2Muqx10VaqH797TnydUmn
        hD8vc9loJrSCYzUkfy9i1vVbI2ArWmqrb4ToyZkLxKFu7SJAMmBi3D9bHPcGIB2+
        TPQQHxqRLhIeDs37cFPqN5GS6cAAEjwCF7/pE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36250D5574;
        Tue, 19 Dec 2017 13:33:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9F714D5573;
        Tue, 19 Dec 2017 13:33:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] revision: introduce prepare_revision_walk_extended()
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
        <20171218151043.GA9449@sigill.intra.peff.net>
        <39581cd0-0bfd-c8d1-642b-1245cf425ab4@web.de>
        <20171219114906.GB24558@sigill.intra.peff.net>
Date:   Tue, 19 Dec 2017 10:33:55 -0800
In-Reply-To: <20171219114906.GB24558@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 19 Dec 2017 06:49:06 -0500")
Message-ID: <xmqq7etiworw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2C1D84DC-E4EB-11E7-8AC7-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Dec 18, 2017 at 08:18:19PM +0100, Ren=C3=A9 Scharfe wrote:
>
>> > The root of the matter is that the revision-walking code doesn't cle=
an
>> > up after itself. In every case, the caller is just saving these to c=
lean
>> > up commit marks, isn't it?
>>=20
>> bundle also checks if the pending objects exists.
>
> Thanks, I missed that one. So just adding a feature to clean up commit
> marks wouldn't be sufficient to cover that case.

OK.

>> > That sidesteps all of the memory ownership issues by just creating a
>> > copy. That's less efficient, but I'd be surprised if it matters in
>> > practice (we tend to do one or two revisions per process, there don'=
t
>> > tend to be a lot of pending tips, and we're really just talking abou=
t
>> > copying some pointers here).
>> [...]
>> I don't know if there can be real-world use cases with millions of
>> entries (when it would start to hurt).
>
> I've seen repos which have tens of thousands of tags. Something like
> "rev-list --all" would have tens of thousands of pending objects.
> I think in practice it's limited to the number of objects (though in
> practice more like the number of commits).
> ...

OK again; that is an argument against "let's copy the array".

>> Why does prepare_revision_walk() clear the list of pending objects at
>> all?  Assuming the list is append-only then perhaps remembering the
>> last handled index would suffice.

For that matter, why does it copy, instead of using revs->pending
directly?  I do not think I can answer this, as I think the design
decisions led to this code predates me.

In any case, it seems that the discussion has veered into an
interesting tangent but at this point it seems to me that it is not
likely to produce an immediate improvement over the posted patch.

Should we take the patch posted as-is and move forward?
