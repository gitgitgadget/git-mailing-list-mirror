From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Git performance on OS X
Date: Sat, 19 Apr 2008 21:28:20 +0200
Message-ID: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 21:29:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnIkN-0005ar-Ep
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 21:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755506AbYDST23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 15:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755446AbYDST23
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 15:28:29 -0400
Received: from smtp-1.orange.nl ([193.252.22.241]:32115 "EHLO smtp-1.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755205AbYDST22 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 15:28:28 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6003.orange.nl (SMTP Server) with ESMTP id 157BD24000A2;
	Sat, 19 Apr 2008 21:28:22 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6003.orange.nl (SMTP Server) with ESMTP id BAE4B2400090;
	Sat, 19 Apr 2008 21:28:20 +0200 (CEST)
X-ME-UUID: 20080419192821765.BAE4B2400090@mwinf6003.orange.nl
X-Mailer: git-send-email 1.5.5.131.g255c6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79918>

Hi Git mailing list,

I have done some tests regarding git's performance on the OS X platform. We
noticed that mercurial is a lot faster than git in the "git status" command,
especially on the webkit repository. This repository has 45k files, so one
would expect it to be slow because of OS X's slow lstat. However, mercurial is
a lot faster (usually 6.2 seconds for git vs ~4 seconds for hg).

For a reference to the statistics below, `git status' in the webkit repo takes
about 6.21 seconds with a std dev of 0.26.

1. 10k empty files

First off, I started with the most simple case: a repository with 10k empty
files in a flat repo.

Git add times

It appears that on large initial imports, git add * is a lot slower than git
add .. This test was performed on a directory with 10000 empty files in it.

Results
=========================================================
Command                               Mean     Std
rm -rf .git && git init && git add .  0.617    0.153
rm -rf .git && git init && git add *  43.383   0.419
rm -rf .hg && hg init && hg add .     0.926    0.027
rm -rf .hg && hg init && hg add *     4.312    0.013
=========================================================

Sampling this, it appears that git add spends a lot of time in fnmatch.
top function calls in 4 second sample:

        fnmatch$UNIX2003  2452
        fnmatch1          310
        strlen            292
        mbrtowc_l         188

probably because git is performing its own glob expansion. This is expensive
on 10,000 supplied files. Of course, this is an uncommon scenario, but still
Mercurial seems to do things differently (I don't know how to sample python,
unfortunately).

Git status on these 10k files takes about 0.111 seconds:

Results
================================================
Command                     Mean     Std
git status                   0.112    0.006
hg status                    0.317    0.005
================================================

This all seems very acceptable. Now we scale up to 50,000 files.

2. 50k empty files

Unfortunately, this was too much for my system to pass as arguments:

  sh: /opt/local/bin/hg: Argument list too long

Therefore, only part of the git adds can be compared

Results
======================================================================
Command                                            Mean     Std    
rm -rf .git .hg && git init && git add .           6.239   0.184
rm -rf .hg .git && hg init && hg add .             11.059  0.342
======================================================================

Git is still faster than Mercurial on adding files.. so far so good. Now the
git / hg status test:

Results
======================================================================
Command                                            Mean     Std    
hg status                                          4.984  0.249
git status                                         3.709  0.150
======================================================================

So, git takes a bit less time than hg in this case. These are mostly system
calls:

    Vienna:perf pieter$ time git status
    # On branch master
    nothing to commit (working directory clean)

    real  0m3.705s
    user  0m0.212s
    sys   0m3.256s
    
So it's not git's fault here that the status is slow.


3. A more complex directory structure.

We now use Webkit's directory and file structure and see what happens. This
test repository has exactly the same files and structure as the webkit repo,
but all files are empty.

Results
======================================================================
Command                                            Mean     Std    
rm -rf .git .hg && git init && git add .           6.014  0.523
rm -rf .git .hg && git init && git add *           6.198  0.228
rm -rf .hg .git && hg init && hg add .             7.707  0.519
rm -rf .hg .git && hg init && hg add *             7.632  0.405
======================================================================

Funnily enough, Mercurial is faster with this structure than with the
one-directory structure. Git shows linear scaling. Also, with a real
structure, the * vs . problem in git goes away.

Now we can look at the "git status" commands and compare them to the actual
status' of the actual webkit repository.

Results
======================================================================
Command                                            Mean     Std    
git status                                         4.573  0.514
git status .                                       13.515  0.448
hg status                                          4.411  1.594
hg status .                                        4.903  0.171
======================================================================

There's no significant difference between the git and hg status things.
Remember that in the webkit repo, "git status" takes about 6.2 seconds, which
is a lot slower than we see here.

Therefore, it is interesting to look at what happens if we import the whole
webkit branch.

4. A new webkit repository

This test was done by creating a new clone of the webkit repository.
Basically, I did a git archive | tar x and did a git add on that.

This is where some interesting stuff happens. I haven't done the git add
thing, as that should be clear by now and takes a lot of time. The status
command, however:

Results
======================================================================
Command                                            Mean     Std    
git status                                         4.428   0.486
git status .                                       13.508  1.451
hg status                                          4.285   1.681
hg status .                                        4.930   0.165
======================================================================

Again, git shows similar performance to mercurial. Furthermore, the status
time hasn't changed since last time. Apparently, the increased file size and
increased number of objects didn't matter. So, why is there such a big
difference between the real webkit repository and this fresh one?

5. A repacked shallow webkit repo

One thing that could be it is that the webkit repo is heavily packed. To test
this, I created a new clone and repacked this one and (21 minutes later):

Results
======================================================================
Command                                            Mean     Std    
(Pre-GC): git status                               4.470   0.423
(Pre-GC): git status .                             13.355  1.025
(Post-GC): git status                              4.910   0.324
(Post-GC): git status .                            11.265  0.222
======================================================================

When run with 10 tests in the pre and post case, there is a significant
difference according to a t-test (df=18, p << 0.01). Therefore, I compared the
real, user and system times pre and post of git status. I also included the
real webkit again, and also a shallow clone of that repository.

          Pre-GC       Post-GC      (shallow)   (real webkit) 
real     4.36 (0.06)   4.61 (0.06)  5.72 (0.25)  6.21 (0.28)  
user     0.39 (0.01)   0.37 (0.00)  0.36 (0.00)  0.39 (0.00)  
sys      3.28 (0.04)   2.86 (0.03)  3.21 (0.09)  2.90 (0.01)  

The system time seems to jump up and down sometimes, but the real times
definitely keep getting higher. This isn't due to system or user time. Where
does this extra time come from?

I hope anyone can explain this. I tried profiling the commands, but `sample'
often doesn't want to show symbols (sometimes it does, though) and gprof
doesn't show most functions. My profiling skills aren't that high, so if
anyone has suggestions, I'll be glad to help.

- Pieter
