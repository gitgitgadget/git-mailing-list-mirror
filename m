Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 468532022A
	for <e@80x24.org>; Thu, 27 Oct 2016 00:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933693AbcJ0AtE (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 20:49:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60515 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932702AbcJ0AtE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 20:49:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6A514992E;
        Wed, 26 Oct 2016 20:49:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J59HuQL4/cY0RXkMUvZN+PJKmRM=; b=HquPE5
        aNYuo/M8QWqGAT9xY6I5D12kx5T2q8y2T7UaYIcFssAtsGm3GWBk/7XU3Ynh2h7k
        lj7PrcYflzYrGu8n5RvTPnIEq/kpX7YvloH5BTSe16Vc5Wog44N6etKlggkwGbV/
        vtMVa+KcccDycomKTZA96E6wSm4hEV9GJ2oVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dgXoThF/yzhAWYwGNR3WV70oT2JeL6qK
        YMy2HgfnSHpBXT4f93ke4AVb5tHHTZY6v9JTDOptsD97u1mp2aoMAGhAgc9ugDay
        q80mb+CjyIhVvjb8JCycb6GTvvLerKCEprYk7/IvRhu1Z8UpMI9pdmOm8O3nXEKq
        BevIW96FpXU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE6694992D;
        Wed, 26 Oct 2016 20:49:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 38E164992B;
        Wed, 26 Oct 2016 20:49:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     pclouds@gmail.com, git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        j6t@kdbg.org, peff@peff.net, bmwill@google.com, simon@ruderich.org
Subject: Re: [PATCHv2 1/2] attr: convert to new threadsafe API
References: <CAGZ79kYhMVrKHhNGYcf_D9kWEYp+sC+tMGbuE+gnD8AU27dh8g@mail.gmail.com>
        <20161026224104.31844-1-sbeller@google.com>
Date:   Wed, 26 Oct 2016 17:49:00 -0700
In-Reply-To: <20161026224104.31844-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 26 Oct 2016 15:41:04 -0700")
Message-ID: <xmqqbmy6aa6b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2767E6F4-9BDF-11E6-9830-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>  extern struct git_attr *git_attr(const char *);
> ...
> +extern void git_attr_check_append(struct git_attr_check *,
> +				  const struct git_attr *);

Another thing.  Do we still need to expose git_attr() to the outside
callers?  If we change git_attr_check_append() to take "const char *"
as its second parameter, can we retire it from the public interface?

It being an "intern" function, by definition it is not thread-safe.
Its use from prepare_attr_stack() inside git_check_attr() that takes
the Big Attribute Subsystem Lock is safe, but the callers that do

	struct git_attr_check *check = ...;
	struct git_attr *text_attr = git_attr("text");

	git_attr_check_append(check, text_attr);

would risk racing to register the same entry to the "all the
attributes in the known universe" table.  

If the attribute API does not have to expose git_attr(const char *)
to the external callers at all, that would be ideal.  Otherwise, we
would need to rename the current git_attr() that is used internally
under the Big Lock to 

    static struct git_attr *git_attr_locked(const char*)

that is defined inside attr.c, and then provide the external version
as a thin wrapper that calls it under the Big Lock.


