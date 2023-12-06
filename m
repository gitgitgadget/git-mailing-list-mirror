Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B579A
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 12:10:49 -0800 (PST)
Received: (qmail 5720 invoked by uid 109); 6 Dec 2023 20:10:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Dec 2023 20:10:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28255 invoked by uid 111); 6 Dec 2023 20:10:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Dec 2023 15:10:50 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Dec 2023 15:10:48 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Adam Majer <adamm@zombino.com>, git@vger.kernel.org
Subject: Re: [PATCH] setup: recognize bare repositories with packed-refs
Message-ID: <20231206201048.GE103708@coredump.intra.peff.net>
References: <20231117203253.21143-1-adamm@zombino.com>
 <20231128142845.11523-1-adamm@zombino.com>
 <20231128190446.GA10477@coredump.intra.peff.net>
 <ZWcOvjGPVS_CMUAk@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWcOvjGPVS_CMUAk@tanuki>

On Wed, Nov 29, 2023 at 11:13:18AM +0100, Patrick Steinhardt wrote:

> As I'm currently working on the reftable backend this thought has also
> crossed my mind. The reftable backend doesn't only create "refs/", but
> it also creates "HEAD" with contents "ref: refs/heads/.invalid" so that
> Git commands recognize the Git directory properly. Longer-term I would
> really love to see us doing a better job of detecting Git repositories
> so that we don't have to carry this legacy baggage around.
> 
> I can see different ways for how to do this:
> 
>     - Either we iterate through all known reference backends, asking
>       each of them whether they recognize the directory as something
>       they understand.
> 
>     - Or we start parsing the gitconfig of the repository so that we can
>       learn about which reference backend to expect, and then ask that
>       specific backend whether it thinks that the directory indeed looks
>       like something it can handle.
> 
> I'd personally prefer the latter, but I'm not sure whether we really
> want to try and parse any file that happens to be called "config".

We do eventually parse the config file to pick up repositoryFormatVersion.
But there's sort of a chicken-and-egg here where we only do so after
gaining some confidence that it's a repo directory. :)

I actually think the "ask each backend if it looks plausible" is
reasonable, at least for an implementation that knows about all
backends. Though what gives me pause is how older versions of Git will
behave with a new-format repository that does not have a "refs"
directory.

There are really two compatibility checks. In is_git_directory(), we
want to say "is this a repo or not". And then later we parse the config,
make sure the repository format is OK, and that we support all
extensions. So right now, an older version of Git that encounters a
reftable-formatted repo (that has a vestigial "refs/" directory) says
"ah, that is a repo, but I don't understand it" (the latter because
presumably the repo version/extensions in .git/config are values it
doesn't know about). But if we get rid of "refs/", then older versions
of Git will stop even considering it as a repo at all, and will keep
searching up to the ceiling directory. So either:

  1. They'll find nothing, and you'll get "you're not in a git repo",
     rather than "you're in a git repo, but I don't understand it".
     Which is slightly worse.

  2. They'll find some _other_ containing repo. Which could be quite
     confusing.

So forgetting at all about how we structure the code, it seems to me
that the problem is not new code, but all of the existing code which
looks for access("refs", X_OK).

I dunno. Maybe that is being too paranoid about backwards compatibility.
People will have to turn on reftable manually, at least for a while, and
would hopefully know what they are signing up for, and that old versions
might not work as well. And by the time a new format becomes the
default, it's possible that those older versions would have become quite
rare.

> Just throwing this out there, but we could use this as an excuse to
> introduce "extensions.refFormat". If it's explicitly configured to be
> "reffiles" then we accept repositories even if they don't have the
> "refs/" directory or a "packed-refs" file. This would still require work
> in alternative implementations of Git, but this work will need to happen
> anyway when the reftable backend lands.
> 
> I'd personally love for this extension to be introduced before I'm
> sending the reftable backend upstream so that we can have discussions
> around it beforehand.

We already have an extension config option to specify that we're using
reftable, don't we? But anything in config has the same chicken-and-egg
problems as above, I think.

-Peff
