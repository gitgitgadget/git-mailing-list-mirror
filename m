Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F345530EF6D
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 21:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765921844; cv=none; b=o4LnorEiP0OW2KZr2DDFXybgLCKj+vgwekHq4dFDYE7hLdUOstBHSVbwNDYj1C/by4uJ1moIigeCs8fgwu8JPRzYPK8oF6i8B3t5T6hsn/ws3HSo9JnSBNnt2jzoEVrgLSlIbGE7ynDy9QJBdjI9MXdN/IdBz/3EEu7RBNmY0Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765921844; c=relaxed/simple;
	bh=3wIwRE7NJkVeyXMhqgXLBYq66nBYoCdWLb6iMp1knJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i69gIR/0jFmATnZGDkmMBCKQ6Vlis1D/Po3LAmdBnB0k2JWcWWvr8jercY+zR55e4sDw+C37zCX3j6DTwUk9rWTkI5mQojlE+7W3ERKwFBdVBbTaNmCPSt0PEwXZjYXsRBJSWwK9mkDZ+RoByQNkyhFdacEUbmOSuMByxlKUDiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfEbDZFk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfEbDZFk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D56C4CEF1;
	Tue, 16 Dec 2025 21:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765921842;
	bh=3wIwRE7NJkVeyXMhqgXLBYq66nBYoCdWLb6iMp1knJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pfEbDZFkb7xnhuprbtcF+bPo6MVOWppCTvrd7ihlWTKyEQmSjLhbfkWbXR5AZXyr9
	 /wZID81cibsgvEtrEDFf+j0D40IXkBxM1CC7QjUzPbmEfx9rdFlA94Di8xk7w3Hth3
	 h05THCheqo5NgjyZtGov50Z9Gqpz52oygFAT2w3lXJ/ki1mhlPZoXRCei27TCTrUrG
	 ags2abROt12dPSnxwrTo2yIAci+3wY372Tiaeo0IsKdJi07Mu0r4JS3hc1B7kbzeKM
	 wKIR0dqjHccImX3Fc0ZGU4HPnvPo6JKE5VMQJq8WixfTIok/t2jfkl/XCmBpBbpLKu
	 fMzjh8pMr/t5A==
Date: Tue, 16 Dec 2025 15:50:40 -0600
From: Lucas De Marchi <demarchi@kernel.org>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: git@vger.kernel.org, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH] remote-curl: Use auth for probe_rpc() requests too
Message-ID: <gn2laka3nl6vb66mvwyqie5ztvwzloadv2xcowzd33bgohecba@duf5klzyuteo>
References: <20251112223722.376330-1-aplattner@nvidia.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251112223722.376330-1-aplattner@nvidia.com>

On Wed, Nov 12, 2025 at 02:37:18PM -0800, Aaron Plattner wrote:
>If a large request requires post_rpc() to call probe_rpc(), the latter
>does not use the authorization credentials used for other requests. If
>this fails with an HTTP 401 error and http_auth.multistage isn't set,
>then the whole request just fails.
>
>For example, using git-credential-msal [1], the following attempt to clone a
>large repository fails partway through because the initial request to download
>the commit history and promisor packs succeeds, but the
>subsequent request to download the blobs needed to construct the working
>tree fails with a 401 error and the checkout fails.
>
>(lines removed for brevity)
>
>  git clone --filter=blob:none https://secure-server.example/repo
>  11:03:26.855369 git.c:502               trace: built-in: git clone --filter=blob:none https://secure-server.example/repo
>  Cloning into 'sw'...
>  warning: templates not found in /home/aaron/share/git-core/templates
>  11:03:26.857169 run-command.c:673       trace: run_command: git remote-https origin https://secure-server.example/repo
>  11:03:27.012104 http.c:849              => Send header: GET repo/info/refs?service=git-upload-pack HTTP/1.1
>  11:03:27.049243 http.c:849              <= Recv header: HTTP/1.1 401 Unauthorized
>  11:03:27.049270 http.c:849              <= Recv header: WWW-Authenticate: Bearer error="invalid_request", error_description="No bearer token found in the request", msal-tenant-id="<tenant>", msal-client-id="<client>"
>  11:03:27.053786 run-command.c:673       trace: run_command: 'git credential-msal get'
>  11:03:27.952830 http.c:849              => Send header: GET repo/info/refs?service=git-upload-pack HTTP/1.1
>  11:03:27.952849 http.c:849              => Send header: Authorization: Bearer <redacted>
>  11:03:27.995419 http.c:849              <= Recv header: HTTP/1.1 200 OK
>  11:03:28.230039 http.c:890              == Info: Reusing existing https: connection with host secure-server.example
>  11:03:28.230208 http.c:849              => Send header: POST repo/git-upload-pack HTTP/1.1
>  11:03:28.230216 http.c:849              => Send header: Content-Type: application/x-git-upload-pack-request
>  11:03:28.230221 http.c:849              => Send header: Authorization: Bearer <redacted>
>  11:03:28.269085 http.c:849              <= Recv header: HTTP/1.1 200 OK
>  11:03:28.684163 http.c:890              == Info: Reusing existing https: connection with host secure-server.example
>  11:03:28.684379 http.c:849              => Send header: POST repo/git-upload-pack HTTP/1.1
>  11:03:28.684391 http.c:849              => Send header: Accept: application/x-git-upload-pack-result
>  11:03:28.684393 http.c:849              => Send header: Authorization: Bearer <redacted>
>  11:03:28.869546 run-command.c:673       trace: run_command: git index-pack --stdin --fix-thin '--keep=fetch-pack 43856 on dgx-spark' --promisor
>  11:06:39.861237 run-command.c:673       trace: run_command: git -c fetch.negotiationAlgorithm=noop fetch origin --no-tags --no-write-fetch-head --recurse-submodules=no --filter=blob:none --stdin
>  11:06:39.865981 run-command.c:673       trace: run_command: git remote-https origin https://secure-server.example/repo
>  11:06:39.868039 run-command.c:673       trace: run_command: git-remote-https origin https://secure-server.example/repo
>  11:07:30.412575 http.c:849              => Send header: GET repo/info/refs?service=git-upload-pack HTTP/1.1
>  11:07:30.456285 http.c:849              <= Recv header: HTTP/1.1 401 Unauthorized
>  11:07:30.456318 http.c:849              <= Recv header: WWW-Authenticate: Bearer error="invalid_request", error_description="No bearer token found in the request", msal-tenant-id="<tenant>", msal-client-id="<client>"
>  11:07:30.456439 run-command.c:673       trace: run_command: 'git credential-cache get'
>  11:07:30.461266 http.c:849              => Send header: GET repo/info/refs?service=git-upload-pack HTTP/1.1
>  11:07:30.461282 http.c:849              => Send header: Authorization: Bearer <redacted>
>  11:07:30.501628 http.c:849              <= Recv header: HTTP/1.1 200 OK
>  11:07:34.725262 http.c:849              => Send header: POST repo/git-upload-pack HTTP/1.1
>  11:07:34.725279 http.c:849              => Send header: Content-Type: application/x-git-upload-pack-request
>  11:07:34.761407 http.c:849              <= Recv header: HTTP/1.1 401 Unauthorized
>  11:07:34.761443 http.c:890              == Info: Bearer authentication problem, ignoring.
>  11:07:34.761453 http.c:849              <= Recv header: WWW-Authenticate: Bearer error="invalid_request", error_description="No bearer token found in the request", msal-tenant-id="<tenant>", msal-client-id="<client>"
>  11:07:34.761509 http.c:890              == Info: The requested URL returned error: 401
>  11:07:34.761530 http.c:890              == Info: closing connection #0
>  11:07:34.761913 run-command.c:673       trace: run_command: 'git credential-cache erase'
>  11:07:34.761927 run-command.c:765       trace: start_command: /bin/sh -c 'git credential-cache erase' 'git credential-cache erase'
>  11:07:34.768069 git.c:502               trace: built-in: git credential-cache erase
>  11:07:34.768690 run-command.c:673       trace: run_command: 'git credential-msal erase'
>  11:07:34.768713 run-command.c:765       trace: start_command: /bin/sh -c 'git credential-msal erase' 'git credential-msal erase'
>  11:07:34.772742 git.c:808               trace: exec: git-credential-msal erase
>  11:07:34.772783 run-command.c:673       trace: run_command: git-credential-msal erase
>  11:07:34.772819 run-command.c:765       trace: start_command: /usr/bin/git-credential-msal erase
>  error: RPC failed; HTTP 401 curl 22 The requested URL returned error: 401
>  fatal: unable to write request to remote: Broken pipe
>  fatal: could not fetch c4fff0229c9be06ecf576356a4d39a8a755b8d81 from promisor remote
>  warning: Clone succeeded, but checkout failed.
>  You can inspect what was checked out with 'git status'
>  and retry with 'git restore --source=HEAD :/'
>
>Fix the immediate problem by including the authorization headers in the
>probe_rpc() request as well.
>
>Signed-off-by: Aaron Plattner <aplattner@nvidia.com>

Tested-by: Lucas De Marchi <demarchi@kernel.org>

thanks,
Lucas De Marchi
