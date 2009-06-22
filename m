From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default???
Date: Mon, 22 Jun 2009 09:31:42 -0700
Message-ID: <7vws74cjrl.fsf@alter.siamese.dyndns.org>
References: <h1nks1$vdl$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 18:31:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MImR4-00066u-28
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 18:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757188AbZFVQbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 12:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757141AbZFVQbm
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 12:31:42 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:45466 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757529AbZFVQbk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 12:31:40 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090622163143.PJYT20430.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>;
          Mon, 22 Jun 2009 12:31:43 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 74Xi1c00L4aMwMQ044XiN3; Mon, 22 Jun 2009 12:31:42 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=mDV3o1hIAAAA:8 a=KjGjMYOz04QuZPh4kG0A:9
 a=yzI5nd6kAm5fQmfBSGAA:7 a=Kn1tHH5SCAZjLq-NOrw0QSyOaYQA:4 a=P12RAKQObZoA:10
 a=ii61gXl28gQA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122047>

Paolo Bonzini <bonzini@gnu.org> writes:

> 1) Also in 1.6.3, invent a special refspec for "tracking", something
> like "HEAD>" (of course this is not a special case; "refs/heads/*>"
> would also work, yadda yadda)

You cannot do anything "in 1.6.3"; The ship has already left the port.

You can set push.default to "tracking" and have it take effect for all
remotes you interact with from your repository (set remote.$name.push for
some remotes you do not want this to take effect).  Instead, you could
leave push.default to "matching" and define remote.$name.push with the
"push tracking" magic you are going to invent for a specific remote.

Both arrangements can do the same thing, so even if your "HEAD>" is never
supported, there is no functionality loss (similarly, if we did not have
"push.default", we would be Ok if we had your "HEAD>" magic).  Depending
on which one you would want to use for majority of remotes you interact
with, you would want both.

So in that sense, I do not think the current situation is such a "total
nonsense" as you seem to be painting it [*1*].  It just does not have the
other half of the story that you are bringing up now.

In other words, I do not have objection to your "HEAD>" at the conceptual
level.  At the syntax level, I suspect people will have suggestions for
better alternatives.

In retrospect, because a push refspec (or "magic" you will be adding) for
a specific remote is called "remote.$name.push", it might have been a
better idea to use "remote.push" instead of "push.default" as the name of
the configuration variable.  Then the rules can become

	* if you ask explicitly from the command line, it wins;
	* otherwise, if you have remote.$name,push, it is used;
        * otherwise, if you have remote.push, it is used;
        * otherwise, the default is "matching".

which is slightly nicer to read, than the current situation where the
third rule talks about push.default instead.

> 2) Also in 1.6.3, add a "--push={current,tracking,matching,mirror}"
> option to "git remote add" that would set up a push refspec without
> the need to actually know refspec syntax. (--mirror would become just
> a synonym for --push=mirror).

This is probably sensible if/when we do (1).  

But here I have to qualify what I mean by (1).  I am not married to the
idea of using remote.$name.push at all.  I view (1) as solving this issue:

        Currently with push.default, we can only set push.default to
        something other than "matching" and have specific remote override
        that with remote.$name.push with a more concrete refspec, if we
        want to have the magic 'tracking push' semantics.

        We want to have a way to say "for this and that particular
        remotes, use the magic tracking push" in a more direct way.

And hiding the detail of how this "direct way" is implemented from the end
user is a good idea.

> 3) Possibly, in 1.6.3 make "git clone" add a "push = :" line for the
> origin branch.  This was actually suggested in a patch by myself.

This contradicts with (1), I think.  The default after cloning is
"matching", and if one wants to change it to "track", one not just needs
to set push.default but also needs to remove/twaek remote.origin.push
if you add such a line.

So I do not think this one makes much sense.

> 4) in 1.6.4 or 1.7.0, make "git push" fail outright if there is no
> push line, with text suggesting

This was already part of one possible option for push.default (change the
built-in default to 'nothing-and-warn') when it was introduced, wasn't it?
Instead of suggesting to configure remote.$name.push, it would suggest to
set push.default to a desired value, which I think is a more sensible
thing to do.

[Footnote]

*1* ... even though I admit that I am not convinced 'push "tracking"'
makes much sense for me to begin with, because pushing a branch to the
branch it forked from rarely if ever makes sense in my workflow.  But I
can see 'push "tracking"' makes sense in some situations and people seem
to want to do this, so we have already added push.default.
