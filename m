Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9A7207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 20:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932272AbcJCUuB (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 16:50:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58590 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932255AbcJCUt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 16:49:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0912841445;
        Mon,  3 Oct 2016 16:49:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jliw3/vZ8VDswA/swe7HD7b6F/4=; b=vQvcws
        +hnNS0oRpiXrhdJ6Zui4E4MbMQCAu8h1wRGpAUKbHI/HpS/a/KKedm5s67kqX227
        JNTYpREawvRqKR/Eyx4X/aOFsX2B8mK9+3zFCthkbrfD2HlTdOE6rC2f7acB7gc8
        QOxYayYrSTqABrVO2qC5IUDFxh5c1/HVWvhYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fdmKBrCKtG84sduFaT8tyEWLEeDzPATH
        My565PCv4+BCBLzz78aOaGPvJbGkPJEBzS2nNSo1kDf/h7+jNl5novsC6ifb0mUU
        pR1RPOFEeZ/hHlAEt5XUfYe9kjexRVqFPVHmP57D9lrztqPWx+1EqvQVg052hgi/
        VIOms09mbgI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 00DE541444;
        Mon,  3 Oct 2016 16:49:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 73CF041443;
        Mon,  3 Oct 2016 16:49:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2016, #08; Tue, 27)
References: <xmqq8tudkjvn.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kY6c-vwSP7-1Gz4jwWO-z_yT2oFbG4cgZb-JAae=Sk-cA@mail.gmail.com>
        <xmqqk2dp71d2.fsf@gitster.mtv.corp.google.com>
        <CAGZ79ka8dO1AHJftKAqD6LvxJSP+8yGGa7Citcdxxrnc5DMeYg@mail.gmail.com>
Date:   Mon, 03 Oct 2016 13:49:53 -0700
In-Reply-To: <CAGZ79ka8dO1AHJftKAqD6LvxJSP+8yGGa7Citcdxxrnc5DMeYg@mail.gmail.com>
        (Stefan Beller's message of "Mon, 3 Oct 2016 12:55:55 -0700")
Message-ID: <xmqqwphp5f9q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0917A00-89AA-11E6-83BE-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I am looking at the tip of jc/attr-more and for a minimum
> thread safety we'd want to change the call sites to be aware of the
> threads, i.e. instead of doing
>
      static struct git_attr_check *check;	
>     if (!check)
>         check = git_attr_check_initl("crlf", "ident",
>                     "filter", "eol", "text",
>                     NULL);
>
> We'd rather call
>
>         struct git_attr_check *check;
>         check = git_attr_check_lookup_or_initl_threadsafe(
>                 "crlf", "ident", "filter", "eol", "text", NULL);
>          if (!git_check_attr(path, check)) {
>              ...

I actually am hoping that the "static" can be kept so that we can
minimize the cost of interning these symbols into struct git_attr.

The initialization would thus become something like:

	static struct git_attr_check *check;
	git_attr_check_initl(&check, "crlf", "ident", ..., NULL);

The structure will have an array of git_attr[], once interned will
be shared and used by everybody.  _initl() will need to make sure
that the "check" pointer is updated atomically so that multiple
people racing to initialize this variable will not step on each
others' toes.

Then the use site would do something like

	const char *result[... some size ...];
	git_check_attr(path, check, result[]);

to receive result regardless of anybody else who is using the same
"check" structure to ask the same question (for different paths).
