Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE0B42035F
	for <e@80x24.org>; Tue, 25 Oct 2016 16:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753859AbcJYQ66 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 12:58:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62620 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752762AbcJYQ65 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 12:58:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E096484AD;
        Tue, 25 Oct 2016 12:58:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ddhTxaO9WPe/6EdMo7XYBXXeVOE=; b=R1Li/j
        gaUIiobxqZL01Tg8y8IM2Ch+wzhlVJB9oEhi1V3pXkn6BJwbD9aIUbCj8DfZu3a/
        JouJca9muNGHWFhXzb/tT6KJHfIaI5JVatLTZfJpd5GgY2IhGyadLtNgHf8Ppo0Z
        ZWIA5WscYFP5+fbJerv1E8bYEO4J76WQjGoUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TtQVE7IcORR247N04pZqewjRXBukuDWl
        ZJ14GeQOW8R9TP8gjHmI9kxUVEY1Btks/FxTAvJaUh2K26gFZM0ktgRc3fiIfIeM
        Iv85j2HVyymot1U48T6nPJHCHEuxadJlekMGbXiwMiI4JLm9wISho59bwtkzEevC
        XItZ0guUSFM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 15E68484AC;
        Tue, 25 Oct 2016 12:58:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8C1D5484A7;
        Tue, 25 Oct 2016 12:58:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        e@80x24.org, jnareb@gmail.com
Subject: Re: [PATCH v2 1/2] sha1_file: open window into packfiles with CLOEXEC
References: <20161024180300.52359-1-larsxschneider@gmail.com>
        <20161024180300.52359-2-larsxschneider@gmail.com>
        <alpine.DEB.2.20.1610251220280.3264@virtualbox>
Date:   Tue, 25 Oct 2016 09:58:52 -0700
In-Reply-To: <alpine.DEB.2.20.1610251220280.3264@virtualbox> (Johannes
        Schindelin's message of "Tue, 25 Oct 2016 12:27:52 +0200 (CEST)")
Message-ID: <xmqqwpgws6ur.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FEA6FE0-9AD4-11E6-8426-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The patch series may be a little bit more pleasant to read if you renamed
> git_open_noatime() to git_open() first, in a separate commit.

Possibly.

If this were "we added a new parameter at the same time and each
calling site of the renamed function with an extra parameter chooses
to pass different value to it", then keeping the rename and the
interface enhancement as two separate steps would help a lot.

But this one only renames and updates the internal implementation,
without changing what the calling sites need to do.  I am OK with
having them together in a single patch like the one posted.

>> @@ -1598,12 +1598,18 @@ int git_open_noatime(const char *name)
>>  		if (fd >= 0)
>>  			return fd;
>>  
>> -		/* Might the failure be due to O_NOATIME? */
>> -		if (errno != ENOENT && sha1_file_open_flag) {
>> -			sha1_file_open_flag = 0;
>> +		/* Try again w/o O_CLOEXEC: the kernel might not support it */
>> +		if (O_CLOEXEC && errno == EINVAL &&
>> +			(sha1_file_open_flag & O_CLOEXEC)) {
>> +			sha1_file_open_flag &= ~O_CLOEXEC;
>
> How about
>
> 		if ((O_CLOEXEC & sha1_file_open_flag) && errno == EINVAL) {
> 			sha1_file_open_flag &= ~O_CLOEXEC;
>
> instead? It is shorter and should be just as easily optimized out by a
> C compiler if O_CLOEXEC was defined as 0.

Yup, I think that makes things easier to read for humans, too.
