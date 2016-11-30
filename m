Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D99F31FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 21:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755370AbcK3VHq (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 16:07:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53572 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756686AbcK3Uvk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 15:51:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBD9C53832;
        Wed, 30 Nov 2016 15:51:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MCyspEmXqtRH6eUBCzDuAkz1znQ=; b=kjSJAC
        I82JDQkER+Jj2uxytpQKzD//tfvIN1oNBxHFU+5labyztdQnn/kDj6E6xBp5+Z1U
        jyThF9OMQ2FQk4QjOmRgg6aMfGuiAH6T006Rbv/v40+nDBFmTO8whH8WI4mjIze5
        Hx3BKoz0O+DMmc2JjzVIDFY05mvP9+SfV28As=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=euDkFr+x/+1beaPoUfHzcu/AwQ3TowTg
        yS+kk4BZ+rmoeubvyuFeew/008geR4JInujF3pfq20pWKB+xP4lqIA2af3myyCXN
        nYxJZQLjd4seiKwmq5w28ESOVKfVMRPmR5AQ8Pqo/AFMJMvbo4mg+H7Mr+Kyn87+
        PhmN/6jTaD0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B103F53831;
        Wed, 30 Nov 2016 15:51:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2F0105382F;
        Wed, 30 Nov 2016 15:51:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCHv2 4/4] submodule: add embed-git-dir function
References: <20161122192235.6055-1-sbeller@google.com>
        <20161122192235.6055-5-sbeller@google.com>
        <CACsJy8Ce3Oa-xJ4BwgRRy6neM=Jxkfqq7yboHZDXLDG2tu9GzQ@mail.gmail.com>
Date:   Wed, 30 Nov 2016 12:51:36 -0800
In-Reply-To: <CACsJy8Ce3Oa-xJ4BwgRRy6neM=Jxkfqq7yboHZDXLDG2tu9GzQ@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 30 Nov 2016 18:14:11 +0700")
Message-ID: <xmqqpolcd73b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9C08468-B73E-11E6-9BFE-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Nov 23, 2016 at 2:22 AM, Stefan Beller <sbeller@google.com> wrote:
>> +/*
>> + * Migrate the given submodule (and all its submodules recursively) from
>> + * having its git directory within the working tree to the git dir nested
>> + * in its superprojects git dir under modules/.
>> + */
>> +void migrate_submodule_gitdir(const char *prefix, const char *path,
>> +                             int recursive)
>
> Submodules and worktrees seem to have many things in common. The first
> one is this. "git worktree move" on a worktree that contains
> submodules .git also benefits from something like this [1]. I suggest
> you move this function to some neutral place and maybe rename it to
> relocate_gitdir() or something.

Yeah, good suggestion (including name; first round used "intern" I
had trouble with, then "embed" which was OK-ish, but probably
"relocate" is better choice.  If anything, what Stefan's series adds
is a command to un-embed embedded one).

> It probably should take a bit flag instead of "recursive" here. One
> thing I would need is the ability to tell this function "I have moved
> all these .git dirs already (because I move whole worktree in one
> operation), here are the old and new locations of them, fix them up!".
> In other words, no rename() could be optionally skipped.

Thanks two of you for working well together ;-)
