Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 537F420899
	for <e@80x24.org>; Wed, 23 Aug 2017 19:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932600AbdHWTNV (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 15:13:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54532 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932458AbdHWTNT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 15:13:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0305F9CAD2;
        Wed, 23 Aug 2017 15:13:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H6T7YdwTssb2anT2aIcGzIW4sGw=; b=eFNCXq
        0o/mjkOZQQRircTftRAySKlXCx7btU5ahybRuxHejZr65N/aXLtbZbN+z3C49BIJ
        hlnrlSXbgtYti9OJEWDpI1HTxVmLB/9sNYNt7JZRAHGxGii2W1dH9En6Rkt9Yqmn
        H4Eg8UdHzrNTZR35zavvOfKK2hELI7y29E/K4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ezmXHkyXNkQtXtK+gLiE045elEGd3eTL
        zbiAaE8ondcgelWX3dpH1n2bbbxukk80adbOOiKAYWPcoM+zrX13J2IvE/snziDO
        VLq/5wi4BnlfNTaaF2ouoaMfKKpmwGvrIHPF79YieA7Fwde5VWY9gSS0QrsfsqNe
        dYsZnZ7Onho=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF7BB9CAD1;
        Wed, 23 Aug 2017 15:13:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 63AAA9CACD;
        Wed, 23 Aug 2017 15:13:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org, sbeller@google.com
Subject: Re: [GSoC][PATCH v2 2/4] submodule--helper: introduce for_each_submodule()
References: <xmqqinhf1bjf.fsf@gitster.mtv.corp.google.com>
        <20170823181506.8557-1-pc44800@gmail.com>
        <20170823181506.8557-3-pc44800@gmail.com>
Date:   Wed, 23 Aug 2017 12:13:17 -0700
In-Reply-To: <20170823181506.8557-3-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Wed, 23 Aug 2017 23:45:04 +0530")
Message-ID: <xmqqbmn6yu5u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F15CCBA-8837-11E7-A2A5-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

> +typedef void (*submodule_list_func_t)(const struct cache_entry *list_item,
> +				      void *cb_data);
> +
>  static char *get_default_remote(void)
>  {
>  	char *dest = NULL, *ret;
> @@ -353,17 +356,30 @@ static int module_list(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> -static void init_submodule(const char *path, const char *prefix, int quiet)
> +static void for_each_submodule(const struct module_list *list,
> +			       submodule_list_func_t fn, void *cb_data)

In the output from

	$ git grep for_each \*.h

we find that the convention is that an interator over a group of X
is for_each_X, the callback function that is given to for_each_X is
of type each_X_fn.  An interator over a subset of group of X that
has trait Y, for_each_Y_X() iterates and calls back a function of
type each_X_fn (e.g. for_each_tag_ref() still calls each_ref_fn).

I do not offhand think of a reason why the above code need to
deviate from that pattern.


