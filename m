Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D50C366563
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 04:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781323685; cv=none; b=BqfpL3CqbelCw1Ennon3lnPffaXT7ki7JrqD/KdH8z2coW0rpDBXwJPfzv6opg7s53/ndwZBDvhFk0WmY1Cjd6E9Vb6ffNeH0RIx4UyvSI16HLVBIA2GqnZyosaGq+m6qpCAsHe26O5OP9bcBleL4neVrfLqbMSYIgyYAPsgtmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781323685; c=relaxed/simple;
	bh=MrCYqawIxriYXCIKSvhJi6zqQ+D94DtH2iWejoxVvX8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=sYUzhMFO6b21E1SVoUX01tolIfRLhfl7SPJH1eugfd8s7IM3W34nBQgA3G+GaPHMP1GViB92WflM1MNJ6LJs7bxQ6ncREPiv/L6aet9CMbAssHJO9H0VEUqLjsOeA92ciyvwgnPb6L+fdibKNd6r9hSrAIx4cdjyFZ8ee8HqKyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=qP11CFH4; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="qP11CFH4"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id BC90C60007;
	Sat, 13 Jun 2026 04:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781323682; bh=MrCYqawIxriYXCIKSvhJi6zqQ+D94DtH2iWejoxVvX8=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=qP11CFH4S27k+Ej3APBFjYOVBH/q9WS1mcb4r4LI3IAXLYuC2fPq3iXcstKhBFmI4
	 onkw3INMOOWpRJjm/WQiJ4DI96CMIlTwLA/eRrQqgccIETuqWRevvQ6Xq6eBbr+5s7
	 IXST/2L+LSOgPmBtsJeVY86dHLiQsI6WOHMf8T1I=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 13 Jun 2026 00:08:02 -0400
Message-Id: <DJ7MJMIFZR5N.2SG1RWB46WPQB@lfurio.us>
Cc: "h8d13" <hadean-eon-dev@proton.me>
To: "h8d13 via GitGitGadget" <gitgitgadget@gmail.com>, <git@vger.kernel.org>
From: "Matt Hunter" <m@lfurio.us>
Subject: Re: [PATCH] clone: accept DEPTH env var as fallback for --depth
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <pull.2333.git.git.1781314780645.gitgitgadget@gmail.com>
In-Reply-To: <pull.2333.git.git.1781314780645.gitgitgadget@gmail.com>

On Fri Jun 12, 2026 at 9:39 PM EDT, h8d13 via GitGitGadget wrote:
> @@ -1022,6 +1022,12 @@ int cmd_clone(int argc,
>  		usage_msg_opt(_("You must specify a repository to clone."),
>  			builtin_clone_usage, builtin_clone_options);
> =20
> +	if (!option_depth) {
> +		const char *env_depth =3D getenv("DEPTH");

Nearly all of the non-standard environment variables used by git start
with "GIT_".  "GIT_CLONE_DEPTH" may be a better choice.

> +		if (env_depth && *env_depth)
> +			option_depth =3D xstrdup(env_depth);

Following normal command-line option parsing, if --depth is given, then
option_depth points to the parsed string from cmd_clone's argv array
directly and is not freed.  Therefore, the string copy returned via
xstrdup also goes unfreed before it is lost.

One might argue this isn't very impactful, since we would expect the
process to exit after git-clone completes, but there are already several
explicit calls to free and related functions at the end of cmd_clone.
> +	}
> +
>  	if (option_depth || option_since || option_not.nr)
>  		deepen =3D 1;
>  	if (option_single_branch =3D=3D -1)
>
> base-commit: 3e65291872de10c3f0bf05ea8c24187e7a71ebf0

