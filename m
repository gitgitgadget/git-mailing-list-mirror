Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C105C433C1
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 18:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29BC7619B1
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 18:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhC0ShB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 14:37:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50635 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhC0SgW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 14:36:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D93E7B5D4B;
        Sat, 27 Mar 2021 14:36:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UWRwrGCferfkp+eBLYLU7qTyArI=; b=IeeVpF
        /RENsAI1YWpPKmdfd4HggM+UOvU1dxbXoRnj6i1pyPnfPwtsykmp3vsiXypPZS3X
        Aui3TXiXUpDJAtXH/4pBOA0xPZ3IRnBER0V3hsJXhngyTJxw84THilFkga/jyzn1
        N9fLdU+YbzwABwG5PXQMPDhzI5kz6idLShlSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wbQQkUpTEhrL+FuVQ3ehI36DOzS9C4S9
        E3Con20HziIinDMJDfzL+XYczHzkgHFAlXC1X8kbz51dhDRcZkSGay8vC+Z9u0ot
        oaYwoWvZfFAsAmZXfUAbDRHBfQ0xanVHeuz1wQBWzAUG40C9ohu0r8/A4/OqpEad
        BC1A0lapPxc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1F98B5D4A;
        Sat, 27 Mar 2021 14:36:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65548B5D49;
        Sat, 27 Mar 2021 14:36:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stavros Ntentos <stdedos@gmail.com>, bagasdotme@gmail.com,
        git@vger.kernel.org, stdedos+git@gmail.com
Subject: Re: [RFC PATCH v1 1/2] pathspec: warn: long and short forms are
 incompatible
References: <YF1w/xKbozpQn7Vf@coredump.intra.peff.net>
        <20210326161626.28648-1-133706+stdedos@users.noreply.github.com>
        <YF792/TkS3Ssw9NS@coredump.intra.peff.net>
Date:   Sat, 27 Mar 2021 11:36:20 -0700
In-Reply-To: <YF792/TkS3Ssw9NS@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 27 Mar 2021 05:41:47 -0400")
Message-ID: <xmqqa6qoqw9n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53A09D62-8F2B-11EB-A8D2-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It also feels like any checks like this should be relying on the
> existing pathspec-magic parser a bit more. I don't know the pathspec
> code that well, but surely at some point it has a notion of which parts
> are magic flags (e.g., after parse_element_magic in init_pathspec_item).

Absolutely.  parse_element_magic() decides, by looking at the
character after the initial ':', the we are looking at the longhand
form when magic sequence is introduced by ":(".

Otherwise, : must be followed by shorthand form, where the only
usable ones are '/' (synonym for top), '!' and '^' (synonym for
exclude), and ':' (end of short-form marker), but most importantly,
'(' will *never* be a valid shorthand form (because it is not part
of the GIT_PATHSPEC_MAGIC class of bytes).

So, presumably, inside parse_short_magic(), you could detect '('
and complain it as an attempt to switch to longform.

Here is to illustrate where to hook the check.  With this, I can get
something like this:

    $ git show -s --oneline -- ':!/(foobar)frotz' ':/(bar)nitfol' .
    warning: :!/: cannot mix shortform magic with longform like (exclude)
    warning: :/: cannot mix shortform magic with longform like (exclude)
    84d06cdc06 Sync with v2.31.1

Note that this illustration does not show the best warning message.
To improve it to a bit more useful level, I think two things need to
happen on top.

 * Use advice to allow users sequelch.

 * Show a few letters after '(' (but pay attention to the end of the
   string, which ends with either '\0' or ':'), and lose the
   substring "like (exclude)" from the message.

That would have given

    hint: ":!/(foo...": cannot mix shortform and longform magic

for the above example.

I initially thought it might make it even better if we looked ahead
of what comes after '(', took the substring before ',' or ')', and
looked up pathspec_magic[] array, BUT I do not think it is a good
idea.  It would be confusing if we do not give the same advice to
":!(literol)" when the user does get one for ":!(literal)".  So the
above "two things need to happen" list deliberately excludes an
"improvement" doing so.


 pathspec.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git i/pathspec.c w/pathspec.c
index 18b3be362a..cd343d5b54 100644
--- i/pathspec.c
+++ w/pathspec.c
@@ -336,6 +336,9 @@ static const char *parse_long_magic(unsigned *magic, int *prefix_len,
 	return pos;
 }
 
+static const char mixed_pathspec_magic[] =
+	N_("%.*s: cannot mix shortform magic with longform like (exclude)");
+
 /*
  * Parse the pathspec element looking for short magic
  *
@@ -356,6 +359,16 @@ static const char *parse_short_magic(unsigned *magic, const char *elem)
 			continue;
 		}
 
+		if (ch == '(') {
+			/*
+			 * a possible common mistake: once you started
+			 * a shortform you cannot add (longform), e.g.
+			 * ":!(top)"
+			 */
+			warning(_(mixed_pathspec_magic),
+				(int)(pos-elem), elem);
+		}
+
 		if (!is_pathspec_magic(ch))
 			break;
 

