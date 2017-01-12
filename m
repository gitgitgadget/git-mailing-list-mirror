Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 373D31FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 21:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750973AbdALVkg (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 16:40:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60240 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750806AbdALVkf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 16:40:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A80995F75E;
        Thu, 12 Jan 2017 16:40:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YQZBHkw7omo4s7v8TsnhrhKXtyk=; b=bPRTPz
        Eezfixix22Y2dwSBu7J37vjI2e1UlxEs+Lftp5WVUo7cM1k8JygRJH19Oy6nmBlW
        JXWLjQ2zUojoFCPfpFcLxRYs8oDvSzGycOQgWLyYvEnBvor20JgEmIvY8LZoetVC
        sGMaFmo0s7KJvlMVpweBqFbq/ihA2x2880xYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UBNixI12FS+zzpQ+xAINSi4Dgbt/Twr4
        ZXowbw0nHBpjpCM2lVjvLStO6JJI8ZbjJUrUT4O1GsuMqzvNt3iuQJzsQ13LHyyy
        nrzNkj2A4M5G9olP9cLalbIcfruX8iFCus05qPxAY1DAlkqQX9Er8OFCXd1p9/HT
        MyorcJ2wiug=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E5555F75D;
        Thu, 12 Jan 2017 16:40:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F1F95F75B;
        Thu, 12 Jan 2017 16:40:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org
Subject: Re: [PATCHv2 4/4] unpack-trees: support super-prefix option
References: <xmqq37gpnuyi.fsf@gitster.mtv.corp.google.com>
        <20170112001253.27679-1-sbeller@google.com>
Date:   Thu, 12 Jan 2017 13:40:32 -0800
In-Reply-To: <20170112001253.27679-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 11 Jan 2017 16:12:53 -0800")
Message-ID: <xmqqtw94hs8f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF6E2B26-D90F-11E6-A6DE-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This is only patchv4 that is rerolled, patches 1-3 remain as is.

Good timing, as I was about to send a reminder to suggest rerolling
4/4 alone ;-)

> +static const char *super_prefixed(const char *path)
> +{

There used to be a comment that explains why we keep two static
buffers around here.  Even though it is in the log message, the
in-code comment would save people trouble of having to go through
"git blame" output.

I'd say something like

	/*
	 * It is necessary and sufficient to have two static buffers
	 * as the return value of this function is fed to error()
	 * using the unpack_*_errors[] templates we can see above.
	 */

perhaps.

> +	static struct strbuf buf[2] = {STRBUF_INIT, STRBUF_INIT};
> +	static int super_prefix_len = -1;
> +	static unsigned idx = 0;
> +

If we initialize this to 1 (or even better, "ARRAY_SIZE(buf) - 1"),
then we would use buf[0] first and then buf[1], which feels more
natural to me.

Other than that, this looks OK.  Will queue.

Thanks.

> +	if (super_prefix_len < 0) {
> +		if (!get_super_prefix())
> +			super_prefix_len = 0;
> +		else {
> +			int i;
> +
> +			super_prefix_len = strlen(get_super_prefix());
> +			for (i = 0; i < ARRAY_SIZE(buf); i++)
> +				strbuf_addstr(&buf[i], get_super_prefix());
> +		}
> +	}
> +
> +	if (!super_prefix_len)
> +		return path;
> +
> +	if (++idx >= ARRAY_SIZE(buf))
> +		idx = 0;
> +
> +	strbuf_setlen(&buf[idx], super_prefix_len);
> +	strbuf_addstr(&buf[idx], path);
> +
> +	return buf[idx].buf;
> +}
> +
>  void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
>  				  const char *cmd)
>  {
> @@ -172,7 +202,7 @@ static int add_rejected_path(struct unpack_trees_options *o,
>  			     const char *path)
>  {
>  	if (!o->show_all_errors)
> -		return error(ERRORMSG(o, e), path);
> +		return error(ERRORMSG(o, e), super_prefixed(path));
>  
>  	/*
>  	 * Otherwise, insert in a list for future display by
> @@ -196,7 +226,7 @@ static void display_error_msgs(struct unpack_trees_options *o)
>  			something_displayed = 1;
>  			for (i = 0; i < rejects->nr; i++)
>  				strbuf_addf(&path, "\t%s\n", rejects->items[i].string);
> -			error(ERRORMSG(o, e), path.buf);
> +			error(ERRORMSG(o, e), super_prefixed(path.buf));
>  			strbuf_release(&path);
>  		}
>  		string_list_clear(rejects, 0);
> @@ -1918,7 +1948,9 @@ int bind_merge(const struct cache_entry * const *src,
>  			     o->merge_size);
>  	if (a && old)
>  		return o->gently ? -1 :
> -			error(ERRORMSG(o, ERROR_BIND_OVERLAP), a->name, old->name);
> +			error(ERRORMSG(o, ERROR_BIND_OVERLAP),
> +			      super_prefixed(a->name),
> +			      super_prefixed(old->name));
>  	if (!a)
>  		return keep_entry(old, o);
>  	else
