Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EB434252C
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 04:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781151186; cv=none; b=DZiXeinkqun4XwIy3yTDCX2ct5iW3Hdk2Js6o3VPxx4aoLFz7V+vbZCGCPiEirdmV8leZ3JP+33nuNWVMMzuOLJtTmgAaG8OLOamdv32YoEtxyOA+GqO7pF50cZUcmvuHc1WLxkZ8wxD0xT9/j15J36jq9rXwIcX3Wg8/5jqUiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781151186; c=relaxed/simple;
	bh=ypnB164fTbICmhg6wfvo20FY9LH8SW4w1cHxIVqQZQU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Di9owyt8Pd4HUtb1zmXFdHjvbbUJ9PqTFHCxlbARVovK6tlWQnamU2Ol/TEbgM4tBMJoMjUg8IExBC110dmMKl/sQHDHv0LRMlQGD6HpXqMv+kzzc2+n14j7aThhj2p0NMvKhDqxWMbaJpd/aHvuj1rZrgYuR79IiX/g0Mfi68k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=qWfnbE20; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="qWfnbE20"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 2B8F260007;
	Thu, 11 Jun 2026 04:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781151178; bh=ypnB164fTbICmhg6wfvo20FY9LH8SW4w1cHxIVqQZQU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=qWfnbE20by4NSpenm0jzoUD9VRnHuhnru2ibvfu6bCoDFcmwYf64ty5P+3j4eO+Uv
	 8xEfmW3Lcbw8cSIOb2cZw7cgJTopwsy1pLgGFPc71mGhLLg4R7X1Ywm82CvCX9SHaH
	 tZ4295A7NziVKsGP1R/mtQ+Qfl9WeiLStdWf+Tww=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 00:12:54 -0400
Message-Id: <DJ5XE9HC5YNY.33U8AG1GX6ZP0@lfurio.us>
Subject: Re: followRemoteHEAD management question
Cc: <git@vger.kernel.org>, "Bence Ferdinandy" <bence@ferdinandy.com>
To: "Jeff King" <peff@peff.net>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <DJ19CI50W6UH.17QLIBNTXBWXU@lfurio.us>
 <20260608234946.GB358144@coredump.intra.peff.net>
In-Reply-To: <20260608234946.GB358144@coredump.intra.peff.net>

On Mon Jun 8, 2026 at 7:49 PM EDT, Jeff King wrote:
>>=20
>> The topic mentioned above (merged in a1f34d595503) adds a new
>> configuration key 'remote.<name>.followRemoteHEAD'.  I'm assuming that
>> the intended use for followRemoteHEAD is really only in local /
>> per-repository config, since trying to apply it to my personal
>> .gitconfig has some odd behavior.
>
> I think this is a gap in the new feature's implementation. It added
> per-remote config, but there is no global config to fall back to (e.g.,
> the way that remote.*.prune falls back to fetch.prune). There should be
> a fetch.followRemoteHEAD option (or perhaps remote.followRemoteHEAD).

Earlier on while working on this, I actually settled on
fetch.followRemoteHEAD instead, taking example from the prune setting.
Thanks for the confirmation.

>> The <name> in the key template does not accept a wildcard, so I must
>> list out each of the common remote names I use across different
>> repositories.  Since many of my repos don't actually have remotes
>> established for all of these names, they pick up a kind of half-baked
>> definition for each of them as git performs its config parsing.  For
>> instance, a name will appear under 'git remote -v', but it won't
>> have any actual properties configured.
>
> Yes, this is a common problem with the remote-config namespace. Defining
> _any_ key makes the remote "exist", even without a defined url, but that
> isn't usually the intent.  But we can't distinguish that from the case
> where you really do want to define a remote without a url (in which case
> the url is the name of the remote).

I had no idea a remote like that was supported.  Interesting.

>> Is there another solution in place I've missed?  If not, would there be
>> any opposition to a new key like 'remote.followRemoteHEAD' which serves
>> to provide a default value for any remote that doesn't have its own
>> 'remote.<name>.followRemoteHEAD' key?
>>=20
>> I've started scouting out changes to make for such a patch.  It's not
>> ready yet, but I figured I would throw this question out in case an easy
>> answer can save the effort.
>
> I think you are on the right track. I can see arguments for or against
> putting it in fetch.* or remote.*, so you'll have to pick one. ;)

As stated, I think putting it in fetch.* is more consistent.  I'd be
curious to hear arguments the other way.

As for another design decision: I'm leaning toward omitting support for
the "warn-if-not-$branch" value in fetch.followRemoteHEAD.

My take on that option as-documented is that it serves more as an
acknowledgment from the user that "yes, I understand that origin has
pointed HEAD at foo, please only warn me if it changes" as opposed to the
user expressing that the branch "foo" is in some way special to them.

This interpretation feels very remote-dependent and doesn't make sense in
the context of a default catch-all value to me.

Thanks for the feedback!
