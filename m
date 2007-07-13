From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: sharing between local "work" and "nightly build" git repos
Date: Fri, 13 Jul 2007 07:11:40 +0200
Message-ID: <20070713051140.GB2430@steel.home>
References: <7154c5c60707121636l585b42d4l931b08f1468ddfc@mail.gmail.com> <7vmyy1rwza.fsf@assigned-by-dhcp.cox.net> <7154c5c60707121727k36854891u82afc4a8be822861@mail.gmail.com> <7154c5c60707121733r6584a407r8d60d5890b9c89e2@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Frech <nimblemachines@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 07:11:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9DRS-0004oR-Rq
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 07:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbXGMFLo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 01:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbXGMFLn
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 01:11:43 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:60342 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbXGMFLm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 01:11:42 -0400
Received: from tigra.home (Fc891.f.strato-dslnet.de [195.4.200.145])
	by post.webmailer.de (fruni mo2) (RZmta 8.3)
	with ESMTP id Z000acj6D1ALwx ; Fri, 13 Jul 2007 07:11:40 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 8C1D6277BD;
	Fri, 13 Jul 2007 07:11:40 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id DE821C164; Fri, 13 Jul 2007 07:11:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7154c5c60707121733r6584a407r8d60d5890b9c89e2@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+bxu8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52360>

David Frech, Fri, Jul 13, 2007 02:33:19 +0200:
> On 7/12/07, David Frech <nimblemachines@gmail.com> wrote:
> >On 7/12/07, Junio C Hamano <gitster@pobox.com> wrote:
> >> Then a nightly update would go like this:
> >>
> >>  $ cd ~/nightly-git
> >>  $ git pull origin next
> >>  $ make clean
> >>  $ make test || barf
> 
> One more thing: would it make sense to do "make -k test" so that *all*
> failures (if >1) show up?

Yes, definitely. You'll find you will see failures which you know are
already fixed, just didn't reach the nightly-build yet.

BTW, do _not_ send the errors to this mailing list. It just too easy
gets out of control. And consider saving the build log somewhere after
doing a _completely_ clean build, i.e. like this:

    #!/bin/bash
    cd ~/nightly-git || exit
    echo 'Subject: Nightly build git next ' $(date) >/tmp/mail.msg
    echo >>/tmp/mail.msg
    {
	rm -rf * # it does not remove .git
	git reset --hard
	git pull origin next || exit 1
	make || exit 1
	make -k test|| exit 1
    } &>> /tmp/mail.msg

    $ nightly-build || sendmail local-user@localhost < /tmp/mail.msg

It is simplier to find out what went wrong if you know what state did
you have before doing the test. And the state after rm -rf * is very
simple to predict.
