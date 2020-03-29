Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2EFC43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 18:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D77420732
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 18:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M9xFDhyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgC2SUa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:20:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64487 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbgC2SUa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 14:20:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7A414AB5C;
        Sun, 29 Mar 2020 14:20:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sEYeaEZYK70S1uV19HwP9mU4ubs=; b=M9xFDh
        yB2guSPh5hlTAeQ/vCvCg9cM5N1CFYamb+sCcDN0IjoB5RpWtyVK0G6sIY8fvctG
        KYIWJLH1kCHr6P5QoNr6D93T4XxtpyHNpOr/gRida+3uFejFpu3uXBfos4xgClJp
        6XL2vl6W0JWVeWtBAYg7wMQTuB6K/BNh5X44Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bI4OaFo5j3nTTrw1UfYgb2rtm5XnwS2q
        JEZaLb3H+YXClY1DWygRItpk384hREmg2X0dPStUBGHjkvNuPPU1/jBI5DsFAr6C
        vTbgBewmKMO+f3Di+8TG+lYHXLHOea3KIVEc0ymxyUWVmJnqC+rJvVFHWbyt/WXK
        MBMA0viGJzs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE3044AB5B;
        Sun, 29 Mar 2020 14:20:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D0CA4AB5A;
        Sun, 29 Mar 2020 14:20:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Martin Melka <martin.melka@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v4 0/7] Avoid multiple recursive calls for same path in read_directory_recursive()
References: <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
        <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
        <ad7c7cd7-2f2e-d406-6a1f-9dd7f155dc10@gmail.com>
        <CABPp-BFXWx_MPL1Z0-X5hHf0N1T_13TEbAhVTKh6-atO1+g90Q@mail.gmail.com>
Date:   Sun, 29 Mar 2020 11:20:26 -0700
In-Reply-To: <CABPp-BFXWx_MPL1Z0-X5hHf0N1T_13TEbAhVTKh6-atO1+g90Q@mail.gmail.com>
        (Elijah Newren's message of "Sat, 28 Mar 2020 10:33:10 -0700")
Message-ID: <xmqqy2rj9g5x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6FD77BA-71E9-11EA-AE14-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> An update of my own for this series: Based on Felipe's reported
> bash-completion issue I was modifying commands to try out a number of
> other things and discovered some cases that can trigger the die("git
> ls-files: internal error - directory entry not superset of prefix")
> message from ls-files so there's still some fixes I need to make.
> Will send an update when I've got it.

Thanks.  This is uncomfortably exciting ;-)

