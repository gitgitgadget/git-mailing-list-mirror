Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8672C4743D
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 00:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5356613B6
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 00:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhFIAoi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 20:44:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51084 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbhFIAoh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 20:44:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5DB7C1439DF;
        Tue,  8 Jun 2021 20:42:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v3azuaaRiO0vgPKQeUOnWQ1yZg4Poo3bPWrbXL
        3/5F4=; b=izz2JWfEyYJFt1bhu/S82sBpkdblSFl3fhU3oYtdbj059fY3L2MSrb
        71VlLW0LArf4Pr7dSdxhWiu+HkzP/0+qYi6Zg2Q1r2QJVphs05INMWhOkBeqv/E+
        Be/vA7COrKyCQ5pCs/gELb98TreAaKDwoBzRtz+Aok7GwfLIHxpLo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 567A51439DE;
        Tue,  8 Jun 2021 20:42:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9EFE11439DD;
        Tue,  8 Jun 2021 20:42:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [RFE] Teach git textconv to support %f
References: <01f901d75c7c$5a8bcb10$0fa36130$@nexbridge.com>
Date:   Wed, 09 Jun 2021 09:42:39 +0900
In-Reply-To: <01f901d75c7c$5a8bcb10$0fa36130$@nexbridge.com> (Randall
        S. Becker's message of "Tue, 8 Jun 2021 11:38:33 -0400")
Message-ID: <xmqq8s3jna0w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9905E88E-C8BB-11EB-B15A-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> The filter structure provides a mechanism for providing the
> working directory's file name path to a filter using a %f
> argument. This request is to teach the textconv mechanism to
> support the same capability.
>
> The use case comes from a complex content renderer that needs to
> know what the original file name is, so as to be able to find
> additional content, by name, that describes the file (base
> name+different extension).
>
> If this is considered a good idea, I would be happy to implement
> this but need a pointer or two of where to look in the code to
> make it happen.

Both in diff, grep and cat-file, textconv eventually triggers
diff.c::fill_textconv() and calls run_textconv() unless there is a
cached copy of the resut of running textconv earlier on the same
contents.  This is because for each textconv driver, the output is
expected to be purely a function of the input bytestream, and that
is why it does not take any other input.

So, if we have two identical blobs in a tree object under different
pathnames, making the output from textconv different for them
because they sit at different pathnames directly goes against the
basic design of the system at the philosophical level.

Having said that, I _suspect_ (but not verified) that as long as the
driver is marked as non-cacheable, it may be acceptable to export a
new environment variable, say, GIT_TEXTCONV_PATH, and allow the
textconv program to produce different results for the same input.  I
am not offhand sure if it is OK to allow command line substitutions
like the filter scripts, though.  It would be nice from the point of
view of consistency if we could do so, but those who use an existing
textconv program at a pathname with per-cent in it may get negatively
affected.

Thanks.
