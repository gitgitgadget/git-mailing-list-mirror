From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: t5800-*.sh: Intermittent test failures
Date: Thu, 08 Sep 2011 18:42:11 +0100
Message-ID: <4E68FE73.4000005@ramsay1.demon.co.uk>
References: <4E417CB4.50007@ramsay1.demon.co.uk> <CAGdFq_jv_T-x7VGqm_j-fDfeW6TsBG95=1TWn91Yk9B3TGZdsQ@mail.gmail.com> <7vpqjgyvn1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 01:32:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1o50-0002tS-Mw
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 01:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755215Ab1IHXcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 19:32:04 -0400
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:37698 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755429Ab1IHXcA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2011 19:32:00 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1R1ie2-0003RZ-fs; Thu, 08 Sep 2011 17:44:46 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vpqjgyvn1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181005>

Junio C Hamano wrote:
> Sverre Rabbelier <srabbelier@gmail.com> writes:
>> On Tue, Aug 9, 2011 at 20:30, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
>>> The git-fast-import is hung in the read() syscall waiting for data which will
>>> never arrive. This is because the git(fast-export) process, started by the above
>>> git(push), executes (producing it's data on stdout) and completes successfully
>>> and exits *before* the above git-fast-import process starts.
>>>
>>> I haven't looked to see how the git(fast-export)/git-fast-import processes are
>>> plumbed together, but there seems to be a synchronization problem somewhere ...
>> This seems odd, before the fast-export process is even started it's
>> stdout are wired to the stdin of the helper (and thus the fast-import
>> process). What indication do you have that fast-import hasn't started
>> and that fast-export has finished?
>>
>> Also, you say git remote-test everywhere, but it should be git
>> remote-testgit, typo?
> 
> FWIW, I have been seeing this every once in a while.

Good to know I'm not alone ;-P

Unfortunately, I haven't had the time to debug this further than I've
already reported ...

As I said, it's obviously a process plumbing/synchronization problem; the reading
end of the fast-export output pipe must be open for read by someone (probably by
it's parent), otherwise it would receive SIGPIPE (also, the output is small enough
not to fill the pipe) rather than exiting with success.

When I run the tests with "make test >test-out", I see a failure rate of about
1 in 10. If I then set the debug environment variables (GIT_TRANSPORT_HELPER_DEBUG,
GIT_TRANSLOOP_DEBUG and GIT_DEBUG_TESTGIT) and run the test script directly (-v),
then the failure rate goes up to about 1 in 3.

Well, ... I added debug code to git-fast-{im,ex}port which writes the debug info
to a file (can't write to stdout/stderr obviously), so that may well be affecting
the timing enough to increase the chance of a failure. Having said that, If I'm
listening to music (rhythmbox) at the same time, then the failure rate seems to
increase ...

ATB,
Ramsay Jones
