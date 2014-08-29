From: Jonas 'Sortie' Termansen <Sortie@Maxsi.org>
Subject: Re: [PATCH 1/9] git-compat-util.h: Add missing semicolon after struct
 itimerval
Date: Fri, 29 Aug 2014 20:54:52 +0200
Message-ID: <5400CC7C.4010706@Maxsi.org>
References: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com> <1409330916.18778.17.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Keller, Jacob E" <jacob.e.keller@intel.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 29 20:55:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNRK5-00056R-Uc
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 20:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbaH2Syy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 14:54:54 -0400
Received: from csmtp2.one.com ([91.198.169.22]:35289 "EHLO csmtp2.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752942AbaH2Syx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 14:54:53 -0400
Received: from [192.168.1.2] (0133301021.0.fullrate.dk [95.166.189.26])
	by csmtp2.one.com (Postfix) with ESMTPA id A1A2F4000A2E3;
	Fri, 29 Aug 2014 18:54:51 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1409330916.18778.17.camel@jekeller-desk1.amr.corp.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256179>

Hi,

Thanks for the interest. :)

There's a whole lot of emails being sent. I'll make a nice V2 shortly that
takes your feedback into consideration. :)

But first let's discuss. I think we should define the intended criteria.

I expect to find these systems out there:
 * No setitimer and no timer_settime.
 * Has setitimer and no timer_settime.
 * Has setitimer and timer_settime (broken).
 * Has setitimer and timer_settime (works).
 * No setitimer and timer_settime (works).

Which of these do we want to support? Right we support the cases where
systems have setitimer, the cases without it is slightly broken prior to
my fixes.

Jake's modified patch set breaks the case where timer_settimer exists and
is broken. As far as I know, that's only OpenBSD among the noticeable free
software world, but could be more systems, perhaps in the future.

The progress bar displayed is rather non-essential. If we go with Jake's
proposal, we support most non-broken platforms, and the broken platforms
will start working when they add POSIX timers.

Ideally, I'd prefer to only support the systems with timer_settime that
works, but real people use git on systems without and it is not too much
work to support all of these combinations.

I see these approaches to the problem:

1) Only use setitimer (do nothing right now).

 * Disadvantage: We don't support modern systems without setitimer but that
   has timer_settime. Those are few, though, as setitimer is pretty much
   universal at the moment.

 * Disadvantage: We are using an older interface instead of the modern good
   practices.

2) Use setitimer (emulated with timer_create if needed).

 * Disadvantage: The core source code doesn't employ current best practices.

3) Use timer_create (emulated with setitimer if needed).

 * Disadvantage: The build system may have a false positive when checking
   whether timer_settime is available.

4) Use both (decision is made at runtime if both are available)

   If we do this well, the bulk of the compatibility code is isolated from
   the real source code (that just uses timer_settime naively) and it can
   be reduced when broken systems gets fixed.

 * Advantage: No regressions.

 * Disadvantage: The compatibility logic may be complicated.

I'm personally in favor of proposal 3, but it's more in git's spirit to pick
proposal 4 as supports more of the real systems out there.

My first attempt was essentially proposal 4, but with no effort in trying to
hide the fact that timer_settime might be broken. I'm going to develop a V2
that isolates this compatibility logic from the core code. I'm not convinced
this approach is actually cleaner, but we'll see when it's done. Either way,
isolated compatibility code today can be removed tomorrow when we no longer
need it. :)

Jonas
