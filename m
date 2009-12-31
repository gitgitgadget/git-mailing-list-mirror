From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [Updated PATCH 2/2] Improve transport helper exec failure reporting
Date: Thu, 31 Dec 2009 18:48:02 +0100
Message-ID: <4B3CE3D2.5010502@kdbg.org>
References: <1262170338-11574-1-git-send-email-ilari.liusvaara@elisanet.fi> <1262170338-11574-3-git-send-email-ilari.liusvaara@elisanet.fi> <4B3CC6E5.7090404@kdbg.org> <20091231165904.GA24243@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Dec 31 18:52:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQPCb-0002Yg-4e
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 18:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbZLaRsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 12:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbZLaRsF
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 12:48:05 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:23202 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750722AbZLaRsF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 12:48:05 -0500
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 04F9F10002;
	Thu, 31 Dec 2009 18:48:00 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091231165904.GA24243@Knoppix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135959>

Ilari Liusvaara schrieb:
> On Thu, Dec 31, 2009 at 04:44:37PM +0100, Johannes Sixt wrote:
>> Ilari Liusvaara schrieb:
>>> @@ -31,13 +31,19 @@ static struct child_process *get_helper(struct transport *transport)
>> You should set helper->silent_exec_failure = 1 when you give your
>> own error message for the ENOENT case.
> 
> Ah yeah, might matter for Win32.

Actually, no. I forgot to mention that your modified start_command should 
treat ENOENT differently by looking at cmd->silent_exec_failure. But see 
below.

>> BTW, which error message do you see without your change in this
>> case? You only say "pretty much useless", but do not give an
>> example.
> 
> git: 'remote-foo' is not a git-command. See 'git --help'.
> 
> And as first line of output, such thing is utterly confusing.

And you change this by treating the helper command not as a git command, 
but as a normal command that happens to start with 'git-'. Whether this 
interpretation is suitable for the transport layer, I do not want to 
decide and I will certainly not object. :-)

An alternative solution would be to forward the silent_exec_failure flag 
to exec_git_cmd() to unify the treatment of the error condition with the 
non-git-command error path.

>>> +		else
>>> +			die("Unable to run helper %s: %s", helper->argv[0],
>>> +				strerror(errno));
>> You shouldn't write an error message here because start_command has
>> already reported the error.
> 
> Its not printed on Unix.

I see.

Documentation/technical/api-run-command.txt documents the error behavior. 
There are three error cases:

1. system call failures
2. exec failure due to ENOENT
3. non-zero exit of the child and death through signal

Your patch makes all exec failures into category 1, but IMO, these are 
actually category 3 (except for the ENOENT case).

In case 3, it is expected that the child process prints a suitable error 
message. Therefore, you should start with merely replacing the unconditional

	exit(127);
by
	if (errno == ENOENT)
		exit(127);
	else
		die_errno("Cannot exec %s", cmd->argv[0]);

And then you can think about how you support the ENOENT case better. My 
proposal for this was to do the PATH lookup manually before the fork(), 
and then the above conditional would melt down to simply:

	die_errno("Cannot exec %s", cmd->argv[0]);

-- Hannes
