From: Grzegorz Kulewski <kangur@polcom.net>
Subject: git-cvsimport problem
Date: Tue, 30 May 2006 03:06:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605300236270.25988@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Tue May 30 03:07:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkshE-0007zq-Vf
	for gcvg-git@gmane.org; Tue, 30 May 2006 03:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWE3BGw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 21:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWE3BGw
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 21:06:52 -0400
Received: from alpha.polcom.net ([83.143.162.52]:47037 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S1751302AbWE3BGv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 21:06:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by alpha.polcom.net (Postfix) with ESMTP id C4874648FE
	for <git@vger.kernel.org>; Tue, 30 May 2006 03:06:48 +0200 (CEST)
Received: from alpha.polcom.net ([127.0.0.1])
 by localhost (alpha [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07271-04 for <git@vger.kernel.org>; Tue, 30 May 2006 03:06:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by alpha.polcom.net (Postfix) with ESMTP id 34894217C4
	for <git@vger.kernel.org>; Tue, 30 May 2006 03:06:42 +0200 (CEST)
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: amavisd-new at alpha
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21003>

Hi,

I think I hit some problem in git-cvsimport or maybe cvsps or maybe (but 
unprobable) in network communication.

I am trying to do:

git-cvsimport -d :pserver:cvs@cvs.rulez.pl:/home/cvsroot -C lms -i -k -u 
-m -v lms

and it looks like it hangs in the middle with message:

cvs [rlog aborted]: unexpected '\x0' reading revision number in RCS file 
/home/cvsroot/lms/templates/noaccess.html,v

and to my understanding does not do anything usefull next. Nothing is 
imported (there is only nearly empty .git tree). I have to press CTRL-C to 
stop it.

strace:
[pid 30796] read(3, "---------------------\nM revision"..., 4096) = 2068
[pid 30796] read(3, "M date: 2003/06/20 21:07:56;  au"..., 4096) = 1448
[pid 30796] read(3, ".19\nM date: 2003/05/26 21:05:47;"..., 4096) = 1448
[pid 30796] read(3, " revision 1.15.2.3\nM date: 2003/"..., 4096) = 1276
[pid 30796] write(2, "cvs [rlog aborted]: unexpected \'"..., 117cvs [rlog 
aborted]: unexpected '\x0' reading revision number in RCS file 
/home/cvsroot/lms/templates/noaccess.html,v
) = 117
[pid 30796] read(3,       <-- hangs on that read

ps:
kangur   30791 30556  3 02:55 pts/4    S+     0:00      \_ strace -f 
git-cvsimport -d :pserver:cvs@cvs.rulez.pl:/home/cv
kangur   30792 30791  2 02:55 pts/4    S+     0:00          \_ 
/usr/bin/perl -w /usr/bin/git-cvsimport -d :pserver:cvs@c
kangur   30796 30792 18 02:55 pts/4    S+     0:03              \_ cvsps 
--norc --cvs-direct -u -A --root :pserver:cvs@c

file descriptors:
kangur@beta ~ $ ls -al /proc/30796/fd/
total 5
dr-x------ 2 kangur users  0 May 30 02:55 .
dr-xr-xr-x 3 kangur users  0 May 30 02:55 ..
lrwx------ 1 kangur users 64 May 30 02:57 0 -> /dev/pts/4
l-wx------ 1 kangur users 64 May 30 02:57 1 -> pipe:[429154]
lrwx------ 1 kangur users 64 May 30 02:55 2 -> /dev/pts/4
lrwx------ 1 kangur users 64 May 30 02:57 3 -> socket:[429155]
lrwx------ 1 kangur users 64 May 30 02:57 4 -> socket:[429155]
kangur@beta ~ $ ls -al /proc/30792/fd/
total 6
dr-x------ 2 kangur users  0 May 30 02:55 .
dr-xr-xr-x 3 kangur users  0 May 30 02:55 ..
lrwx------ 1 kangur users 64 May 30 02:57 0 -> /dev/pts/4
lrwx------ 1 kangur users 64 May 30 02:57 1 -> /dev/pts/4
lrwx------ 1 kangur users 64 May 30 02:55 2 -> /dev/pts/4
lr-x------ 1 kangur users 64 May 30 02:57 3 -> /home/kangur/.cvspass
lrwx------ 1 kangur users 64 May 30 02:57 4 -> socket:[429124]
lr-x------ 1 kangur users 64 May 30 02:57 5 -> pipe:[429154]
kangur@beta ~ $ ls -al /proc/30791/fd/
total 3
dr-x------ 2 kangur users  0 May 30 02:55 .
dr-xr-xr-x 3 kangur users  0 May 30 02:55 ..
lrwx------ 1 kangur users 64 May 30 02:58 0 -> /dev/pts/4
lrwx------ 1 kangur users 64 May 30 02:58 1 -> /dev/pts/4
lrwx------ 1 kangur users 64 May 30 02:55 2 -> /dev/pts/4

netstat:
tcp        0      0 beta.polcom.net:50743   netx.waw.pl:cvspserver 
ESTABLISHED
tcp        0      0 beta.polcom.net:50744   netx.waw.pl:cvspserver 
ESTABLISHED

I am using:
git version 1.3.3
cvsps version 2.1


What is going on?


Thanks in advance,

Grzegorz Kulewski
