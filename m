Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C18002013E
	for <e@80x24.org>; Sat,  4 Mar 2017 07:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbdCDHqo (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 02:46:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:38544 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750818AbdCDHqn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 02:46:43 -0500
Received: (qmail 21492 invoked by uid 109); 4 Mar 2017 07:39:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Mar 2017 07:39:54 +0000
Received: (qmail 4573 invoked by uid 111); 4 Mar 2017 07:40:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Mar 2017 02:40:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Mar 2017 02:39:53 -0500
Date:   Sat, 4 Mar 2017 02:39:53 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/9] Fix the early config
Message-ID: <20170304073952.drfgy7jacnlm6tum@sigill.intra.peff.net>
References: <cover.1488506615.git.johannes.schindelin@gmx.de>
 <cover.1488562287.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1488562287.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 06:31:55PM +0100, Johannes Schindelin wrote:

> Interdiff vs v2:
> [...]
>  +	 * When we are not about to create a repository ourselves (init or
>  +	 * clone) and when no .git/ directory was set up yet (in which case
>  +	 * git_config_with_options() would already have picked up the
>  +	 * repository config), we ask discover_git_directory() to figure out
>  +	 * whether there is any repository config we should use (but unlike
>  +	 * setup_git_directory_gently(), no global state is changed, most
>  +	 * notably, the current working directory is still the same after
>  +	 * the call).
>   	 */
>  -	if (!startup_info->creating_repository && !have_git_dir() &&
>  -	    discover_git_directory(&buf)) {
>  +	if (!have_git_dir() && discover_git_directory(&buf)) {

I think this "when we are not about to..." part of the comment is no
longer true, given the second part of the hunk.

>  @@ -721,8 +721,10 @@ static const char *setup_discovered_git_dir(const char *gitdir,
>   	if (offset == cwd->len)
>   		return NULL;
>   
>  -	/* Make "offset" point to past the '/', and add a '/' at the end */
>  -	offset++;
>  +	/* Make "offset" point past the '/' (already the case for root dirs) */
>  +	if (offset != offset_1st_component(cwd->buf))
>  +		offset++;

Nice. I was worried we would have to have a hacky "well, sometimes we
don't add one here..." code, but using offset_1st_component says
exactly what we mean.

> +/* Find GIT_DIR without changing the working directory or other global state */
>  extern const char *discover_git_directory(struct strbuf *gitdir);

The parts that actually confused me were the parameters (mostly whether
gitdir was a directory to start looking in, or an output parameter). So
maybe:

  /*
   * Find GIT_DIR of the repository that contains the current working
   * directory, without changing the working directory or other global
   * state. The result is appended to gitdir. The return value is NULL
   * if no repository was found, or gitdir->buf otherwise.
   */

This looks good to me aside from those few comment nits. I'm still not
sure I understand how ceil_offset works in setup_git_directory_gently_1(),
but I don't think your patch actually changed it. I can live with my
confusion.

-Peff
