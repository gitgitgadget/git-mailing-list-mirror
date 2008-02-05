From: Scott Parish <srp@srparish.net>
Subject: Re: git-daemon breakage in 1.5.4
Date: Tue, 5 Feb 2008 09:49:22 -0800
Message-ID: <AC76050F-D727-4952-A528-55827D5B707B@srparish.net>
References: <BE051395-F4E1-428B-89B3-5D01BEA42C71@wincent.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 04:38:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMb6q-0007w7-7S
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 04:38:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756652AbYBFDhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 22:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756604AbYBFDhL
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 22:37:11 -0500
Received: from smtp-gw3.mailanyone.net ([208.101.54.178]:56724 "EHLO
	smtp-gw3.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756580AbYBFDhK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 22:37:10 -0500
X-Greylist: delayed 34933 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Feb 2008 22:37:10 EST
Received: from mailanyone.net
	by smtp-gw3.mailanyone.net with esmtp (MailAnyone extSMTP)
	id 1JMS0V-0003Ro-Gw
	for git@vger.kernel.org; Tue, 05 Feb 2008 11:54:55 -0600
Received: from mailanyone.net
	by smtp-gw47.mailanyone.net with esmtpsa (TLSv1:AES128-SHA:128)
	(MailAnyone extSMTP srp)
	id 1JMRuf-00025r-Rq; Tue, 05 Feb 2008 11:48:54 -0600
In-Reply-To: <BE051395-F4E1-428B-89B3-5D01BEA42C71@wincent.com>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72751>


On Feb 5, 2008, at 7:39 AM, Wincent Colaiuta wrote:

> I just noticed that my copy of git-daemon running from xinetd on  
> Red Hat Enterprise Linux 3 has been broken since upgrading to 1.5.4.
>
> Nothing printed to the logs on the server side: it simply hangs up.  
> By connecting via telnet I've confirmed that git-daemon is running  
> and does accept the initial connection.
>
> The verdict according to "git bisect" is that  
> 511707d42b3b3e57d9623493092590546ffeae80 is first bad commit:
>
> Does that look like it might be the issue? Anyone familiar with  
> that part of the code care to comment? Any other info I can provide  
> that might shed light on the problem?

Prior to that patch, execv_git_cmd called execve in a loop to find  
the command to run. The above patch added a setup_path() api to setup  
PATH and then called execvp() to do the looping. The problem in this  
case is that daemon is never calling setup_path(), so the builtin  
path (among others) aren't getting included in the PATH.

You should see the problem go away if you run "git daemon" instead of  
"git-daemon". Given that directly using the dash versions of the  
commands are discouraged, it probably wouldn't hurt doing this  
anyway. I'll work up a patch later today.

sRp
