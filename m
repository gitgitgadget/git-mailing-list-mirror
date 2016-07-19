Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3439C1FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 17:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbcGSR4F (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 13:56:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53835 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753669AbcGSR4E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 13:56:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DD2A2D85B;
	Tue, 19 Jul 2016 13:56:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=txL6ER/wyCunMSgdRJheHlJXb3I=; b=niZuXa
	22sTVHM8XeYfn3ncRJu6omPGr4AjQQ92R6ZzDPGRIRoRu45+CZ55ZMU2iLrmdevW
	2U6G80UqLlXrZmSHloiDsyeBYeMeme2Qk9ucxw2jY5E22Oij7qSpHmwfyCZ/Lk3Z
	i4we71n7JTpyp4+VtQaVX4EZ4Cl/Px10ETK2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jvHFJf5zONlvTLpJLnPwlrxtwmSjiZa9
	nDm8Hg0u4JetbeNylxwcea2RuFmC0uDJIvmRJQiK7sP3F/T3TPZMys9FMkrpY54J
	eLzLaWgRC/bShZ8lej//PlbmZG0ea6voyRN+75jZUkriuf7fuXIrXAupE+m9Wj7S
	skiyvDzgQMc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 07E892D859;
	Tue, 19 Jul 2016 13:56:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 87A132D857;
	Tue, 19 Jul 2016 13:56:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: Looking for help to understand external filter driver code
References: <67D9AC88-550E-4549-9AFD-2401B70B363B@gmail.com>
Date:	Tue, 19 Jul 2016 10:56:00 -0700
In-Reply-To: <67D9AC88-550E-4549-9AFD-2401B70B363B@gmail.com> (Lars
	Schneider's message of "Tue, 19 Jul 2016 18:40:48 +0200")
Message-ID: <xmqqbn1th5qn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0EAAF82A-4DDA-11E6-A246-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> a long time ago in aa4ed4 Junio introduced the external filter
> driver definition. Since that time we fork the Git process and
> then we fork again to run the external filter. This is probably a
> super stupid question with an obvious answer... but can anyone
> help me to understand the code and explain why we fork twice?

In "git show aa4ed4" you find this picture:

       /*
        * Create a pipeline to have the command filter the buffer's
        * contents.
        *
        * (child --> cmd) --> us
        */

where "child" is a fork of the original Git process; it still has
the <src, size> buffered data inherited from the original process,
so it can write_in_full() into the pipe going to the cmd process.
"us" is the original process that has the reading end of the pipe
that connects us to the "(child --> cmd)" processes, so that it can
read the filtered result from them.

The key benefit of this arrangement is the above can be done without
having to do poll() to flip between reading and writing that is
needed to avoid deadlocking, which kept the code simpler.  A later
conversion of the write side into async does not fundamentally
change anything from the original arrangement.






