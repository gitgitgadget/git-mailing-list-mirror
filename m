Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A658F1FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 10:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbdFJKHe (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 06:07:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:37608 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751890AbdFJKHd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 06:07:33 -0400
Received: (qmail 9658 invoked by uid 109); 10 Jun 2017 10:07:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 10:07:32 +0000
Received: (qmail 30310 invoked by uid 111); 10 Jun 2017 10:07:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 06:07:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Jun 2017 06:07:30 -0400
Date:   Sat, 10 Jun 2017 06:07:30 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 8/8] Use the early config machinery to expand aliases
Message-ID: <20170610100730.j62kh2hayt6zknr5@sigill.intra.peff.net>
References: <cover.1496951503.git.johannes.schindelin@gmx.de>
 <af40ce088de03130a5edfae187bb8274b5a9d3a9.1496951503.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af40ce088de03130a5edfae187bb8274b5a9d3a9.1496951503.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 08, 2017 at 09:53:53PM +0200, Johannes Schindelin wrote:

> @@ -245,36 +201,37 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  
>  static int handle_alias(int *argcp, const char ***argv)
>  {
> +	struct strbuf cdup_dir = STRBUF_INIT;
>  	int envchanged = 0, ret = 0, saved_errno = errno;
>  	int count, option_count;
>  	const char **new_argv;
>  	const char *alias_command;
>  	char *alias_string;
> -	int unused_nongit;
> -
> -	save_env_before_alias();
> -	setup_git_directory_gently(&unused_nongit);
>  
>  	alias_command = (*argv)[0];
> -	alias_string = alias_lookup(alias_command, NULL);
> +	alias_string = alias_lookup(alias_command, &cdup_dir);
>  	if (alias_string) {
>  		if (alias_string[0] == '!') {
>  			struct child_process child = CHILD_PROCESS_INIT;
>  
> +			if (cdup_dir.len)
> +				setup_git_directory();
> +

I'm really confused here. We went to all the trouble to record the
cdup_dir as part of the alias lookup so that we could make sure to
chdir() to it. But we don't seem to ever look at its value. We just use
it as a proxy for "did we find a git-dir". And if we did, we go to all
the trouble to re-discover it via setup_git_directory().

I understand why you must use setup_git_directory() and not just a
chdir(), because the latter sets up variables like GIT_PREFIX and
GIT_DIR that the shell alias may be depending on.

But couldn't we just unconditionally do:

  setup_git_directory_gently();

here to move into the top-level if there is one, without caring about
cdup_dir at all?

That should be equally correct. It does do an extra discovery when we
already know that there isn't a gitdir at all. But my earlier comments
about optimizing apply (measure, and possibly cache). And in the common
case that we are in a repo, it's exactly the same, since the setup call
here would re-discover from scratch (though again, if we care, caching
could solve that).

-Peff
