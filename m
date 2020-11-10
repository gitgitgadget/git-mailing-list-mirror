Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B163C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 17:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC16206D8
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 17:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dl7gu1oW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgKJREH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 12:04:07 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59525 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKJREH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 12:04:07 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CD1C0105946;
        Tue, 10 Nov 2020 12:04:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J4ghtyCxvpDNTk0P3+8AKMCO+dI=; b=Dl7gu1
        oW5e6sapxjQjFgtodnrJzMXudylL7y77rwU7kVmAz+dusWKHp/Zciy767alBmZr+
        cMblQ8HqRY4Cur1zjQkORxT31+PoHkWSs352D/nOaB0/GO+fuBWAlGN8e0JT11P4
        Vxrabojv9hY4RWL+pismivQUiQOereJ4MpYtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yUfr3YnTlavKuViKIatxb4ZcLoymW+VP
        A+B/tL+ZSIG6CnszA12CMKrCvtYoF1D/c+KUQvyIoG1nC0MIg3MyKkO7fF2q5pXP
        0EPtXq3OY+3eZ9DbUESRBO8F0EfAy4ogrdcj0FyI4PRe9og8MfHRD5Ju1ngnlvsc
        DS4TI0jIIZo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C7089105945;
        Tue, 10 Nov 2020 12:04:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 15AB210592E;
        Tue, 10 Nov 2020 12:04:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 1/4] t1400: Avoid touching refs on filesystem
References: <cover.1604501265.git.ps@pks.im> <cover.1604908834.git.ps@pks.im>
        <9b49e849eaf6786c63016d767d2ad56112d08d51.1604908834.git.ps@pks.im>
        <xmqqpn4mb9bv.fsf@gitster.c.googlers.com> <X6qIidgbnhYa3S0o@ncase>
Date:   Tue, 10 Nov 2020 09:04:01 -0800
In-Reply-To: <X6qIidgbnhYa3S0o@ncase> (Patrick Steinhardt's message of "Tue,
        10 Nov 2020 13:34:22 +0100")
Message-ID: <xmqq7dqt87pa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBEEF92A-2376-11EB-A603-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

>> For now, I think this is fine, but we'd probably clean it up so that
>> without --force update-ref would not corrupt the repository like
>> this.  When used with --force, or before adding such a safety
>> measure, how we test if we successfully corrupted the repository is
>> an interesting matter.  I'd say
>> 
>> 	git update-ref --force --no-deref -d HEAD &&
>> 	test_must_fail git show-ref --verify -q HEAD &&
>> 	cp -f .git/HEAD.orig .git/HEAD &&
>> 	git show-ref --verify -q "$m"
>> 
>> to ensure that other than removing HEAD and corrupting the
>> repository, it did not cause permanent damage by removing the
>> underlying ref, perhaps.
>> 
>> We may want to add some NEEDSWORK comment around such tests.
>
> I think the proper way to do the test would be to create a non-mandatory
> symref and delete it. That'd also be a nice preparation for the
> `--force` parameter already.

Excellent.  Yes, the test is about creation and removal of a symref;
the symref used for testing does not have to be the HEAD.

Thanks.
