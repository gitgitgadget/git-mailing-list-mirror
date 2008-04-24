From: Geert Bosch <bosch@adacore.com>
Subject: Excruciatingly slow git-svn imports
Date: Thu, 24 Apr 2008 14:54:04 -0400
Message-ID: <CC0F600D-71F3-493A-AA9C-AF901C1A58C4@adacore.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 24 21:19:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jp6yl-0008RE-OF
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 21:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759799AbYDXTSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 15:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759714AbYDXTSs
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 15:18:48 -0400
Received: from rock.gnat.com ([205.232.38.15]:54324 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759699AbYDXTSr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 15:18:47 -0400
X-Greylist: delayed 1482 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Apr 2008 15:18:47 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 13DF92A9F66
	for <git@vger.kernel.org>; Thu, 24 Apr 2008 14:54:05 -0400 (EDT)
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id w1fo881yaK54 for <git@vger.kernel.org>;
	Thu, 24 Apr 2008 14:54:04 -0400 (EDT)
Received: from potomac.gnat.com (potomac.gnat.com [205.232.38.124])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTP id E89972A9F65
	for <git@vger.kernel.org>; Thu, 24 Apr 2008 14:54:04 -0400 (EDT)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80313>

I'm trying to import a 9.7G, 130K revision svn repository
but it seems to only import about 6K revisions per day on fast hardware
using a recent git (1.5.5).

This means about 20 days, or more if things slow down as the repo gets  
bigger
Are there any tips/tricks on how to most efficiently convert large  
repos?
I'm using ssh+svn protocol for accessing the repository, but slowness
seems due to local inefficiency. An strace -fcp <pid> during a minute  
gives
the following results:

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
  52.46   21.392640       17607      1215           clone
  47.47   19.358882        3983      4860      3645 execve
   0.05    0.019571          16      1216           wait4
   0.01    0.003944           0     14582      1215 open
   0.01    0.002458           0     14580     12150 access
   0.00    0.000797           0      8500           write
   0.00    0.000694           0     26013           read
   0.00    0.000574           0      3693           munmap
   0.00    0.000513           0     20659           close
   0.00    0.000452           0     21918           mmap
   0.00    0.000353           0      1215           stat
   0.00    0.000234           0     12158      1215 lseek
   0.00    0.000155           0     17013           fstat
   0.00    0.000077           0      6075           mprotect
   0.00    0.000076           0      8511           rt_sigaction
   0.00    0.000074           0      6078      6078 ioctl
   0.00    0.000049           0      2432           unlink
   0.00    0.000033           0      2430           dup2
   0.00    0.000033           0      7293           fcntl
   0.00    0.000022           0      3681           brk
   0.00    0.000022           0      1215           getppid
   0.00    0.000019           0      1215           uname
   0.00    0.000019           0      1215           arch_prctl
   0.00    0.000000           0      1215           lstat
   0.00    0.000000           0      1216           pipe
   0.00    0.000000           0        22           mremap
   0.00    0.000000           0      2431           dup
   0.00    0.000000           0      1215           getcwd
   0.00    0.000000           0      2430           getdents64
------ ----------- ----------- --------- --------- ----------------
100.00   40.781691                196296     24303 total

So, 99.93% of the time seems to be in clone/execve
(including actual work done by the forked programs)

In another trace, I found the following execve calls were made:
      22 execve("/homes/bosch/x86_64-linux/bin/git",
       2 execve("/homes/bosch/x86_64-linux/bin/git-commit-tree",
    2842 execve("/homes/bosch/x86_64-linux/bin/git-hash-object",
      22 execve("/opt/gnu/bin/git",
       2 execve("/opt/gnu/bin/git-commit-tree",
    2842 execve("/opt/gnu/bin/git-hash-object",
      22 execve("/opt/local/bin/git",
       2 execve("/opt/local/bin/git-commit-tree",
    2842 execve("/opt/local/bin/git-hash-object",
      22 execve("/opt/local/sbin/git",
       2 execve("/opt/local/sbin/git-commit-tree",
    2842 execve("/opt/local/sbin/git-hash-object",

I don't have git installed in either of /opt/gnu/bin, /opt/local/bin  
or /opt/local/sbin.
These three directories just happen to be before the one containing  
git in my path:

bosch:~/git$ echo $PATH
/opt/gnu/bin:/opt/local/bin:/opt/local/sbin:/homes/bosch/x86_64-linux/ 
bin ...

Before trying to brush up my Perl and propose patching fixes for this
(I doubt the extra execve's take much time at all), I was wondering why
we don't open a single stream to git-fast-import and have it do
the heavy lifting. Are there fundamental issues with this?

   -Geert
