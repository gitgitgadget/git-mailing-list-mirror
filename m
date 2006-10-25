X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: VCS comparison table
Date: Wed, 25 Oct 2006 17:03:06 -0400
Message-ID: <20061025210306.GA29550@coredump.intra.peff.net>
References: <vpq4ptz2uh8.fsf@ecrins.imag.fr> <453DAC87.8050203@research.canon.com.au> <Pine.LNX.4.64.0610232318200.3962@g5.osdl.org> <Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu> <Pine.LNX.4.64.0610240812410.3962@g5.osdl.org> <Pine.LNX.4.64N.0610241300450.8112@attu4.cs.washington.edu> <20061025084810.GA26618@coredump.intra.peff.net> <Pine.LNX.4.64N.0610250157470.3467@attu1.cs.washington.edu> <20061025094900.GA26989@coredump.intra.peff.net> <Pine.LNX.4.64N.0610250954380.31053@attu2.cs.washington.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 21:03:30 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Lachlan Patrick <loki@research.canon.com.au>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0610250954380.31053@attu2.cs.washington.edu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30100>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcpu8-0008EU-BX for gcvg-git@gmane.org; Wed, 25 Oct
 2006 23:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422823AbWJYVDL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 17:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422842AbWJYVDL
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 17:03:11 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:40843
 "HELO peff.net") by vger.kernel.org with SMTP id S1422823AbWJYVDJ (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 17:03:09 -0400
Received: (qmail 1961 invoked from network); 25 Oct 2006 17:02:12 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 25 Oct 2006 17:02:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Oct
 2006 17:03:06 -0400
To: David Rientjes <rientjes@cs.washington.edu>
Sender: git-owner@vger.kernel.org

On Wed, Oct 25, 2006 at 10:21:42AM -0700, David Rientjes wrote:

> Yes, it does.  I'll give you an example from six months ago: there was a 

First off, thanks for giving examples. I was having trouble seeing where
you were coming from.

> need for the group that I work with to support a faster type of hashing 
> function for whatever reason.  This would have been simple with previous 
> versions of git, but if you've ever looked at the SHA1 code in git, you'll 
> realize that you're probably better off never trying to touch it.  There 
> is absolutely _no_ abstraction of it at all and the code is so deeply 
> coupled in the source that abstracting it away is a pain.

Is this really an artifact of the C code versus the shell code? A lot of
parts of the system need to touch SHA1 hashes, and I think it has been
sprinkled throughout the code from the beginning. In fact, I think the
libification of git-rev-list has made the code a lot _cleaner_ (and
shorter), in that the C programs can all use the same nice interface.
The external interface is still there, but now there is consistency
among programs when using rev syntax (ISTR issues in the distant past
where program X didn't understand syntax because the parsing was all
done ad-hoc).

> Likewise, there is always room for personal or organizational tweaks on 
> the part of the developer.  Things like distributed pulling and 
> merging should actually be pretty simple to implement if the complexity 
> wasn't so high in the merge-* family.  This is something I implemented 
> after an enormous headache because we were dealing with very large 
> projects: yes, larger than the Linux kernel.  And this is _exactly_ where 
> piping would help; we have implementations of distributed grep over very 
> large datasets (on the order of terabytes).

I guess I don't see how this was ever any easier. Do you mean that when
we called an external grep, it was easier to plug in your distributed
grep?

> > You can do the same thing in C. In fact, look at how similar
> > git-whatchanged, git-log, and git-diff are.
> No you can't.


The "same thing" I referred to was changing behavior trivially based on
the program name. So yes, you can.

> Making a one line addition, commenting out a line, or changing a
> simple flag in a shell script is much easier.  And like I already

Sure, shell can be easier to modify (though in well-written C, you're
likely just commenting out a few lines or a function call -- maybe you
can argue whether or not git is well-written). However, I remain
unconvinced that this is a common use case, or that it is something that
should weigh heavily when compared with portability, efficiency, or
robustness concerns.

> It's not, it's related to the original vision of git which was meant for 
> efficiency and simplicity.


Simplicity is fine if all you want is plumbing. But normal people want
to _use_ git without hacking their own shell scripts, so it makes sense
to provide the scripts that other people have hacked together (as shell,
perl, C, or whatever). Do I want to use git-send-email? Hell no, the
interface is terrible to me. But do the plumbing commands still exist so
that I can use the scripts I hacked together? Absolutely. I can take
what I want and leave the rest.

> A year ago it was very easy to pick up the package and start using it
> effectively within a couple hours.  Keep in mind that this was without

Was it? The most common complaint I've heard about git, starting a year
ago, was the lack of documentation and tutorials and the complexity of
use.

> tutorials, it was just reading man pages.  Today it would be very
> difficult to know what the essential commands are and how to use them
> simply to get the job done, unless you use the tutorials.  This

I think this has been the case for a long time. It's just that there
_weren't_ tutorials back then.

> Have you never tried to show other people git without giving them a 
> tutorial on the most common uses?  Try it and you'll see the confusion.  
> That _specifically_ illustrates the ever-increasing lack of simplicity 
> that git has acquired.

No, it illustrates a lack of simplicity that currently exists; it says
_nothing_ about the change in simplicity over time.

> There are _not_ scalability improvements.  There may be some slight 
> performance improvements, but definitely not scalability.  If you have 
> ever tried to use git to manage terabytes of data, you will see this 

There has been work on scaling to larger repositories (e.g., mozilla and
xorg prompting work/discussion on cvs importing, subproject/superproject
support, shallow clones, etc), but not on terabyte scales. I realize
that might not help you, but it is helping a lot of people. Quite
honestly, git is focused on SOURCE CODE MANAGEMENT, not terabytes of
data. Perhaps that is your true complaint: git is developing tools for
working with source code, potentially at the loss of some generality
(though I tend to think it hasn't lost generality, but rather it hasn't
gained).

> becomes very clear.  And "rebasing with 3-way merge" is not something 
> often used in industry anyway if you've followed the more common models 
> for revision control within large companies with thousands of engineers.  
> Typically they all work off mainline.

My point isn't that every feature is useful to every developer. My point
is that just because features aren't useful to _you_ doesn't mean
they're not useful at all.

And if you want to talk about industry standard, didn't the discussion
start off with your complaint about porting to Windows? An
industry-standard SCM needs to be cross-platform across the major
operating systems.

> Few months back here on the mailing list.  When I tried cleaning up even 
> one program, I got the response back from the original author "why fix a 
> non-problem?" because his argument was that since it worked the code 
> doesn't matter.

I remember a big discussion about the order of arguments in relational
expressions. Git may have problems, but I just don't see coding style
nitpicks as a priority.

Abstracting the hashing might be worthwhile, but the list consensus was
that it's not worth the work unless we're actually going to _do_
something with the abstraction.  Your argument seems to be that you
_are_ doing something with the abstraction on your own. If you want to
convince the git developers that this is a worthwhile direction, then
show some code which uses it.

> 	http://marc.theaimsgroup.com/?l=git&m=115589472706036

OK, I remember this particular discussion. And I just read through to
the end of the thread; it looks like Junio ended up with "this code is
ugly; fix it" and Johannes did.

It sounds like your real beef was that you want to use some alternate
"mv" command that handles your data set better, and having git-mv as a
shell-script would make that simpler for you.  Well, it isn't a shell
script and it never was. If you want to write it as one, I imagine it
would be considered for inclusion (though I expect the C version may
have some advantages, such as atomicity of file movement and index
updating).

