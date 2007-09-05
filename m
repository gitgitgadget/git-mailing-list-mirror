From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 11:04:16 +0200
Message-ID: <vpqbqchxz3j.fsf@bauges.imag.fr>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<7vsl5tk1r8.fsf@gitster.siamese.dyndns.org>
	<200709051013.39910.johan@herland.net>
	<vpqtzq91p5z.fsf@bauges.imag.fr> <20070905085158.GC31750@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Sep 05 11:04:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISqoi-0000X5-UQ
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 11:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977AbXIEJEx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 05:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755970AbXIEJEw
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 05:04:52 -0400
Received: from imag.imag.fr ([129.88.30.1]:49609 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755971AbXIEJEw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 05:04:52 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l8594HfD029962
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 5 Sep 2007 11:04:17 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1ISqo5-0005ts-1R; Wed, 05 Sep 2007 11:04:17 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1ISqo4-00086V-VE; Wed, 05 Sep 2007 11:04:16 +0200
In-Reply-To: <20070905085158.GC31750@artemis.corp> (Pierre Habouzit's message of "Wed\, 05 Sep 2007 10\:51\:58 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 05 Sep 2007 11:04:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57695>

Pierre Habouzit <madcoder@debian.org> writes:

> On Wed, Sep 05, 2007 at 08:39:52AM +0000, Matthieu Moy wrote:
>> Johan Herland <johan@herland.net> writes:
>> 
>> > When git-fetch and git-commit has done its job and is about to exit, it checks 
>> > the number of loose object, and if too high tells the user something 
>> > like "There are too many loose objects in the repo, do you want me to repack? 
>> > (y/N)". If the user answers "n" or simply <Enter>,
>> 
>> I don't like commands to be interactive if they don't _need_ to be so.
>> It kills scripting, it makes it hard for a front-end (git gui or so)
>> to use the command, ...
>
>   There is absolutely no problem here, as it can be avoided if the
> output is not a tty. It's not _that_ hard to guess if you're currently
> running in a script or in an interactive shell after all.

I do find it hard to guess _reliably_ if you're running interactively
or not. For example, I've been bitten recently by "git log" running
inside a pager while I was launching it non-interactively inside Emacs
(as part of DVC). I don't know whether this was git's or Emacs's
fault, and the fix was not too hard (GIT_PAGER=cat), but it took some
of my time to get it working.

Adding more interactive stuff means adding more opportunities for this
kind of problems. None will be a huge problem, but each problem will
take some time to be fixed (I'm pretty sure adding an interactive
prompt in git-commit will break DVC's commit functionality, and we'll
have to fix it).

>   Really, git commit/fetch/... whatever suggesting to repack/gc when it
> believes it begins to be critical to performance is not a bad idea.

_Suggesting_ is a good idea, definitely. Something like

if (number_of_unpacked > 1000 && number_of_unpacked < 10000) {
	printf ("more than 1000 unpacked objects. Think of running git-gc\n");
} else if (number_of_unpacked >= 10000) {
	printf ("HEY, WHAT THE HELL ARE YOU DOING WITH >10000 UNPACKED OBJECTS???\n"
                "I TOLD YOU TO REPACK\n");
}

would be fine with me. The proposal to run git-gc in the background,
with low priority seems to be a good idea too.

But please, don't put an interactive prompt where it's not needed.

-- 
Matthieu
