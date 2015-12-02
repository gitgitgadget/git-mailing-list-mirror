From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clean: new option --exclude-from
Date: Wed, 2 Dec 2015 12:51:45 -0500
Message-ID: <20151202175144.GA18550@sigill.intra.peff.net>
References: <1448549065-16337-1-git-send-email-rouzier@gmail.com>
 <20151202005338.GD28197@sigill.intra.peff.net>
 <xmqq37vl7fux.fsf@gitster.mtv.corp.google.com>
 <20151202024403.GA29329@sigill.intra.peff.net>
 <xmqqlh9c6byy.fsf@gitster.mtv.corp.google.com>
 <20151202164712.GA16636@sigill.intra.peff.net>
 <xmqqd1uo69vf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James <rouzier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 18:51:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4BZJ-0003JH-NT
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 18:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933116AbbLBRvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 12:51:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:36395 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755265AbbLBRvs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 12:51:48 -0500
Received: (qmail 28598 invoked by uid 102); 2 Dec 2015 17:51:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Dec 2015 11:51:47 -0600
Received: (qmail 651 invoked by uid 107); 2 Dec 2015 17:51:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Dec 2015 12:51:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Dec 2015 12:51:45 -0500
Content-Disposition: inline
In-Reply-To: <xmqqd1uo69vf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281895>

On Wed, Dec 02, 2015 at 09:25:24AM -0800, Junio C Hamano wrote:

> I do not think we should liberally add options that apply to
> anything "git" in the first place [*1*].  Limit them to ones that
> are really special and fundamental that changes the way Git
> operates, i.e. "Where is our $GIT_DIR?" is a good thing for users to
> be able to tell "git" itself.  Compared to that, the ignore patterns
> is a fringe that is used only by commands that care about the
> working tree (e.g. the global option in "git --exclude='*.o'
> ls-tree" would be meaningless).
> 
> 
> [Footnote]
> 
> *1* It would add unnecessary confusion to the end users; they have
>     to decide if they need to pass an option before or after the
>     subcommand name.  If the motivation behind the "git --option cmd"
>     is to share code and semantics for common "--option", we should
>     instead further refactor command line option handling, just like
>     the code for config handling allows us to share config_default.

My motivation isn't exactly code sharing. It is that you sometimes want
to affect sub-commands of a program, and cannot pass command line
options to them yourself.

For instance, "git-stash --include-untracked" will call "git clean"
under the hood. There is no way to say "...and treat foo.* as ignored
for this invocation". It could grow its own "-e" option, but that does
not help any other third-party scripts which call "git clean".

So IMHO this is not really about command-line options, but about the
environment in which a command is executed. Environment variables are
the obvious way to do that; "git --foo" options are just syntactic sugar
to set the variables. We could just add variables without matching
options.

I agree that we could end up proliferating such options (or environment
variables). Using the logic above, you could argue that I should be able
to affect any option of any sub-command in a script, which just gets
silly. My rule of thumb would be that if there is some implicit state in
the on-disk repo (e.g., what is in your .git/config) that you
might want to override for a one-shot invocation, then it may be a
reasonable candidate. The "git -c" config override is such an example.

In this case, it is basically adding to ".git/info/exclude", which
follows the same rule.

But like I said, I do not feel all that strongly about this particular
option. I would not use it myself. Just trying to make my reasoning
clear. :)

-Peff
