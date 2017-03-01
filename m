Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7064C2027B
	for <e@80x24.org>; Wed,  1 Mar 2017 22:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753140AbdCAWvA (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 17:51:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50145 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752642AbdCAWu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 17:50:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9526978EC1;
        Wed,  1 Mar 2017 17:49:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1zwF5t+P9e8BMjqcXb5PRWi4kEs=; b=IdPcQq
        zwsz68d/YAF87Sy9iQXl9tplHJyvGCSlsofi1naOjhTFSY4nAn16Xo8+QlGpO/aq
        SBcjBlpm17pwE2WbNN2Q3o6vkTcVJvkOAtTF9Dxa79M81AJmJc5qyCUzimOlQwjI
        FCYCosAxiMdxTxbriew0pyPCWJItnO6oGaLyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uwWLQYQ7yh/PlGCJJf2fhNFmfvqyjAPc
        W7t4KGNh9nhJ9vSAK70l5QsWYVjuofTKfFMgdwqwNnSdOXSTj95EqKBzllmG3KVb
        asC4Lj1D2KsHwa6MgioFc2a6HbUK3dW/0hteVzT4sUhvnHZAm4MCCA+GhYME5uus
        2NdS71RhVHU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C7E178EC0;
        Wed,  1 Mar 2017 17:49:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CECC878EBF;
        Wed,  1 Mar 2017 17:49:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     git@vger.kernel.org, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH 5/6 v5] merge.c: delegate handling of "-" shorthand to revision.c:get_sha1
References: <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>
        <1488007487-12965-6-git-send-email-kannan.siddharth12@gmail.com>
Date:   Wed, 01 Mar 2017 14:49:43 -0800
In-Reply-To: <1488007487-12965-6-git-send-email-kannan.siddharth12@gmail.com>
        (Siddharth Kannan's message of "Sat, 25 Feb 2017 07:24:46 +0000")
Message-ID: <xmqqpoi0eho8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D51B52E-FED1-11E6-9B80-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Kannan <kannan.siddharth12@gmail.com> writes:

> The callchain for handling each argument contains the function
> revision.c:get_sha1 where the shorthand for "-" ~ "@{-1}" has already been
> implemented in a previous patch; the complete callchain leading to that
> function is:
>
> 1. merge.c:collect_parents
> 2. commit.c:get_merge_parent : this function calls revision.c:get_sha1
>
> This patch also adds a test for checking that the shorthand works properly

This breaks "git merge".

> +test_expect_success 'merge - should work' '
> +        git checkout testing-2 &&
> +        git merge - &&
> +        git rev-parse HEAD HEAD^^ | sort >actual &&
> +        git rev-parse master testing-1 | sort >expect &&
> +        test_cmp expect actual

This test is not sufficient to catch a regression I seem to be
seeing.

	$ git checkout side
	$ git checkout pu
	$ git merge -

used to say "Merge branch 'side' into pu".  With this series merged,
I seem to be getting "Merge commit '-' into pu".
