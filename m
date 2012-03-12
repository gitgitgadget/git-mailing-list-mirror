From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 02/11] Introduce a performance test for git-rebase
Date: Mon, 12 Mar 2012 18:41:23 +0100
Message-ID: <87ipi9yaws.fsf@thomas.inf.ethz.ch>
References: <cover.1331561353.git.trast@student.ethz.ch>
	<e6a6af53264368a25e71719901f3227042e21f5c.1331561353.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 12 18:41:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S79FU-0006qi-No
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 18:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722Ab2CLRl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 13:41:27 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:34488 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751591Ab2CLRl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 13:41:26 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 18:41:22 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 18:41:23 +0100
In-Reply-To: <e6a6af53264368a25e71719901f3227042e21f5c.1331561353.git.trast@student.ethz.ch>
	(Thomas Rast's message of "Mon, 12 Mar 2012 16:09:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192910>

Thomas Rast <trast@student.ethz.ch> writes:

> The perf framework lets the user run the test in an arbitrary repo,
> which makes writing a test for rebase a bit finicky.  This one uses a
> perl script to determine a longest linear segment of history, that is,
> a range A..B which is completely linear.  (For a full clone of
> git.git, this is the (whole) 'html' branch.)  The number of commits
> that are rebased is capped at 50, however.  That is, if A..B is more
> than 50 commits, it uses B~50..B instead.
>
> Having determined a suitable range, it then runs rebase with all
> combinations of rerere (on/off), -i / noninteractive, and -m / normal.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---

I forgot to put the interesting part here:

 Test                                   this tree
 ------------------------------------------------------
 3400.4: rebase -f (rerere off)         4.64(2.12+1.80)
 3400.5: rebase -m -f (rerere off)      4.17(2.07+1.53)  to .4: -10% ***
 3400.6: rebase -i -f (rerere off)      4.51(2.30+1.57)  to .4:  -3% *
 3400.7: rebase -i -m -f (rerere off)   4.51(2.31+1.57)
 ------------------------------------------------------
 Significance hints:  '.' 0.1  '*' 0.05  '**' 0.01  '***' 0.001

I did the change/significance manually here, so I might have made a
mistake in the exact numbers.

However, it's pretty obvious that 'rebase -f' is slow compared to
'rebase -m'.  So slow in fact that the user would be better off running
an *interactive* rebase.

So what's the advantage of not using -m?  I always thought it was
because plain rebase was supposed to be *faster* than -m, and I
confirmed this in an extremely scientific test on #git-devel:

  [09 Mar 14:05] <charon> hrm, what's the advantage of straight rebase over 'rebase -m' ?
  [09 Mar 14:06] <mhagger> charon: It's supposed to be significantly faster
  [09 Mar 14:06] <charon> mhagger: ah thanks, that's what i suspected

This wasn't always the case; back in v1.7.0 you would see this picture:

 Test                                v1.7.0
 ---------------------------------------------------
 3400.4: rebase -f (rerere off)      3.75(2.12+1.18)
 3400.5: rebase -m -f (rerere off)   4.05(2.29+1.32)  to .4: +8% ***

This comes from the i18n support added in adc3b2b27..a9f578685, and from
43c2325 (am: use get_author_ident_from_commit instead of mailinfo when
rebasing, 2010-06-16).

Now I'm not really keen on hacking on git-am until it gets back its
performance, as for most uses it's probably still fast enough.  But I
think one important question is: can we get rid of the
git-format-patch|git-am mode of git-rebase, which has historically been
a source of pain (see, e.g., the aforementioned 43c2325)?

Ok, perhaps not: certain features like --whitespace depend on it :-(

--
Thomas Rast
trast@{inf,student}.ethz.ch
