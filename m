Return-Path: <SRS0=2Qsv=4E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTTP_EXCESSIVE_ESCAPES,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BB7C3B1BF
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 06:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCC320857
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 06:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgBPGNZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 01:13:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:45042 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725816AbgBPGNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 01:13:25 -0500
Received: (qmail 32115 invoked by uid 109); 16 Feb 2020 06:13:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Feb 2020 06:13:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 998 invoked by uid 111); 16 Feb 2020 06:22:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 16 Feb 2020 01:22:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 16 Feb 2020 01:13:23 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] credential: allow wildcard patterns when matching
 config
Message-ID: <20200216061323.GA2397568@coredump.intra.peff.net>
References: <20200214225929.541306-1-sandals@crustytoothpaste.net>
 <20200214225929.541306-4-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214225929.541306-4-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 14, 2020 at 10:59:29PM +0000, brian m. carlson wrote:

> From: brian m. carlson <bk2204@github.com>
> 
> In some cases, a user will want to use a specific credential helper for
> a wildcard pattern, such as https://*.corp.example.com. Use the urlmatch
> code to match a pattern for a URL to allow this behavior.
> 
> Since we are handling URLs using urlmatch, remove the custom code to
> match URLs, since it is no longer needed.

I think it's a good idea to unify the matching for these two subsystems
if we can.  Playing devil's advocate for a moment:

 - are there cases that would have matched before that won't now?
   Basic stuff like:

     echo url=https://example.com/foo |
     GIT_TERMINAL_PROMPT=0 git \
       -c credential.https://example.com/foo.helper='!echo >&2 full helper' \
       -c credential.https://example.com/fo.helper='!echo >&2 partial helper' \
       credential fill

   seems to behave the same (we respect only the full match both before
   and after your patch). I wondered if we might run into problems
   matching usernames. But this:

     echo url=https://user@example.com/ |
     GIT_TERMINAL_PROMPT=0 git \
       -c credential.https://example.com.helper='!echo >&2 bare helper' \
       -c credential.https://user@example.com.helper='!echo >&2 user helper' \
       credential fill

   seems to be behave the same both before and after (it runs both
   helpers). And this:

     echo url=https://example.com/ |
     GIT_TERMINAL_PROMPT=0 git \
       -c credential.https://example.com.helper='!echo >&2 bare helper' \
       -c credential.https://user@example.com.helper='!echo >&2 user helper' \
       credential fill

   likewise behaves the same before and after, running only the bare
   helper (I think we _could_ match the user-helper by doing a second
   pass over the config after getting the username from config, from
   another helper, or from the user, but I doubt anybody is clamoring
   for that feature).

   So I think we're OK here, unless you can come up with any more
   obscure case.

 - are there cases that match now that didn't before? Those are a bit
   dangerous become they may mean unexpectedly sharing credentials with
   hosts the user didn't mean to.

   Obviously anything with a "*" in it will behave differently, but I
   think that's OK (i.e,. I doubt anybody wrote "*" in a hostname and
   didn't mean it for it to glob).

   One interesting one is that the credential code currently requires a
   full path match instead of a prefix match. So:

     echo url=https://example.com/foo/bar |
     GIT_TERMINAL_PROMPT=0 git \
       -c credential.https://example.com/foo.helper='!echo >&2 run helper' \
       credential fill

   doesn't currently trigger the helper, but does with your patch. I
   think this is _probably_ OK. I think the existing behavior was done
   to just always err on the side of strictness in matching, with the
   thought that nobody cared that much about path matching anyway (by
   default we ignore the paths completely).

 - The rules for ordering are a bit different, in that the credential
   code takes any matches in the order in which they appear in the
   config file. Whereas urlmatch won't pass on any less-specific
   matches. So doing:

     echo url=https://example.com/foo |
     GIT_TERMINAL_PROMPT=0 git \
       -c credential.https://example.com/foo.helper='!echo >&2 path helper' \
       -c credential.https://example.com.helper='!echo >&2 bare-domain helper' \
       credential fill

   right now will trigger both helpers (path then bare-domain), but
   after your patch will just trigger the path helper. Curiously, if you
   flip the order of the two config keys, it will still run both. That's
   because urlmatch assumes that the receiver is handling the "last one
   wins" semantics, but the credential code is actually building a list
   of helpers.

   Weirder still, the current strategy for single-valued items like
   credential.*.username is "first one wins". So:

     echo url=https://example.com/foo |
     git \
       -c credential.https://example.com.username=domain-user \
       -c credential.https://example.com/foo.username=path-user \
       credential fill

   will prompt for the password of domain-user, but flipping it will ask
   for path-user. Which seems...weird. That actually doesn't change with
   your patch, because we'll either send both to the credential callback
   (in the order above) or we'd just send the first one (if the order is
   flipped).

   I'd be in favor of changing that to the usual "last one wins",
   because it makes no sense and is unlike the rest of Git's config.
   However, I think the reason it's written that way is so that:

     echo url=https://foo@example.com |
     git \
       -c credential.https://example.com.username=bar \
       credential fill

   still takes the username=foo from the command-line. We'd want to take
   care not to break that case, which implies remembering whether
   c->username came from a previous config value, or was part of the
   initial credential lookup.

   That doesn't _technically_ have to be part of your patch, because
   your patch doesn't make it any worse than it is now. But it would be
   nice to cleanup (since urlmatch gives us nice "most specific wins"
   semantics).

   But I do think we need to deal with the helper-list behavior as part
   of your patch, because it _does_ regress. And while the example above
   is probably fairly contrived, I think urlmatch is responsible for
   matching credential.helper, too (as the least specific possible
   match), and it's not outrageous to have something like:

     [credential]
     helper = cache
     [credential "https://example.com"]
     helper = !some-host-specific-helper

   Some options are:

     - teach urlmatch to pass matching config keys to our callback even
       if they're "worse" than a previously-seen key, so that we can
       then record all helpers in the order they appear in the config
       (retaining the existing behavior)

     - use urlmatch's cmp_matches() to order the list of helper. This
       would be a change in behavior, but I wonder if it might be what
       people prefer. I suspect it would make some happy (if the
       host-specific helper can answer the query above, you'd just as
       soon not run the cache helper at all) and others not (if the
       host-specific one is expensive or requires user interaction, you
       may want to try the cache first). So I'm not sure if it would be
       a good idea or not.

A few comments on the patch itself:

> --- a/Documentation/gitcredentials.txt
> +++ b/Documentation/gitcredentials.txt
> @@ -131,7 +131,9 @@ context would not match:
>  because the hostnames differ. Nor would it match `foo.example.com`; Git
>  compares hostnames exactly, without considering whether two hosts are part of
>  the same domain. Likewise, a config entry for `http://example.com` would not
> -match: Git compares the protocols exactly.
> +match: Git compares the protocols exactly.  However, you may use wildcards in
> +the domain name and other pattern matching techniques as with the `http.<url>.*`
> +options.

You'd probably want to review the documentation to accommodate any of
the behavior changes discussed above that we end up with.

>  static void credential_apply_config(struct credential *c)
>  {
> +	char *normalized_url;
> +	struct urlmatch_config config = { STRING_LIST_INIT_DUP };

Here we initialize a string_list, but I don't think we ever free it. It
looks like the urlmatch_config_entry() callback will stash items here
for its "more specific match" checks.

I think we need:

  string_list_clear(&config.vars, 1);

which builtin/config.c:get_urlmatch() does. It also seems to free
config.url.url, which is touched by the normalization process. I _think_
this is always the same as the return value normalized_url, so we'd be
OK there.

> +	config.section = "credential";
> +	config.key = NULL;
> +	config.collect_fn = credential_config_callback;
> +	config.cascade_fn = git_default_config;
> +	config.cb = c;

I don't think the old code would ever call git_default_config (we _just_
want to load values for this specific URL). So I think you'd want to
leave the cascade_fn NULL here?

> +	credential_describe(c, &url);
> +	normalized_url = url_normalize(url.buf, &config.url);

The purpose of credential_describe() so far has been to show the URL to
the user. It won't do any %-encoding that would be required for more
exotic URLs. But I assume we'd want that in whatever we feed to
url_normalize. So for example:

  echo url=https://example.com/%2566 |
  GIT_TERMINAL_PROMPT=0 git \
    -c credential.https://example.com/%2566.helper='!echo >&2 run helper'
    credential fill

matches in the current code, but not after your patch (we decode %25
into just "%", and then feed "%66" to the url normalizer, which decodes
it to "f".

-Peff
