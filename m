Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA633A5E67
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236694; cv=none; b=OUM+X/sNzfgh7qTp3MffPP823hE2ReHQHkO/qYumGBlT4mq7lLW+zTJaQY+SzvRcr0ge6Jt7UfHgVG3SyRy0nrTASSolcIzyBnvqm0rxbWcBo1BI5/ytKOoDqy8W0NvV3ESQEPTvxgWIjLfX9IKAUpH114SKQNnKMyaCWcEc8MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236694; c=relaxed/simple;
	bh=V9uRfKYPhodP9T+YO6dw/Zz8FEnSk+98F22izoh4ffE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=LW5GW6Ves5Bvxf5zGB3OyECj+JMwJWDbf1++4k4Ijiz7RwJgWYMuGx4tinRHM/MVgS63nZDlmdYbcAfnG8GczAKz46xQlUEkT3Q9J/cOSM50dLMsjGgsxZAgxDeU6p8KOPc/YMH1magT/OXYp3uWrfkJ9dRjXvlwNf3SP/vvRQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=YwE3eGdU; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="YwE3eGdU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1790236210; bh=V9uRfKYPhodP9T+YO6dw/Zz8FEnSk+98F22izoh4ffE=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=YwE3eGdUGinSrFNL9ip++lxGc8rYp23wvMCbY8HjW3XESlzV2AeyNkTCDtKejzhpe
	 PLG4k/gVQ81bYvalRBdHUE7jFAomefKZo3DJEEY5C1R/exWGoCuXTO+8YYi8wPfqVw
	 XV7VEY0Fippv7I/l1qyFygaVe2lBXpzk9CDNnzwU=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id E5BE960122;
	Thu, 24 Sep 2026 07:50:09 +0000 (UTC)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 03:50:09 -0400
Message-Id: <DLNDRT2L2DYK.3LCFVZ6URY4G6@lfurio.us>
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>, "Colin Hinton"
 <colinlewishinton@gmail.com>
From: "Matt Hunter" <m@lfurio.us>
Subject: Re: [PATCH] fetch.c: defer fetch.followRemoteHEAD validation
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260922040047.2567-1-colinlewishinton@gmail.com>
 <xmqqwlsdhmvk.fsf@gitster.g>
In-Reply-To: <xmqqwlsdhmvk.fsf@gitster.g>

Colin - thanks for picking this up.

Just wanted to make note of some lingering thoughts of mine from when
this config was added.  I wouldn't consider these necessary for your
patch, though you might agree with the ideas.

On Tue Sep 22, 2026 at 1:32 AM EDT, Junio C Hamano wrote:
> Colin Hinton <colinlewishinton@gmail.com> writes:
>
>> +static enum follow_remote_head_settings get_follow_remote_head(const ch=
ar *setting)
>> +{
>> +	if (!strcmp(setting, "never"))
>> +		return FOLLOW_REMOTE_NEVER;
>> +	else if (!strcmp(setting, "create"))
>> +		return FOLLOW_REMOTE_CREATE;
>> +	else if (!strcmp(setting, "warn"))
>> +		return FOLLOW_REMOTE_WARN;
>> +	else if (!strcmp(setting, "always"))
>> +		return FOLLOW_REMOTE_ALWAYS;
>> +	warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored"), s=
etting);
>> +	return FOLLOW_REMOTE_UNCONFIGURED;
>> +}
>
> OK.  So unrecognised are treated as unconfigured, just like before.

There was an idea I raised in [1] that didn't really get discussed.
That being that we should effectively act like FOLLOW_REMOTE_NEVER is
set when the configured value is unrecognized.

The situation I envision is a user porting their .gitconfig file to a
system running an older git, that doesn't know about their preferred
setting.  Given that _something_ is configured, the user obviously
doesn't want the default behavior, but that's what they'll get when
FOLLOW_REMOTE_UNCONFIGURED is returned.

FOLLOW_REMOTE_NEVER seems like the least suprising action to take when
we don't understand the request.  And I think this reasoning could apply
to remote.foo.followRemoteHEAD as well, if you think it's worth doing
here.

>
> Make a mental note that do_set_head is flipped on ONLY here in this
> function.
>
>>  			if (follow_remote_head !=3D FOLLOW_REMOTE_NEVER)
>>  				do_set_head =3D 1;
>>  		}
>
> And later, do_set_head is referenced twice.  Once when preparing the
> transport options to first discover what refs they have (ls-refs)
>
> 	if (do_set_head)
> 		strvec_push(&transport_ls_refs_options.ref_prefixes,
> 			    "HEAD");
>
> and then once more to make a set-head call using follow_remote_head.
>
> 	if (do_set_head) {
> 		/*
> 		 * Way too many cases where this can go wrong so let's just
> 		 * ignore errors and fail silently for now.
> 		 */
> 		set_head(remote_refs, transport->remote, follow_remote_head);
> 	}
>
> Incidentally, after that "lazily turn configuration string into
> follow_remote_head variable" block is left, this is the only place
> that follow_remote_head variable is referenced.
>
> Which suggests to me that we can get rid of do_set_head variable, we
> can initialize follow_remote_head variable to FOLLOW_REMOTE_NEVER,
> and replace these two=20
>
> 	if (do_set_head)
>
> with
>
> 	if (follow_remote_head !=3D FOLLOW_REMOTE_NEVER)
>
> and the resulting code may become a tad easier to follow.

It occurred to me a while ago that there's another case in which we
might want to skip querying the remote for its HEAD - when
FOLLOW_REMOTE_CREATE is in effect, and the remote already has a local
HEAD symref.  Given that 'create' is the default mode for this setting,
it would probably be a valuable save on network and server overhead.

Of course, I think this should probably be its own topic, separate from
what this patch is addressing.  But if the condition of that 'if'
statement is to become more complicated, it might be a good reason to
not start duplicating it here.

>
> Hmmm?

1: https://lore.kernel.org/git/DJBVYP58YNTU.LQ7VXFIQE84H@lfurio.us/
