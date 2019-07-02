Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C69F41F461
	for <e@80x24.org>; Wed,  3 Jul 2019 00:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfGCAf3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 20:35:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56837 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfGCAf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 20:35:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 25FB07700D;
        Tue,  2 Jul 2019 16:16:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LDELOpEY4OnIy3W503teaYQ0piQ=; b=JWAAOq
        bK8APujuPaNgoIM1yECQpSZIVNGWdbQCC4+ePcPt4Qj4KpqmuGnJlHveDaiiSLUz
        BYToNvxdXhsB4sW4McwZI4l9Qvtl5iyhd/crj55lugVqk0yYil6jgc3XQyy0WFhO
        lX++zVuXo9v/nK5wV+OIepjPq4HuMr8b+APrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ou8zoHMD1Fnwe1zVfK+BNSr+W5lclprT
        hDMmtr8UNa+9gpc74bkFr1iwdr84OtpPc5zPd/ciEYUhQaMDX57WSUE4fMFonIqu
        j05aq/EpAdlTufwWK0iISD3XiM4HaltR0tu6sHlUEjDN9bqR4Rt8ns3tw3tRxvSS
        LCVpfYD/tdA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1E6257700C;
        Tue,  2 Jul 2019 16:16:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4E0517700B;
        Tue,  2 Jul 2019 16:16:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] transport-helper: enforce atomic in push_refs_with_push
References: <20190702005340.66615-1-emilyshaffer@google.com>
Date:   Tue, 02 Jul 2019 13:16:46 -0700
In-Reply-To: <20190702005340.66615-1-emilyshaffer@google.com> (Emily Shaffer's
        message of "Mon, 1 Jul 2019 17:53:40 -0700")
Message-ID: <xmqqk1d02nv5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 520AF1A0-9D06-11E9-A4A2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +		if ((flags & TRANSPORT_PUSH_ATOMIC) && err) {
> +			for (struct ref *it = remote_refs; it; it = it->next)
> +				switch (it->status) {
> +				case REF_STATUS_NONE:
> +				case REF_STATUS_UPTODATE:
> +				case REF_STATUS_OK:
> +					it->status = REF_STATUS_ATOMIC_PUSH_FAILED;
> +				default:
> +					continue;
> +				}
> +		}


Let's write this more like so

		if ((flags & TRANSPORT_PUSH_ATOMIC) && err) {
			for (struct ref *it = remote_refs; it; it = it->next)
				switch (it->status) {
				case REF_STATUS_NONE:
				case REF_STATUS_UPTODATE:
				case REF_STATUS_OK:
					it->status = REF_STATUS_ATOMIC_PUSH_FAILED;
					break;
				default:
					break;
				}
		}

to prevent compilers from giving "implicit fallthru" warnings.
