From: Dmitry Potapov <deaptor@mail.ru>
Subject: Re: [PATCH] post-checkout hook, and related docs and tests
Date: Wed, 26 Sep 2007 18:52:29 +0400
Message-ID: <20070926145229.GA15300@potapov>
References: <1190406421-15620-1-git-send-email-jjengla@sandia.gov> <7vzlzfh7xd.fsf@gitster.siamese.dyndns.org> <1190654052.6078.14.camel@beauty> <7vsl53ap5x.fsf@gitster.siamese.dyndns.org> <1190662396.6078.63.camel@beauty> <7vejgnai1z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh England <jjengla@sandia.gov>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 17:14:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaYae-0005in-EH
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 17:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758123AbXIZPOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 11:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754310AbXIZPOG
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 11:14:06 -0400
Received: from smtp06.mtu.ru ([62.5.255.53]:62676 "EHLO smtp06.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757504AbXIZPOF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 11:14:05 -0400
X-Greylist: delayed 650 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Sep 2007 11:14:05 EDT
Received: from potapov.private (ppp85-141-237-255.pppoe.mtu-net.ru [85.141.237.255])
	by smtp06.mtu.ru (Postfix) with ESMTP id 9F3E47BD9F4;
	Wed, 26 Sep 2007 19:02:54 +0400 (MSD)
Received: from potapov.private (localhost [127.0.0.1])
	by potapov.private (8.13.8/8.13.8/Debian-3) with ESMTP id l8QEqVtD016340;
	Wed, 26 Sep 2007 18:52:31 +0400
Received: (from dpotapov@localhost)
	by potapov.private (8.13.8/8.13.8/Submit) id l8QEqTZx016339;
	Wed, 26 Sep 2007 18:52:29 +0400
X-Authentication-Warning: potapov.private: dpotapov set sender to deaptor@mail.ru using -f
Content-Disposition: inline
In-Reply-To: <7vejgnai1z.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59234>

On Mon, Sep 24, 2007 at 02:07:36PM -0700, Junio C Hamano wrote:
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

Actually, they already act differently even without any hook.
If path.c is a symbol link then 1 and 2 will give a different
result than commands 3 and 4.

On the other hand, while the difference in above commands
understandable (in case 1 and 2, the shell creates path.c; and
in 3 and 4, git creates it), I really dislike the idea of 
"checkout is magical." I believe that command 3 and 4 should
always give the same result or Git is broken.

Another reason, why I dislike the post-checkout hook is that it
is prone to abuse like as not so smart user trying to put some
content modification here. Moreover, it appears to be excessive
to me, because if you want to run something after git-checkout,
you can write a simple shell script for that that first runs
git-checkout with the given arguments and then run whatever you
want. I don't see why we should modify Git for that.

Perhaps, it would be better to have a hook on modification,
which is invoked every time when Git wants to try to change
anything in the working directory. The hook could receives on
the input something that looks like 'git-diff --name-status'
output and can do any work on creation files, etc. It is much
more flexible, because you can do additional stuff here like
creating one directory in the path as a symbol link somewhere
else or something like that. But what is much more important
is that everything work _consistently_ and you get the same
results whether you type:
git diff -R otherbranch path.c | git apply
or
git checkout otherbranch path.c

If you start with one "magical interface" then eventually you
will end up with everything being so magical that no one can
make sense of it. Please, stay consistent.

Dmitry Potapov
