From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [Updated PATCH 2/2] Improve transport helper exec failure reporting
Date: Thu, 31 Dec 2009 19:44:40 +0100
Message-ID: <4B3CF118.7080404@kdbg.org>
References: <1262170338-11574-1-git-send-email-ilari.liusvaara@elisanet.fi> <1262170338-11574-3-git-send-email-ilari.liusvaara@elisanet.fi> <4B3CC6E5.7090404@kdbg.org> <20091231165904.GA24243@Knoppix> <4B3CE3D2.5010502@kdbg.org> <20091231182436.GA1326@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Dec 31 19:44:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQQ0s-0003Ns-Lu
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 19:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbZLaSom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 13:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752979AbZLaSom
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 13:44:42 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:44724 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752959AbZLaSol (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 13:44:41 -0500
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E0F22CDFA7;
	Thu, 31 Dec 2009 19:44:38 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091231182436.GA1326@Knoppix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135964>

Ilari Liusvaara schrieb:
> On Thu, Dec 31, 2009 at 06:48:02PM +0100, Johannes Sixt wrote:
>> In case 3, it is expected that the child process prints a suitable
>> error message. Therefore, you should start with merely replacing the
>> unconditional
>>
>> 	exit(127);
>> by
>> 	if (errno == ENOENT)
>> 		exit(127);
>> 	else
>> 		die_errno("Cannot exec %s", cmd->argv[0]);
>>
>> And then you can think about how you support the ENOENT case better.
>> My proposal for this was to do the PATH lookup manually before the
>> fork(), and then the above conditional would melt down to simply:
>>
>> 	die_errno("Cannot exec %s", cmd->argv[0]);
>>
> 
> The child process can't sanely print anything. Stderr would go to
> who knows where.

Wrong - because:

> Parent process should have much better idea what to
> do with errors.

Very correct. For this reason, the parent process assigns a stderr channel 
to the child (or does not do so to inherit its own stderr), and the child 
is expected to use it. Errors due to execvp failures are no exception, IMO 
(except ENOENT, as always).

-- Hannes
