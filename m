Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F9C4207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 16:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422693AbcIZQhP (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 12:37:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53164 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753556AbcIZQhO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 12:37:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0964941AAD;
        Mon, 26 Sep 2016 12:37:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=us3SStMVdlNaAltldayudDWkboo=; b=Qd51Ko
        tlhmdDdMr3gnzGA2T58m2AAtZtOuOr8huyAbvu3AFb6Jhmu5JNCl5bYMxUg0Nv9C
        DdViosX64usbVVbQiC8RS0THVFO8ORyYXgJ+noJ6Vm5hfoowvTt+vx8s2bWmcJgm
        b7s8hhV3PttXry3h8hAYxS1U3U6rsPLrSARew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hWcSGyTG6wKeYWBgxjHhNBRJR3a4Qx1W
        hdvKV6RA+/lETW6eJ5O6J+3fWG0yJqL4sFC+Tk/eGZoGO8Lt8KUhGlqh6i9UGy11
        B/BTBTy7fYggvNqswTh1A8xMBAZ4k9KhaVAwguv0VRgMq9PyzeRNAghmIUFzWJ7l
        adL+EJRwyyI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01F8F41AAC;
        Mon, 26 Sep 2016 12:37:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7F4EB41AAB;
        Mon, 26 Sep 2016 12:37:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 01/10] get_sha1: detect buggy calls with multiple disambiguators
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
        <20160926115901.txmbr4e6xzwyfpmo@sigill.intra.peff.net>
Date:   Mon, 26 Sep 2016 09:37:10 -0700
In-Reply-To: <20160926115901.txmbr4e6xzwyfpmo@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 26 Sep 2016 07:59:01 -0400")
Message-ID: <xmqqbmzavcqx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79DA1C76-8407-11E6-918E-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The get_sha1() family of functions takes a flags field, but
> some of the flags are mutually exclusive. In particular, we
> can only handle one disambiguating function, and the flags
> quietly override each other. Let's instead detect these as
> programming bugs.
>
> Technically some of the flags are supersets of the others,
> so treating COMMITTISH|TREEISH as just COMMITTISH is not
> wrong, but it's a good sign the caller is confused. And
> certainly asking for BLOB|TREE does not work.
>
> We can do the check easily with some bit-twiddling, and as a
> bonus, the bit-mask of disambiguators will come in handy in
> a future patch.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Other than your reinvention of HAS_MULTI_BITS(), which has been with
us since db7244bd ("parse-options new features.", 2007-11-07), this
looks like a reasonable thing to do.

;-)

>  cache.h     | 5 +++++
>  sha1_name.c | 9 +++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/cache.h b/cache.h
> index d0494c8..7bd78ca 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1203,6 +1203,11 @@ struct object_context {
>  #define GET_SHA1_FOLLOW_SYMLINKS 0100
>  #define GET_SHA1_ONLY_TO_DIE    04000
>  
> +#define GET_SHA1_DISAMBIGUATORS \
> +	(GET_SHA1_COMMIT | GET_SHA1_COMMITTISH | \
> +	GET_SHA1_TREE | GET_SHA1_TREEISH | \
> +	GET_SHA1_BLOB)
> +
>  extern int get_sha1(const char *str, unsigned char *sha1);
>  extern int get_sha1_commit(const char *str, unsigned char *sha1);
>  extern int get_sha1_committish(const char *str, unsigned char *sha1);
> diff --git a/sha1_name.c b/sha1_name.c
> index faf873c..f9812ff 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -310,6 +310,11 @@ static int prepare_prefixes(const char *name, int len,
>  	return 0;
>  }
>  
> +static int multiple_bits_set(unsigned flags)
> +{
> +	return !!(flags & (flags - 1));
> +}
> +
>  static int get_short_sha1(const char *name, int len, unsigned char *sha1,
>  			  unsigned flags)
>  {
> @@ -327,6 +332,10 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
>  	prepare_alt_odb();
>  
>  	memset(&ds, 0, sizeof(ds));
> +
> +	if (multiple_bits_set(flags & GET_SHA1_DISAMBIGUATORS))
> +		die("BUG: multiple get_short_sha1 disambiguator flags");
> +
>  	if (flags & GET_SHA1_COMMIT)
>  		ds.fn = disambiguate_commit_only;
>  	else if (flags & GET_SHA1_COMMITTISH)
