Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2173C205C9
	for <e@80x24.org>; Wed, 11 Jan 2017 20:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755272AbdAKUmg (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 15:42:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60923 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932755AbdAKUlf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 15:41:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E6BE5EAE9;
        Wed, 11 Jan 2017 15:41:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=g2C3frTldeck
        AbvlzQ2C547Ospw=; b=vRY0/kcLr/FakFssnmDnMXGlbNDQw1bkChXUx4KfCJNP
        kMmmq4gnOwa7jTdmnQQzvoY1MuNiFRHyHVIkem91PIe2wSy1pdiGNvkX/fpMNoXZ
        IZ7WNUHFri+gDviY17DNMpaV2otz82sWLtFKQK7HIqU39XYUULlvCMNYGfMR03g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=oLq97b
        CSwrJvXYt+MI0AOuCrADkGTgKcpEf4MHsDwTpPbtsXP1f8Q4PX/aPCw/pfxlNtLf
        7auurvW5Gtgazd1+PIAaSa2R1rGGMkN/46Bxrdois7uE6TFrsTRnXkCAze7+80ad
        Uhwxe6eyHwk57ZiKCNJH0bURyWpaxFCgz9YJA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 626595EAE8;
        Wed, 11 Jan 2017 15:41:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CFF255EAE7;
        Wed, 11 Jan 2017 15:41:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>, Taylor Blau <ttaylorr@github.com>
Subject: Re: [PATCH v1] convert: add "status=delayed" to filter process protocol
References: <20170108191736.47359-1-larsxschneider@gmail.com>
        <xmqqa8b115ll.fsf@gitster.mtv.corp.google.com>
        <ec8078ef-8ff2-d26f-ef73-5ef612737eee@gmail.com>
        <9A1064BB-DA72-44DB-A875-39E007708A69@gmail.com>
        <17fa31a5-8689-2766-952b-704f433a5b3a@gmail.com>
Date:   Wed, 11 Jan 2017 12:41:32 -0800
In-Reply-To: <17fa31a5-8689-2766-952b-704f433a5b3a@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Wed, 11 Jan 2017 15:53:27
 +0100")
Message-ID: <xmqqo9zdnxc3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 56E31C3C-D83E-11E6-9219-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

>> Yes, this problem happens every day with filters that perform network
>> requests (e.g. GitLFS).=20
>
> Do I understand it correctly that the expected performance improvement
> thanks to this feature is possible only if there is some amount of
> parallelism and concurrency in the filter?  That is, filter can be send=
ing
> one blob to Git while processing other one, or filter can be fetching b=
lobs
> in parallel.

The first-object latency may not be helped, but by allowing
"delayed", the latency to retrieve the second and subsequent objects
can be hidden, I would think.
