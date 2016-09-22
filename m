Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0D321F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 21:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034909AbcIVVQ3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 17:16:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54983 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1034728AbcIVVQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 17:16:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D79D93F86F;
        Thu, 22 Sep 2016 17:16:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MY8fw7xR2pF+7q+wMHqiiuAFJpY=; b=flb57j
        Ai67leqgi9ueUdkn5gg74usJBr8bANds3B7sZ7EZltXDBpdrT6t1jvLWlYIZGwmB
        QY2MFJ6WQdzzMgDWzu4SyDjcfKEqmKKSdNRenhuc31lwIb5lnJaC2eMRxPKlt4bB
        WiNhKzgC10hJAEtbzDQpyMPCPWxaQJakgYM5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WGeYkabAUTK/9aGC1vEWcRyoEKNHeMWR
        RsnzdgclLAsNDiJqM1ynfRFLfKD6dCpO9VuduShL6tCD5D3D5tON2Vpj7qwrNXxQ
        MW5duiNcSP3Yha1yMvMEWnk9x3na7RxHq08rR8TB3irktJJoFBYepoXhBLo2u/x0
        rPSc0k7bItQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CFF133F86B;
        Thu, 22 Sep 2016 17:16:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58BEE3F86A;
        Thu, 22 Sep 2016 17:16:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org
Subject: Re: [PATCH 5/6] builtin/verify-tag: Add --format to verify-tag
References: <20160922185317.349-1-santiago@nyu.edu>
        <20160922185317.349-6-santiago@nyu.edu>
Date:   Thu, 22 Sep 2016 14:16:21 -0700
In-Reply-To: <20160922185317.349-6-santiago@nyu.edu> (santiago@nyu.edu's
        message of "Thu, 22 Sep 2016 14:53:16 -0400")
Message-ID: <xmqqintn3aai.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D07B1CC0-8109-11E6-A3BB-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

santiago@nyu.edu writes:

> From: Santiago Torres <santiago@nyu.edu>
>
> Callers of verify-tag may want to cross-check the tagname from refs/tags
> with the tagname from the tag object header upon GPG verification. This
> is to avoid tag refs that point to an incorrect object.
>
> Add a --format parameter to git verify-tag to print the formatted tag
> object header in addition to or instead of the --verbose or --raw GPG
> verification output.
>
> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
>  builtin/verify-tag.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> index 7a1121b..319d469 100644
> --- a/builtin/verify-tag.c
> +++ b/builtin/verify-tag.c
> @@ -12,12 +12,15 @@
>  #include <signal.h>
>  #include "parse-options.h"
>  #include "gpg-interface.h"
> +#include "ref-filter.h"
>  
>  static const char * const verify_tag_usage[] = {
> -		N_("git verify-tag [-v | --verbose] <tag>..."),
> +		N_("git verify-tag [-v | --verbose] [--format=<format>] <tag>..."),
>  		NULL
>  };
>  
> +char *fmt_pretty;

Does this have to be extern?  I do not think so; prepend "static "
in front of it.

>  	while (i < argc) {
>  		unsigned char sha1[20];
>  		const char *name = argv[i++];
>  		if (get_sha1(name, sha1))
>  			had_error = !!error("tag '%s' not found.", name);
>  		else {
> -			if (verify_and_format_tag(sha1, name, NULL, flags))
> +			if (verify_and_format_tag(sha1, name, fmt_pretty, flags))

OK.  The callchain from here is

    verify_and_format_tag()
    -> run_gpg_verify()
      -> print_signature_buffer()

so not cramming QUIET into the flags parameter that is already
passed is cumbersome.  As I said in my earlier review, it would make
more sense to have the conditional NOT in print_signature_buffer()
but in its caller, but it still is OK to add GPG_VERIFY_QUIET bit
to the flag, which you would check in run_gpg_verify() to decide not
to call print_signature_buffer().

