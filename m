From: Scott Lamb <slamb@slamb.org>
Subject: git-p4import.py robustness changes
Date: Thu, 31 May 2007 09:47:51 -0700
Message-ID: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 31 19:14:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtoDw-0001O5-BL
	for gcvg-git@gmane.org; Thu, 31 May 2007 19:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754990AbXEaROE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 13:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755595AbXEaROE
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 13:14:04 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:59411 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754990AbXEaROD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 13:14:03 -0400
X-Greylist: delayed 1566 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 May 2007 13:14:03 EDT
Received: from [172.16.1.4] (ppp-71-139-194-102.dsl.snfc21.pacbell.net [71.139.194.102])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by hobbes.slamb.org (Postfix) with ESMTP id 6C21498038
	for <git@vger.kernel.org>; Thu, 31 May 2007 09:47:53 -0700 (PDT)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48814>

I'm trying out git-p4import.py (and git itself) for the first time.  
I'm frustrated with its error behavior. For example, it's saying this:

     $ git-p4import.py //my/path/... master
     Setting perforce to  //my/path/...
     Already up to date...

when it should be saying this:

     $ git-p4import.py //my/path/... master
     Setting perforce to  //my/path/...
     git-p4import fatal error: p4 changes //my/path/...@1,#head:  
Request too large (over 150000); see 'p4 help maxresults'.

There's a logfile option, but that's a poor excuse for no error  
handling. I'd like to fix it. A couple questions, though:


First, is it acceptable to switch from os.popen to the subprocess  
module? I ask because the latter was only introduced with Python 2.4  
on. The subprocess module does work with earlier versions of Python  
(definitely 2.3) and is GPL-compatible, so maybe it could be thrown  
into the distribution if desired.

I could make do with popen2.Popen3, but subprocess is actually  
pleasant to use:

         git = subprocess.Popen(cmdlist,
                                stdin=subprocess.PIPE,
                                stdout=subprocess.PIPE,
                                stderr=subprocess.PIPE)
         stdout, stderr = git.communicate(stdin)
         if git.wait() != 0:
             raise GitException("'git %s' failed: %s" % (cmd, stderr))

vs. the popen2 way, which is longer and uglier. It'd probably involve  
tempfiles rather than reimplementing subprocess.Popen.communicate().


Second, this crowd seems to want sequences of tiny patches. How does  
this sound?

* patch 1 - use subprocess to make git_command.git() and p4_command.p4 
() throw properly-typed exceptions on error, fix caller exception  
handling to match.

* patch 2 - remove the use of the shell and pipelines (fix some  
escaping problems).

* patch 3 - use lists instead of space separation for the commandline  
arguments (fix more escaping problems).

* patch 4 - allow grabbing partial history (make my error go away).


Cheers,
Scott

-- 
Scott Lamb <http://www.slamb.org/>
