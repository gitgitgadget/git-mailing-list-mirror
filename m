Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDA562098B
	for <e@80x24.org>; Wed, 19 Oct 2016 15:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S945288AbcJSPlC (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 11:41:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:59458 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S943609AbcJSPlA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 11:41:00 -0400
Received: (qmail 6422 invoked by uid 109); 19 Oct 2016 09:10:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 09:10:45 +0000
Received: (qmail 11280 invoked by uid 111); 19 Oct 2016 09:11:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 05:11:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Oct 2016 05:10:44 -0400
Date:   Wed, 19 Oct 2016 05:10:44 -0400
From:   Jeff King <peff@peff.net>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v4 5/7] builtin/tag: add --format argument for tag -v
Message-ID: <20161019091044.k3ewbfxjj6ihv5o5@sigill.intra.peff.net>
References: <20161007210721.20437-1-santiago@nyu.edu>
 <20161007210721.20437-6-santiago@nyu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161007210721.20437-6-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 07, 2016 at 05:07:19PM -0400, santiago@nyu.edu wrote:

> Adding --format to git tag -v mutes the default output of the GPG
> verification and instead prints the formatted tag object.

The same comments apply to "mutes" here, as to the previous patch (which
is to say I think we may want something more, but this is probably OK
for now).

> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 7ecca8e..3bb5e3c 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -15,7 +15,7 @@ SYNOPSIS
>  'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
>  	[--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>]
>  	[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]
> -'git tag' -v <tagname>...
> +'git tag' -v [--format=<format>] <tagname>...

Just thinking out loud, but if we had ref-filter placeholders that
triggered GPG verification, you could do this all with the listing mode,
like:

  git tag --format='%(gpgstatus) %(tag) %(refname:short)'

and verify multiple tags (or give a single tag to limit it to just one).

I don't think that's any kind of blocker for this series. We already
have "-v", and adding --format to it is reasonable, even if we
eventually move to a world where people can use the listing mode. Like I
said, just thinking out loud.

> +static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
> +		void *cb_data)
>  {
>  	const char **p;
>  	char ref[PATH_MAX];
>  	int had_error = 0;
>  	unsigned char sha1[20];
>  
> +
>  	for (p = argv; *p; p++) {

Extra space?

>  static int verify_tag(const char *name, const char *ref,
> -				const unsigned char *sha1)
> +				const unsigned char *sha1, void *cb_data)
>  {
> -	return verify_and_format_tag(sha1, name, NULL, GPG_VERIFY_VERBOSE);
> +	int flags;

Probably doesn't matter much, but these flags are defined as "unsigned"
elsewhere.

-Peff
