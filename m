Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E78F20987
	for <e@80x24.org>; Mon,  3 Oct 2016 20:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbcJCURX (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 16:17:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58020 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751758AbcJCURX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 16:17:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71DF943648;
        Mon,  3 Oct 2016 16:17:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=whBHtRGP9sZQceWgHAyxpM5jeZc=; b=ROHp73
        Q3u/fEYDy8RC2SsX+bdMjDkgxHPeZ3NZ+oW/7+8dZuL8G4Dnm1fBGeaytb8zjSqm
        +XlcuKc6TwV9uMKl88ZRsjjbhVL7Ava2YJjy/z1Sx1Q+ys4ve7ejck2s+LLeBt9+
        5McPiOriaNi7k56KsjQc/4TbxqYeNfycd9cb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w0kHVr3w01z56hf2QYFMBDlvqzXnNB6I
        gpHhnjGphIzM2OQgl40K4JoyVTXGs+cLPl3yFoYgzPN51Wi9qtVZgTgEdCgcCbvU
        ZTeec/GcHS/0DmJCwOnFPcjXm8RXK1u2IJlLoUBW1+OGvG1mp0hh7c/f7zl1XMQm
        BiY6pdQppyo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6881743647;
        Mon,  3 Oct 2016 16:17:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D329243645;
        Mon,  3 Oct 2016 16:17:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2016, #08; Tue, 27)
References: <xmqq8tudkjvn.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kY6c-vwSP7-1Gz4jwWO-z_yT2oFbG4cgZb-JAae=Sk-cA@mail.gmail.com>
        <xmqqk2dp71d2.fsf@gitster.mtv.corp.google.com>
        <CAGZ79ka8dO1AHJftKAqD6LvxJSP+8yGGa7Citcdxxrnc5DMeYg@mail.gmail.com>
Date:   Mon, 03 Oct 2016 13:17:18 -0700
In-Reply-To: <CAGZ79ka8dO1AHJftKAqD6LvxJSP+8yGGa7Citcdxxrnc5DMeYg@mail.gmail.com>
        (Stefan Beller's message of "Mon, 3 Oct 2016 12:55:55 -0700")
Message-ID: <xmqq1szx6vch.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6387CF8C-89A6-11E6-9407-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> The minimum that would future-proof us, that is still missing from
>> the series, would probably be to separate the query parameter
>> "struct git_attr_check" and the return values from git_check_attr().
>
> Not sure what you mean here with separating as a preparation for
> the thread safety. As I understand it we can still keep the thread local
> states in git_attr_check, we'd just have to route each thread to its
> own part of the memory in there?

For example, look at what you did in your pathspec-label topic.

    static int match_attrs(const char *name, int namelen,
                           const struct pathspec_item *item)
    {
            int i;

            git_check_attr_counted(name, namelen, item->attr_check);
            for (i = 0; i < item->attr_match_nr; i++) {
                    const char *value;
                    int matched;
                    enum attr_match_mode match_mode;

                    value = item->attr_check->check[i].value;
                    match_mode = item->attr_match[i].match_mode;

Each pathspec item has an attr_check member that wants to see a
specific set of attributes for a path being matched.  Each element
of the item->attr_check->check[] array is <attr, value> pair, where
<attr> is a constant for the purpose of the codepath (i.e. no matter
which thread is asking, and no matter for which path the question is
being asked, it asks for a fixed attribute that was computed when
the pathspec was parsed).  But <value> is a slot to return the
finding back to the caller.

So you can never keep this code structure and have this function
called more than once, specifically, you cannot make
git_check_attr_counted() call from multiple threads, at one time.

Instead the calling convention needs to be updated to allow this
caller of git_check_attr_counted() to pass a separate array that is
on its stack, e.g.

	const char *v[... some size ...];

	git_check_attr_counted(name, namelen, item->attr_check, v);
        for (i = 0; i < item->attr_match_nr; i++) {
        	const char *value;

                value = v[i];
        	match_mode = item->attr_match[i].match_mode;

We could do that API update way before we make the attribute
subsystem's implementation thread-safe, and if we did so now,
then the caller will not have to change.

That is what I meant as "future-proofing", i.e. future-proofing the
callers.

And from that point of view, I think 0a5aadcce4 is not an ideal
place to stop.  We'd want at least up to 079186123a but probably
even more, e.g. to 48d93f7f42, I would think.
