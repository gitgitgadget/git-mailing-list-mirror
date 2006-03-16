From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Thu, 16 Mar 2006 12:55:55 +0100
Message-ID: <4419524B.1030405@op5.se>
References: <20060314211022.GA12498@localhost.localdomain>	<Pine.LNX.4.64.0603141351470.3618@g5.osdl.org>	<20060314224027.GB14733@localhost.localdomain>	<Pine.LNX.4.64.0603141506130.3618@g5.osdl.org>	<7vek13ieap.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0603151450070.3618@g5.osdl.org>	<7vlkvbffhz.fsf@assigned-by-dhcp.cox.net>	<20060316075324.GA19650@pfit.vm.bytemark.co.uk> <7vmzfq8zmr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Qingning Huo <qhuo@mayhq.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 16 12:56:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJr5F-0004DD-Cf
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 12:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWCPLz6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 06:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWCPLz6
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 06:55:58 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:64216 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932094AbWCPLz5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 06:55:57 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 3E5B76BD21; Thu, 16 Mar 2006 12:55:56 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzfq8zmr.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17632>

Junio C Hamano wrote:
> 
> And the second issue is the last point in the "implications"
> list above.  You are right, and I stand corrected.  Our scripts
> should consistently use dash form.
> 
> One thing that bothers me is that we need to keep encouraging
> users to use dashless form from the command line, while we
> update our scripts to use dash form.  What a contradicting and
> confusing situation X-<.
> 

One of the two reasons for rewriting the git wrapper in C was the 
performance penalty that came from having it as a shell-script while it 
was desirable from a porcelainish standpoint to use the dash-less form 
since we thought even then that "git" would always be in PATH while 
"git-foo" was to be moved to the still-imaginary GIT_EXEC_PATH.

The prepending of the GIT_EXEC_PATH to PATH was a laziness workaround 
for scripts that use the dashed form until we'd had time to change 
those, although I see from the commit-message that it's a far cry from 
abundantly clear (reading it now I even think it's clear I meant the 
other way around, although I remember I didn't). Anyways, the relative 
parts are these, from commit 8e49d50388211a0f3e7286f6ee600bf7736f4814

---8<---8<---8<---
     The location of the GIT_EXEC_PATH (name discussion's closed,
     thank gods) can be obtained by running

     	git --exec-path

     which will hopefully give porcelainistas ample time to adapt their
     heavy-duty loops to call the core programs directly and thus save
     the extra fork() / execve() overhead, although that's not really
     necessary any more.

     The --exec-path value is prepended to $PATH, so the git-* programs
     should Just Work without ever requiring any changes to how they call
     other programs in the suite.

     Some timing values for 10000 invocations of git-var >&/dev/null:
     	git.sh: 24.194s
     	git.c:   9.044s
     	git-var: 7.377s

---8<---8<---8<---

 From the timing values there I think the performance issues of using 
the dash-less form can just be ignored. Very rarely will a porcelainish 
wrapper do 10000 invocations of git commands where less than 2 seconds 
will be a large percentage of the overall runtime.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
