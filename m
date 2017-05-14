Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C08C7201A4
	for <e@80x24.org>; Sun, 14 May 2017 14:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbdENOnS (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 10:43:18 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:36137 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdENOnR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 10:43:17 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Sun, 14 May 2017 16:44:10 +0200
  id 0000000000000092.0000000059186D3A.00004ABD
Date:   Sun, 14 May 2017 16:43:15 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     "=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 4/7] grep: add support for the PCRE v1 JIT API
Message-ID: <20170514144315.w46t7iggp7yeqn4n@ruderich.org>
References: <20170513234535.12749-1-avarab@gmail.com>
 <20170513234535.12749-5-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170513234535.12749-5-avarab@gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 13, 2017 at 11:45:32PM +0000, Ævar Arnfjörð Bjarmason wrote:
> [snip]
>
> +#ifdef PCRE_CONFIG_JIT
> +	if (p->pcre1_jit_on)
> +		ret = pcre_jit_exec(p->pcre1_regexp, p->pcre1_extra_info, line,
> +				    eol - line, 0, flags, ovector,
> +				    ARRAY_SIZE(ovector), p->pcre1_jit_stack);
> +	else
> +		ret = pcre_exec(p->pcre1_regexp, p->pcre1_extra_info, line,
> +				eol - line, 0, flags, ovector,
> +				ARRAY_SIZE(ovector));
> +#else
>  	ret = pcre_exec(p->pcre1_regexp, p->pcre1_extra_info, line, eol - line,
>  			0, flags, ovector, ARRAY_SIZE(ovector));
> +#endif

Wouldn't it be simpler to remove the duplication and
unconditionally use the old pcre_exec() call? Something like
this:

    +#ifdef PCRE_CONFIG_JIT
    +	if (p->pcre1_jit_on)
    +		ret = pcre_jit_exec(p->pcre1_regexp, p->pcre1_extra_info, line,
    +				    eol - line, 0, flags, ovector,
    +				    ARRAY_SIZE(ovector), p->pcre1_jit_stack);
    +	else
    +#endif
     	ret = pcre_exec(p->pcre1_regexp, p->pcre1_extra_info, line, eol - line,
     			0, flags, ovector, ARRAY_SIZE(ovector));

>  	if (ret < 0 && ret != PCRE_ERROR_NOMATCH)
>  		die("pcre_exec failed with error code %d", ret);
>  	if (ret > 0) {
> @@ -394,7 +420,16 @@ static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
>  static void free_pcre1_regexp(struct grep_pat *p)
>  {
>  	pcre_free(p->pcre1_regexp);
> +#ifdef PCRE_CONFIG_JIT
> +	if (p->pcre1_jit_on) {
> +		pcre_free_study(p->pcre1_extra_info);
> +		pcre_jit_stack_free(p->pcre1_jit_stack);
> +	} else {
> +		pcre_free(p->pcre1_extra_info);
> +	}
> +#else
>  	pcre_free(p->pcre1_extra_info);
> +#endif

Same here. The pcre_free() is the same with and without the
ifdef.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
