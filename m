Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 230231F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 19:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751444AbdAYTcJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 14:32:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50332 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750768AbdAYTcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 14:32:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AFFCC62B61;
        Wed, 25 Jan 2017 14:32:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=li18n8XQdZhvCe6tddlxx37qXEM=; b=E8cejG
        V0L6R5ATtKQ2xX3swsvbpE32GPT106ZpRSWzRKamLQKG69eMpDoismnH7STLc6fF
        Y0NeLP4lgPAXAdOKrM+TTcqwWT2QJKHuMi6YCv+5yzPJ2XctVUoD/a8H/Mq4egqq
        kTycLqj3Xm4PRHEB5p2CLEwVVQUmzglRFZ0N8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XygxMllgVSKre5QkeAALstp9IW4mQK9f
        Mj/L4kMgeie6hMnHjMWaAn3zauDigOQwD9sxhcq9amKIOdjmJSQo/eGCGTaK5bPu
        05NhZ1F+NI71S/r8OILF0FKEe5K9Weg+qPyIYdH4IckTKn57FW1q3Yt8LPLCFWAD
        zaE9S77bqD4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A84BC62B60;
        Wed, 25 Jan 2017 14:32:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1815D62B5E;
        Wed, 25 Jan 2017 14:32:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 09/12] receive-pack: use oidset to de-duplicate .have lines
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
        <20170124004739.5aowmmkesbanyohm@sigill.intra.peff.net>
Date:   Wed, 25 Jan 2017 11:32:05 -0800
In-Reply-To: <20170124004739.5aowmmkesbanyohm@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 23 Jan 2017 19:47:39 -0500")
Message-ID: <xmqqefzraqbu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5176196-E334-11E6-9DB8-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If you have an alternate object store with a very large
> number of refs, the peak memory usage of the sha1_array can
> grow high, even if most of them are duplicates that end up
> not being printed at all.
> ...
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/receive-pack.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)

Nice.  

Incidentally, this also shows that the refnames in alternate ref
namespace will not matter.  We are to only show just one of many
anyway (and that name is masked and replaced with ".have").  Perhaps
we want to do 04/12 without refname?

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index b9f2c0cc5..27bb52988 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -21,6 +21,7 @@
>  #include "sigchain.h"
>  #include "fsck.h"
>  #include "tmp-objdir.h"
> +#include "oidset.h"
>  
>  static const char * const receive_pack_usage[] = {
>  	N_("git receive-pack <git-dir>"),
> @@ -271,27 +272,24 @@ static int show_ref_cb(const char *path_full, const struct object_id *oid,
>  	return 0;
>  }
>  
> -static int show_one_alternate_sha1(const unsigned char sha1[20], void *unused)
> +static void show_one_alternate_ref(const char *refname,
> +				   const struct object_id *oid,
> +				   void *data)
>  {
> -	show_ref(".have", sha1);
> -	return 0;
> -}
> +	struct oidset *seen = data;
>  
> -static void collect_one_alternate_ref(const char *refname,
> -				      const struct object_id *oid,
> -				      void *data)
> -{
> -	struct sha1_array *sa = data;
> -	sha1_array_append(sa, oid->hash);
> +	if (oidset_insert(seen, oid))
> +		return;
> +
> +	show_ref(".have", oid->hash);
>  }
>  
>  static void write_head_info(void)
>  {
> -	struct sha1_array sa = SHA1_ARRAY_INIT;
> +	static struct oidset seen = OIDSET_INIT;
>  
> -	for_each_alternate_ref(collect_one_alternate_ref, &sa);
> -	sha1_array_for_each_unique(&sa, show_one_alternate_sha1, NULL);
> -	sha1_array_clear(&sa);
> +	for_each_alternate_ref(show_one_alternate_ref, &seen);
> +	oidset_clear(&seen);
>  	for_each_ref(show_ref_cb, NULL);
>  	if (!sent_capabilities)
>  		show_ref("capabilities^{}", null_sha1);
