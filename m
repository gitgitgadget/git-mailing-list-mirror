Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6185420954
	for <e@80x24.org>; Mon,  4 Dec 2017 16:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753189AbdLDQJc (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 11:09:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55488 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753611AbdLDQJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 11:09:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EEAAF9FDFB;
        Mon,  4 Dec 2017 11:09:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MtsAVFPDiG58Iy6QxAfTWPewYWA=; b=Zpa5ZB
        zbPeDJgU++nk5aHXAn70K97SMZhg+qAb8UgAuUuGTuNKzTbSAcxPCTUE7VVXgBaw
        tjkWWJNXI/pFX7B9DrUkOuPGA4JmalQKdoA+C3CFSQw6aw52FwkhQwbTIlxs/bO5
        Gu4DSbIIVsqjtjVKWxYyH6SjjKCpQCDPNbZYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OOaF9e51+mfTqmvYC7QdXNHGX0ReqwIy
        vZLz8Flz1sOBzdGbWDnDKibGBDOZWDAFx9Wz2hh8mrso5BuK6dPdpW8GxS/1prk8
        jXBwKAFs2h1WMYxsmKLP8PaqlYMeseN5V4ZoxBTlgeLqnmbCKlNbRl6InvMQgrlO
        iSUa4sROCSI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E66959FDF9;
        Mon,  4 Dec 2017 11:09:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5DEDD9FDF8;
        Mon,  4 Dec 2017 11:09:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 4/9] rebase -i: refactor transform_todo_ids
References: <20171127045514.25647-1-liambeguin@gmail.com>
        <20171203221721.16462-1-liambeguin@gmail.com>
        <20171203221721.16462-5-liambeguin@gmail.com>
        <alpine.DEB.2.21.1.1712041541000.98586@virtualbox>
Date:   Mon, 04 Dec 2017 08:09:27 -0800
In-Reply-To: <alpine.DEB.2.21.1.1712041541000.98586@virtualbox> (Johannes
        Schindelin's message of "Mon, 4 Dec 2017 15:42:11 +0100 (CET)")
Message-ID: <xmqq4lp6o4p4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 813A8968-D90D-11E7-9FCB-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 3 Dec 2017, Liam Beguin wrote:
>
>> The transform_todo_ids function is a little hard to read. Lets try
>> to make it easier by using more of the strbuf API. Also, since we'll
>> soon be adding command abbreviations, let's rename the function so
>> it's name reflects that change.
>
> I am not really a fan of the new name, and would prefer the old one, but
> that's only a nit, not a reason to reject the patch.

FWIW, I do think the new name goes backwards.  The command uses to
remember what operations are to be carried out in which order using
a thing, and the name of that thing "todo list".  We also called it
the "instruction sheet", and "insn" was a good term to call one item
on that sheet among other items.

But recent commits in the area are pushing us to call it "todo list"
consistently.  An element in that list should be called "todo".

A "todo" consists of two parts, "what operation is done" part and
"using what commit object" part.  The original implementation of
this function affected only the latter part, and in that light, the
original name transform_todo_ids() is understandable.  Now you are
planning to make it modify both parts, not just "ids", so it is
understandable that you would want to rename it.  But I do not think
"insn" matches the recent trend.  It even risks misunderstanding
(i.e. xfrm_todo_ids() is about modifying "using what commit" part,
so perhaps xfrm_todo_insns() is about modifying "what operation is
done" part---but that is different from what you want to do, which
is to update _both_ halves).

Calling it just transform_todo() would probably be more in line with
the reason why you wanted to rename it in the first place.

