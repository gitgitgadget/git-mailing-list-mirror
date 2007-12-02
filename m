From: Steffen Prohaska <prohaska@zib.de>
Subject: Corrupted (?) commit 6e6db85e confusing gitk
Date: Sun, 2 Dec 2007 17:06:07 +0100
Message-ID: <5F1A20CC-7427-4E7A-AB95-E89C9FA17951@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 02 17:05:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyrJq-0006Gd-8Z
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 17:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446AbXLBQFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 11:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752484AbXLBQFA
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 11:05:00 -0500
Received: from mailer.zib.de ([130.73.108.11]:57569 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752422AbXLBQFA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 11:05:00 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lB2G4wcq017449
	for <git@vger.kernel.org>; Sun, 2 Dec 2007 17:04:58 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1a965.pool.einsundeins.de [77.177.169.101])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lB2G4vTd027306
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 2 Dec 2007 17:04:58 +0100 (MET)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66787>

When I run

    gitk 6e6db85ea9423eea755cf5acf7a563c0d9559063

gitk complaints with 'Error: expected integer but got "Hamano"'.

I tracked the problem down to the raw content of the commit object.
The author line is lacking time and timezone information:

     $ git-cat-file -p 6e6db85ea9423eea755cf5acf7a563c0d9559063
     tree 5265f13d094e7c453a06f097add25eaefb843a79
     parent d25430c5f88c7e7b4ce24c1b08e409f4345c4eb9
     author Junio C Hamano <gitster@pobox.com>
     committer Junio C Hamano <gitster@pobox.com> 1196466497 -0800

     Run the specified perl in Documentation/

     Makefile uses $(PERL_PATH) but Documentation/Makefile uses "perl";
     that means the two Makefiles actually use two different
     Perl installations.

     Teach Documentation/Makefile to use PERL_PATH that is exported  
from the
     toplevel Makefile, and give a sane fallback for people who run  
"make"
     from Documentation directory.

     Signed-off-by: Junio C Hamano <gitster@pobox.com>

gitk fails to parse this because it expects the time to be
the second item from the end of a line (look for "set audate"
in function parsecommit of gitk).  For the commit above, gitk
finds "Hamano" instead of the correct time.

I'm pretty convinced that the original commit is reported
correctly.  I verified that with two different versions of git
(1.5.3.7.949.g2221a6 on mac and 1.5.3.6.1889.g98603 on mingw).
Both report the raw commit without time and timezone.

I'd like to conclude with some questions:
  - Is this commit corrupted?
  - How was the commit created?
  - Should "git fsck" detect such corruption?
  - Should gitk more gracefully handle corrupted commits?

I do not have solutions yet.

	Steffen
