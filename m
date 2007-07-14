From: Mark Levedahl <mdl123@verizon.net>
Subject: bug in gitk on cygwin, v1.5.3-rc1
Date: Sat, 14 Jul 2007 15:02:05 -0400
Message-ID: <46991DAD.9020005@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 14 21:02:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9mtJ-0006NE-TA
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 21:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760453AbXGNTCV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 15:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763374AbXGNTCU
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 15:02:20 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:64749 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763337AbXGNTCL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 15:02:11 -0400
Received: from [192.168.100.117] ([72.66.124.87])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JL6007IWNJIFOXD@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 14 Jul 2007 14:02:06 -0500 (CDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52496>

Paul,

The previous bug I reported of gitk giving an error on Cygwin, and that 
you addressed in 8c93917d23ec7ef998154a, now manifests itself 
differently in that all commits are not shown. For instance, "gitk 
v1.5.3-rc1" results in a display where the last shown commit is  9e026d3 
(dated 205-09-26), the tag v0.99.8g is the penultimate shown, both are 
shown with white circles at the tip of their respective commit lines. 
12-15 previous commits are shown in the same way. The correct display of 
course begins with commit e83c51 on 2005-040-7.

I have built a new tcl/tk package, using 8.4.15 sources, using POSIX + 
X-Windows under Cygwin, and using this tcl/tk package I get identical 
(assumed correct) results as I do on my fedora FC7 box. (Such a package 
cannot be introduced into Cygwin as the Tcl/Tk package there is the one 
that supports the insight debugger, and the Tcl/Tk sources are 
integrated into the insight debugger source tree).

Further investigation has shown that:

1) The contents read in getcommitlines is identical (I logged from both 
versions and compared the results).
2) The Posix-X windows version (and on Linux) in general reads 50,000 
bytes at a time from the pipe, as would be expected from the line "    
set stuff [read $fd 500000]"
3) The normal Cygwin TCL version reads 3000 - 5000 bytes at a time, not 
50,000.
4) gitk, prior to commit 8c93917, would throw an error when trying to 
layout the row that now shows up as the last commit.

So, my suspicion is that the layout code gets ahead of the read loop, 
requiring data for a commit not yet read in, and prematurely terminates 
the graph rather than waiting for more data to be read in before 
attempting to continue the layout. Just a guess as I do not really 
understand the pseudo-threading you have written.

Mark Levedahl
