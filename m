From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Tue, 08 Jun 2010 20:59:55 +0200
Message-ID: <4C0E932B.3010702@viscovery.net>
References: <1275955088-32750-1-git-send-email-soft.d4rio@gmail.com>	<1275955270-sup-2380@pinkfloyd.chass.utoronto.ca>	<AANLkTinydWk3GqGDww8FS7pmW16jAVazRkmT_GsRMIhy@mail.gmail.com>	<20100608053507.GB15156@coredump.intra.peff.net>	<AANLkTilvvpy4TBQF6g8boQL87FRB7kFDrVfYiHvOv6xu@mail.gmail.com>	<4C0E5103.7030501@viscovery.net>	<AANLkTilWg8hw5j20o-xGsVO-q_OeSmtKEKAO6O416qvH@mail.gmail.com>	<4C0E6810.3070301@viscovery.net> <AANLkTinZSuXJEXzpvEavYNLSyqUlx8qzWlrbtIH6q6fx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Ben Walton <bwalton@artsci.utoronto.ca>,
	git <git@vger.kernel.org>
To: Dario Rodriguez <soft.d4rio@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 21:00:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM41u-0008Ll-Kk
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 21:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755628Ab0FHTAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 15:00:00 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:31985 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755623Ab0FHS77 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 14:59:59 -0400
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 0F3CC2C4018;
	Tue,  8 Jun 2010 20:59:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <AANLkTinZSuXJEXzpvEavYNLSyqUlx8qzWlrbtIH6q6fx@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148702>

Am 08.06.2010 19:28, schrieb Dario Rodriguez:
> On Tue, Jun 8, 2010 at 12:56 PM, Johannes Sixt<j.sixt@viscovery.net>  wrote:
>> Am 08.06.2010 16:39, schrieb Dario Rodriguez:
>>>
>>> On Tue, Jun 8, 2010 at 11:17 AM, Johannes Sixt<j.sixt@viscovery.net>
>>>   wrote:
>>>>
>>>>   $ GIT_PAGER=/is/not/there git log
>>>>   $ echo $?
>>>>   141
>>>>
>>>> That's SIGPIPE, just as I would expect.
>>>
>>> As I said in the original thread...
>>>
>>> $ PAGER=/nothing/here ../git log
>>> $ echo $?
>>> 0
>>
>> That's no surprise with your toy repository: git-log has run to completion
>> (without overrunning the pipe buffer) before the pager process that it
>> forked can even execute its first instruction.
>>
>
> I cannot understand what's the point... I'm running git without
> installing it, but why do you say "toy repository"?...

Your repository has only 2 commits and its git log output is less than 
1kB, i.e., sufficiently small to fit in a pipe's buffer.

git log calls start_command to fork() the pager. The OS's scheduler does 
not run the newly forked process immediately; rather, git log goes on with 
its own business, writing output to the pipe that connects to the pager. 
Because your repository is so small, git log never has to wait that the 
pager drains the pipe. git log finally reaches exit(0). At this time, an 
atexit() handler (wait_for_pager()) finally calls finish_command() to wait 
for the pager.

This is the first time that the forked child process can run. Only now it 
turns out that the pager cannot be run. The child process closes the pipe 
and exits with an error, but it is too late: wait_for_pager() drops the 
error return code of finish_command() to the floor. The parent process 
(git log) can complete with the exit code that it was given earlier, 0.

Repeat your experiment with ./git log in git.git itself to see the difference.

-- Hannes
