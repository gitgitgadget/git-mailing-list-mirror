From: Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH v3 19/22] resolve_ref(): emit warnings for
 improperly-formatted references
Date: Tue, 11 Oct 2011 16:39:03 -0400
Message-ID: <20111011203903.GA23069@sigill.intra.peff.net>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
 <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
 <20111011161652.GA15629@sigill.intra.peff.net>
 <7vr52jfm8i.fsf@alter.siamese.dyndns.org>
 <7vmxd7flkw.fsf@alter.siamese.dyndns.org>
 <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	cmn@elego.de, A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 11 22:39:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDj6Y-0000Lp-H0
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 22:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898Ab1JKUjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 16:39:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57794
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528Ab1JKUjG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 16:39:06 -0400
Received: (qmail 4484 invoked by uid 107); 11 Oct 2011 20:39:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 11 Oct 2011 16:39:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Oct 2011 16:39:03 -0400
Content-Disposition: inline
In-Reply-To: <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183324>

On Tue, Oct 11, 2011 at 01:14:26PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> I think we've discussed tightening it a few years ago already.
> >>
> >> HEAD, MERGE_HEAD, FETCH_HEAD, etc. all are "^[_A-Z]*$" and it may even be
> >> a good idea to insist "^[_A-Z]*HEAD$" or even "^([A-Z][A-Z]*_)?HEAD$".
> >
> > Perhaps like this? Only compile tested...
> 
> Not quite. There are at least three bugs in the patch.
> 
>  - Some subsystems use random refnames like NOTES_MERGE_PARTIAL that would
>    not match "^([A-Z][A-Z]*_)?HEAD$". The rule needs to be relaxed;

Yeah, I found one of these also. I thought at first we could rename
things like NOTES_MERGE_PARTIAL, as it's more about internal
communication within a specific version of git than it is about letting
an external program peek at our state. But there really are several of
them. And I think it makes sense to keep this safety valve conservative,
and try to document existing practice rather than dictating it. I'm
worried that some porcelain or other tool is using their own all-caps
name, and that tightening it too much would be breaking that.

Your relaxed rule does match things like COMMIT_EDITMSG and NOTES_MSG,
which are obviously bogus. At the same time, I'm not sure it's a big
deal. The point of this is to restrict the lookup to a class of names
which are likely magical to git, and users should probably avoid the
magical namespace (i.e., it's still not a good idea to call your branch
"HEAD"). Something like "config" is an easy branch name to unknowingly
use. Something like "COMMIT_EDITMSG" is not.

Your rule does disallow RENAMED-REF, which is used in branch renaming.
However, I'm having trouble figuring out what it's really for. It's not
mentioned in the documentation at all, and c976d41, its origin, says
only:

  This also indroduces $GIT_DIR/RENAME_REF which is a "metabranch"
  used when renaming branches. It will always hold the original
  sha1 for the latest renamed branch.

  Additionally, if $GIT_DIR/logs/RENAME_REF exists,
  all branch rename events are logged there.

But in the code, it is spelled RENAMED-REF (with a dash). And as far as
I can tell, does not actually create a reflog. And it's not documented
anywhere, so I suspect nobody is using it. Maybe it is worth switching
that name.

>  - dwim_ref() can be fed "refs/heads/master" and is expected to dwim it to
>    the master branch.

It looks like your code will allow any subdirectory. I had thought to
limit it to "refs/". Otherwise, my "config" example could be
"objects/pack", or "lost-found/commits", "remotes/foo", or something.
Obviously the longer the name, the smaller the possibility of an
accidental collision.  But I couldn't think of any other subdirectory
into which refs should go.

-Peff
