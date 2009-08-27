From: "Matthias Andree" <matthias.andree@uni-paderborn.de>
Subject: git-svn intermittent issues with absent_file
Date: Thu, 27 Aug 2009 16:56:25 +0200
Organization: =?iso-8859-15?Q?Universit=E4t_Paderborn=3B_EIM-I?=
Message-ID: <op.uzbs4bsq3myrm3@balu.cs.uni-paderborn.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: "Eric Wong" <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 16:58:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MggQO-0004Kf-Ba
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 16:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbZH0O43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 10:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbZH0O43
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 10:56:29 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:51919 "EHLO
	mail.uni-paderborn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbZH0O42 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 10:56:28 -0400
Received: from balu.cs.uni-paderborn.de ([131.234.21.37])
	by mail.uni-paderborn.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63 spheron)
	id 1MggOp-0007xP-HO; Thu, 27 Aug 2009 16:56:28 +0200
Received: from localhost ([127.0.0.1] helo=balu.cs.uni-paderborn.de)
	by balu.cs.uni-paderborn.de with esmtp (Exim 4.69)
	(envelope-from <matthias.andree@uni-paderborn.de>)
	id KP1IU1-0003Y0-KJ; Thu, 27 Aug 2009 16:56:25 +0200
User-Agent: Opera Mail/9.64 (Win32)
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 5.5.7.378829, Antispam-Engine: 2.7.2.376379, Antispam-Data: 2009.8.27.144528
X-IMT-Authenticated-Sender: uid=mandree,ou=People,o=upb,c=de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127161>

Greetings,

we seem to have issues with checking out files from an SVN server via  
https://. The problem is hard to reproduce, and shows as "absent_file"  
warnings, i. e. files that are in the SVN checkout don't make it to the  
Git checkin.

Perhaps this rings a bell with someone or there are similar reports that  
relate to our issues...


## ISSUE ## Once in a while, a git-svn clone or rebase fails with files  
missing from commits, as mentioned above. We haven't been able to figure  
out under what circumstances this happens. If we try to reproduce this (i.  
e. kill the directory completely and re-run the git svn clone), another  
revision (for instance 170) might show this, or the clone may succeed.
   This was observed with Git 1.6.0.4 under Ubuntu Linux Jaunty Jackalope  
(9.04) and on a different computer with Git 1.6.4.1.196.g31f0b (from the  
master branch) under a fully updated Cygwin 1.5.


Example log of failed data (sorry, we are not allowed to let you access  
the repository, so we must debug by proxy).
I'm replacing substrings in the log below to maintain corporate  
confidentiality levels:

$ git svn clone --no-checkout https://svnserver.example.edu/project/
Initialized empty Git repository in /tmp/compnet/.git/
W: +empty_dir: branches
W: +empty_dir: tags
W: +empty_dir: trunk
r1 = a1b0e99e3986da4d8d461944b623b6abb2460de4 (refs/remotes/git-svn)
...
r135 = 294077e62ee5f463b8ab97d961d9742ef89ae662 (refs/remotes/git-svn)
         A       ... (~100 PDF files)
       ...
         A       d1/u1/2009_06/f1.pdf
W: +empty_dir: d1/u2/slides/2009_06
W: absent_file: d1/u1/2009_06/d1/u1/2009_06/f2.pdf Insufficient  
permissions?
W: absent_file: d1/u3/06_2009/f1/u3/2009_06/f3.pdf Insufficient  
permissions?
W: absent_file: d1/u2/slides/2009_06/d1/u2/slides/2009_06/f4.pdf  
Insufficient permissions?
r136 = 58523cf1fa867d33a74080dabdcbc85ae0ba99ec (refs/remotes/git-svn)
...
r139 = 2fb1647bc40d3815a5eefb32d43a375e03d2e871 (refs/remotes/git-svn)
Incomplete data: Delta source ended unexpectedly at  
/usr/local/libexec/git-core/git-svn line 4605


Just re-running "git svn fetch" reproduces the "Incomplete data:" error  
and aborts, but re-fetching an older version succeeds. No fiddling with  
permissions needed.


## WORKAROUND ##

If this happens, I can force a checkout with, say, "git checkout -t -b  
master remotes/git-svn", revert to the last good revision with "git svn  
reset -r135" (this doesn't work without prior checkout) and then re-run  
git svn fetch, which will usually succeed then.


The three absent_file lines are also recorded in  
.git/svn/refs/remotes/git-svn/unhandled.log for r136.


Questions:

1. What causes these absent_file issues? How can we assist with debugging  
this?

2. What does "Delta source ended unexpectedly" mean? (the line number is  
bogus, it's just the finish_report call)

3. Is this or a similar issue known? Is this an issue with the SVN server,  
the SVN bindings, or the git svn adaptor?

4. How can we avoid or fix this?

We're happy to test patches.


Thanks a lot in advance.

Cheers,

-- 
Matthias Andree
