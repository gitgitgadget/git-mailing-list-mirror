From: "Josh England" <jjengla@sandia.gov>
Subject: Re: [PATCH] post-checkout hook, and related docs and tests
Date: Mon, 24 Sep 2007 13:33:16 -0600
Message-ID: <1190662396.6078.63.camel@beauty>
References: <1190406421-15620-1-git-send-email-jjengla@sandia.gov>
 <7vzlzfh7xd.fsf@gitster.siamese.dyndns.org>
 <1190654052.6078.14.camel@beauty>
 <7vsl53ap5x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 21:31:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZteT-0007rH-Qr
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 21:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759204AbXIXTbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 15:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756859AbXIXTbV
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 15:31:21 -0400
Received: from mm03snlnto.sandia.gov ([132.175.109.20]:2511 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755226AbXIXTbU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 15:31:20 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Mon, 24 Sep 2007 13:31:11 -0600
X-Server-Uuid: 6CEB1540-FE13-491B-9872-FD67060ED864
Received: from [132.175.2.191] (beauty.son.sandia.gov [132.175.2.191])
 by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id l8OJVBmk022252;
 Mon, 24 Sep 2007 13:31:11 -0600
In-Reply-To: <7vsl53ap5x.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940,
 Antispam-Data: 2007.9.24.121257
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0,
 __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0,
 __MIME_VERSION 0, __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20070924193113; SEV=2.2.2; DFV=B2007092415;
 IFV=2.0.4,4.0-9; AIF=B2007092415; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230322E34364638313038302E303043333A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007092415_5.02.0125_4.0-9
X-WSS-ID: 6AE6CFF52E03293562-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59072>

On Mon, 2007-09-24 at 11:34 -0700, Junio C Hamano wrote:
> "Josh England" <jjengla@sandia.gov> writes:
> 
> >> What's the _semantics_ you are trying to achieve?
> >
> > I'd like to get a hook that runs whenever the working dir gets
> > updated.  The 'git-checkout otherbranch path.c' case should
> > run it also, so I view that as a bug.
> 
> I think that _is_ INSANE.  Do you run the hook for these then?
> 
> 	$ edit path.c
>         $ git-cat-file otherbranch:path.c >path.c
> 
> Why "git checkout otherbranch path.c" should be any different?

It is different because the file is being updated through the 'git
checkout' interface.  The user is not copying the file over by hand,
he/she is asking git to do it for them via 'git checkout'.  Granted, the
branch (and HEAD) does not change for this operation, but that shouldn't
matter.  It is somewhat in line with the principle of 'least-surprise':
if the hook runs for 'git checkout otherbranch', but not 'git checkout
otherbranch path.c', this could cause confusion and distress to the
user.  IMO, it is a 'checkout' so the post-checkout hook should run.
Why is that so insane?  

Look at it from the perspective of the intended use of this hook.  I'm
trying to use this hook to keep working dir metadata (ownership/perms)
in a consistent state.  When I do a 'git checkout otherbranch', the hook
runs, updating perms as needed, and all is well.  As is, if I 'git
checkout otherbranch path.c', the file is created with the default
umask, the hook is not run, and path.c potentially (likely) has
incorrect perms.  The working dir is now in an inconsistent state and
the worst part is that the next commit will propagate the faulty
metadata for that file.

-JE
