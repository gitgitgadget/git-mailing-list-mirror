From: Wincent Colaiuta <win@wincent.com>
Subject: git-daemon breakage in 1.5.4
Date: Tue, 5 Feb 2008 16:39:00 +0100
Message-ID: <BE051395-F4E1-428B-89B3-5D01BEA42C71@wincent.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: srp@srparish.net
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 16:39:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMPtb-0004f3-W5
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 16:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbYBEPjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 10:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbYBEPjF
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 10:39:05 -0500
Received: from wincent.com ([72.3.236.74]:58232 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627AbYBEPjE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 10:39:04 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m15Fd1ff013276;
	Tue, 5 Feb 2008 09:39:02 -0600
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72673>

I just noticed that my copy of git-daemon running from xinetd on Red  
Hat Enterprise Linux 3 has been broken since upgrading to 1.5.4.

On the client side this is what you see ("git clone" used in the  
example but you get the same issue with "git ls-remote"):

   git clone git://git.wincent.com/wikitext.git
   Initialized empty Git repository in /tmp/wikitext/.git/
   fatal: The remote end hung up unexpectedly
   fetch-pack from 'git://git.wincent.com/wikitext.git' failed.

Nothing printed to the logs on the server side: it simply hangs up. By  
connecting via telnet I've confirmed that git-daemon is running and  
does accept the initial connection.

The verdict according to "git bisect" is that  
511707d42b3b3e57d9623493092590546ffeae80 is first bad commit:

commit 511707d42b3b3e57d9623493092590546ffeae80
Author: Scott R Parish <srp@srparish.net>
Date:   Sun Oct 28 04:17:20 2007 -0700

     use only the $PATH for exec'ing git commands

     We need to correctly set up $PATH for non-c based git commands.
     Since we already do this, we can just use that $PATH and execvp,
     instead of looping over the paths with execve.

     This patch adds a setup_path() function to exec_cmd.c, which sets
     the $PATH order correctly for our search order. execv_git_cmd() is
     stripped down to setting up argv and calling execvp(). git.c's
     main() only only needs to call setup_path().

     Signed-off-by: Scott R Parish <srp@srparish.net>
     Signed-off-by: Junio C Hamano <gitster@pobox.com>

:100644 100644 33b17a6b45699e73a9b58f0ff02135eae913b47d  
2d0a75851284392aa8ae44bc486df6a034d0af13 M	exec_cmd.c
:100644 100644 da99287552b5d3eafc495f998a936df81ee3f8b9  
a892355c8212298130fb3925c6cba352ed6999b6 M	exec_cmd.h
:100644 100644 c7cabf5f348118f318d7c3abe55853b576869a98  
4e10581101c26444da5c7c44a80219b11607705b M	git.c

Does that look like it might be the issue? Anyone familiar with that  
part of the code care to comment? Any other info I can provide that  
might shed light on the problem?

Cheers,
Wincent
