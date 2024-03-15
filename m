Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10335D52F
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 05:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710481786; cv=none; b=f7Rsk3RFZkCUS0v2wuj+D9tbpOxQ4YY0hBrKlhVWWMKJi0YPffYi4j6xB2jENsFf1CeoKTMpp6dYyoXCnBhaxoRIUhYLexrCqO1GfBghr2Ed6iJ/YPHcho9AzHeE8pN9M97Iaff+9SMvs8lfHPBQPEoyAR4YbDE9/ttrvY9JnoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710481786; c=relaxed/simple;
	bh=1cGLPE85sySe6GCW3aJjBsgVc8DQTbEYapTswEJ+HM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBcN4y/zITN9B7VaiS37VKqSTXcR/oZnlxIw9gAOIrLY76dljcIGoCq4Hk8UwwJ4ITumGB70W1m+y/uZmdkIFiQfum64HN8TaNUqObL7PAn+MBVvukDVy8rbyHMFfYlnAjf/Gw/0FM8glpDh7ocYOLjggC22A/ni9GBuoHYlhNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22986 invoked by uid 109); 15 Mar 2024 05:49:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 Mar 2024 05:49:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28591 invoked by uid 111); 15 Mar 2024 05:49:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Mar 2024 01:49:40 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 15 Mar 2024 01:49:36 -0400
From: Jeff King <peff@peff.net>
To: Yasuhiro Kimura <yasu@utahime.org>
Cc: git@vger.kernel.org
Subject: Re: Name for initial branch is ignored when repository is cloned
 with SSH
Message-ID: <20240315054936.GA1741107@coredump.intra.peff.net>
References: <20240315.104939.1269594475664662053.yasu@utahime.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240315.104939.1269594475664662053.yasu@utahime.org>

On Fri, Mar 15, 2024 at 10:49:39AM +0900, Yasuhiro Kimura wrote:

> I expect the change is committed to 'main' branch. But actually it is
> committed to 'master' branch.
> 
> Anything else you want to add:
> 
> If I change step 2 as following,
> 
> 2'. git clone /somewhere/test.git
> 
> then I get expected behavior.

I suspect you are running afoul of two things:

  1. When cloning a totally empty repository, detecting the destination
     of the unborn HEAD requires a protocol extension. This extension
     was implemented only for Git's v2 protocol, not for v0.

  2. Git should automatically use v2 in most cases these days. But it
     does so by probing the server in a backwards-compatible way to see
     if it also supports v2. For ssh, that probe happens by passing a
     special environment variable. However, the default config for many
     ssh servers refuses unknown variables. For OpenSSH, you'd want to
     add:

       AcceptEnv GIT_PROTOCOL

     to your sshd_config.

You can verify the protocol in use by running your clone with
GIT_TRACE_PACKET=1 in the environment. For v0, you'll see either a pair
of empty flush packets (for older versions of the server):

  packet:        clone< 0000
  packet:        clone> 0000

or a single-line capabilities faux-ref like:

  packet:        clone< 00000... capabilities^{}\0multi_ack thin-pack side-band etc...

For v2, the server will respond with a multi-line capabilities list,
starting with the version:

  packet:        clone< version 2

Assuming my guess is right, I think everything here is working as
designed, though obviously it's not a great outcome (and changing the
server-side config may not be an option for everyone).

Some possible things we could do to make it better:

  a. teach v0 the same "unborn" extension that v2 knows (or maybe even
     the existing symref extension would work on the capabilities line?)
     This probably wouldn't be too hard, but I think there are many
     other capabilities that v0 would still lack, so it's kind of a
     losing battle.

  b. as v0-only servers become more and more rare, it would be nice if
     the client could start assuming v2 by default, rather than probing.
     But I don't think this quite works, because it is the server who
     starts speaking v2 first (and it won't do so without seeing that
     probe). You could imagine the client invoking "git-upload-pack
     --version=2" on the server, but of course no server implements that
     option yet (and if you added it, you'd have to wait for the server
     side support to percolate).

  c. provide more ways to get the v2 probe information to the server.
     For ssh, one obvious thing is to invoke "GIT_PROTOCOL=version=2
     git-upload-pack" on the server, using the shell to set the
     environment variable rather than passing it over ssh. We didn't do
     that when we added v2 because there are backwards compatibility
     failure modes (e.g., servers where the shell is not regular 'sh' or
     where there might not be a shell at all, or restricted environments
     which allow "git-upload-pack" to run but nothing else).

But maybe taking (b) and (c) together, we could add an option to ask the
client to pass the protocol variable via the shell. It doesn't have to
work everywhere because you'd enable it manually for servers where you
know it would work (and people configuring restricted servers probably
already made the necessary ssh config changes).

Of course the biggest challenging is users realizing that they need to
do something to enable v2 in the first place. For the most part v0 just
works, and so it is easy to not realize you're still using it.

-Peff
