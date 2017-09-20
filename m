Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC1E52047F
	for <e@80x24.org>; Wed, 20 Sep 2017 06:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbdITGXM (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 02:23:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56046 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751547AbdITGXL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 02:23:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF75796FC3;
        Wed, 20 Sep 2017 02:23:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L4grz8yTub8sZPaZT2mhSEhLoDo=; b=Jal1AL
        SAk01kEY2ih7yFWvjKmqlHKEGQtb9tVJPbZzHOkOUa7nct3tUJVUgRlKUR6Hv+HZ
        xpCwBboCrkyMd9JxsFP4uBLAOundSU21rSIJ4g5aT8i67ltWc4ZEdcSfk0b5ZlDz
        uvCbD8DL2awyhFc0S+tyS010tW8d7QU6kd1vM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YbkAm4hSC/L618nvZ/BhpfEp+JfbPlUA
        5X1Urjpok1zZuLz3gr6ZSnM/kEzfdm3SkqiKkIwYeWeBROfYnJ8DjN5SCnlTyCYI
        Acd9Ppk08hNObiBcqbT47vXu7K1/35htvdEO/QxGPtsgGqLF6XCDZOOLTB94MvNj
        5WxsGzpEjZI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D53EC96FC2;
        Wed, 20 Sep 2017 02:23:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1183996FC1;
        Wed, 20 Sep 2017 02:23:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: Re: [PATCH v7 04/12] fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
References: <20170915192043.4516-1-benpeart@microsoft.com>
        <20170919192744.19224-1-benpeart@microsoft.com>
        <20170919192744.19224-5-benpeart@microsoft.com>
Date:   Wed, 20 Sep 2017 15:23:09 +0900
In-Reply-To: <20170919192744.19224-5-benpeart@microsoft.com> (Ben Peart's
        message of "Tue, 19 Sep 2017 15:27:36 -0400")
Message-ID: <xmqq377hopma.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C60DF86-9DCC-11E7-AA86-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> @@ -344,6 +346,7 @@ struct index_state {
>  	struct hashmap dir_hash;
>  	unsigned char sha1[20];
>  	struct untracked_cache *untracked;
> +	uint64_t fsmonitor_last_update;

This field being zero has more significance than just "we haven't
got any update yet", right?  The way I am reading the code is that
setting it 0 is a way to signal that fsmon has been inactivated.  It
also made me wonder if add_fsmonitor() that silently returns without
doing anything when this field is already non-zero is a bug (in
other words, I couldn't tell what the right answer would be to a
question "shouldn't the caller be avoiding duplicate calls?").

> diff --git a/fsmonitor.c b/fsmonitor.c
> new file mode 100644
> index 0000000000..b8b2d88fe1
> --- /dev/null
> +++ b/fsmonitor.c
> ...

This part was a pleasant read.

Thanks.
