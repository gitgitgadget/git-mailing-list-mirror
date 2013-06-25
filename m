From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 11/16] rev-list: add bitmap mode to speed up lists
Date: Tue, 25 Jun 2013 09:22:28 -0700
Message-ID: <87mwqdlvsq.fsf@linux-k42r.v.cablecom.net>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
	<1372116193-32762-12-git-send-email-tanoku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Vicent Marti <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 23:34:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrasJ-0005Fv-6M
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 23:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854Ab3FYVeC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 17:34:02 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:6756 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532Ab3FYVeB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 17:34:01 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 25 Jun
 2013 23:33:59 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.210.110) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 25 Jun 2013 23:33:59 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.210.110]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228999>

Vicent Marti <tanoku@gmail.com> writes:

> Calling `git rev-list --use-bitmaps [committish]` is the equivalent
> of `git rev-list --objects`, but the rev list is performed based on
> a bitmap result instead of using a manual counting objects phase.

Why would we ever want to not --use-bitmaps, once it actually works?
I.e., shouldn't this be the default if pack.usebitmaps is set (or
possibly even core.usebitmaps for these things)?

> These are some example timings for `torvalds/linux`:
>
> 	$ time ../git/git rev-list --objects master > /dev/null
>
> 	real    0m25.567s
> 	user    0m25.148s
> 	sys     0m0.384s
>
> 	$ time ../git/git rev-list --use-bitmaps master > /dev/null
>
> 	real    0m0.393s
> 	user    0m0.356s
> 	sys     0m0.036s

I see your badass numbers, and raise you a critical issue:

  $ time git rev-list --use-bitmaps --count --left-right origin/pu...origin/next
  Segmentation fault

  real    0m0.408s
  user    0m0.383s
  sys     0m0.022s

It actually seems to be related solely to having negated commits in the
walk:

  thomas@linux-k42r:~/g(next u+65)$ time git rev-list --use-bitmaps --count origin/pu
  32315

  real    0m0.041s
  user    0m0.034s
  sys     0m0.006s
  thomas@linux-k42r:~/g(next u+65)$ time git rev-list --use-bitmaps --count origin/pu ^origin/next
  Segmentation fault

  real    0m0.460s
  user    0m0.214s
  sys     0m0.244s

I also can't help noticing that the time spent generating the segfault
would have sufficed to generate the answer "the old way" as well:

  $ time git rev-list --count --left-right origin/pu...origin/next
  189     125

  real    0m0.409s
  user    0m0.386s
  sys     0m0.022s

Can we use the same trick to speed up merge base computation and then
--left-right?  The latter is a component of __git_ps1 and can get
somewhat slow in some cases, so it would be nice to make it really fast,
too.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
