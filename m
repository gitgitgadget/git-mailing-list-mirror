From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Alternates and push
Date: Mon, 8 Sep 2008 19:56:06 +0200
Message-ID: <20080908175606.GA3466@efreet.light.src>
References: <9e4733910809060542s5ede6d6m5bdb894c958ea8b7@mail.gmail.com> <20080906162030.GT9129@mit.edu> <7viqt9rvwm.fsf@gitster.siamese.dyndns.org> <20080907184922.GA3909@efreet.light.src> <7vhc8rn5sl.fsf@gitster.siamese.dyndns.org> <7v8wu3n4t1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@MIT.EDU>, Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 19:57:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KckzO-0007Bk-Tu
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 19:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbYIHR4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 13:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753767AbYIHR4T
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 13:56:19 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:49340 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753016AbYIHR4S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 13:56:18 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id BC071572B0;
	Mon,  8 Sep 2008 19:56:17 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id mZ-P3s+Lg+ND; Mon,  8 Sep 2008 19:56:14 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id E18B857276;
	Mon,  8 Sep 2008 19:56:12 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1Kcky7-0001Ck-A5; Mon, 08 Sep 2008 19:56:07 +0200
Content-Disposition: inline
In-Reply-To: <7v8wu3n4t1.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95280>

On Sun, Sep 07, 2008 at 12:18:02 -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jan Hudec <bulb@ucw.cz> writes:
> > ...
> >> Why is this a *mis*design? Couldn't push be fixed by redesigning it's
> >> protocol along the lines of:
> >>  - clients sends a list of sha1s it wants to push, from the tip down
> >>  - server stops it when it sees an object it has -- this check can be done
> >>    against the object store without having a ref for it.
> >
> > Because your second step is *BROKEN*.
> >
> > Think of a case where an earlier commit walker started fetching into that
> > "server" end, which got newer commits and their associated objects first
> > and then older ones, and then got killed before reaching to the objects it
> > already had.  In such a case, the commit walker will *not* update the refs
> > on the server end (and for a very good reason).
> >
> > After that, the server end would have:
> >
> >  * refs that point at some older commits, all objects from whom are
> 
> s/from whom/reachable from which/;
> 
> >    guaranteed to be in the repository (that's the "ref" guarantee);
> >
> >  * newer commits and their objects, but if you follow them you will hit
> >    some objects that are *NOT* in the repository.
> 
> To visualize, the server object store and refs would be like this:
> 
>     ---o---o---A...x...x...x...x...o---o---X
>                ^ ref
> 
> Commits 'x' are all missing because the commit walker fetched commit X,
> inspected its tree and got the necessary tree and blob objects, went back
> to get X's parent, did the same, then its parent, attempted to do the same
> but got killed before connecting the history fully to A.

The problem was I didn't realize how this could happen. Now when you said
/walker/, it's obvious which way of adding objects does it. I'd however
argue that that, rather than having the object store independent in the first
place, is misdesign.

> If you accepted history on top of X before guaranteeing that you have
> everything reachable from X already in this round of push will give you this:
> 
> 
>     ---o---o---A...x...x...x...x...o---o---X---o---o---Y
>                ^ ref =========== (wrong) ============> ^ ref
> 
> and if you update the ref to point at Y, then you cannot satisfy requests
> from other people who want the history that leads to Y, because somewhere
> between A and X there are commit that you do not even have to begin with.
> 
> So you may even be able accept objects between X..Y, but you cannot update
> the ref from A to Y after accepting such a push, which is pointless.
> 
> You could try a variant of it to unbreak your trick, though.  When you see
> an object that you have, say 'X' above, you traverse down from there until
> reaching some ref (in this case, A) and make sure that you have everything
> in between (not just commits but also associated trees and blobs that are
> needed).  This is quite similar to what is happening when the commit
> walker says "walk deadbeef..." in its progress output.  So it _could_ be
> done, but it would be somewhat expensive.

No. I would vote for unbreaking it at the walker instead. Instead of putting
the downloaded packs directly into the object store, it could put them in
some staging area and only move them in place when all dependencies are
downloaded. Still makes the solution comparably complex to the other ones.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
