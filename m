From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] prompt: don't scream continuation state
Date: Tue, 4 Jun 2013 00:38:37 -0400
Message-ID: <20130604043836.GA3931@sigill.intra.peff.net>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
 <1370181822-23450-2-git-send-email-artagnon@gmail.com>
 <87r4gjzi3d.fsf@linux-k42r.v.cablecom.net>
 <CALkWK0=LzUe0k7rWcrbiiTZNOOGg+=SsQB3u2F2ysjb5AJ=qZw@mail.gmail.com>
 <20130603211556.GB23224@sigill.intra.peff.net>
 <CALkWK0=5XecaMpPPQgvJZTwR2QUUWVqbZK5p7af9R1HjA0U=OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 06:38:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujj1A-0003XC-Rl
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 06:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570Ab3FDEil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 00:38:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:37587 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972Ab3FDEik (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 00:38:40 -0400
Received: (qmail 25940 invoked by uid 102); 4 Jun 2013 04:39:25 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Jun 2013 23:39:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Jun 2013 00:38:37 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0=5XecaMpPPQgvJZTwR2QUUWVqbZK5p7af9R1HjA0U=OQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226310>

On Tue, Jun 04, 2013 at 09:14:23AM +0530, Ramkumar Ramachandra wrote:

> Jeff King wrote:
> > It seems silly to argue about output formats when we are writing a
> > prompt in a convenient Turing-complete scripting language already.
> > What about something like:
> 
> Could you have a look at __git_ps1_colorize_gitstring from
> rr/zsh-color-prompt in pu?  In the general case, wouldn't the user
> need to re-implement this entire function (with so many variables) in
> her ~/.zshrc?  Isn't it horribly painful for too little gain?

It is a lot of ugly code, but then, complexity and flexibility are a
tradeoff. You would not _have_ to use a custom function at all. But if
we make it an option, and leave the existing code as the default
function, then only those who want it have to use it.

Even better, we can hit a middle ground by abstracting away some of the
complexity.  You could probably write colorize() function to handle
colorizing a particular string (and handle bash/zsh magic), and then
pull the whole "which color is the branch" function into a
colorize_branch(), and so forth.

I haven't looked that closely, so there may be hidden troubles awaiting,
but I don't see why you couldn't ultimately let the user write something
like:

  __git_ps1_printer() {
          echo ' ('
          test "$bare" = t && echo "BARE:"; # or "bare:" :)
          color_branch "$(short_ref $branch)" "$detached"
          test "$wt_changes" = t && colorize red "*"
          ...
          echo ')'
  }

And if that is too much, you can abstract bits of it out. The point is
that if we can expose the lowest-level details, we can compose functions
around them at whatever level is appropriate, and callers can mix and
match for the balance of complexity and flexibility they want.

Perhaps it is overkill, but I also think it may make the code itself
more readable. For example, I put a "..." above because the next line
would handle this:

  if [ -n "$i" ]; then
          gitstring="$gitstring\[$ok_color\]$i"
  fi

I have no clue what that does, or what the global variable "$i"
contains. Reading through __git_ps1, it looks like it will be "+" for
index changes. Being able to write:

  test "$index_changes" = t && colorize green "+"

seems much more readable to me. And we could probably compose a:

  colorize_diff_state() {
          test "$wt_changes" = t && colorize red "*"
          test "$index_changes" = t && colorize green "+"
  }

for people who just want to take the default colors and characters.

-Peff
