Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20AEC25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 22:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbiHTW7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 18:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiHTW7x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 18:59:53 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5226255
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 15:59:52 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 33A531A9D4B;
        Sat, 20 Aug 2022 18:59:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9HiqjT9nprD9yd/t6pxQ/5okYnsMndXEeZEaMS
        rxT7o=; b=SK0edsWpFh4ZuEzfaEss8luhWzPnsgvNZijg157GFalHfU9L+P+yzb
        /rHwiH26wfW6WboQuiqAzqhshcnIQql7N3WLpC2pMXhrexgFNAyActU+R70hQHgN
        Ple1ycJWvollFr/xNjnJyFLQeHojJgS/o0Ra1tWBkE3chnewntRt8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 22A581A9D49;
        Sat, 20 Aug 2022 18:59:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9E9E11A9D01;
        Sat, 20 Aug 2022 18:59:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tim Hockin <thockin@google.com>
Cc:     git@vger.kernel.org
Subject: Re: rev-parse: -- is sometimes a flag and sometimes an arg?
References: <CAO_RewbD+BJd1hPKCmCNM8wYBSUmZ2TuOoy6t1up1CT-rbn4DA@mail.gmail.com>
Date:   Sat, 20 Aug 2022 15:59:47 -0700
In-Reply-To: <CAO_RewbD+BJd1hPKCmCNM8wYBSUmZ2TuOoy6t1up1CT-rbn4DA@mail.gmail.com>
        (Tim Hockin's message of "Sat, 20 Aug 2022 15:39:54 -0700")
Message-ID: <xmqq8rniikrg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA8EFC64-20DB-11ED-A98B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tim Hockin <thockin@google.com> writes:

> ```
> $ git rev-parse unknown-tag
> unknown-tag
> fatal: ambiguous argument 'unknown-tag': unknown revision or path not
> in the working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
> ```
>
> OK
>
> ```
> $ git rev-parse unknown-tag --
> fatal: bad revision 'unknown-tag'
> ```
>
> Much nicer error.  But:
>
> ```
> $ git rev-parse HEAD --
> 113a928239196d0d9f70671517ce917071ceecf6
> --
> ```
>
> That's not very nice.  Why is "--" treated as an arg?
>
> ```
> $ git rev-parse HEAD
> 113a928239196d0d9f70671517ce917071ceecf6
> ```
>
> Looking at rev-parse code it SEEMS to be intentional, but I can't
> comprehend why.

Because the first function of "rev-parse" (among many others) is to
be a helper usable in scripted Porcelains to "parse" command line
arguments, shifting them into revs and "files".  Without options
like --revs-only, --no-revs, --flags etc., it dumps everything, while
translating "revs" into raw object names, to its output.  "--" is a
valid command line option for whatever scripted Porcelain you'd be
writing using "rev-parse" to help parsing its command line arguments.

So everything we see above is very much working as designed.

