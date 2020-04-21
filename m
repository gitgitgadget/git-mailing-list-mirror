Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785D2C54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 536E42073A
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uzd2NqUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgDUUwu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:52:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58781 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDUUwu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 16:52:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE3F0624A9;
        Tue, 21 Apr 2020 16:52:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Yx0PSRpk+Bk0sdjQp01Gu92ZLUA=; b=uzd2Nq
        Ullu+R6ZlIARsfrFMiTTTq8L+sTfgli/pK4QzwtgrQdJX8+ZTgWx0WZ0L9JjVsp7
        4DEfCyON0OrjJ+cpLOQmdZj+Fa5fXxd+q/oBMoy8io3jT0nK5W8Ds8ryCDgWGqcp
        6/W7/a55SLJnTM9BydDwFsjask6OHgZ7U8GEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=USNxbwru7nxfrQ5DdFnwip45dzaWEWLi
        Ve5f8z4jF1CTJNJdCx3hRzck02duxz54jPKkNC6XYMdmvET319vlenGpiAEF5IOW
        aGlFugM6kx49CRMWGr74LmLUzbFVSRImjZ/ibWxYjS8wHFVKD08E8SFnGJlYNUod
        0bYN9Dn1TUk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C6DBD624A8;
        Tue, 21 Apr 2020 16:52:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4DF9A624A7;
        Tue, 21 Apr 2020 16:52:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] shallow.c: use 'reset_repository_shallow' when appropriate
References: <8d295389ea43c6b7e008514067b7af6eacba64a5.1587492422.git.me@ttaylorr.com>
        <xmqqeesgmuzv.fsf@gitster.c.googlers.com>
        <20200421204516.GA69777@syl.local>
Date:   Tue, 21 Apr 2020 13:52:46 -0700
In-Reply-To: <20200421204516.GA69777@syl.local> (Taylor Blau's message of
        "Tue, 21 Apr 2020 14:45:16 -0600")
Message-ID: <xmqq5zdsmuht.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E5B401A-8412-11EA-AE9C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> > @@ -414,6 +414,7 @@ void prune_shallow(unsigned options)
>> >  	} else {
>> >  		unlink(git_path_shallow(the_repository));
>> >  		rollback_lock_file(&shallow_lock);
>> > +		reset_repository_shallow(the_repository);
>> >  	}
>>
>> Here, we reset only after we realize we cannot write the updated
>> shallow file.  Intended?
>
> Yes, see this earlier discussion I had about it with Jonathan:
> https://lore.kernel.org/git/20200416020509.225014-1-jonathantanmy@google.com/.

I did, and then I asked the question, because I couldn't quite get
if JTan was asking a question similar to the one he asked earlier in
the message ("do you need a reset in the "else" branch as well?"),
or if he was saying what he sees there, "the opposite case", was
good.

Also, I was sort-of reacting to """In any case, I think the commit
message should discuss why reset_repository_shallow() is added only
on the unlink+rollback side in one "if" statement, but only on the
opposite "commit" side in another "if" statement.""" in that
message.

Thanks.
