From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: extra headers in commit objects
Date: Wed, 3 Feb 2010 11:26:12 -0800
Message-ID: <20100203192612.GD14799@spearce.org>
References: <20100203174041.GC14799@spearce.org> <alpine.LFD.2.00.1002031311010.1681@xanadu.home> <9b18b3111002031101p3385ecdfo638433bc269791aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, git <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 20:26:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nckrq-0003Ep-4u
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 20:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757584Ab0BCT0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 14:26:21 -0500
Received: from mail-yx0-f189.google.com ([209.85.210.189]:40403 "EHLO
	mail-yx0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757560Ab0BCT0V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 14:26:21 -0500
Received: by yxe27 with SMTP id 27so1455868yxe.4
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 11:26:20 -0800 (PST)
Received: by 10.100.245.30 with SMTP id s30mr4679370anh.164.1265225180220;
        Wed, 03 Feb 2010 11:26:20 -0800 (PST)
Received: from localhost ([209.20.77.23])
        by mx.google.com with ESMTPS id 22sm7747789iwn.12.2010.02.03.11.26.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Feb 2010 11:26:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9b18b3111002031101p3385ecdfo638433bc269791aa@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138866>

demerphq <demerphq@gmail.com> wrote:
> On 3 February 2010 19:15, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Wed, 3 Feb 2010, Shawn O. Pearce wrote:
> >
> >> Am I correct that core C developers are still under the opinion
> >> that extra headers in a commit object aren't encouraged?
> >
> > I would say so.
> >
> > [...]
> >> At the end of the day, is it a bug that C git doesn't support
> >> working with extra commit headers? ?IMHO, no, because, we've
> >> rejected these in the past, and its not part of the Git standard.
> >> And other implementations shouldn't be trying to sell it that way.
> >
> > Agreed. ?And this was discussed in great length on this list on few
> > occasions already (probably more than a year back).
> 
> One problem, is that if you take the approach you say then you
> basically guarantee that a new git that DOES add new headers will
> break an old git that doesnt know about the headers, and actually
> doesnt care about them either.

As I understand it, the current stance is:

1) A compliant Git implementation ignores any headers it doesn't
   recognize that appear *after* the optional "encoding" header.

2) A compliant Git implementation does not produce any additional
   headers in a commit object, because other implementations cannot
   perform any machine based reasoning on them.

3) All implementations would (eventually) treat all headers equally,
   that is they all understand what author, committer, encoding are
   and process them the same way.  Any new headers should equally
   be fully cross-implementation.

> So it would essentially mean that if you ever have to change the
> commit format you will be in a position where new git commits will be
> incompatible by design with old git commits.

So, we can change the format by adding a new header, after the
optional "encoding" header.

But such a change needs to be something that an older Git will
safely ignore (due to rule 1), and something that a newer Git can
make really effective use of (due to rule 2 and 3).  And that newer
Git must also safely deal with commits missing that new header, due
to the huge number of commits out in the wild without said header.

And don't even get me started on amending commits with new unknown
headers.  Existing implementions of Git tools will drop the extra
headers during the amend, because the headers are viewed as part
of the commit object data... and during an amend you are making a
totally new object.

For example, git-gui would drop any extra headers during an amend,
because its running `git commit-tree` directly without any way to
tell commit-tree this is for an amend of an existing commit, vs. a
completely new commit... because either way its a new commit object.

> Shouldn't an old git just ignore headers from a new git?

Yes, see above.
 
-- 
Shawn.
