From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v2 4/5] check-ignore: allow incremental streaming of
 queries via --stdin
Date: Thu, 11 Apr 2013 21:31:41 +0100
Message-ID: <20130411203141.GB21091@pacific.linksys.moosehall>
References: <20130411110511.GB24296@pacific.linksys.moosehall>
 <1365681913-7059-1-git-send-email-git@adamspiers.org>
 <1365681913-7059-4-git-send-email-git@adamspiers.org>
 <20130411191132.GC3177@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 22:32:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQOAJ-0003ez-2S
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 22:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765136Ab3DKUcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 16:32:10 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:59841 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759724Ab3DKUbn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 16:31:43 -0400
Received: from localhost (2.d.c.d.2.5.f.b.c.0.4.8.0.1.4.d.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:d410:840c:bf52:dcd2])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 0E58358EB3
	for <git@vger.kernel.org>; Thu, 11 Apr 2013 21:31:42 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130411191132.GC3177@sigill.intra.peff.net>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220925>

On Thu, Apr 11, 2013 at 03:11:32PM -0400, Jeff King wrote:
> I always get a little nervous with sleeps in the test suite, as they are
> indicative that we are trying to avoid some race condition, which means
> that the test can fail when the system is under load, or when a tool
> like valgrind is used which drastically alters the timing (e.g., if
> check-ignore takes longer than 1 second to produce its answer, we may
> fail here).

Agreed, especially here where my btrfs filesystems see fit to kindly
freeze my system for a few seconds many times each day :-/

> Is there a simpler way to test this?
> 
> Like:
> 
>   # Set up a long-running "check-ignore" connected by pipes.
>   mkfifo in out &&
>   (git check-ignore ... <in >out &) &&
> 
>   # We cannot just "echo >in" because check-ignore
>   # would get EOF after echo exited; instead we open
>   # the descriptor in our shell, and then echo to the
>   # fd. We make sure to close it at the end, so that
>   # the subprocess does get EOF and dies properly.
>   exec 9>in &&
>   test_when_finished "exec 9>&-" &&
> 
>   # Now we can do interactive tests
>   echo >&9 one &&
>   read response <out &&
>   test "$response" = ... &&
>   echo >&9 two &&
>   read response <out &&
>   test "$response" = ...
> 
> Hmm. Maybe simpler wasn't the right word. :) But it avoids any sleeps or
> race conditions.

The shell source is strong with this one ;-)

Congrats - I first tried with FIFOs (hence my other patch which moves
the PIPE test prerequisite definition into the core framework - the
original intention was to reuse it here) but failed to get it working.
I'll re-roll using your approach.
