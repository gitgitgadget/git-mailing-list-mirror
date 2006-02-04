From: Paul Mackerras <paulus@samba.org>
Subject: git-diff-tree --cc on the dodecapus
Date: Sat, 4 Feb 2006 22:45:35 +1100
Message-ID: <17380.37855.117313.631961@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Feb 04 12:45:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5LrO-0004rl-JX
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 12:45:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWBDLpm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 06:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWBDLpm
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 06:45:42 -0500
Received: from ozlabs.org ([203.10.76.45]:38118 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932379AbWBDLpl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2006 06:45:41 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 1A80768A5B; Sat,  4 Feb 2006 22:45:40 +1100 (EST)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15587>

Junio,

When I use git diff-tree --cc on Len's dodecapus merge (9fdb62af), the
first diff hunk that it shows is this:

@@@@@@@@@@@@@ -712,17 -711,9 -703,9 -703,9 -703,9 -708,9 -703,9 -703,9 -711,9 -703,9 -711,9 -711,9 +717,17 @@@@@@@@@@@@@
            	load_ramdisk=	[RAM] List of ramdisks to load from floppy
            			See Documentation/ramdisk.txt.
            
 -----------	lockd.udpport=	[NFS]
 +++++++++++	lockd.nlm_grace_period=P  [NFS] Assign grace period.
 +++++++++++			Format: <integer>
 +++++++++++
 +++++++++++	lockd.nlm_tcpport=N	[NFS] Assign TCP port.
 +++++++++++			Format: <integer>
 ++++ ++++++
     -      	lockd.tcpport=	[NFS]
 +++++++++++	lockd.nlm_timeout=T	[NFS] Assign timeout value.
 +++++++++++			Format: <integer>
     +      
 ---- ------	lockd.tcpport=	[NFS]
 +++++++++++	lockd.nlm_udpport=M	[NFS] Assign UDP port.
 +++++++++++			Format: <integer>
            
            	logibm.irq=	[HW,MOUSE] Logitech Bus Mouse Driver
            			Format: <irq>

For some reason, the 6th parent's lines are getting matched
differently from the other parents.  Parents 2-12 are actually all the
same in this file AFAICS.  All that has happened is that a sequence of
three lines: "lockd.udpport=  [NFS]", a blank line, "lockd.tcpport=
[NFS]", have been replaced by 11 lines.  For parent 6, the blank line
has been matched with the 6th line of the new stuff, whereas for
parents 2..5 and 7..12 the blank line has been matched with line 9 of
the new stuff.  This makes it look like the change from parent 6 is
different when it isn't really, and thus the diff looks interesting
when it shouldn't.

In general, I have found in doing N-way diff displays (both in dirdiff
and in gitk), that one needs to be a bit clever about working out
which lines correspond in the N versions.  If you do a series of 2-way
diffs and just believe what diff tells you about which lines
correspond, you will end up with things being shown as different when
they aren't.  Where there is ambiguity, some of the 2-way diffs will
resolve it one way and some another, and as a result, something which
is in fact common to all the files can end up being shown as a
difference.

What I do in dirdiff is to do a number of 2-way diffs, but just use
the result as an indication of which parts of the files have some
difference.  I then find the matches between all the files in Tcl code
and work out which lines are common and which lines are unique.  I
have found it necessary to apply a rule that says that a match across
a larger number of files is preferable to a match across a smaller
number, even if it is a longer match.  For a set of lines, I
iteratively pull out the best match (most number of files, then most
number of lines).  What's left at the end is the lines that are unique
to one file.  This ends up being a bit complicated, but it seems to be
necessary for producing a reasonable result.  I can go into more
detail on the algorithm I use if you want.

Paul.
