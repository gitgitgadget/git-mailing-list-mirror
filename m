From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] push: don't guess at qualifying remote refs on deletion
Date: Wed, 4 Jul 2012 03:37:59 -0400
Message-ID: <20120704073758.GA23473@sigill.intra.peff.net>
References: <CAKON4OwnUKQ6MT8HBNDyfhZLZS5xGKA2Ss1krY9OQGG1gaFhDw@mail.gmail.com>
 <7vsjd9wkek.fsf@alter.siamese.dyndns.org>
 <CAKON4OxBo7XiF5c60oyEUMR1xCh16n5BZCz-mmcUc0V9X7D32A@mail.gmail.com>
 <20120703180439.GC3294@sigill.intra.peff.net>
 <7vipe4vdnh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "jonsmirl@gmail.com" <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 09:38:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmKA6-0001UH-Mu
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 09:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933389Ab2GDHiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 03:38:05 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:52854
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642Ab2GDHiC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 03:38:02 -0400
Received: (qmail 31239 invoked by uid 107); 4 Jul 2012 07:38:09 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Jul 2012 03:38:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Jul 2012 03:37:59 -0400
Content-Disposition: inline
In-Reply-To: <7vipe4vdnh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200995>

On Tue, Jul 03, 2012 at 12:38:10PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Instead, we can just be more succinct and say "we can't
> > delete this because we couldn't find it". So before:
> >
> >   $ git push origin :bogus
> >   error: unable to push to unqualified destination: bogus
> >   The destination refspec neither matches an existing ref on the remote nor
> >   begins with refs/, and we are unable to guess a prefix based on the source ref.
> >   error: failed to push some refs to '$URL'
> >
> > and now:
> >
> >   $ git push origin :bogus
> >   error: unable to delete 'bogus': remote ref does not exist
> >   error: failed to push some refs to '$URL'
> 
> This is telling a truth ($GIT_DIR/refs/bogus does not exist) but not
> the whole truth; while I tend to agree that it is better than the
> original (especially with ", and we are unable to guess..." part),
> given that the above request would delete refs/tags/bogus or
> refs/heads/bogus if they existed on the "origin", I am a bit worried
> that it may send an incorrect message to novice users.
> 
>     unable to delete 'bogus': no branch or tag with that name
> 
> might allay my worries, but I am not extremely happy with that
> wording, either.

I think the most accurate explanation of the behavior is "the
destination refspec does not match an existing ref, and it is not fully
qualified, so I didn't know what you meant to delete". But that is a
pretty awful message (only slightly less awful than the original one,
but I think that one is pretty bad).

The really interesting part is that we tried to match "bogus" against
all of the usual ref lookup rules, and it didn't match anything. But we
have the same issue when we say "git show bogus" and it does not match
anything, and we simply say "bad revision 'bogus'".

Maybe:

  unable to delete 'bogus': no matching remote ref found

would be a reasonably short way of saying that?

That still leaves out the second half, that it was not fully qualified
and therefore we could not even transmit an attempt to delete (even
though that attempt would clearly not succeed!). But that is really not
a subtlety that I think is worth putting in the error message, as it is
way more likely to confuse somebody.

-Peff
