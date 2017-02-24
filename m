Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7735201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 20:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbdBXUjp (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 15:39:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:33567 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbdBXUjo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 15:39:44 -0500
Received: (qmail 10970 invoked by uid 109); 24 Feb 2017 20:39:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 20:39:43 +0000
Received: (qmail 17260 invoked by uid 111); 24 Feb 2017 20:39:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 15:39:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2017 15:39:41 -0500
Date:   Fri, 24 Feb 2017 15:39:41 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] refs: parse_hide_refs_config to use parse_config_key
Message-ID: <20170224203940.hbmfsouw5k67l3h3@sigill.intra.peff.net>
References: <20170224203335.3762-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170224203335.3762-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 12:33:35PM -0800, Stefan Beller wrote:

> parse_config_key was introduced in 1b86bbb0ade (config: add helper
> function for parsing key names, 2013-01-22), the NEEDSWORK that is removed
> in this patch was introduced at daebaa7813 (upload/receive-pack: allow
> hiding ref hierarchies, 2013-01-18), which is only a couple days apart,
> so presumably the code replaced in this patch was only introduced due
> to not wanting to wait on the proper helper function being available.
> 
> Make the condition easier to read by using parse_config_key.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
>   When investigating the state of the art for parsing config options, I saw
>   opportunity for a small drive-by patch in an area that I did not look at for 
>   a long time.
>   
>   The authors of the two mentioned commits are Jeff and Junio, so maybe you
>   remember another reason for this NEEDSWORK here?

No, I think the reasoning you gave in the commit message is exactly
what happened.

> diff --git a/refs.c b/refs.c
> index cd36b64ed9..c9e5f13630 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1034,10 +1034,11 @@ static struct string_list *hide_refs;
>  
>  int parse_hide_refs_config(const char *var, const char *value, const char *section)
>  {
> +	const char *subsection, *key;
> +	int subsection_len;
>  	if (!strcmp("transfer.hiderefs", var) ||
> -	    /* NEEDSWORK: use parse_config_key() once both are merged */
> -	    (starts_with(var, section) && var[strlen(section)] == '.' &&
> -	     !strcmp(var + strlen(section), ".hiderefs"))) {
> +	    (!parse_config_key(var, section, &subsection, &subsection_len, &key)
> +	    && !strcmp(key, "hiderefs"))) {

This will start parsing "receive.foobar.hiderefs", which we don't want.
I think you need:

  !parse_config_key(var, section, &subsection, &subsection_len, &key) &&
  !subsection &&
  !strcmp(key, "hiderefs")

Perhaps passing NULL for the subsection variable should cause
parse_config_key to return failure when there is a non-empty subsection.

-Peff

PS Outside of parse_config_key, this code would be nicer if it used
   skip_prefix() instead of starts_with(). Since it's going away, I
   don't think it matters, but I note that parse_config_key could
   probably benefit from the same.
