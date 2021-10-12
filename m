Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD29C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 23:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E153060F11
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 23:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbhJLXcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 19:32:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:38196 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhJLXcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 19:32:09 -0400
Received: (qmail 1975 invoked by uid 109); 12 Oct 2021 23:30:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Oct 2021 23:30:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20170 invoked by uid 111); 12 Oct 2021 23:30:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Oct 2021 19:30:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Oct 2021 19:30:05 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] config: include file if remote URL matches a glob
Message-ID: <YWYafdpemaiAjvUV@coredump.intra.peff.net>
References: <cover.1634077795.git.jonathantanmy@google.com>
 <967680d27aa7a2709e528ff989a9dd534886efba.1634077795.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <967680d27aa7a2709e528ff989a9dd534886efba.1634077795.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 12, 2021 at 03:57:23PM -0700, Jonathan Tan wrote:

> This is a feature that supports config file inclusion conditional on
> whether the repo has a remote with a URL that matches a glob.
> 
> Similar to my previous work on remote-suggested hooks [1], the main
> motivation is to allow remote repo administrators to provide recommended
> configs in a way that can be consumed more easily (e.g. through a
> package installable by a package manager). But this can also be used by,
> say, an individual that wants certain configs to apply to a certain set
> of local repos but not others.

OK. I was a little wary after reading the subject that this would be
"when we are using such a URL", which is full of all kinds of odd corner
cases. But if it is "a remote is defined with a matching URL" that makes
it a property of the repository, not the operation.

I think in general this kind of feature is currently served by just
correlating filesystem paths with their function. So with your patch I
could do:

  [includeIf "hasremoteurl:https://myjob.example.com"]
  path = foo.conf

But in general, I'd imagine most people put their repository in ~/work
or similar, and just do:

  [includeIf "gitdir:~/work"]
  path = foo.conf

(and of course you can imagine more subdivisions as necessary). So I
find the use-case only sort-of compelling. In general, I'm in favor of
adding new includeIf directions even if they're only moderately
convenient. But this one is rather sticky, because it is dependent on
other config keys being defined. So it introduces a new and complicated
ordering issue. Is it worth it? Maybe I'm not being imaginative enough
in seeing the use cases.

> I marked this as RFC because there are some design points that need to
> be resolved:
> 
>  - The existing "include" and "includeIf" instructions are executed
>    immediately, whereas in order to be useful, the execution of
>    "includeIf hasremoteurl" needs to be delayed until all config files
>    are read. Are there better ways to do this?

Note that this violates the "as if they had been found at the location
of the include directive" rule which we advertise to users. I'd imagine
that most of the time it doesn't matter, but this is a pretty big
exception we'll need to document.

Just brainstorming some alternatives:

  - We could stop the world while we are parsing and do a _new_ parse
    that just looks at the remote config (in fact, this is the natural
    thing if you were consulting the regular remote.c code for the list
    of remotes, because it does its own config parse).

    That does mean that the remote-conditional includes cannot
    themselves define new remotes. But I think that is already the case
    with your patch (and violating that gets you into weird circular
    problems).

  - We could simply document that if you want to depend on conditional
    includes based on a particular remote.*.url existing, then that
    remote config must appear earlier in the sequence.

    This is a bit ugly, because I'm sure it will bite somebody
    eventually. But at the same time, it resolves all of the weird
    timing issues, and does so in a way that will be easy to match if we
    have any other config dependencies.

>  - Is the conditionally-included file allowed to have its own
>    "include{,If}" instructions? I'm thinking that we should forbid it
>    because, for example, if we had 4 files as follows: A includes B and
>    C includes D, and we include A and C in our main config (in that
>    order), it wouldn't be clear whether B (because A was first included)
>    or C (because we should execute everything at the same depth first)
>    should be executed first. (In this patch, I didn't do anything about
>    includes.)

I'd say that A would expand B at the moment it is parsed, by the usual
as-if rule. If it has a recursive includeIf on remotes, then my head may
explode. I'd argue that we should refuse to do recursive remote-ifs in
that case (though all of this is a consequence of the after-the-fact
parsing; I'd much prefer one of the alternatives I gave earlier).

>  - A small one: the exact format of the glob. I probably will treat the
>    URL like a path.

You might want to use the matcher from urlmatch.[ch], which understands
things like wildcards. Of course remote "URLs" are not always real
syntactically valid URLs, which may make that awkward.

Barring that the usual fnmatch glob is probably our best bet.

> @@ -319,10 +331,18 @@ static int include_condition_is_true(const struct config_options *opts,
>  static int git_config_include(const char *var, const char *value, void *data)
>  {
>  	struct config_include_data *inc = data;
> +	const char *remote_name;
> +	size_t remote_name_len;
>  	const char *cond, *key;
>  	size_t cond_len;
>  	int ret;
>  
> +	if (!parse_config_key(var, "remote", &remote_name, &remote_name_len,
> +			      &key) &&
> +	    remote_name &&
> +	    !strcmp(key, "url"))
> +		string_list_append(&inc->remote_urls, value);

So we make a copy of every remote name on the off chance that somebody
has an includeIf which looks at it. That feels wasteful, though in
practice it's probably not that big a deal.

By doing the config parsing ourselves here we're missing out on any
other forms of remote, like .git/remotes. Those are old and not widely
used, and I'd be OK with skipping them. But we should clearly document
that this is matching remote.*.url, not any of the other mechanisms.

> [...]

I only lightly read the rest of the patch. I didn't see anything
obviously wrong, but I think the goal at this point is figuring out the
design.

-Peff
