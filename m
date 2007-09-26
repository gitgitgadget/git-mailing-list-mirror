From: "Josh England" <jjengla@sandia.gov>
Subject: Re: [PATCH] post-checkout hook, and related docs and tests
Date: Wed, 26 Sep 2007 13:23:53 -0600
Message-ID: <1190834633.6078.139.camel@beauty>
References: <1190406421-15620-1-git-send-email-jjengla@sandia.gov>
 <7vzlzfh7xd.fsf@gitster.siamese.dyndns.org>
 <1190654052.6078.14.camel@beauty>
 <7vsl53ap5x.fsf@gitster.siamese.dyndns.org>
 <1190662396.6078.63.camel@beauty>
 <7vejgnai1z.fsf@gitster.siamese.dyndns.org>
 <20070926145229.GA15300@potapov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Dmitry Potapov" <deaptor@mail.ru>
X-From: git-owner@vger.kernel.org Wed Sep 26 21:22:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IacSQ-0005tZ-2a
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 21:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994AbXIZTVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 15:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755820AbXIZTVx
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 15:21:53 -0400
Received: from mm03snlnto.sandia.gov ([132.175.109.20]:3907 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401AbXIZTVv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 15:21:51 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Wed, 26 Sep 2007 13:21:40 -0600
X-Server-Uuid: AA8306FD-23D1-4E5B-B133-B2D9F10C3631
Received: from [132.175.2.191] (beauty.son.sandia.gov [132.175.2.191])
 by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id l8QJLdFr014491;
 Wed, 26 Sep 2007 13:21:39 -0600
In-Reply-To: <20070926145229.GA15300@potapov>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940,
 Antispam-Data: 2007.9.26.120536
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0,
 __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0,
 __MIME_VERSION 0, __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20070926192141; SEV=2.2.2; DFV=B2007092616;
 IFV=2.0.4,4.0-9; AIF=B2007092616; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230372E34364641423134352E303036353A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007092616_5.02.0125_4.0-9
X-WSS-ID: 6AE46ECE3HO3551628-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59240>

On Wed, 2007-09-26 at 18:52 +0400, Dmitry Potapov wrote:
> On Mon, Sep 24, 2007 at 02:07:36PM -0700, Junio C Hamano wrote:
> > "Josh England" <jjengla@sandia.gov> writes:
> > 
> > > ...  Granted, the
> > > branch (and HEAD) does not change for this operation, but that shouldn't
> > > matter.  It is somewhat in line with the principle of 'least-surprise':
> > > if the hook runs for 'git checkout otherbranch', but not 'git checkout
> > > otherbranch path.c', this could cause confusion and distress to the
> > > user.  IMO, it is a 'checkout' so the post-checkout hook should run.
> > > Why is that so insane?  
> > 
> > Because I find it would be surprising if the following commands
> > behave differently:
> > 
> > 	$ git cat-file blob otherbranch:path.c >path.c
> >         $ git show otherbranch:path.c >path.c
> >         $ git diff -R otherbranch path.c | git apply
> >         $ git checkout otherbranch path.c
> 
> Actually, they already act differently even without any hook.
> If path.c is a symbol link then 1 and 2 will give a different
> result than commands 3 and 4.

Moroever, with respect to permissions, the first 2 retain the
permissions of the file if it already exists in the worktree, whereas
the other variations actually recreate the file with a default umask and
wipe out existing permissions.

> On the other hand, while the difference in above commands
> understandable (in case 1 and 2, the shell creates path.c; and
> in 3 and 4, git creates it), I really dislike the idea of 
> "checkout is magical." I believe that command 3 and 4 should
> always give the same result or Git is broken.
> 
> Another reason, why I dislike the post-checkout hook is that it
> is prone to abuse like as not so smart user trying to put some
> content modification here.

Content modification is not among the intended uses for this hook.  Any
and all hooks can be abused/misused in this way.  I just want to give
the user a tool -- if he wants to hit himself in the face with it that's
his prerogative.

>  Moreover, it appears to be excessive
> to me, because if you want to run something after git-checkout,
> you can write a simple shell script for that that first runs
> git-checkout with the given arguments and then run whatever you
> want. I don't see why we should modify Git for that.

The same could be said for pre-commit and other hooks.  The whole
reason for the hook system is to provide a useful interface so that
users are *not* required to write their own wrapper scripts to get the
job done.  In this case, providing the hook is by far the *more*
consistent way of doing things.

> Perhaps, it would be better to have a hook on modification,
> which is invoked every time when Git wants to try to change
> anything in the working directory. The hook could receives on
> the input something that looks like 'git-diff --name-status'
> output and can do any work on creation files, etc. It is much
> more flexible, because you can do additional stuff here like
> creating one directory in the path as a symbol link somewhere
> else or something like that. But what is much more important
> is that everything work _consistently_ and you get the same
> results whether you type:
> git diff -R otherbranch path.c | git apply
> or
> git checkout otherbranch path.c
> 
> If you start with one "magical interface" then eventually you
> will end up with everything being so magical that no one can
> make sense of it. Please, stay consistent.

I don't know why you think this is so magical.  git-checkout can run a
post-checkout hook, if enabled.  Plain and simple.  No magic here.  As
for the universal 'worktree-updated' hook, I look forward to seeing a
sane implementation, but in the meantime post-merge and post-checkout
suit my needs just fine.

-JE
