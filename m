From: "Josh England" <jjengla@sandia.gov>
Subject: Re: [PATCH] post-checkout hook, and related docs and tests
Date: Mon, 24 Sep 2007 16:05:58 -0600
Message-ID: <1190671558.6078.87.camel@beauty>
References: <1190406421-15620-1-git-send-email-jjengla@sandia.gov>
 <7vzlzfh7xd.fsf@gitster.siamese.dyndns.org>
 <1190654052.6078.14.camel@beauty>
 <7vsl53ap5x.fsf@gitster.siamese.dyndns.org>
 <1190662396.6078.63.camel@beauty>
 <7vejgnai1z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 00:04:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZw2u-0001OU-5q
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 00:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756400AbXIXWEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 18:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756221AbXIXWEI
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 18:04:08 -0400
Received: from mm04snlnto.sandia.gov ([132.175.109.21]:2397 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385AbXIXWEF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 18:04:05 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Mon, 24 Sep 2007 16:03:54 -0600
X-Server-Uuid: 6CEB1540-FE13-491B-9872-FD67060ED864
Received: from [132.175.2.191] (beauty.son.sandia.gov [132.175.2.191])
 by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id l8OM3rdu020823;
 Mon, 24 Sep 2007 16:03:53 -0600
In-Reply-To: <7vejgnai1z.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940,
 Antispam-Data: 2007.9.24.144234
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CP_NOT_1 0, __CT
 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0,
 __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20070924220357; SEV=2.2.2; DFV=B2007092417;
 IFV=2.0.4,4.0-9; AIF=B2007092417; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230312E34364638333434432E303131423A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007092417_5.02.0125_4.0-9
X-WSS-ID: 6AE6EBC02E03315287-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59078>

On Mon, 2007-09-24 at 14:07 -0700, Junio C Hamano wrote:
> "Josh England" <jjengla@sandia.gov> writes:
> 
> > ...  Granted, the
> > branch (and HEAD) does not change for this operation, but that shouldn't
> > matter.  It is somewhat in line with the principle of 'least-surprise':
> > if the hook runs for 'git checkout otherbranch', but not 'git checkout
> > otherbranch path.c', this could cause confusion and distress to the
> > user.  IMO, it is a 'checkout' so the post-checkout hook should run.
> > Why is that so insane?  
> 
> Because I find it would be surprising if the following commands
> behave differently:
> 
> 	$ git cat-file blob otherbranch:path.c >path.c
>         $ git show otherbranch:path.c >path.c
>         $ git diff -R otherbranch path.c | git apply
>         $ git checkout otherbranch path.c

For all intents and purposes, these would still behave the same.  The
existence of a post-checkout hook does not at all affect the outcome of
the checkout.  Sure there is potential for someone to do something
stupid inside the hook script, but that is true of any hook.

Most git users would never even enable the hook, but for those that do I
would assume that they'd want the hook to run for all 'git-checkout'
variants -- as I do.

> These are all talking about various ways to _edit_ working tree
> files, and not about switching between revisions.
> 
> That's why I said I found that what the second sentence from
> your original description implied ("the hook gets old and new
> commit object name" which means we are talking about switching
> between revisions) was sensible, but it needs to be stressed a
> bit.
> 
> If you want to spacial case 
> 
>         $ git checkout otherbranch path.c
> 
> it raises another issue.  Which commit should supply the
> "extended attribute description" for path.c?  Should it be taken
> from the current commit (aka HEAD), otherbranch, or the index?

This already is a special case and your question is valid but not one
that git should necessary care about.  Since extended attributes are not
built into git the only way to handle them is through hooks.  A such, it
is up to the hook to worry about these kinds of issues.  The hook I have
written handles this by updating path.c attributes to match whatever
exists in the (tracked) attributes file of the current HEAD.

This 'git-checkout otherbranch path.c' is a corner case, but one that
can result in broken behavior when handling metadata unless the hook
runs.  I just want to close all the holes.  I can change the description
of the hook to try to dispel any confusion if that would help.

-JE
