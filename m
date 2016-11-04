Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 804D32022D
	for <e@80x24.org>; Fri,  4 Nov 2016 23:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbcKDXGS (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 19:06:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:38917 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752089AbcKDXGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 19:06:16 -0400
Received: (qmail 21173 invoked by uid 109); 4 Nov 2016 23:06:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Nov 2016 23:06:16 +0000
Received: (qmail 27212 invoked by uid 111); 4 Nov 2016 23:06:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Nov 2016 19:06:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Nov 2016 19:06:13 -0400
Date:   Fri, 4 Nov 2016 19:06:13 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v3] transport: add protocol policy config option
Message-ID: <20161104230613.epbziphiqyl57bcn@sigill.intra.peff.net>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <1478292933-7873-1-git-send-email-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1478292933-7873-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2016 at 01:55:33PM -0700, Brandon Williams wrote:

> Previously the `GIT_ALLOW_PROTOCOL` environment variable was used to
> specify a whitelist of protocols to be used in clone/fetch/pull
> commands.  This patch introduces new configuration options for more
> fine-grained control for allowing/disallowing protocols.  This also has
> the added benefit of allowing easier construction of a protocol
> whitelist on systems where setting an environment variable is
> non-trivial.

Good rationale.

> Now users can specify a policy to be used for each type of protocol via
> the 'protocol.<name>.allow' config option.  A default policy for all
> unknown protocols can be set with the 'protocol.allow' config option.

I think "unconfigured" is a better word here than "unknown", as it would
apply to known protocols like "https", etc.

That made me wonder if "unknown" would be a better behavior, but I'm
pretty sure it is not. It is harder to explain, and I think would be
less convenient in practice. I.e., you really do want:

  git config protocol.allow never
  git config protocol.https.allow always

to allow nothing but https.

> If no user configured default is made git, by default, will allow
> known-safe protocols (http, https, git, ssh, file), disallow
> known-dangerous protocols (ext), and have a default poliy of `user` for
> all other protocols.

I think this is a good way of thinking about it. The order of
enforcement becomes:

  - GIT_ALLOW_PROTOCOL; environment variables always take precedence
    over config, so this makes sense. And it also is nice to put the
    blunt hammer at the front for backwards-compatibility.

  - protocol-specific config

  - protocol-generic config

  - built-in defaults (known-safe, known-scary, unknown)

which seems right.

Also, s/poliy/policy/.

> The supported policies are `always`, `never`, and `user`.  The `user`
> policy can be used to configure a protocol to be usable when explicitly
> used by a user, while disallowing it for commands which run
> clone/fetch/pull commands without direct user intervention (e.g.
> recursive initialization of submodules).  Commands which can potentially
> clone/fetch/pull from untrusted repositories without user intervention
> can export `GIT_PROTOCOL_FROM_USER` with a value of '0' to prevent
> protocols configured to the `user` policy from being used.

Makes sense. I know "user" came from me. I don't know if there is a
better word to describe it. I originally called it "cmdline", but that
seemed too obscure (especially when a tool external to git sets it).
Something like "trusted" might make sense (we allow it only in a
more-trusted setting), but it's kind of vague. And it also doesn't leave
room for there to be more types of trust in the future. So "user" is
probably reasonable (or perhaps "user-only" or similar).

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 27069ac..5d845c4 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2308,6 +2308,31 @@ pretty.<name>::
>  	Note that an alias with the same name as a built-in format
>  	will be silently ignored.
>  
> +protocol.allow::
> +	If set, provide a user defined default policy for all protocols which
> +	don't explicitly have a policy (protocol.<name>.allow).  By default,
> +	if unset, known-safe protocols (http, https, git, ssh, file) have a
> +	default policy of `always`, known-dangerous protocols (ext) have a
> +	default policy of `never`, and all other protocols have a default policy
> +	of `user`.  Supported policies:
> ++
> +--
> +
> +* `always` - protocol is always able to be used.
> +
> +* `never` - protocol is never able to be used.
> +
> +* `user` - protocol is only able to be used when `GIT_PROTOCOL_FROM_USER` is
> +  either unset or has a value of 1.  This policy should be used when you want a
> +  protocol to be usable by the user but don't want it used by commands which
> +  execute clone/fetch/pull commands without user input, e.g. recursive
> +  submodule initialization.

Makes sense. I wonder if it would be good to emphasize _directly_ usable
here. I.e., "...when you want a protocol to be directly usable by the
user but don't want...".

Should clone/fetch/pull also include push?

> +protocol.<name>.allow::
> +	Set a policy to be used by protocol <name> with clone/fetch/pull commands.
> +

Nice that this matches protocol.allow, so we don't need to re-explain
that.

Should the list of protocols be here? I know they're covered under
GIT_ALLOW_PROTOCOL already, but if this is the preferred system, we
should probably explain them here, and then just have GIT_ALLOW_PROTOCOL
refer the user.

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index ab7215e..ab25580 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -1150,13 +1150,13 @@ of clones and fetches.
>  	cloning a repository to make a backup).
>  
>  `GIT_ALLOW_PROTOCOL`::
> -	If set, provide a colon-separated list of protocols which are
> -	allowed to be used with fetch/push/clone. This is useful to
> -	restrict recursive submodule initialization from an untrusted
> -	repository. Any protocol not mentioned will be disallowed (i.e.,
> -	this is a whitelist, not a blacklist). If the variable is not
> -	set at all, all protocols are enabled.  The protocol names
> -	currently used by git are:
> +	The new way to configure allowed protocols is done through the config
> +	interface, though this setting takes precedences.  See
> +	linkgit:git-config[1] for more details.  If set, provide a
> +	colon-separated list of protocols which are allowed to be used with
> +	fetch/push/clone.  Any protocol not mentioned will be disallowed (i.e.,
> +	this is a whitelist, not a blacklist).  The protocol names currently
> +	used by git are:

I wonder if we can explain this in terms of the config system. Something
like:

  If set to a colon-separated list of zero or more protocols, behave as
  if `protocol.allow` is set to `never`, and each of the listed
  protocols has `protocol.$protocol.allow` set to `always`.

> +`GIT_PROTOCOL_FROM_USER`::
> +	Set to 0 to prevent protocols used by fetch/push/clone which are
> +	configured to the `user` state.  This is useful to restrict recursive
> +	submodule initialization from an untrusted repository.  See
> +	linkgit:git-config[1] for more details.

Under "this is useful", it may make sense to make it clear that external
programs can use this, too. Something like:

  It may also be useful for programs which feed potentially-untrusted
  URLs to git commands.

> diff --git a/t/lib-proto-disable.sh b/t/lib-proto-disable.sh
> index b0917d9..5950fbf 100644
> --- a/t/lib-proto-disable.sh
> +++ b/t/lib-proto-disable.sh
> @@ -1,15 +1,12 @@
>  # Test routines for checking protocol disabling.
>  
> -# test cloning a particular protocol
> -#   $1 - description of the protocol
> -#   $2 - machine-readable name of the protocol
> -#   $3 - the URL to try cloning
> -test_proto () {
> +# Test clone/fetch/push with GIT_ALLOW_PROTOCOL whitelist
> +test_whitelist () {
>  	desc=$1
>  	proto=$2
>  	url=$3
>  
> -	test_expect_success "clone $1 (enabled)" '
> +	test_expect_success "clone $desc (enabled)" '

Yeah, this should have been $desc all along. It makes the diff really
noisy, though. Should it be split out into a preparatory change?

> +# test cloning a particular protocol
> +#   $1 - description of the protocol
> +#   $2 - machine-readable name of the protocol
> +#   $3 - the URL to try cloning
> +test_proto () {
> +	test_whitelist "$@"
> +
> +	test_config "$@"
> +}

This makes sense. It's probably more testing than we actually need. We
could just check the config version per-protocol, and then confirm that
GIT_ALLOW_PROTOCOL behaves as I described above for at least one
protocol. The per-protocol code paths are really just making sure that
the protocol is correctly named for each code path.

That being said, simple and stupid test setup is nice as long as it does
not take too long to run.

> diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
> index bc44ac3..75c570a 100755
> --- a/t/t5509-fetch-push-namespaces.sh
> +++ b/t/t5509-fetch-push-namespaces.sh
> @@ -4,6 +4,7 @@ test_description='fetch/push involving ref namespaces'
>  . ./test-lib.sh
>  
>  test_expect_success setup '
> +	git config --global protocol.ext.allow user &&
>  	test_tick &&
>  	git init original &&

These remote-ext fixups might be worth a note in the commit message, or
a comment here explaining what is going on.

> +static enum protocol_allow_config get_protocol_config(const char *type)
> +{
> +	char *key = xstrfmt("protocol.%s.allow", type);
> +	char *value;
> +
> +	if (!git_config_get_string(key, &value)) {
> +		enum protocol_allow_config ret =
> +			parse_protocol_config(key, value);
> +		free(key);
> +		free(value);
> +		return ret;
> +	}
> +	free(key);
> +
> +	/* if defined, use user default for unknown protocols */
> +	if (!git_config_get_string("protocol.allow", &value)) {
> +		enum protocol_allow_config ret =
> +			parse_protocol_config("protocol.allow", value);
> +		free(value);
> +		return ret;
> +	}
> +
> +	/* known safe */
> [...]

It's probably worth a comment at this point in the function to follow-up
on your "if defined" comment above. So the end result reads something
like:

  /* first check the per-protocol config */
  ...

  /* now fallback to the generic config */
  ...

  /* and then fallback to our built-in defaults */

-Peff
