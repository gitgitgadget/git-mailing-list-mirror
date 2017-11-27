Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A13E820A41
	for <e@80x24.org>; Mon, 27 Nov 2017 05:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750945AbdK0FTi (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 00:19:38 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63503 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750726AbdK0FTh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 00:19:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 20ED0B2426;
        Mon, 27 Nov 2017 00:19:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f4bEVQLIEWeUBjAbEOL19Yabxwk=; b=aSuplW
        2caHXvwEhh5Xlz3fV3pwC2nkqoMJxsjptY4fb8HcVxAm/0vZS6bZeM/3KXruBq4y
        /FMnS5E45E62LFI4n5Tvwnbq2BY8AjR7IuICodZA/lgkux5ANW+NaS4N97+v43yt
        3RKU7x8Aj6TQYiQb++dnNeu1LcnwUExKsn5pY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ivQpigRdQdMRNDjhDetTadDPJPNEYxbG
        Q0VuIBl5CBrZ3Z9SQTuio9qSx4hGaok2skzWFEzrmGkgg18eGzzn+uaEsFY2TbVD
        019TbXSZhAn9j/z1/R56xFN5cWkvV4vtNb9IakzvNNdXqIgMIAel7aNRBJgQVb1D
        NErM3PMAqX8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 177C9B2425;
        Mon, 27 Nov 2017 00:19:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8395CB2423;
        Mon, 27 Nov 2017 00:19:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com
Subject: Re: [PATCH 4/5] rebase -i: learn to abbreviate command names
References: <20171127045514.25647-1-liambeguin@gmail.com>
        <20171127045514.25647-5-liambeguin@gmail.com>
Date:   Mon, 27 Nov 2017 14:19:35 +0900
In-Reply-To: <20171127045514.25647-5-liambeguin@gmail.com> (Liam Beguin's
        message of "Sun, 26 Nov 2017 23:55:13 -0500")
Message-ID: <xmqq1skke1so.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F637E2C-D332-11E7-8F08-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Liam Beguin <liambeguin@gmail.com> writes:

>  	if (command == MAKE_SCRIPT && argc > 1)
> -		return !!sequencer_make_script(keep_empty, stdout, argc, argv);
> +		return !!sequencer_make_script(keep_empty, abbreviate_commands,
> +					       stdout, argc, argv);

This suggests that a preliminary clean-up to update the parameter
list of sequencer_make_script() is in order just before this step.
How about making it like so, perhaps:

    int sequencer_make_script(FILE *out, int ac, char **av, unsigned flags)

where keep_empty becomes just one bit in that flags word.  Then another
bit in the same flags word can be used for this option.

Otherwise, every time somebody comes up with a new and shiny feature
for the function, we'd end up adding more to its parameter list.
