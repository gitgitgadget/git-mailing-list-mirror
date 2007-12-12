From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-clone: Implement git clone as a builtin command.
Date: Wed, 12 Dec 2007 11:12:50 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712121103510.27959@racer.site>
References: <20071211195712.GA3865@bitplanet.net> <Pine.LNX.4.64.0712111549490.5349@iabervon.org>
 <1197416286.7552.4.camel@hinata.boston.redhat.com> <7vejdsbo7d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-284983851-1197457970=:27959"
Cc: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 12:13:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2PWf-00037h-6l
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 12:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbXLLLMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 06:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753907AbXLLLMy
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 06:12:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:42043 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751631AbXLLLMx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 06:12:53 -0500
Received: (qmail invoked by alias); 12 Dec 2007 11:12:51 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 12 Dec 2007 12:12:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1887zx27uk8w6tToiz5FwChawS6Y1a2kC8+RLxBbf
	klPJcR3ORyGqH7
X-X-Sender: gene099@racer.site
In-Reply-To: <7vejdsbo7d.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68036>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-284983851-1197457970=:27959
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 11 Dec 2007, Junio C Hamano wrote:

> Kristian Høgsberg <krh@redhat.com> writes:
> 
> > On Tue, 2007-12-11 at 15:59 -0500, Daniel Barkalow wrote:
> >> On Tue, 11 Dec 2007, Kristian Høgsberg wrote:
> >> 
> >> > Ok, don't flame me, I know this isn't appropriate at the moment 
> >> > with stabilization for 1.5.4 going on, but I just wanted to post a 
> >> > heads up on this work to avoid duplicate effort.  It's one big 
> >> > patch at this point and I haven't even run the test suite yet, but 
> >> > that will change.
> >> 
> >> Is that why you misspelled Junio's email address? :)
> >
> > Hehe, yeah, do not mess with maintainers in release mode :)
> 
> Actually this is a bit unfortunate, regardless of everybody being in 
> release and bugfix only mode.

I can understand that feeling, but I have to say that I am actually quite 
pleased with the progress in direction of having most of git as builtins.

> I was hoping that the evolution path for clone would be to first make it 
> a very thin wrapper around:
> 
> 	git init
>         git remote add -f
>         git checkout
> 
> sequence.

Yeah, I thought so too, but I'll also gladly take the builtin first.

> There are a handful issues in that approach with the current git-remote, 
> and that was why I also thought recent "git remote in C" by Dscho a bit 
> unfortunate, as enhancements and interface fixes (both user and machine) 
> tend to be much easier in scripted version.

And here I have to disagree strongly.  I _wasted_ a _week_ on trying to 
fix that stupid "add --mirror && prune" bug in the scripted version.  It 
was absolutely horrible.  And I felt like a moron after that week.

In contrast, it was easy as chocolate cake to fix it in the builtin 
remote.

Now, if you not only hinted in some mail that something is wrong with 
builtin-remote, but gave me some input, I could fix that in the builtin, 
too.

> What the current "git clone" does that are not naturally expressed by
> the above sequence are:
> 
>  * HEAD discovery
> 
>    The code can be lifted from the scripted version and transplanted to
>    git-remote.  And to make "origin" and other remotes added by "git
>    remote add", this logic needs to be moved to "git remote".
> 
>    However, before rewriting the "git remote" to C, it would be really
>    nice if we can update the native protocol so that we can reliably
>    find out which branch HEAD points at.  The current code guesses, only
>    because the native protocol does not carry that information [*1*].
>    Worse yet, even though the current code _knows_ this information when
>    going over dumb protocols, it discards it to use the same guessing
>    logic as used by the native protocol.

I wonder why this should be easier with git remote in Perl.  IMHO it is 
easier with git remote in C.

>  * --shared optimization
> 
>    This is a very easy addition to "git remote add".  You make sure that
>    the added remote repository is on a local machine, and set up
>    alternates to point at its object store.

Concur.

Since I want to lose that dependency on cpio on Windows (which we fake by 
using tar), I'll implement this in C anyway.

Ciao,
Dscho

---1463811741-284983851-1197457970=:27959--
