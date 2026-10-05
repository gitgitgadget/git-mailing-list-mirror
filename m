Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D713B6BF4
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791191167; cv=none; b=Af4rvlDywYm8EdxLj0tRtumpx7mxZ/IQHiuAxdTuypAVz5zn70Nf//SSJI9S+HgZjJv1j3KHYQNTxL1OvNFO/fPv5cUWOBIN12yjg85sst2TPFSBz10ghSX074lvJl/LfCZaUnTldPFyFxeKgfNR7RrcxnYNSIY13/Rm2VyuvIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791191167; c=relaxed/simple;
	bh=hl0bRi2x2T8jXM64J+Zig2tb1yJHVRhhbKLrLr3k8qg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=F0roaMG6mQ2Ffi4Q31dEthpIwajRU1DaTvSNwKrjY3vfRWit+XHW2gKzUOZuJVMpqFIyNH/BL1HCfpNNVNCO0nNMwlGnkb3YzmQocnm9yzhPI0VcDkQsyXL0M4LTJmDV9cijwJSTvaQy71hBIzz1ZS6IaCgVnGbapreP6+l+Ezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=HAI1M8XJ; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="HAI1M8XJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1791191158; bh=hl0bRi2x2T8jXM64J+Zig2tb1yJHVRhhbKLrLr3k8qg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=HAI1M8XJ36Z+ZZ9AXicRJrLwq371GlvZnLY5FM/0QwtWK9Cp4Uur10zdjGgJEGJ/B
	 8nKLMAtIwiOg02lAwTTj7o5LoDuEaAa05hoHBcMxmVP2grflIV+rRvpk1YLUR13tGZ
	 TcUw7OIKG0nYnROGWyz8NJhSX248rEuBr7muX4ls=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 8144661F3B;
	Mon,  5 Oct 2026 09:05:58 +0000 (UTC)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Oct 2026 05:05:51 -0400
Message-Id: <DLWS9R3ZM2Z0.MVT71MWE19LN@lfurio.us>
Subject: Re: [PATCH v5] fetch.c: defer fetch.followRemoteHEAD validation
Cc: <gitster@pobox.com>
To: "Colin Hinton" <colinlewishinton@gmail.com>, <git@vger.kernel.org>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261003231422.6004-1-colinlewishinton@gmail.com>
 <20261004201428.5210-1-colinlewishinton@gmail.com>
In-Reply-To: <20261004201428.5210-1-colinlewishinton@gmail.com>

Hi Colin,

Just a couple comments and 'thinking aloud' on the design of the patch
from me.  Unfortunately I don't have time at the moment to test this new
revision.

thanks

On Sun Oct 4, 2026 at 4:14 PM EDT, Colin Hinton wrote:
> The value of the fetch.followRemoteHEAD configuration variable is
> validated while the configuration file is being parsed, which
> produces a warning even when this particular "git fetch" invocation
> will never consult it.
>
> Store the raw config string instead, and resolve/validate it lazily
> at the one place in do_fetch() that actually uses it, so a mistyped
> value only warns, and a missing value only dies, when this fetch
> would have consulted it.
>
> remote.c's handle_config() has the same problem for
> remote.<name>.followRemoteHEAD, but is left unaddressed here since
> it touches shared remote-parsing infrastructure used well beyond
> fetch. Leave NEEDSWORK comments at both the now unresolved call site

The new comment in fetch.c doesn't actually have the NEEDSWORK label.  I
would probably suggest placing one there, instead of adjusting this
sentence.

> @@ -103,7 +103,8 @@ static struct string_list negotiation_include =3D STR=
ING_LIST_INIT_NODUP;
> =20
>  struct fetch_config {
>  	enum display_format display_format;
> -	enum follow_remote_head_settings follow_remote_head;
> +	char *follow_remote_head_raw;
> +	int follow_remote_head_seen;
>  	int all;
>  	int prune;
>  	int prune_tags;
> @@ -176,24 +177,31 @@ static int git_fetch_config(const char *k, const ch=
ar *v,
>  	}
> =20
>  	if (!strcmp(k, "fetch.followremotehead")) {
> -		if (!v)
> -			return config_error_nonbool(k);
> -		else if (!strcmp(v, "never"))
> -			fetch_config->follow_remote_head =3D FOLLOW_REMOTE_NEVER;
> -		else if (!strcmp(v, "create"))
> -			fetch_config->follow_remote_head =3D FOLLOW_REMOTE_CREATE;
> -		else if (!strcmp(v, "warn"))
> -			fetch_config->follow_remote_head =3D FOLLOW_REMOTE_WARN;
> -		else if (!strcmp(v, "always"))
> -			fetch_config->follow_remote_head =3D FOLLOW_REMOTE_ALWAYS;
> -		else
> -			warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored"), =
v);
> +		free(fetch_config->follow_remote_head_raw);
> +		fetch_config->follow_remote_head_raw =3D xstrdup_or_null(v);
> +		fetch_config->follow_remote_head_seen =3D 1;
>  		return 0;
>  	}

We now have 'follow_remote_head_seen', which tells us whether to trust
the 'raw' string ptr or if the variable hasn't been set by the user.

Therefore, when 'seen' is true, the raw string is:

    - NULL when a valueless true was specified
    - "" when an actual empty string was specified
    - any other string for a normal value

Because of this ...

> =20
>  	return git_default_config(k, v, ctx, cb);
>  }
> =20
> +static enum follow_remote_head_settings get_follow_remote_head(const cha=
r *setting)
> +{
> +	if (!setting)
> +		die(_("missing value for 'fetch.followRemoteHEAD'"));

... this case is now meaningful, as we couldn't previously reach this if
'setting' was NULL.

> +	else if (!strcmp(setting, "never"))
> +		return FOLLOW_REMOTE_NEVER;
> +	else if (!strcmp(setting, "create"))
> +		return FOLLOW_REMOTE_CREATE;
> +	else if (!strcmp(setting, "warn"))
> +		return FOLLOW_REMOTE_WARN;
> +	else if (!strcmp(setting, "always"))
> +		return FOLLOW_REMOTE_ALWAYS;
> +	warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored"), se=
tting);

And the empty string case is handled here, which makes sense.

I believe Junio had mentioned tightening this warning to a die.  I'm not
sure if it was _just_ this case or something else.  Personally, I think the
warning is still the better call for some "f@KeValue".  But it _could_
make sense to die on "", since that is more obviously mis-configured.

Having typed the above out, I now realize that is actually how the
previous v4 behaved (but in slightly less code).  So, we're getting into
opinionated details here... Though, as-is I think this v5 implementation
is reasonable.

> @@ -2509,7 +2508,8 @@ int cmd_fetch(int argc,
>  {
>  	struct fetch_config config =3D {
>  		.display_format =3D DISPLAY_FORMAT_FULL,
> -		.follow_remote_head =3D FOLLOW_REMOTE_UNCONFIGURED,
> +		.follow_remote_head_raw =3D NULL,
> +		.follow_remote_head_seen =3D 0,

and the 'seen' variable is initialized to false, good.

>  		.prune =3D -1,
>  		.prune_tags =3D -1,
>  		.show_forced_updates =3D 1,
> diff --git a/remote.c b/remote.c
> index fe62068463..58f3436222 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -582,6 +582,13 @@ static int handle_config(const char *key, const char=
 *value,
>  					      &remote->negotiation_include);
>  	} else if (!strcmp(subkey, "followremotehead")) {
>  		const char *no_warn_branch;
> +		/*
> +		 * NEEDSWORK: this is validated/warned about here, during config
> +		 * parsing, regardless of whether the fetch that triggered this
> +		 * parse will ever consult it for this particular remote. See
> +		 * fetch.c's deferred handling of fetch.followRemoteHEAD for the
> +		 * pattern this should likely follow.
> +		 */
>  		if (!strcmp(value, "never"))
>  			remote->follow_remote_head =3D FOLLOW_REMOTE_NEVER;
>  		else if (!strcmp(value, "create"))
