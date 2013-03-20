From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Add posibility to preload stat information.
Date: Wed, 20 Mar 2013 14:46:43 -0400
Message-ID: <20130320184643.GA30165@sigill.intra.peff.net>
References: <1363781732-11396-1-git-send-email-iveqy@iveqy.com>
 <CALkWK0=b80U5dxGMpwKwL+jFURisEuSapWuuNRFcP+5R2f3+GA@mail.gmail.com>
 <20130320174120.GA32426@paksenarrion.iveqy.com>
 <CALkWK0nCY3o_KW8ykq9TkzfHeVj6NKDkOFuym9UmSWLH0ZFxBw@mail.gmail.com>
 <20130320183641.GB32426@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, spearce@spearce.org,
	git@vger.kernel.org, pclouds@gmail.com
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:47:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIO2f-0005E9-42
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932773Ab3CTSqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 14:46:50 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60379 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208Ab3CTSqt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 14:46:49 -0400
Received: (qmail 11325 invoked by uid 107); 20 Mar 2013 18:48:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Mar 2013 14:48:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2013 14:46:43 -0400
Content-Disposition: inline
In-Reply-To: <20130320183641.GB32426@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218651>

On Wed, Mar 20, 2013 at 07:36:41PM +0100, Fredrik Gustafsson wrote:

> > Yes, I would certainly like my git startup time to be improved.  But I
> > don't want to trade my hard drive's life for it.
> 
> Does this really increase disk-reads? The fs-cache would make sure that
> the disk reads is almost the same, we only do them before we usually do
> them.

It shouldn't. But if you are running "stat" on every file in the repo
for each prompt, that is going to take measurable CPU time for large
repos (e.g., WebKit).

> > What I meant by "first time" is "chpwd() into the git repository, not
> > further chpwd()s when already inside the git repository".
> 
> That's a good point. I'm not sure how to solve that though. Because it's
> not a fact that you always go to the root git-dir first.
> 
> The only way I see this is with a lock-file that's kept and we only run
> git status every 5 minutes when doing something inside a work dir. That
> would add a lot of meta-data (the lock files), to store. (I hope I
> successfully explained that).

How about something like:

  __git_primed_toplevel=
  __git_prime_dir() {
          local toplevel=`git rev-parse --show-toplevel 2>/dev/null`
          if test -n "$toplevel" &&
             test "$toplevel" != "$git_primed_toplevel"; then
                  git status >/dev/null 2>&1
                  git_primed_toplevel=$toplevel
          fi
  }

that would prime the whole repo the first time you enter it, but otherwise do
nothing (and you could run it from each prompt). If you switched back and forth
between two repos a lot, you would end up priming them both a lot, but that is
not that common a mode of operation (and you could keep an list of recently
primed repos instead of a single one, if you really wanted to deal with that).
You would also prime twice if you used two different terminals, but that's OK.
The subsequent ones are much faster due to disk cache, so this is really just
about not paying the extra stat penalty on _every_ prompt.

-Peff
