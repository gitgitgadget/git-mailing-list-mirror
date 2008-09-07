From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Alternates and push
Date: Sun, 7 Sep 2008 21:17:40 +0200
Message-ID: <20080907191740.GA29055@efreet.light.src>
References: <9e4733910809060542s5ede6d6m5bdb894c958ea8b7@mail.gmail.com> <20080906162030.GT9129@mit.edu> <7viqt9rvwm.fsf@gitster.siamese.dyndns.org> <20080907184922.GA3909@efreet.light.src> <7vhc8rn5sl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@MIT.EDU>, Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 21:19:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcPmv-0005e0-0P
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 21:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755130AbYIGTRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 15:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755102AbYIGTRt
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 15:17:49 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:36682 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755049AbYIGTRs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 15:17:48 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 7234857374;
	Sun,  7 Sep 2008 21:17:46 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id x52BU2EeIfRm; Sun,  7 Sep 2008 21:17:43 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 1F696572C2;
	Sun,  7 Sep 2008 21:17:40 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1KcPlU-0007a3-Cr; Sun, 07 Sep 2008 21:17:40 +0200
Content-Disposition: inline
In-Reply-To: <7vhc8rn5sl.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95163>

On Sun, Sep 07, 2008 at 11:56:42 -0700, Junio C Hamano wrote:
> Jan Hudec <bulb@ucw.cz> writes:
> 
> > On Sat, Sep 06, 2008 at 11:06:49 -0700, Junio C Hamano wrote:
> >> Theodore Tso <tytso@MIT.EDU> writes:
> >> 
> >> > Long-standing mis-feature in git's logic in deciding what to push.
> >> > It's been reported a few times, but apparently it's hard to fix, or at
> >> > least it never hsa been fixed as far as I know.
> >> 
> >> This comes from an early (mis)design of git.
> >> [...]
> >>  * The existing alternates mechanism is not about alternate repositories.
> >>    It is about alternate object stores.  That is why each line of this
> >>    file points at "objects" directory elsewhere, not the ".git" directory
> >>    that is typically at one level above that "objects" directory.
> >> 
> >>    The fact your repository's object store points at the object store that
> >>    happens to be inside Linus's repository does not imply that Linus's
> >>    object store is associated with refs in Linus's repository in any way
> >>    (that's the early _mis_design part).
> >
> > Why is this a *mis*design? Couldn't push be fixed by redesigning it's
> > protocol along the lines of:
> >  - clients sends a list of sha1s it wants to push, from the tip down
> >  - server stops it when it sees an object it has -- this check can be done
> >    against the object store without having a ref for it.
> 
> Because your second step is *BROKEN*.
> 
> Think of a case where an earlier commit walker started fetching into that
> "server" end, which got newer commits and their associated objects first
> and then older ones, and then got killed before reaching to the objects it

Is there really any transport that stores newer objects first? And can't be
fixed to only store the objects when they are good. My proposal definitely
does not need to do that (the list goes from newest to older, but the data in
third step can come from oldest to newer).

> already had.  In such a case, the commit walker will *not* update the refs
> on the server end (and for a very good reason).
> 
> After that, the server end would have:
> 
>  * refs that point at some older commits, all objects from whom are
>    guaranteed to be in the repository (that's the "ref" guarantee);
> 
>  * newer commits and their objects, but if you follow them you will hit
>    some objects that are *NOT* in the repository.
> 
> Now imagine starting your broken procedure to serve clients from such a
> repository.  Your second step would cause the server to attempt to pack
> the difference from the latter classes of incomplete objects and makes the
> pack generation fail.

Yes, it would add a requirement that objects are only placed in the object
store after all objects they reference, but I can't imagine good reason this
couldn't be done.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
