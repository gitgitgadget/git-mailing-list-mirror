Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2DA32070F
	for <e@80x24.org>; Thu, 15 Sep 2016 19:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753085AbcIOTVq (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 15:21:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59547 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751127AbcIOTVp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 15:21:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E5C43C38A;
        Thu, 15 Sep 2016 15:21:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wYWR7DFNHItPI3WT+LoZc0MrA8s=; b=NQ7QB+
        2nGC38AVBBKoKPT3g8d4KnkDy3oxnThMlnCH3xwbBQC0fVBJe0um1t//jbcttVd0
        m+41Dn0ze2rs+1MKaOo0TKy6YGaXk8byVQFudpEku3e/jwZM6u/RlBdVMVh4OQdN
        XxeFXxVnH8Hdj0FJCiy+mFtAyVN64T1VHZ8Qk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YvrHjWj4ZAMORqE0U7CKY/QTu332SlDv
        /PTdQ3JzCQc+oXRLNwYSLTEla731cb9+SqYh58mCSrJER3xqk7Z52YkmWF6qPTk7
        O7HgjzpEIW0en88JnOGFXc/HuNUscrA9ZJBO4znXwRvRP/owHYnM2HLMhWt3Wt9s
        k2MUk2sZ8XI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7621C3C389;
        Thu, 15 Sep 2016 15:21:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ECD9C3C387;
        Thu, 15 Sep 2016 15:21:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 21/25] sequencer: refactor write_message()
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <cover.1473590966.git.johannes.schindelin@gmx.de>
        <da2293aee439da2274e30304e2d1f097b9644e64.1473590966.git.johannes.schindelin@gmx.de>
        <e21e3391-bfc3-68b8-8eaf-0e15e5a436c5@kdbg.org>
Date:   Thu, 15 Sep 2016 12:21:41 -0700
In-Reply-To: <e21e3391-bfc3-68b8-8eaf-0e15e5a436c5@kdbg.org> (Johannes Sixt's
        message of "Mon, 12 Sep 2016 10:35:22 +0200")
Message-ID: <xmqqfup1nf3u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A28DC4D8-7B79-11E6-A934-92D512518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 11.09.2016 um 12:55 schrieb Johannes Schindelin:
>> -static int write_message(struct strbuf *msgbuf, const char *filename)
>> +static int write_with_lock_file(const char *filename,
>> +				const void *buf, size_t len, int append_eol)
>>  {
>>  	static struct lock_file msg_file;
>>
>>  	int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0);
>>  	if (msg_fd < 0)
>>  		return error_errno(_("Could not lock '%s'"), filename);
>> -	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
>> -		return error_errno(_("Could not write to %s"), filename);
>> -	strbuf_release(msgbuf);
>> +	if (write_in_full(msg_fd, buf, len) < 0)
>> +		return error_errno(_("Could not write to '%s'"), filename);
>> +	if (append_eol && write(msg_fd, "\n", 1) < 0)
>> +		return error_errno(_("Could not write eol to '%s"), filename);
>>  	if (commit_lock_file(&msg_file) < 0)
>>  		return error(_("Error wrapping up %s."), filename);
>>
>>  	return 0;
>>  }
>
> The two error paths in the added lines should both
>
> 		rollback_lock_file(&msg_file);
>
> , I think. But I do notice that this is not exactly new, so...

It may not be new for this step, but overall the series is aiming to
libify the stuff, so we should fix fd and lockfile leaks like this
as we notice them.

Thanks.
