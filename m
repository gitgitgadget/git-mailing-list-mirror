From: John Keeping <john@keeping.me.uk>
Subject: Re: Unexpected/unexplained difference between git pull --rebase and
 git rebase
Date: Tue, 3 Mar 2015 23:40:57 +0000
Message-ID: <20150303234057.GR890@serenity.lan>
References: <CAPfvZp6oNnM=M-9BAVqAE052jQApH-O_t3gEoq6JWC2kQrR8gg@mail.gmail.com>
 <20150303210900.GP890@serenity.lan>
 <CAPfvZp5KmEwY_903aUJE0p7qKMUbABYpC3Y8JvPSc_Dmd0ppGA@mail.gmail.com>
 <20150303214653.GQ890@serenity.lan>
 <xmqq61ahad18.fsf@gitster.dls.corp.google.com>
 <CAPfvZp5jTTbWVL0QuZTP83=SWvsvyZWX0BG_q7jPLK5wNNvCgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Botsko <botsko@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 00:47:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSwX2-00047X-G0
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 00:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756618AbbCCXrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 18:47:13 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:33652 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756006AbbCCXrM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 18:47:12 -0500
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Mar 2015 18:47:12 EST
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 47581866038;
	Tue,  3 Mar 2015 23:41:16 +0000 (GMT)
X-Quarantine-ID: <nFhylJlPWWtd>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.001
X-Spam-Level: 
X-Spam-Status: No, score=-1.001 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_20=-0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nFhylJlPWWtd; Tue,  3 Mar 2015 23:41:12 +0000 (GMT)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 2D06D866017;
	Tue,  3 Mar 2015 23:40:59 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAPfvZp5jTTbWVL0QuZTP83=SWvsvyZWX0BG_q7jPLK5wNNvCgg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264710>

On Tue, Mar 03, 2015 at 03:20:48PM -0800, Mike Botsko wrote:
> Maybe I'm lacking the distinction regarding what I'm being specific about.
> 
> In both examples, I'm asking it specifically to rebase in changes from
> the remote "upstream" and a named branch at that location. I'm giving
> git the same information, it's just interpreting it differently - and
> I'm not understanding why.

Not quite.  If you say:

	git rebase $sha1

then you're telling git-rebase to apply the commits $sha1..HEAD onto
$sha1.

If you say:

	git rebase

then it will be re-written as:

	git rebase --fork-point @{upstream}

in which case Git will apply more complicated logic so that you can
recover from the case where @{upstream} has been re-written.

Consider the following scenario:

                      F			branch
                     /
               C -- D			master@{1}
              /
	A -- B -- C' -- D' -- E		master

where C' and D' are rewritten versions of C and D.

In this case, imagine you are at F on "branch", "git rebase master" will
replace C, D and F onto E because you have explicitly selected to replay
master..branch onto master.

"git rebase" will apply the fork-point logic and realise that D is a
previous version of master, so it will only replay F onto E.

In general if you just want to rebase onto your upstream it is simpler
to just call "git rebase" which will do the right thing; it's also
shorter to type ;-)

> My local branch would have been created from the
> upstream/feature-branch, and will eventually be merged back into it.
> Until I'm ready for that, I regularly rebase the work done on
> upstream/feature-branch so that my local work is always clean and
> above anything else.

In this case the problem stems from the fact that
upstream/feature-branch has been rewritten.  Building on top of branches
that will be rewritten is not advisable unless you have a really good
reason to do so.

> On Tue, Mar 3, 2015 at 3:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > John Keeping <john@keeping.me.uk> writes:
> >
> >> git-rebase assumes that if you give an explicit upstream then you want
> >> precisely what you asked for.  From git-rebase(1):
> >>
> >>       If either <upstream> or --root is given on the command line,
> >>       then the default is `--no-fork-point`, otherwise the default is
> >>       `--fork-point`.
> >
> > Correct.
> >
> > You ask it to rebase the history without guessing by being explicit;
> > the command guesses when you are not explicit and being lazy ;-).
