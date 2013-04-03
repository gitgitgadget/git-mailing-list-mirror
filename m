From: Jeff King <peff@peff.net>
Subject: Re: Behavior of git rm
Date: Wed, 3 Apr 2013 16:36:12 -0400
Message-ID: <20130403203612.GB3982@sigill.intra.peff.net>
References: <1365000624535-7581485.post@n2.nabble.com>
 <20130403155841.GA16885@sigill.intra.peff.net>
 <7vli8z5xfr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jpinheiro <7jpinheiro@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 03 22:36:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNUQI-0005UB-QR
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 22:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762549Ab3DCUgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 16:36:18 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53816 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760603Ab3DCUgS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 16:36:18 -0400
Received: (qmail 27422 invoked by uid 107); 3 Apr 2013 20:38:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Apr 2013 16:38:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Apr 2013 16:36:12 -0400
Content-Disposition: inline
In-Reply-To: <7vli8z5xfr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219971>

On Wed, Apr 03, 2013 at 10:35:52AM -0700, Junio C Hamano wrote:

> > diff --git a/builtin/rm.c b/builtin/rm.c
> > index dabfcf6..7b91d52 100644
> > --- a/builtin/rm.c
> > +++ b/builtin/rm.c
> > @@ -110,7 +110,7 @@ static int check_local_mod(unsigned char *head, int index_only)
> >  		ce = active_cache[pos];
> >  
> >  		if (lstat(ce->name, &st) < 0) {
> > -			if (errno != ENOENT)
> > +			if (errno != ENOENT && errno != ENOTDIR)
> 
> OK.  We may be running lstat() on D/F but there may be D that is not
> a directory.  If it is a file, we get ENOTDIR.
> 
> By the way, if D is a dangling symlink, we get ENOENT; in such a
> case, we report "rm 'D/F'" on the output and remove the index entry.
>
> 	$ rm -f .git/index && rm -fr D E
> 	$ mkdir D && >D/F && git add D && rm -fr D
>         $ ln -s erewhon D && git rm D/F && git ls-files
>         rm 'D/F'

That seems sane to me, and makes me feel like handling ENOTDIR here is
the right direction.  What that conditional is trying to say is "if it
is because the file is not there...", and so far we know of three
conditions where it is not there:

  1. There is no entry at that path.

  2. There is a non-directory in the prefix of that path.

  3. There is a dangling symlink in the prefix of that path.

(1) and (3) we already handle via ENOENT. I think it is sane to handle
(2) the same as (3), but we do not do so currently.

> Also if D is a symlink that point at a directory E, "git rm" does
> something interesting.
> 
> (1) Perhaps we want a complaint in this case.
> 
> 	$ rm -f .git/index && rm -fr D E
> 	$ mkdir D && >D/F && git add D && rm -fr D
> 	$ mkdir E && ln -s E D && git rm D/F

I think that is OK without complaint; the user asked to get rid of D/F,
and it is indeed gone (as well as its index entry) after the call
finishes. And we did not even need to delete anything, so we cannot be
losing data. I am much more concerned about this case:

> (2) Perhaps we want to make sure D/F is not beyond a symlink in this
>     case.
> 
> 	$ rm -f .git/index && rm -fr D E
> 	$ mkdir D && >D/F && git add D && rm -fr D
> 	$ mkdir E && ln -s E D && date >E/F && git rm D/F

where the user is deleting something that may or may not be related to
the original D/F. On the other hand, I don't have that much sympathy;
"rm" would make the same deletion. But hmm...shouldn't we be doing an
up-to-date check? Indeed:

  $ git rm D/F
  error: 'D/F' has staged content different from both the file and the HEAD
  (use -f to force removal)
  $ git commit -m foo && git rm D/F
  $ git rm D/F
  error: 'D/F' has local modifications
  (use --cached to keep the file, or -f to force removal)

So I do not think we need any extra safety; the content-level checks
should be enough to make sure we are not losing anything.

-Peff
