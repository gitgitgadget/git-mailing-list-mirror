From: Karl Wiberg <kha@virtutech.com>
Subject: Re: [PATCH] Work around performance bug in
	subprocess.Popen.communicate()
Date: Fri, 14 Aug 2009 08:21:49 +0200
Message-ID: <20090814062149.GA23179@lux.e.vtech>
References: <20090731093632.7018.24435.stgit@october.e.vtech> <b0943d9e0907310427r7e59aa5fi5e5ff5e3f3c03819@mail.gmail.com> <20090804085125.GB27452@lux.e.vtech> <b0943d9e0908131518i3ac18331leb4c0c76313b0780@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mandolaerik@gmail.com, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 08:22:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbqAt-0006Uh-5d
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 08:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520AbZHNGVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 02:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753892AbZHNGVy
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 02:21:54 -0400
Received: from [62.20.90.206] ([62.20.90.206]:25563 "EHLO lux.e.vtech"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752613AbZHNGVx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 02:21:53 -0400
Received: from lux.e.vtech (lux.e.vtech [127.0.0.1])
	by lux.e.vtech (8.14.2/8.14.2) with ESMTP id n7E6LnR7023447;
	Fri, 14 Aug 2009 08:21:49 +0200
Received: (from kha@localhost)
	by lux.e.vtech (8.14.2/8.14.2/Submit) id n7E6LnlR023445;
	Fri, 14 Aug 2009 08:21:49 +0200
X-Authentication-Warning: lux.e.vtech: kha set sender to kha@virtutech.com using -f
Content-Disposition: inline
In-Reply-To: <b0943d9e0908131518i3ac18331leb4c0c76313b0780@mail.gmail.com>
X-Manual-Spam-Check: kha@virtutech.com, clean
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125900>

On 2009-08-13 23:18:59 +0100, Catalin Marinas wrote:

> 2009/8/4 Karl Wiberg <kha@virtutech.com>:
>
> > On 2009-07-31 12:27:53 +0100, Catalin Marinas wrote:
> >
> > > But can this not lead to a deadlock if the __indata is big? The
> > > stdout of the created process is only processed once the whole
> > > __indata is written. I thought communicate() was created to
> > > avoid this issue.
> >
> > I don't think there's a problem. write() isn't supposed to have a
> > limit on the amount of data it will accept in one call, as far as
> > I'm aware. Plus, it works just fine with Erik's test case---which
> > in my case was about 7 MB. If it can handle 7 MB, I doubt there's
> > a limit we'll hit anytime soon.
>
> write() itself doesn't have a limit, it's mainly what the
> application receiving the data can handle. In the Git case, I think
> it takes all the input as it isn't a filtering tool (things may be
> different with tools like sed etc.).
>
> > Oh, and we still call communicate()---we just don't pass it any
> > additional bytes to write to stdin.
>
> Yes, but if write() is blocked, communicate() won't be called.

Ah, so that's what you were worrying about. Yeah, if the process we're
writing to was going to block us (== not read input) for long periods
of time, we'd have to handle that case. And if it was going to decide
to stop reading input half-way through and give us a sigpipe, we'd
have to handle that. But ...

> Since we are only using Git, I'll merge this patch

Exactly. We really don't expect git to do any of those things to us.
We know it reads all available input before producing the output.
(Well, almost always. I have patches in my experimental branch that
use git cat-file --batch and git diff-tree --stdin, where there can be
many rounds of talking back and forth, but when driving those I'm
being very careful to not deadlock.)

> (and maybe add a comment).

Sure.

-- 
Karl Wiberg, Virtutech
