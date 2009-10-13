From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when appropriate to do so
Date: Tue, 13 Oct 2009 10:51:45 +0200
Message-ID: <200910131051.47117.trast@student.ethz.ch>
References: <0016e68fd0123a175304754694b4@google.com> <200910130836.57011.trast@student.ethz.ch> <7vljjf226t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <Euguess@gmail.com>, Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 13 11:02:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxdFt-0003Ij-OT
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 11:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933287AbZJMIxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 04:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbZJMIxK
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 04:53:10 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:43897 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752662AbZJMIxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 04:53:09 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Tue, 13 Oct
 2009 10:52:20 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Tue, 13 Oct
 2009 10:52:39 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <7vljjf226t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130148>

Junio C Hamano wrote:
> 
> What it means is that -t was a broken attempt to help the users at the UI
> level, and I can surely see that.
> 
> So we need the set of new rules, say, for 1.7.0 release.  A strawman?

I feel somewhat uneasy commenting on this because I have a history of
writing just-barely-workable UIs.  That being said:

> Assume that these are the only refs that exist:
> 
>     refs/remotes/origin/{master,next,nitfol}
>     refs/remotes/xyzzy/{frotz,nitfol}
>     refs/heads/master
>     refs/tags/v1.0.0
> 
> #0. These will stay as is:
> 
>  $ git checkout mine               ;# switches to the branch
>  $ git checkout $any_committish^0  ;# detaches
> 
> #1. These used to detach, but will create a local branch
> 
>  $ git checkout origin/next        ;# as if with -t
>  $ git checkout xyzzy/frotz        ;# as if with -t (origin is not special)

Agreed, though I'm still in favour of a cleaner syntax for explicit
detaching.  (Cleaner in the sense that ^0 is documented as having a
completely different purpose and only works by accident.)

> #2. These are allowed only when unambiguous and there is no local branch yet.
> 
>  $ git checkout next               ;# ok
>  $ git checkout frotz              ;# ok (origin is not special)
>  $ git checkout nitfol             ;# not ok (ambiguous and origin is not special)

I'm weakly leaning towards refusing all three, as the user should be
required to explicitly say a remote branch should be involved.

(Weakly because there's also a certain DWIM advantage to 'git checkout
sometopic'...)

> #3. These used to detach, but what should we do?
> 
>  $ git checkout v1.0.0             ;# detach, or refuse???

Refuse, on the grounds that the main goal here is not detaching unless
specifically told to.  (Having a branch called v1.0.0 is worse, as it
would just cause a lot of confusion and/or a refusal at the next
checkout.)

>  $ git checkout origin/master      ;# detach, or refuse???

This seems to be the trickiest of them.  Maybe check out 'master', to
make the process repeatable.  Imagine, in your setting,

  git checkout origin/next           ;# creates 'next' as with -t
  git checkout -                     ;# back
  git checkout origin/next           ;# should go to 'next' again

Then again, that would trade the confusion of detaching for the
confusion of not checking out the exact commit that the user
specified.  Worse, 'next' could conceivably be tracking (as per
branch.next.merge) some entirely different branch, making the "Your
branch is behind..." message misleading.

> I can buy 0, 1, and 2, and I think it is a minor inconvenience if we
> started refusing to detach in case #3, as people who want to detach can
> always suffix ^0 or ~0 to make it a general committish.
> 
> Did I cover all cases?

Some that come to mind:

#3a. Other refs apart from tags that currently detach:

  git fetch origin master            ;# or even sillier, 'git fetch . master'
  git checkout FETCH_HEAD            ;# used to detach; refuse?

#3b. Full specifiers that currently detach:

  git checkout refs/heads/master     ;# could eventually attach
  git checkout heads/master          ;# same

#0a. Should probably detach if the previous checkout was detached:

  git checkout -                     ;# detach if previous was detached?
  git checkout @{-1}                 ;# same

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
