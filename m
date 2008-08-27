From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH] be paranoid about closed stdin/stdout/stderr
Date: Wed, 27 Aug 2008 11:18:00 +0200
Message-ID: <20080827091800.GB484@cuci.nl>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu> <48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org> <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net> <7vbpzgb94q.fsf@gitster.siamese.dyndns.org> <E1KXsL9-0004ef-Co@fencepost.gnu.org> <48B3A948.3080800@viscovery.net> <20080826074044.GA22694@cuci.nl> <32541b130808262201v4d7c1aa5r781720a80b79fcd0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Paolo Bonzini <bonzini@gnu.org>,
	Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 11:19:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYHBF-0005kd-0G
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 11:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350AbYH0JSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 05:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752903AbYH0JSD
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 05:18:03 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:60177 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbYH0JSB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 05:18:01 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 30B755465; Wed, 27 Aug 2008 11:18:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <32541b130808262201v4d7c1aa5r781720a80b79fcd0@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93880>

Avery Pennarun wrote:
>On 8/26/08, Stephen R. van den Berg <srb@cuci.nl> wrote:
>> Well, in general the policy I've used in all the tools I created is that:

>>  a. If it's a setuid tool, then you need to make sure that you don't step
>>    on anything unintendedly.  I.e. for setuid-something programs this is
>>    desirable and necessary in order to prevent securityleaks.

>>  b. Anything else is started in an environment controlled by the user,
>>    and if this environment is broken, then that is the user's fault.

>In general I'd mostly agree with you, but fd 0/1/2 are super-special
>and I've personally been bitten by insane, rare problems that occur
>when programs are started with one or more of those fds closed.

Key words: "insane, rare problems"

>The usual case is that you're writing a new daemon.  The generally
>accepted behaviour for a daemon is to chdir("/') and then close all

>the daemon *or* git was using.  Remember, the situations where the
>daemon leaves fd#2 open pointing at *the wrong thing* aren't the real
>problem - you could easily say that's the daemon leaving the
>environment in an insane state.  The problem situation is when git

Well, as you say, "you're writing a new daemon".  This means that you
need to make sure that *if* this daemon ever forks/execs it leaves the
environment in a sane state which does not open up security holes.
That means that you need to sanitise the environment, that you need to
keep tabs on all the descriptors that need to be closed on exec, and
that it needs to make sure that fd 0, 1 and 2 are pointing to somewhere
appriopriate (/dev/null, if nothing else).
The fact that you forgot to do some of those things means that it is
very helpful if you discover this fact as soon as possible.  By making
git "fix it for you" you will not notice any problems when running git
from your daemon.  Nonetheless this will not cause you to fix your
code.

>Does this sound rare?  It is!  But it's also hellish to debug when it
>happens, precisely because of its rarity.  For example, in one case, I
>had this problem because an sfdisk process started by my custom

Thing is, by making git (and some other programs) hide this problem
from you, this problem will get even *harder* to debug.  Whereas as a
daemon author you should be thankful that something breaks and shows you
your daemon needs fixing.

>Anyway, I personally think that given how incredibly cheap this
>operation is to do, and how startlingly painful it is to debug when it
>*is* a problem, that it would be nice if every program just did this
>by default.  I would personally feel fine if such a thing ended up in
>libc or the kernel, although presumably that would violate POSIX.

And then you'd have the situation that in some cases, where this
mechanism is bypassed or not present, various daemons might show security
holes in their filedescriptor management which nobody noticed before.

>Yes, it would also be fine to have every *daemon* make sure it opens
>/dev/null instead of just closing fd 0/1/2. 

It would not only be fine, it *is* required, since 1972.

> But it's harmless to have
>both.

Considering the fact that daemon authors might not get pointed at their
mistakes as soon as possible, it is harmful to try and hide those facts.

>(As for the non-builtin git commands, isn't this an advantage of
>having everything get run through the main /usr/bin/git wrapper?)

At best a program (e.g. git) could give off a warning when it finds
the filedescriptors in a bad state (and then fix it), but that would
mean that from within git we'd be trying to save the world, since anyone
not running git would not get those warnings.  You have to draw the line
somewhere, and for user-tools it ends here; for setuid-tools it's
different: they need to detect and fix it anyway, and therefore could easily
warn as well.
-- 
Sincerely,
           Stephen R. van den Berg.
"First, God created idiots.  That was just for practice.
 Then he created school boards."  --  Mark Twain
