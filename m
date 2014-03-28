From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [BUG] MSVC: error box when interrupting =?utf-8?b?YGdpdA==?= =?utf-8?b?bG9nYA==?= by quitting less
Date: Fri, 28 Mar 2014 10:07:22 +0000 (UTC)
Message-ID: <loom.20140328T105136-494@post.gmane.org>
References: <20130220195147.GA25332@sigill.intra.peff.net> <20130220200136.GH25647@sigill.intra.peff.net> <loom.20140328T093203-852@post.gmane.org> <loom.20140328T101113-154@post.gmane.org> <20140328094443.GA16370@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 11:07:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTThc-0000NI-DX
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 11:07:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbaC1KHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 06:07:50 -0400
Received: from plane.gmane.org ([80.91.229.3]:34825 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051AbaC1KHs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 06:07:48 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WTThT-0000IS-Eq
	for git@vger.kernel.org; Fri, 28 Mar 2014 11:07:47 +0100
Received: from 185.6.245.138 ([185.6.245.138])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Mar 2014 11:07:47 +0100
Received: from marat by 185.6.245.138 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Mar 2014 11:07:47 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 185.6.245.138 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.152 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245376>

Jeff King <peff <at> peff.net> writes:

> 
> I'm not sure what an actual SIGPIPE death looks like on Windows.

There is no SIGPIPE death on Windows due to total absence of SIGPIPE.
raise(unsupported int) just causes ugly "git.exe has stopped working"
window and possibly ends up as SIGABT (I don't know how to check this).

> What
> happens if git is still writing data to the pager and the pager exits?
> Does it receive a signal of some sort?

I'm not sure what you mean, sorry. check_pipe properly detects pager exit.
The problem is with the way it tries to die.

> The point of the code in check_pipe is to simulate that death. So
> whatever happens to git in that case is what we would want to happen
> when we call raise(SIGPIPE).

That's what I'm talking about. On Windows, you can't raise(SIGPIPE).
You can only raise(Windows_supported_signal) where signal is one of:
SIGABRT, SIGFPE, SIGILL, SIGINT, SIGSEGV, SIGTERM as MSDN tells us.

> A possibly simpler option would be to just have the MSVC build skip the
> raise() call, and do the exit(141) that comes just after. That is
> probably close enough simulation of SIGPIPE death.

Isn't raise(SIGTERM/SIGINT) good enough?
