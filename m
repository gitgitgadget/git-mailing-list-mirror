Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 764032018E
	for <e@80x24.org>; Fri, 26 Aug 2016 18:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754002AbcHZSTm (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 14:19:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54101 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751559AbcHZSTl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 14:19:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 472EC37E7B;
        Fri, 26 Aug 2016 14:19:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qi+bBPiqaa44sv5z1JcLDxNqvYU=; b=OUnwNw
        Qw3mkQA3ae6fSNdL+tfXUU5VjEYnVxzT+BHOHKx6UFM+/tZ/95YCH3Fhr3vVG94Y
        VRHCk5YDcvJKlpuwIA0Wm6f5f4O7n7iE6UuEZ4jPlE99klru4SQXOos0Fn9YUU1t
        9NcXhIbxbiTYFdR/g2BH+ZRPnQ8RGO93HiB9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B+spHCgtyrllA+dCmAcOIPt0w7E9jLoQ
        urOrysvwkaT9RaMDvOp5cWZC97HEgG1fhCzGVJ9t+3mtfoi11CYMEJDLipbdwLrk
        zn9ebRnynY7jgvkUHifEmeB8zS7Zr6wPYWm0eBgQVOfFlNeJzETon8QIeJ2wxl+J
        +Qqi/TWHt9M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E43337E7A;
        Fri, 26 Aug 2016 14:19:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AE25B37E79;
        Fri, 26 Aug 2016 14:19:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v11 5/8] allow do_submodule_path to work even if submodule isn't checked out
References: <20160825233243.30700-1-jacob.e.keller@intel.com>
        <20160825233243.30700-6-jacob.e.keller@intel.com>
Date:   Fri, 26 Aug 2016 11:19:37 -0700
In-Reply-To: <20160825233243.30700-6-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Thu, 25 Aug 2016 16:32:40 -0700")
Message-ID: <xmqqshtrgzpi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A70F1860-6BB9-11E6-B8F4-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> Currently, do_submodule_path will attempt locating the .git directory by
> using read_gitfile on <path>/.git. If this fails it just assumes the
> <path>/.git is actually a git directory.
>
> This is good because it allows for handling submodules which were cloned
> in a regular manner first before being added to the parent project.

s/parent project/superproject/;

> Unfortunately this fails if the <path> is not actually checked out any
> longer, such as by removing the directory.
>
> Fix this by checking if the directory we found is actually a gitdir. In
> the case it is not, attempt to lookup the submodule configuration and
> find the name of where it is stored in the .git/modules/ folder of the
> parent project.

As you consistently say "directory" in the earlier part of the log
message,

s/folder of the parent project/directory of the superproject/;

is desired.

>
> If we can't locate the submodule configuration this might occur because

I added s/configuration/&,/ to make it a bit easier to read.

> for example a submodule gitlink was added but the corresponding
> .gitmodules file was not properly updated. A die() here would not be
> pleasant to the users of submodule diff formats, so instead, modify
> do_submodule_path to return an error code. For git_pathdup_submodule,
> just return NULL when we fail to find a path. For strbuf_git_path_submodule
> propagate the error code to the caller.

Somehow I had to read the latter half of this paragraph twice,
before I realized that the last two sentence talks about how these
two functions exactly do "to return an error code".  Tentatively
what I queued has:

    ... so instead, modify do_submodule_path() to return an error code:

     - git_pathdup_submodule() returns NULL when we fail to find a path.
     - strbuf_git_path_submodule() propagates the error code to the
       caller.

instead, hoping that would be easier to understand.

> -static void do_submodule_path(struct strbuf *buf, const char *path,
> -			      const char *fmt, va_list args)
> +/* Returns 0 on success, non-zero on failure. */

s/non-zero/negative/;

> +#define SUBMODULE_PATH_ERR_NOT_CONFIGURED -1
> +static int do_submodule_path(struct strbuf *buf, const char *path,
> +			     const char *fmt, va_list args)
>  {

This 5/8 is the only changed one in the entire series from the
previous round, I think.  I'll replace what was in 'pu' and wait for
responses.

Thanks.
