Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E911B20899
	for <e@80x24.org>; Mon, 14 Aug 2017 17:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbdHNR50 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 13:57:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54638 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751196AbdHNR50 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 13:57:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4083CA992E;
        Mon, 14 Aug 2017 13:57:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RKunA5LLRXGYumSLPgW49JODICc=; b=qLw95n
        pVY1OxYQo6wUYkA0tnq1b1ywXvIPbxYgrU0Y5sJ937XVn8a/ZhD9quvdEh/FFx5c
        77NGod0gRH+aLWtKqhX9NRuijbrNz/UjrJGAGYwR+O/cQ2QSoR0Sp2Pu5FsgYzcj
        CoxOUOu23THwvktD0UcXrcVL6DYW2z6vtGoW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EEiiGLL1aEqW6siDezkZqaDZkV7OUgCm
        Qxb6mF3/Pyw5fS+gDPpJeQPV/AeajoqGdRge5skwE8W8by0ammgxVhsChSvjbS4l
        sVu87+Hucnm90bGZ7x4hC857eA8phreXlmKhwRKjLrKNJOv+3wH1SO7RX284W9MV
        VW0qkT1uN4A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30E11A992D;
        Mon, 14 Aug 2017 13:57:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8417DA992B;
        Mon, 14 Aug 2017 13:57:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paolo Bonzini <bonzini@gnu.org>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 0/4] interpret-trailers: add --where, --if-exists, --if-missing
References: <20170801090333.32642-1-bonzini@gnu.org>
        <0ac82014-4da9-9ef2-5da0-07996c8aa8fd@gnu.org>
Date:   Mon, 14 Aug 2017 10:57:23 -0700
In-Reply-To: <0ac82014-4da9-9ef2-5da0-07996c8aa8fd@gnu.org> (Paolo Bonzini's
        message of "Mon, 14 Aug 2017 11:26:29 +0200")
Message-ID: <xmqq1soevxq4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 070D8000-811A-11E7-8B0F-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paolo Bonzini <bonzini@gnu.org> writes:

> On 01/08/2017 11:03, Paolo Bonzini wrote:
>> From: Paolo Bonzini <pbonzini@redhat.com>
>> 
>> These options are useful to experiment with "git interpret-trailers"
>> without having to tinker with .gitconfig (Junio said git should ahve
>> done this first and only added configuration afterwards).  It can
>> be useful in the case where you want a different placement for the trailer,
>> or for scripts/aliases that don't want to rely on specific .gitconfig
>> settings.
>> 
>> Compared to v2, the main change is that option order on the command-line
>> is respected.  That is,
>> 
>> 	--trailer 'acked-by: foo' --where end --trailer 'signed-off-by: me'
>> 
>> will only apply where=end to the second trailer.  Likewise,
>> 
>> 	--where end --trailer 'signed-off-by: me' --no-where \
>> 	--trailer 'acked-by: foo'
>> 
>> will only apply it to the first, reverting to trailer.*.where for the
>> "acked-by" trailer.
>
> Junio, I see you haven't yet applied this v4 to origin/pu, did you miss it?

Thanks for pinging.  Either it was not noticed by mistake or was
deliberately ignored during the pre-release freeze, I do not
remember.
