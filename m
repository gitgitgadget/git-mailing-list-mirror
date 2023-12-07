Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650A5D44
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 23:34:52 -0800 (PST)
Received: (qmail 10105 invoked by uid 109); 7 Dec 2023 07:34:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Dec 2023 07:34:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1221 invoked by uid 111); 7 Dec 2023 07:34:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Dec 2023 02:34:55 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Dec 2023 02:34:51 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Adam Majer <adamm@zombino.com>, git@vger.kernel.org
Subject: Re: [PATCH] setup: recognize bare repositories with packed-refs
Message-ID: <20231207073451.GA1278091@coredump.intra.peff.net>
References: <20231117203253.21143-1-adamm@zombino.com>
 <20231128142845.11523-1-adamm@zombino.com>
 <20231128190446.GA10477@coredump.intra.peff.net>
 <ZWcOvjGPVS_CMUAk@tanuki>
 <20231206201048.GE103708@coredump.intra.peff.net>
 <ZXFt1foDuHKBmFwk@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXFt1foDuHKBmFwk@tanuki>

On Thu, Dec 07, 2023 at 08:01:41AM +0100, Patrick Steinhardt wrote:

> > So forgetting at all about how we structure the code, it seems to me
> > that the problem is not new code, but all of the existing code which
> > looks for access("refs", X_OK).
> 
> True. The question is of course how much value there is in an old tool
> to be able to discover a new repository that it wouldn't be able to read
> in the first place due to it not understanding the reference format. So
> I'd very much like to see that eventually, we're able to get rid of
> "legacy" cruft that doesn't serve any purpose anymore.

Right, nobody is going to be mad about not being able to use the
repository with old code. My concern is that by skipping it in the
discovery phase, though, the user may see unexpected behavior (like
continuing and finding some _other_ repo). I admit it's a pretty narrow
case, though.

> The question is whether we can do a better job of this going forward so
> that at least we don't have to pose the same question in the future.
> Right now, we'll face the same problem whenever any part of the current
> on-disk repository data structures changes.
> 
> I wonder whether it would make sense to introduce something like a
> filesystem-level hint, e.g. in the form of a new ".is-git-repository"
> file. If Git discovers that file then it assumes the directory to be a
> Git repository -- and everything else is set up by parsing the config
> and thus the repository's configured format.

I kind of think the presence of a well-formed HEAD is a good indicator
that it is a Git directory. IOW, I don't have any real problem with
simply loosening is_git_directory() to remove the "refs/" check
entirely. But again, that can only help us going forward; older versions
will still get confused if we truly ditch "refs/" for other formats.

Of course some ref formats may want to avoid the "HEAD" file itself, so
your .is-git-repository would be cleaner. I'm just not sure if it's
worth the headache to try to switch things now.

> > We already have an extension config option to specify that we're using
> > reftable, don't we? But anything in config has the same chicken-and-egg
> > problems as above, I think.
> 
> Not yet, no. I plan to submit the new "extensions.refFormat" extension
> soonish though, probably next week.

Ah, OK. I remember talking about it with Han-Wen long ago, but I admit I
have not paid much attention to reftable work recently. :) So I am happy
you are picking it up.

-Peff
