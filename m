Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628704C63D
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 19:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708804568; cv=none; b=O5rStAK2pi+0V9vaCKZouvNjSp172EVPrb71zBG8W32UcMRrjMDk4r+T+hLDSi9Y7AvZ6MEb5B8ByEmmtnBNuNRrqUe1DnYw+ssvCrgVWLPTa0E+MYf6FQyfF6NqW+KEs7WnPvFKZcxL5hYKKczUnF2bZvH870OTWbzg7ov2h64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708804568; c=relaxed/simple;
	bh=RhMJO/4izJeXMc0Agpv4Mo/eIdMI8iFwBhwYzSBY1kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqCRF2Z3Ul0ctV6qgjbE4AcMlduVQUTyhmELHVbWJURfFkk69g4AHqDbzCcNKjbhGY5z00oPoWvSZ53hJ0nKhJgeiBoJFHSp387CpllEu96DmcwH75yhWjYa8JS6/Uk6xqQo/u9sa8BAcGR2S0aFFMgie8c4RCjg1lnvd5msEC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3418120-ipxg00d01tokaisakaetozai.aichi.ocn.ne.jp ([114.171.163.120] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1rdy7o-00ASJM-00;
	Sat, 24 Feb 2024 19:55:56 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1rdy7i-000qFT-0G;
	Sun, 25 Feb 2024 04:55:50 +0900
Date: Sun, 25 Feb 2024 04:55:50 +0900
From: Mike Hommey <mh@glandium.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.44.0
Message-ID: <20240224195550.ignhzidmdy3ce6q4@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <xmqqbk87w164.fsf@gitster.g>
 <20240224051040.ftuo24smozqugbde@glandium.org>
 <ZdmOZRjJ-mClBR02@framework>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdmOZRjJ-mClBR02@framework>

On Sat, Feb 24, 2024 at 07:36:21AM +0100, Patrick Steinhardt wrote:
> Thanks for your report!
> 
> This has to be because we now initialize the refdb at a later point. The
> problem here was that before my change, we initialized the refdb at a
> point when it wasn't clear what the remote actually used as the object
> format. The consequence was twofold:
> 
>   - Cloning a repository with bundles was broken in case the remote uses
>     the SHA256 object format.
> 
>   - Cloning into a repository that uses reftables when the remote uses
>     the SHA256 object format was broken, too.
> 
> Both of these have the same root cause: because we didn't connect to the
> remote yet we had no idea what object format the remote uses. And as we
> initialized the refdb early, it was then initialized with the default
> object format, which is SHA1.
> 
> The change was to move initialization of the refdb to a later point in
> time where we know what object format the remote uses. By necessity,
> this has to be _after_ we have connected to the remote, because there is
> no way to learn about it without connecting to it.
> 
> One consequence of initializing the refdb at a later point in time is
> that we have no "HEAD" yet, and a repo without the "HEAD" file is not
> considered to be a repo. Thus, git-config(1) would now rightfully fail.
> 
> I assume that you discovered it via a remote helper that does something
> more interesting than git-config(1).

Indeed, my own usecase is a remote helper that uses libgit.a and uses
is_git_directory indirectly, but I could imagine other remote helpers that
could be using other git commands that rely on is_git_directory
returning true.

> I have to wonder whether we ever
> really specified what the environment of a remote helper should look
> like when used during cloning. Conceptually it doesn't feel _wrong_ to
> have a not-yet-initialized repo during clone.

How about this: it should look like what you'd get from
`git init $repo`.

> But on the other hand, regressing functionality like this is of course
> bad. I was wondering whether we can get around this issue by setting
> e.g. GIT_DIR explicitly when spawning the remote helper, but I don't
> think it's as easy as that.

GIT_DIR is already set when spawning the remote helper. My remote helper
is using setup_git_directory_gently and uses the value of nongit_ok for
the cases where the executable is used without being wrapped by git (it
provides extra commands), I guess I could use whether GIT_DIR is set as
a workaround.

> Another idea would be to simply pre-create HEAD regardless of the ref
> format, pointing to an invalid ref "refs/heads/.invalid". This is the
> same trick we use for the reftable backend, and should likely address
> your issue.

The interesting thing is that `git init $repo` does give you an invalid
HEAD (and that's what would happen during git clone too), with either
```
ref: refs/heads/master
```
or
```
ref: refs/heads/main
```
depending on configuration.

Mike
