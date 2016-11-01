Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 831A820229
	for <e@80x24.org>; Tue,  1 Nov 2016 19:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754047AbcKATXQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 15:23:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51610 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752964AbcKATXP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 15:23:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B7D14ADEA;
        Tue,  1 Nov 2016 15:23:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/sFR3U+Zhlv4BaMGSikZhJLWns8=; b=X9BiwT
        iHrL1MiuZcZZMve9nq8t2CzPt0hAGGn6MPfu0cfKqxJvov3sygZtPJz8Ybk6yZkH
        zUqzRw3MNAK17tBhkuj580oWyVR9yiySCaArb1om6oTIIOop+x6bjhwHk9P7ITKE
        19dGDyaiAEXxHub5oJNnUuZMU4mKeHaoepRIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EHv+T8sNvhgI/53cvUX5K+N+LzDK+nD1
        MbzWKwB05q438DU+ptTqoXniyCpn8IUtej3ZhOZgywlJflMhQHm+L0GfbkjqGtVw
        4l2hmvGF8SO1V9F1nwLXvpc3tJxG0wBq4Wm6ViVrWe+ukpN7VoMfPn3IFSsvdAfS
        MHGf/pm34X0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92E1D4ADE9;
        Tue,  1 Nov 2016 15:23:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 131A84ADE7;
        Tue,  1 Nov 2016 15:23:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1 14/19] read-cache: touch shared index files when used
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
        <20161023092648.12086-15-chriscool@tuxfamily.org>
        <CACsJy8As2o-ZDXMRWeebpXiWUrDMLaXC2H1R+OMbhAMmM8V_wg@mail.gmail.com>
Date:   Tue, 01 Nov 2016 12:23:12 -0700
In-Reply-To: <CACsJy8As2o-ZDXMRWeebpXiWUrDMLaXC2H1R+OMbhAMmM8V_wg@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 25 Oct 2016 17:26:02 +0700")
Message-ID: <xmqq4m3rovhb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2466A20-A068-11E6-A2D6-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Oct 23, 2016 at 4:26 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> @@ -2268,6 +2268,12 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
>
> Doing this in read_index_from() would keep the shared file even more
> "fresher" since read happens a lot more often than write. But I think
> our main concern is not the temporary index files created by the user
> scripts, but $GIT_DIR/index.lock (make sure we don't accidentally
> delete its shared file before it gets renamed to $GIT_DIR/index). For
> this case, I think refreshing in write_locked_index is enough.

Also warning() is unwarranted.

You may be accessing somebody else's repository to help diagnose the
issue without having any write access.  Treat the utime() like the
opportunistic index refresh done by "git status"---if we can write,
great, but it is not a problem if we can't.

>
>>                 int ret = write_shared_index(istate, lock, flags);
>>                 if (ret)
>>                         return ret;
>> +       } else {
>> +               /* Signal that the shared index is used */
>> +               const char *shared_index = git_path("sharedindex.%s",
>> +                                                   sha1_to_hex(si->base_sha1));
>> +               if (!check_and_freshen_file(shared_index, 1))
>> +                       warning("could not freshen '%s'", shared_index);
>
> _()
