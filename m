From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: ':/<oneline prefix>' notation doesn't support full file syntax
Date: Fri, 4 Jul 2008 02:14:34 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807040206360.2849@eeepc-johanness>
References: <279b37b20807022242q69ad2fcbwb8c11a9d6165272d@mail.gmail.com> <7vfxqr2won.fsf@gitster.siamese.dyndns.org> <279b37b20807030150t2e9cbcc8wf099a5872568af8@mail.gmail.com> <56b7f5510807031127j10e33f3bl516180f7a9b5b5db@mail.gmail.com>
 <7v7ic2zmjp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dana How <danahow@gmail.com>, Eric Raible <raible@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 02:15:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEYxc-00071Z-6o
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 02:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753433AbYGDAOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 20:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbYGDAOj
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 20:14:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:57287 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753308AbYGDAOi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 20:14:38 -0400
Received: (qmail invoked by alias); 04 Jul 2008 00:14:37 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp042) with SMTP; 04 Jul 2008 02:14:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+WwEK8Cd+K6I/bxGHS1qLjCN4h01XvIO4lLg8X9
	st+/6yJINxCVnz
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7v7ic2zmjp.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87344>

Hi,

On Thu, 3 Jul 2008, Junio C Hamano wrote:

> "Dana How" <danahow@gmail.com> writes:
> 
> > I was surprised to see Dscho advocating removing this feature 
> > altogether. Others proposed other command sequences which avoided :/ . 
> > If :/ is now going to be extended and thus perhaps more likely to 
> > appear in scripts, is now the time to change it to ? which has no 
> > other special meaning to git?
> 
> There are number of problems with ":/" notation, but my biggest gripe is 
> that it is only slightly better than "give back a random commit".

Well, it _is_ better than that: it gives you the _newest_ matching commit, 
provided that the people involved in those commits maintained their NTP 
settings correctly.

The _real_ gripe you should have with the notation is what I pointed out 
already: it is _ill_-defined.  It _could_ match more than one commit, but 
matches only _one_.

> As Dscho mentioned, --grep works much better and instead of saying:
> 
>     $ git diff ':/send-email' HEAD
> 
> we can say:
> 
>     $ git diff \
>       $(git log --pretty=format:%H -1 --grep=send-email master next) HEAD
> 
> The error behaviour is somewhat different between the two, though.  
> When you misspell what to grep, the command substitution will give empty 
> and you would get an unexpected result.  Being built-in, ':/' syntax can 
> say "I do not find anything that match" fairly easily, and the command 
> substitution version has to say something ugly like:
> 
>     $ git diff \
>         $(
>             x=$(git log --pretty=format:%H -1 --grep=send-email master next)
>             case "$x" in
>             ('') echo 0000000000000000000000000000000000000000 ;;
>             (?) echo $x ;; esac
>         ) HEAD
> 
> to get a similar effect.

Again, this is the wrong way to think about it.  If you grep for things, 
you can get 0..infty matches, not necessarily 1.

To assume that you get at least one match is already an error.

Letting that funny "case" syntax slip by, I would suggest this command 
line instead:

$ $(git log --pretty=format:'git diff %H..;' --grep=send-email \
	master next)

> But the point is that you can extend it easily with the :path suffix if 
> you wanted to:
> 
>     $ git show \
>         $(git log --pretty=format:%H -1 \
>         --grep=send-email):git-send-email.perl

Again, I would rather suggest pulling the ":<path>" into the format, as I 
did _already_ in another mail, robustifying the whole command.

> So in short, ':/' is limited (cannot be suffixed with :path, cannot be 
> told to dig down from named revs, etc.) but you can do what ':/' cannot 
> do fairly easily with command substitution.
> 
> However, $(git pick --all --grep=something), without suffixed modifiers
> such as ~$N and :$path, may still be common enough that it might deserve a
> short-hand ':/' (and that is why we have it).
> 
> If people do not find that short-hand useful, I am not strongly opposed to
> the idea of dropping it.  I personally find the notation not very useful
> cute hack anyway ;-).

It was a cute hack, and before --grep it was actually useful.

Now it is not any more,
Dscho
