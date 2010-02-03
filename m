From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: extra headers in commit objects
Date: Wed, 3 Feb 2010 13:04:07 -0800
Message-ID: <20100203210407.GG14799@spearce.org>
References: <20100203174041.GC14799@spearce.org> <alpine.LFD.2.00.1002031311010.1681@xanadu.home> <9b18b3111002031101p3385ecdfo638433bc269791aa@mail.gmail.com> <20100203192612.GD14799@spearce.org> <7vwryugifz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: demerphq <demerphq@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 22:04:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcmOY-0002yb-1u
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 22:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932894Ab0BCVEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 16:04:13 -0500
Received: from mail-yx0-f189.google.com ([209.85.210.189]:56080 "EHLO
	mail-yx0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932343Ab0BCVEM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 16:04:12 -0500
Received: by yxe27 with SMTP id 27so1548510yxe.4
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 13:04:11 -0800 (PST)
Received: by 10.91.163.4 with SMTP id q4mr474763ago.13.1265231050443;
        Wed, 03 Feb 2010 13:04:10 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm7875107iwn.15.2010.02.03.13.04.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Feb 2010 13:04:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vwryugifz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138898>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > As I understand it, the current stance is:
> >
> > 1) A compliant Git implementation ignores any headers it doesn't
> >    recognize that appear *after* the optional "encoding" header.
> 
> I first read the above to mean that you need to add encoding if you want
> to throw in other garbage.
> 
> I would say "*after* the mandatory 'tree', 'parent' (0 or more), 'author',
> and 'committer' headers that must appear in this order", for clarity.

Yes, sorry, of course that is what I meant.  Thanks for the
clarification.

To add to that, "after encoding, if encoding is present".
 
> > 2) A compliant Git implementation does not produce any additional
> >    headers in a commit object, because other implementations cannot
> >    perform any machine based reasoning on them.
> >
> > 3) All implementations would (eventually) treat all headers equally,
> >    that is they all understand what author, committer, encoding are
> >    and process them the same way.  Any new headers should equally
> >    be fully cross-implementation.
> 
> These are very important points.
> 
> In your made-up example you added "bug" (presumably to mean "fixes this
> bug") and "message-id" ("am-ed from this message").  The latter might make
> sense, but the former does not belong to the header, as it is not a
> statement of the fact.

This all came out of what appears to be a tool to bridge another
VCS system data into Git.  Ala git-svn.

We all know that some other systems, e.g. SVN, permit adding
additional properties to commits, and that often these are used
to make statements like "Fixed bug NNNN", and bug tracking systems
integrate into SVN by reading or updating those properties.

So you, Nico, myself, might all agree that "bug" does not belong
in the header, but many others see it like SVN sees additional
properties on a revision, and thus it goes there.

Hence the artifical example.  It seems that it is not that artifical
outside of our mailing list.
 
> Forcing people to say "this fixes" at the commit time means you do not
> allow mistakes---it may turn out to be an incorrect or non fix later.

Yup, happens often.

> When you are amending the commit to say "this does not really fix it", you
> would want to lose the old "bug" header, but you would want to keep the
> "message-id" one.  There simply is not enough hint as to which ones must
> be carried across amending in the "we allow people to randomly throw extra
> headers into the commit object" model.  It is not a model--it is chaos.

Exactly.  That's what I had thought our position was, for exactly
this reason, it very quickly devolves into a chaos we can't reason
about, let alone write code to support for end-users.

> Also it wouldn't be obvious to other people what got changed while
> comparing two commits (before and after the amend) if the information is
> hidden in the header.  The right place for that kind of information is in
> the log message (if the nature of the information is for everybody to see)
> or in notes.

I'm afraid users might insert their own headers, then come report
the bug that `git log` and `git show` don't make those headers
visible when formatting the commit.  After all, they show the author
committer, and parent information when you use the right flags.

We'll of course say, its not in the message, and suggest using the
footer style like our Signed-off-by lines, or notes, which appear
below the message if requested.

> Introducing extra headers needs to be done _very_ carefully after thinking
> things through, judging the pros and cons.  Even though we kept the format
> open to allow us to extend the format to add essential statement of fact
> that we can make at the commit time (e.g. "encoding"), I do not foresee us
> adding any official extra headers in near future.

Right, me neither, because everything that has been proposed for an
extra header (e.g. bug id, Message-Id from the email it as git-amed
from, rename tracking, ...) has all been suggested to be better
positioned in the message itself, or in a note, or not at all...

-- 
Shawn.
