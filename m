From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [BUG] MSVC: error box when interrupting `gitlog` by quitting
 less
Date: Fri, 28 Mar 2014 11:28:51 +0100
Message-ID: <53354EE3.2050908@viscovery.net>
References: <20130220195147.GA25332@sigill.intra.peff.net> <20130220200136.GH25647@sigill.intra.peff.net> <loom.20140328T093203-852@post.gmane.org> <loom.20140328T101113-154@post.gmane.org> <20140328094443.GA16370@sigill.intra.peff.net> <loom.20140328T105136-494@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Fri Mar 28 11:28:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTU1y-00045Q-4B
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 11:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbaC1K2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 06:28:54 -0400
Received: from so.liwest.at ([212.33.55.23]:53262 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbaC1K2x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 06:28:53 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WTU1q-0002VP-2F; Fri, 28 Mar 2014 11:28:50 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BD70216613;
	Fri, 28 Mar 2014 11:28:49 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <loom.20140328T105136-494@post.gmane.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245378>

Please do not cull the Cc list.

Am 3/28/2014 11:07, schrieb Marat Radchenko:
> Jeff King <peff <at> peff.net> writes:
> 
>>
>> I'm not sure what an actual SIGPIPE death looks like on Windows.
> 
> There is no SIGPIPE death on Windows due to total absence of SIGPIPE.
> raise(unsupported int) just causes ugly "git.exe has stopped working"
> window and possibly ends up as SIGABT (I don't know how to check this).

This happens "only" with newer Microsoft C runtime libraries. They do not
return EINVAL (because that usually indicates a bug caused by insufficient
checks before the function call), but crash the program by default in the
way that you observed.

>> What
>> happens if git is still writing data to the pager and the pager exits?
>> Does it receive a signal of some sort?

No; the write attempt returns with EPIPE.

> 
> I'm not sure what you mean, sorry. check_pipe properly detects pager exit.
> The problem is with the way it tries to die.
> 
>> The point of the code in check_pipe is to simulate that death. So
>> whatever happens to git in that case is what we would want to happen
>> when we call raise(SIGPIPE).
> 
> That's what I'm talking about. On Windows, you can't raise(SIGPIPE).
> You can only raise(Windows_supported_signal) where signal is one of:
> SIGABRT, SIGFPE, SIGILL, SIGINT, SIGSEGV, SIGTERM as MSDN tells us.

Correct. All other signal number should return EINVAL. But, as I said,
that does not happen by default.

The correct solution is to link against invalidcontinue.obj in the MSVC
build. This is a compiler-provided object file that changes the default
behavior to the "expected" kind, i.e., C runtime functions return EINVAL
when appropriate instead of crashing the application.

>> A possibly simpler option would be to just have the MSVC build skip the
>> raise() call, and do the exit(141) that comes just after. That is
>> probably close enough simulation of SIGPIPE death.

Correct. The MinGW build uses an older C runtime library, which does not
have the strange default behavior, and we do use that exit(141). And with
the fix to the MSVC build suggested above, that version would do likewise.

-- Hannes
