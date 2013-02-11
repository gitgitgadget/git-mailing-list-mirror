From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Mon, 11 Feb 2013 12:27:52 -0500
Message-ID: <20130211172752.GH16402@sigill.intra.peff.net>
References: <20130211041706.GB15329@elie.Belkin>
 <7vwqufpj50.fsf@alter.siamese.dyndns.org>
 <20130211043247.GD15329@elie.Belkin>
 <7vpq07pgpy.fsf@alter.siamese.dyndns.org>
 <20130211061442.GI15329@elie.Belkin>
 <7vliavpc4q.fsf@alter.siamese.dyndns.org>
 <20130211071235.GL15329@elie.Belkin>
 <7v8v6vpbej.fsf@alter.siamese.dyndns.org>
 <20130211160057.GA16402@sigill.intra.peff.net>
 <7v38x2ojl1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 18:28:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4xB1-0000VQ-E6
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 18:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758177Ab3BKR15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 12:27:57 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44390 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758357Ab3BKR1y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 12:27:54 -0500
Received: (qmail 24247 invoked by uid 107); 11 Feb 2013 17:29:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Feb 2013 12:29:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2013 12:27:52 -0500
Content-Disposition: inline
In-Reply-To: <7v38x2ojl1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216065>

On Mon, Feb 11, 2013 at 09:18:18AM -0800, Junio C Hamano wrote:

> That "shell-disabled" thing was to allow customizing the existing
> die() that triggers here:
> [...]
> so it is more like
> 
> 	if ! test -d $HOME/git-shell-commands
> 	then
> 		if test -x /etc/git/shell-disabled
>                 then
> 			exec /etc/git/shell-disabled
> 		else
> 			die Interactive is not enabled
> 		fi
> 	fi
>         ... do whatever in run_shell() ...

OK, that is equivalent to what I said (or at least what I was trying to
say :) ).

> > That at least means you can apply _whether_ to disable the shell
> > selectively for each user (by providing or not a git-shell-commands
> > directory), but you cannot individually select the script that runs for
> > that user.  But it's probably still flexible enough;...
> 
> Such a flexibility is not a goal of /etc/git/shell-disabled.  The
> sole goal is to make the life easier for those site owners that do
> not want any interactive shell access to give more friendly and
> customized error message.
> 
> Those who want further flexibility can exit with non-zero from the
> "help" (which is still a misnomer for a hook to disable interactive
> for the user).

Ah, I thought you were proposing shell-disabled _instead_ of Jonathan's
patch, not in addition to.

> My primary objection is that implementing only that "more flexible
> but requires more configuration work" solution without giving
> simpler solution (i.e. just one thing to configure) to the majory of
> site owners who only have simpler problem to solve (i.e. just want
> to customize "no interactive here"), and saying that the latter can
> be done on top.  It is backwards mentality.

Oh, absolutely. The easy case should be easy, and the hard case
possible. But another way of doing that (which would also make life
easier for admins who want to share config besides shell-disabled) would
be:

  1. Give Jonathan's magic meaning to ~/git-shell-commands/help's exit
     code.

  2. Make /etc/git/shell-commands a fallback if ~/git-shell-commands
     does not exist.

That turns your /etc/git/shell-disabled into /etc/git/shell-commands/help.
It is just as simple to do a site-wide change, still allows per-user
overrides, and additionally gives people who _do_ want the interactive
commands the ability to configure them site-wide instead of symlinking a
directory into everybody's homedir.

The only downside is that it has the confusing "create this directory to
turn on interactivity, then create a file in it to turn it back off"
feature.

I admit I don't care too much, though. I have never actually used
git-shell, as my systems are all either too small (i.e., users are
trusted and have shell access) or too big (grown well beyond a single
server that connects users straight to git-shell). In fact, there seems
to be a lot of guessing in this thread about what people would want, as
it seems none of us actually uses the feature. Maybe that is a sign it
is being over-engineered. :)

-Peff
