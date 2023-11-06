Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F2A156E1
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD0DD42
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 09:31:35 -0800 (PST)
Received: (qmail 21884 invoked by uid 109); 6 Nov 2023 17:31:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 06 Nov 2023 17:31:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11910 invoked by uid 111); 6 Nov 2023 17:31:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Nov 2023 12:31:35 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 6 Nov 2023 12:31:33 -0500
From: Jeff King <peff@peff.net>
To: Joanna Wang <jojwang@google.com>
Cc: git@vger.kernel.org
Subject: Re: Bug: magic-less pathspecs that start with ":" not processed as
 expected.
Message-ID: <20231106173133.GC10414@coredump.intra.peff.net>
References: <CAMmZTi-JJ6=Uw_+r50hKMYf34D0NtqXhaA=f+11+wAQBjqA7_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMmZTi-JJ6=Uw_+r50hKMYf34D0NtqXhaA=f+11+wAQBjqA7_g@mail.gmail.com>

On Mon, Nov 06, 2023 at 10:54:03AM -0500, Joanna Wang wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> What did you expect to happen? (Expected behavior)
> `git stash push -- :file` where `:` is part of the filename, should search
> for files named ":file"
> 
> What happened instead? (Actual behavior)
> The match string used to find files is "file" without the ":".
> 
> What's different between what you expected and what actually happened?
> file named ":file" is not found.
> 
> Anything else you want to add:
> I believe this is due to parse_short_magic() not handling the case where
> ":" is part of the file name rather than a prefix for pathspec magic.
> 
> I could not find any documentation that says ":" is a reserved
> character to indicate pathspec magic symbols MUST follow or that
> ":file" is not a valid file name.

I think this is the correct behavior according to the documentation.
From "git help glossary", the entry on "pathspec" says:

  A pathspec that begins with a colon : has special meaning. In the
  short form, the leading colon : is followed by zero or more "magic
  signature" letters (which optionally is terminated by another colon
  :), and the remainder is the pattern to match against the path.

So ":file" just has zero magic signature letters. I think you want:

  :::file

which of course is rather ugly, but then so is your filename. ;)
Although longer, probably this is more readable:

  :(literal):file

And if you're working with a lot of such files (or you are scripting and
know you have a set of filenames), then your best bet is probably
turning on literal mode, like:

  git --literal-pathspecs ls-files -- :file

-Peff

PS It took me a while to figure out where we document pathspec syntax. I
   wonder if a "gitpathspecs" manpage would make sense, like we have
   "gitrevisions".
