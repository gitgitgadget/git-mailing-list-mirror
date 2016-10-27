Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F0F92022A
	for <e@80x24.org>; Thu, 27 Oct 2016 05:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbcJ0Fo3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 01:44:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51808 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751227AbcJ0Fo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 01:44:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97FB349DC3;
        Thu, 27 Oct 2016 01:44:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uGVugONI2vXJ6zvgckuBMntECrg=; b=Awzw6x
        kM5ReFnG8ZlIkGgxnO11X5CMHSRSf6pC9p0352P3GzXULbGNkeHL9kY6MUKgR5w4
        UZr9uXSUID/tzzjGSOsZMakgbmTgqZ1Sotmgi0sxp4tNfZvnyJ2QXbbwzi3n/MFW
        E7rO7eeyxbt0GheHD4jxwg3sKvrhTV5ugoWK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IyKDouy33i+3serHuWcgKmGEv4jfa9bz
        Bp6cmlwpRruAYcMVjSL4FYMF0nwXWsZYVr8POuKMXf9o/3GjRoqfwcKrVIfvgbOU
        FjXL769wuOR9jlzZIsUrqFlgexj4hwJPQBmzUSQogunNSbK2iunAeSOUjuANLfAJ
        s2fvbqi5onY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F89049DC2;
        Thu, 27 Oct 2016 01:44:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0211149DC0;
        Thu, 27 Oct 2016 01:44:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCHv2 1/2] attr: convert to new threadsafe API
References: <CAGZ79kYhMVrKHhNGYcf_D9kWEYp+sC+tMGbuE+gnD8AU27dh8g@mail.gmail.com>
        <20161026224104.31844-1-sbeller@google.com>
        <xmqqbmy6aa6b.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYiVxJwtAYsgks8LVNWvawWxdy=8Xpdrki-C_u15C3Z9w@mail.gmail.com>
        <xmqq37jia0p8.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 26 Oct 2016 22:44:24 -0700
In-Reply-To: <xmqq37jia0p8.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 26 Oct 2016 21:13:39 -0700")
Message-ID: <xmqqy41a8hxj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6BA25AD8-9C08-11E6-BA72-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> Yeah, I can make it work without exposing struct git_attr.
>
> You completely misunderstood me.  "struct git_attr" MUST be visible
> to the users so that they can ask for the name in git_check.attr[0].
>
> What would be nice to hide if you can is the function to intern a
> string into a pointer to struct git_attr, i.e. git_attr() function.

Even though that was not the primary point of my suggestion, I
actually think it is OK to make "struct git_attr" a structure that
is opaque to the users of the API if you wanted to.  The attr_check
structure will have an array of pointers to "struct git_attr", and
the structure definition may be visible to the public attr.h header,
but the API users won't have to be able to dereference the pointer
"struct git_attr *".  git_check.attr[0] would be a pointer to an
opaque structure from API users' point of view, that can be passed
to API function git_attr_name() to read its string.

What is nice to hide is the constructor of the structure.  What it,
i.e. "struct git_attr *git_attr(const char *)", needs to do is to
(1) see if the attribute object with the same name already exists in
the table of "all known attributes in the universe", and if there
is, return that instance, (2) otherwise create a new attribute
object, register it to the table and return it.  And it needs to do
it in a way that is thread-safe.

If we have to give access to it to the API users, then we'd need to
acquire and release the Big Attr Lock per each call.  

The calls to git_attr() you need to make in your implementation will
be made from two codepaths:

 * check_initl() acquires the Big Attr Lock, creates a check struct,
   makes multiple calls to git_attr() to construct the necessary
   git_attr instances to fill the array and then releases the lock,
   so the git_attr() constructor does not have to be protected for
   concurrent access.

 * check_attr() acquires the Big Attr Lock, calls down to
   prepare_attr_stack() as necessary to parse .gitattributes files
   found in the directory hierarchy, which makes calls to git_attr()
   to record the attributes found in the file.  Then it does the
   matching to fill results[] array and releases the lock.  Again,
   git_attr() constructors are called under the lock, so there is no
   need for a separate lock.

If these are the only callpaths that reach git_attr() to construct
new attribute objects, it would mean that you can make this private
to attr subsystem and hide it from the users of the API.

Otherwise, you would need to rename the git_attr() constructor that
used internally under the Big Lock to

    static struct git_attr *git_attr_locked(const char *);

that is defined inside attr.c, and then provide the external version
as a thin wrapper that calls it under the Big Lock, i.e.

    struct git_attr *git_attr(const char *s)
    {
	struct git_attr *attr;
	take_big_attr_lock();
	attr = git_attr_locked(s);
	release_big_attr_lock();
	return attr;
    }

That will have to make the big attr lock busier, and it would be
good if we can avoid it.  That is where my "can we hide git_attr()
constructor?" comes from.

