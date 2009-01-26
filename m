From: Jeff King <peff@peff.net>
Subject: Re: backwards compatibility, was Re: [PATCH v1 1/3] Introduce
	config variable "diff.primer"
Date: Mon, 26 Jan 2009 06:59:57 -0500
Message-ID: <20090126115957.GA20558@coredump.intra.peff.net>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <1232904657-31831-2-git-send-email-keith@cs.ucla.edu> <7v1vurf7lq.fsf@gitster.siamese.dyndns.org> <alpine.GSO.2.00.0901251345240.12651@kiwi.cs.ucla.edu> <20090126031206.GB14277@sigill.intra.peff.net> <alpine.DEB.1.00.0901261154330.14855@racer> <20090126111605.GB19993@coredump.intra.peff.net> <alpine.DEB.1.00.0901261220300.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Keith Cascio <keith@CS.UCLA.EDU>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 26 13:01:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRQ9i-0006eS-4A
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 13:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbZAZMAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 07:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbZAZMAA
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 07:00:00 -0500
Received: from peff.net ([208.65.91.99]:54920 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974AbZAZL77 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 06:59:59 -0500
Received: (qmail 2931 invoked by uid 107); 26 Jan 2009 12:00:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 26 Jan 2009 07:00:07 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Jan 2009 06:59:57 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901261220300.14855@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107203>

On Mon, Jan 26, 2009 at 12:28:55PM +0100, Johannes Schindelin wrote:

> > Are you aware that gitweb no longer calls "git diff", exactly because
> > of problems caused by calling a porcelain from a script?
> 
> As I said: do you really expect people not to forget to upgrade gitweb 
> manually when they do "sudo make install" with a new Git version?

Yes.

But my point is that gitweb was _already_ broken, because it was calling
a porcelain, and there were _already_ features that could cause serious
breakage.

So yes, adding a new feature that a user can trigger causes one more
opportunity for breakage. But the solution isn't to never ever add more
features to "git diff". It's to close the avenue by which the new _and_
old breakages are triggered.

> > I don't want to break existing setups, either. But at some point you 
> > have to say "this is porcelain, so don't rely on there not being any 
> > user-triggered effects in its behavior". If porcelain is cast in stone, 
> > then what is the point in differentiating plumbing from porcelain?
> 
> Two points there:
> 
> - with gitweb, we were the offenders ourselves.  So we should give the 
>   users of gitweb at least _some_ slack.

I'm not sure I agree. I always assumed that since gitweb, git-gui, and
gitk are bundled with git during release that we have _more_ leeway in
making matching changes between them.

Are you sure that you can run random versions of gitweb with random
versions of git in the first place?

> - Concretely for the "porcelain" git diff: This workflow
> 
> 	git diff > my-patch
> 	<attach and send to somebody>
> 
>   is probably pretty wide spread.  And it is okay, a user is not a script, 
>   they are very much allowed to use porcelain.  And we _would_ break 
>   expectations there.

Sorry, but what in the world are we supposed to do? Never ever allow the
user to specify diff options to a porcelain because they might impact
the output? A user who sets a config option or a command line option to
impact the output of "git diff" is responsible for how they use "git
diff".

There are already options like this in "git diff". I don't see how one
more changes anything.

> Now, I have another two, fundamental problems with the diff options 
> defaults: you are restricting the thing to _one_ set of options, and when 
> somebody wants to run without those options, she has to actively _undo_ 
> them.

Yep, that's what defaults are. And guess what: we _already_ have the
same thing. I have diff.renames set in my ~/.gitconfig. That does
_exactly_ what

  git config --global diff.primer -M

would do. It's just a syntax that saves us from having to introduce a
boatload of new variables, one per command line option.

> Remember, sometimes you need another set of options. Like, when I send 
> mail to a Git user, I want "-M -C -C", when I send mail to a non-Git user, 
> I do not want any additional options (and try to undo "-M -C -C" on the 
> command line, good luck), and sometimes it is much easier to see what 
> happened with a word diff.

This is a strawman. You have described a scenario where an alias or a
wrapper script is a better fit. Great, then use that mechanism in this
scenario. But that doesn't mean there aren't other scenarios where a
different setup makes more sense (I think Keith's original goal was to
use "-w").

> So what I need are three different sets of diff options.
> 
> Guess how well that works with aliases -- we are talking command line 
> here after all, right?

Personally, I have always found the suggestion that users simply put
their preferences into an alias like "mydiff" to be a silly one: git has
already taken the obvious good names, so now I am stuck using "git
mydiff" forever and forgetting that "git diff" even exists.

But then, I don't have your "three sets of options" scenario. I just
want one set of defaults. So I don't have a need to name each one, and
having to choose a different name becomes a detriment rather than an
advantage.

However, there are two other drawbacks of aliases that I can think of:

  1. They are tied to a specific command, whereas diff options are tied
     to the concept of diffing. So now I have to write an alias (with a
     new name) for each command:

       git config alias.mylog 'log -w'
       git config alias.mydiff 'diff -w'
       git config alias.myshow 'show -w'

  2. They can't change defaults based on the file to be diffed. One of
     the things Keith mentioned (and I don't remember if this was
     implemented in his patch series) was supporting this for
     gitattributes diff drivers. How do I do

       git config diff.tex.primer -w

     using aliases?

But now you have me defending Keith's proposal, which he should be doing
himself ;P I actually am not that excited about it, and will probably
not use it for anything myself. But I think:

  - it lets the user accomplish useful things that would not
    otherwise be possible

  - supporting it in "git diff" does not create any danger that was not
    already there

which means that I have no objection to a clean version being applied.

-Peff
