Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 490CA20193
	for <e@80x24.org>; Mon, 24 Oct 2016 18:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939692AbcJXSzd (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 14:55:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64955 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934292AbcJXSzc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 14:55:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 22B1D48AB6;
        Mon, 24 Oct 2016 14:55:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zwedm7F8fa+7Nv589kvtTHDmDwc=; b=F/0mRv
        OCDR+NmQiXuR2kq6KUVfVHAmcvoLKARszXdnWPGOxAlW87bsBCztgv/3x6wih5d1
        qzd8DOo+oelFokAPArAOO/gB69zaJxnaQX2wPKyJacs/dN1AweEEM6JVCSrcTGVK
        +Qrzpxow7WK7rdnkdIrr5Xj8qh5P5qw9UHSfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l/n+lRl4AbMbtjWfwe8HW2TtQQczjSe+
        +GaqM4LHJbw7Q2NjywVTi1v5c4z7g4xkSq1QLD1DbyEstSQbDMllzP597Yq1c3hB
        tINiOfA00WR0OesqXs4lb5mk9YqQ/dEMqE0nDGA65bRQWPBeLkq3uFx8qBVFs2KG
        LCzEIT20V/g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 18A4248AB4;
        Mon, 24 Oct 2016 14:55:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 91C3F48AB3;
        Mon, 24 Oct 2016 14:55:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com
Subject: Re: [PATCH 27/36] attr: convert to new threadsafe API
References: <20161022233225.8883-1-sbeller@google.com>
        <20161022233225.8883-28-sbeller@google.com>
Date:   Mon, 24 Oct 2016 11:55:28 -0700
In-Reply-To: <20161022233225.8883-28-sbeller@google.com> (Stefan Beller's
        message of "Sat, 22 Oct 2016 16:32:16 -0700")
Message-ID: <xmqqr37560gv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F757184-9A1B-11E6-AB25-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This revamps the API of the attr subsystem to be thread safe.
> Before we had the question and its results in one struct type.
> The typical usage of the API was
>
>     static struct git_attr_check *check;
>
>     if (!check)
>         check = git_attr_check_initl("text", NULL);
>
>     git_check_attr(path, check);
>     act_on(check->value[0]);
>
> This has a couple of issues when it comes to thread safety:
>
> * the initialization is racy in this implementation. To make it
>   thread safe, we need to acquire a mutex, such that only one
>   thread is executing the code in git_attr_check_initl.
>   As we do not want to introduce a mutex at each call site,
>   this is best done in the attr code. However to do so, we need
>   to have access to the `check` variable, i.e. the API has to
>   look like
>     git_attr_check_initl(struct git_attr_check*, ...);

Make that a double-asterisk.  The same problem appears in an updated
example in technical/api-gitattributes.txt doc, but the example in
the commit log message (below) is correct.

> The usage of the new API will be:
>
>     /*
>      * The initl call will thread-safely check whether the
>      * struct git_attr_check has been initialized. We only
>      * want to do the initialization work once, hence we do
>      * that work inside a thread safe environment.
>      */
>     static struct git_attr_check *check;
>     git_attr_check_initl(&check, "text", NULL);
>
>     /*
>      * Obtain a pointer to a correctly sized result
>      * statically allocated on the stack; this macro:
>      */
>     GIT_ATTR_RESULT_INIT_FOR(myresult, 1);

Are you sure about this?  We've called attr_check_initl() already so
if this is declaring myresult, it would be decl-after-stmt.

>     /* Perform the check and act on it: */
>     git_check_attr(path, check, myresult);
>     act_on(myresult->value[0]);
>
>     /*
>      * No need to free the check as it is static, hence doesn't leak
>      * memory. The result is also static, so no need to free there either.
>      */

The latter half is questionable.  If it is "static" it wouldn't be
thread safe, no?  I think the diff in this patch for archive.c shows
that we only expect

	struct git_attr_result result[2];

upfront without RESULT_INIT_FOR(), and the reason why there is no
need to free the result[] is because it is on the stack.  And each
element in result[] may point at a string, but the string belongs to
the attr subsystem and must not be freed.

