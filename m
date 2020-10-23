Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1A5C388F7
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 00:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 771CC24630
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 00:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MNVvYBXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374145AbgJWAwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 20:52:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50177 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901065AbgJWAwa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 20:52:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5E0FF1454;
        Thu, 22 Oct 2020 20:52:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=D4XSwfvmXaI01pMCeRkcGpKmx84=; b=MNVvYBXCZApFcdMJG1se
        eFj8wJ95HlZP79PBxJniUPdvxtxAHFfKnaRbnu+E7NCP6oY3TVlLyYStPE4S7VSm
        SRcPTiAHJv6krLjWhUQutz3MKd/TC8N+kgGGdQYRmQddTxFRK0skdxBbDHztoRZa
        2ea0Tv2E+jkkVQh7juqGuO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=KTHhB/Gbw7BndDYF6S4qS21/KBL07d2m4W3n5KoW1ntchK
        I0ZEylLOPVsodNP2tdlfFMIvF21g3PKgWwKHJTW3VYykBWNiq9xSSN5tUsu9lF8p
        R2Rro4A2plEl7eDkNuYylqmai57w42obRZH94Nedbyz/BM+jCLZkvWY0/+rGM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AD28AF1453;
        Thu, 22 Oct 2020 20:52:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8D291F1452;
        Thu, 22 Oct 2020 20:52:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v4 1/2] ref-filter: handle CRLF at end-of-line more
 gracefully
References: <pull.576.v3.git.1602526169.gitgitgadget@gmail.com>
        <pull.576.v4.git.1603335680.gitgitgadget@gmail.com>
        <03b2d7d78a15d15130a68ed1e6092072aa0807cd.1603335680.git.gitgitgadget@gmail.com>
Date:   Thu, 22 Oct 2020 17:52:21 -0700
Message-ID: <xmqq8sbxlq62.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0347FA8A-14CA-11EB-9F97-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> The ref-filter code does not correctly handle commit or tag messages
> that use CRLF as the line terminator. Such messages can be created with
> the `--cleanup=verbatim` option of `git commit` and `git tag`, or by
> using `git commit-tree` directly.
>
> The function `find_subpos` in ref-filter.c looks for two consecutive
> LFs to find the end of the subject line, a sequence which is absent in
> messages using CRLF. This results in the whole message being parsed as
> the subject line (`%(contents:subject)`), and the body of the message
> (`%(contents:body)`) being empty.
>
> Moreover, in `copy_subject`, which wants to return the subject as a
> single line, '\n' is replaced by space, but '\r' is
> untouched.

Honestly, all of the above signal, at least to me, that these
objects are designed to use LF terminated lines and nothing else,
whether Windows or DOS existed in the same world or not.  There is
no such thing as commit objects that use CRLF as the line
terminator.  They are commit objects whose payload has CR at the end
of each and every line.  Just like there can be commit objects whose
payload has trailing SP on each line, or even has binary guck, these
things can be created using the "commit --cleanup=verbatim" command,
or the "hash-objects" command.  It does not mean it is encouraged to
create such objects.  It does not mean it is sensible to expect them
to behave as if these trailing whitespaces (be it SP or CR) are not
there.

> This impacts the output of `git branch`, `git tag` and `git
> for-each-ref`.

The answer to that problem description is "then don't" ;-).  If you
do not want to have trailing whitespaces, you need to clean them up
somehow, and we give an easy way to do so with the default --cleanup
action.  Setting it to verbatim is to decline that easy way offered
to you, and it makes it your responsibility to do your own clean-up
if you still want to remove the CR at the end of your lines.

Having said all that.

Here is how I explained the topic in the "What's cooking" report.

     A commit and tag object may have CR at the end of each and
     every line (you can create such an object with hash-object or
     using --cleanup=verbatim to decline the default clean-up
     action), but it would make it impossible to have a blank line
     to separate the title from the body of the message.  Be lenient
     and accept a line with lone CR on it as a blank line, too.

Let's not call this change a "bug fix".  The phrase you used in your
title, "more gracefully", is a very good one.

In the meantime, I've squashed your "oops forgot ||return 1" change
into [PATCH 2/2].

Thanks.
