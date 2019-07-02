Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DBB31F461
	for <e@80x24.org>; Tue,  2 Jul 2019 18:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfGBS1N (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 14:27:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53264 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGBS1N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 14:27:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53F5A16EB7E;
        Tue,  2 Jul 2019 14:27:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IdDz979bUzKagc96PLHGxKeMEIc=; b=S6gg1s
        0MB2a11W1BzOmHPJa0Udzqves936t89aVhtqan2RheT8GtOr6CP2B2YLG0TqoKm5
        Y4AgCLpJ+O1FzvqHuMP3pq8yzguJlTXrZzeMKaRjkSP4fc8cWll91k+GR+cV/Siu
        ufLjHhkI7++7YDtZlSAD6rDOLZlTsNjuumt2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S8fqLDoGbrlZtJq7wNjkD1yWKJpKf9d9
        1atxJLx5bdrJxpUArNgDbIWUYsqkZAAK3WnglPk3kT6e0F3jKeJV9Es72qbUWksH
        cmHZJBtm808DDHyKXAxTzkaYWXynE2o+zgReNZd6d1UtKsn9lzgitp7321M4CcFR
        5rQ+m4mbHJc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C83516EB7D;
        Tue,  2 Jul 2019 14:27:11 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F9DC16EB7C;
        Tue,  2 Jul 2019 14:27:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] transport-helper: enforce atomic in push_refs_with_push
References: <20190702005340.66615-1-emilyshaffer@google.com>
        <nycvar.QRO.7.76.6.1907021540330.48@tvgsbejvaqbjf.bet>
Date:   Tue, 02 Jul 2019 11:27:09 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1907021540330.48@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 2 Jul 2019 15:51:55 +0200 (CEST)")
Message-ID: <xmqq5zok47ia.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0173B740-9CF7-11E9-AF4A-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +	# Make master incompatible with up/master
>> +	git reset --hard HEAD^ &&
>> +	# Add a new branch
>> +	git branch atomic &&
>> +	# --atomic should roll back creation of up/atomic
>> +	test_must_fail git push --atomic "$up" master atomic &&
>> +	git ls-remote "$up" >up-remotes &&
>> +	test_must_fail grep atomic up-remotes
>
> Why not `test_must_fail git -C "$d" rev-parse refs/heads/atomic`?

They check different expectations.

Between making sure that the state observable in the resulting
repository matches what should have been left and checking what the
command says it did to its output, I agree that the former is a more
robust way to test the commands.

We obviously could test both, though ;-)

