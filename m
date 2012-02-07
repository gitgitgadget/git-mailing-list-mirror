From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] config includes, take 2
Date: Tue, 7 Feb 2012 00:17:19 -0500
Message-ID: <20120207051719.GA11598@sigill.intra.peff.net>
References: <20120206062713.GA9699@sigill.intra.peff.net>
 <CAJDDKr6A2UvB3D-Dapw7WCEzWfzLoLd0E8MSDjT0RtdxFeWZAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 06:17:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RudQk-0005MP-Tl
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 06:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591Ab2BGFRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 00:17:22 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59118
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187Ab2BGFRV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 00:17:21 -0500
Received: (qmail 4049 invoked by uid 107); 7 Feb 2012 05:24:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Feb 2012 00:24:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Feb 2012 00:17:19 -0500
Content-Disposition: inline
In-Reply-To: <CAJDDKr6A2UvB3D-Dapw7WCEzWfzLoLd0E8MSDjT0RtdxFeWZAQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190140>

On Mon, Feb 06, 2012 at 09:01:21PM -0800, David Aguilar wrote:

> I have a questions about this.  Let's say I have ~/foo1.gitconfig:
> 
> [foo]
>     bar = 1
> 
> ...and ~/.gitconfig (I forgot the syntax):
> 
> [foo]
>     bar = 0
> 
> #include "~/foo1.gitconfig"
> 
> 
> Does that mean that:
> 
>     $ git config -f ~/.gitconfig foo.bar
> 
> ...prints 0 and not 1?

Yes, though the syntax is:

  [include]
    path = foo1.gitconfig

(it doesn't respect tilde-expansion, but it probably should). Note that
the syntax was specifically selected for backwards compatibility, and to
allow manipulation with existing tools.

> I can see cases where this would be undesirable behavior.
> 
> For example, an application that uses "git config -z --list -f
> ~/.gitconfig" might expect that the result encompasses all of the
> user-specific config bits.

The problem is that an application might also expect it _not_ to happen
(e.g., if the application is really interested in knowing what's in
~/.gitconfig). Because includes aren't respected now, the safe default
seems to be not to have includes (i.e., don't change behavior for this
case).

A bigger question for me is: if you are interested in getting an answer
from anywhere, why are you restricting with "-f"? IOW, is this a
real-world problem, or a hypothetical one? And if real-world, what is
the actual use case?

> Following this to its natural conclusion means "git config" might
> learn some kind of --no-include flag for use with e.g. "git config
> --no-include -f ~/.gitconfig".  That said, I don't know where I would
> ever actually use such a flag.

It already learned it as part of my series (and --includes, as well).

> I do know where I would use an `--include` flag (if following includes
> were not the default behavior when using '-f'), though, and that's why
> I'm asking.  The problem with not having it be the default means we
> have to use a flag.  This makes it harder to support multiple versions
> of git.

Yes, that's a general problem of adding new command-line options to turn
features off or on. We could add an environment variable to control this
feature. But I'd really like to hear the compelling use case first
(i.e., both why it cannot simply be spelled "git config -z --list", and
why not following includes is not OK).

> Maybe I'm mis-interpreting what you mean by, 'do not use includes for
> "git config" in single-file mode', though.

No, I think you understand the described behavior.

-Peff
