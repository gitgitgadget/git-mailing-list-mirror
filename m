Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B4AD5B
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 13:16:40 -0800 (PST)
Received: (qmail 5944 invoked by uid 109); 6 Dec 2023 21:16:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Dec 2023 21:16:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28730 invoked by uid 111); 6 Dec 2023 21:16:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Dec 2023 16:16:41 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Dec 2023 16:16:39 -0500
From: Jeff King <peff@peff.net>
To: Sven Strickroth <sven@cs-ware.de>
Cc: git <git@vger.kernel.org>
Subject: Re: --end-of-options inconsistently available?!
Message-ID: <20231206211639.GB106480@coredump.intra.peff.net>
References: <4d944fe3-d31d-4859-8ed2-6c1da64410fe@cs-ware.de>
 <20231127212254.GA87495@coredump.intra.peff.net>
 <ab14260c-d515-425e-8ef6-5739d3d6ca4e@cs-ware.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab14260c-d515-425e-8ef6-5739d3d6ca4e@cs-ware.de>

On Tue, Nov 28, 2023 at 09:40:08AM +0100, Sven Strickroth wrote:

> > This one is intentional. rev-parse in its default mode is not just
> > spitting out revisions, but also options that are meant to be passed
> > along to the revision machinery via other commands (like rev-list). So
> > for example:
> > 
> >    $ git rev-parse --foo HEAD
> >    --foo
> >    564d0252ca632e0264ed670534a51d18a689ef5d
> > 
> > And it does understand end-of-options explicitly, so:
> > 
> >    $ git rev-parse --end-of-options --foo --
> >    --end-of-options
> >    fatal: bad revision '--foo'
> > 
> > If you just want to parse a name robustly, use --verify.
> 
> I would expect that -- and --end-of-options are handled in a special way
> here so that rev-parse can also be used in scripts. I need to check whether
> --verify works for me (from the manual I thought I need to specify full
> reference names).

They _are_ handled specially, and for the purpose of using rev-parse in
scripts. It's just that in its default mode it does not do what you
want, because it has another purpose.

> > > $ git checkout -f --end-of-options HEAD~1 -- afile.txt
> > > fatal: only one reference expected, 2 given.
> > 
> > I think this is the same KEEP_DASHDASH problem as with git-reset.
> 
> I also found another problem:
> $ git format-patch --end-of-options -1
> fatal: option '-1' must come before non-option arguments
> 
> Where -1 is the number of commits here...

This is the same as the "log --end-of-options --foo" example I showed
earlier. That "-1" cannot mean "use 1 commit", since you used it after
--end-of-options. It will correctly resolve refs/heads/-1 if you have
such a ref. But if you don't, then the DWIM logic for distinguishing
revisions and pathspecs produces a confusing message.

It would be possible to fix that (by telling verify_filename() that we
saw --end-of-options, and not to treat dashes specially). But in
practice if you are bothering to use --end-of-options, you really ought
to be using "--" as well, like:

  git format-patch --end-of-options $revs -- $paths

in which case it will know that "-1" _must_ be a revision, and complain:

  $ git format-patch --end-of-options -1 --
  fatal: bad revision '-1'

-Peff
