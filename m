From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 0/2] A new merge algorithm, take 3
Date: Wed, 7 Sep 2005 18:47:34 +0200
Message-ID: <20050907164734.GA20198@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Sep 07 18:51:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ED35i-0000Yz-3A
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 18:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbVIGQrm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 12:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbVIGQrm
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 12:47:42 -0400
Received: from [85.8.31.11] ([85.8.31.11]:28639 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932177AbVIGQrl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2005 12:47:41 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 4CB324115; Wed,  7 Sep 2005 18:52:18 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1ED35D-0005Ij-00; Wed, 07 Sep 2005 18:47:35 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8169>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Here is the new version of the merge algorithm patch.

The major changes compared to the previous patch are:

* No more messing around with merge-cache. git-ls-files used to get
  the unmerged entries instead.
* The python code is now contained in two files, git-merge-script and
  gitMergeCommon.py.
* The user interface is identical to the interface provided by
  git-resolve-script
* In the non-clean case the unmerged cache entries will not be
  removed from the cache.

I have also attached a test script which can redo every merge in a
repository with both git-resolve-script and git-merge-script. It will
report any non-clean merges and non-identical results for clean
merges. Do _not_ use this script in repositories you care about. It
calls 'git reset --hard' repeatedly and will probably not leave the
repository in its original state when it's done.

Of the 500 merge commits that currently exists in the kernel
repository 19 produces non-clean merges with git-merge-script. The
four merge cases listed in
<20050827014009.GB18880@c165.ib.student.liu.se> are cleanly merged by
git-merge-script. Every merge commit which is cleanly merged by
git-resolve-script is also cleanly merged by git-merge-script,
furthermore the results are identical. There are currently two merges
in the kernel repository which are not cleanly merged by
git-resolve-script but are cleanly merged by git-merge-script.

I guess the need for this has decreased with Daniel's new read-tree
code. Is there any chance of getting this code merged into mainline
git?

- Fredrik

--sdtB3X0nJg68CQEu
Content-Type: text/x-python; charset=us-ascii
Content-Disposition: attachment; filename="testRepo.py"

#!/usr/bin/env python

import sys, math, random, os, re, signal, tempfile, time
from heapq import heappush, heappop
from sets import Set
from gitMergeCommon import *

def mergeMerge(a, b):
    print 'Running merge-script HEAD', b.sha, '...'
    [out, code] = runProgram(['git-merge-script', 'HEAD', b.sha, 'merge message'],
                             returnCode=True, pipeOutput=False)
    if code == 0:
        return True
    else:
        return False
    
def gitResolveMerge(a, b):
    print 'Running git resolve HEAD', b.sha, '...'
    [out, code] = runProgram(['git', 'resolve', 'HEAD', b.sha, 'merge message'],
                             returnCode=True, pipeOutput=False)

    if code == 0:
        return True
    else:
        return False

def doWork(graph, commits):
    print 'commits:', repr(commits)
    result = []
    totalMergeTime = 0
    totalResolveTime = 0
    numCommits = 0
    try:
        for commit in graph.commits:
            if len(commits) > 0 and not (commit.sha in commits):
                continue

            if len(commit.parents) > 1:
                res = commit.sha + ' : '
                if len(commit.parents) == 2:
                    numCommits += 1
                    print '---------------------------------------'
                    print 'Testing commit', commit.sha, '(tree)', commit.tree()
                    a = commit.parents[0]
                    b = commit.parents[1]

                    runProgram(['git-reset-script', '--hard', a.sha])
                    print 'Running git resolve...'
                    stdout.flush()
                    startTime = time.time()
                    resResolve = gitResolveMerge(a, b)
                    timeResolve = time.time() - startTime
                    totalResolveTime += timeResolve
                    
                    if resResolve:
                        resolveHead = Commit(runProgram(['git-rev-parse', '--verify', 'HEAD']).rstrip(), [a, b])

                    runProgram(['git-reset-script', '--hard', a.sha])
                    print 'Running merge...'
                    stdout.flush()
                    startTime = time.time()
                    resMerge = mergeMerge(a, b)
                    timeMerge = time.time() - startTime
                    totalMergeTime += timeMerge
                    
                    if resMerge:
                        mergeHead = Commit(runProgram(['git-rev-parse', '--verify', 'HEAD']).rstrip(), [a, b])

                    res += 'time r: ' + str(int(timeResolve)) + ' m: ' + str(int(timeMerge)) + '\t'
                    if resResolve and resMerge:
                        if resolveHead.tree() == mergeHead.tree():
                            res += 'Identical result'
                        else:
                            res += 'Non-identical results! resolve: ' + resolveHead.sha + \
                                   ' merge: ' + mergeHead.sha
                    else:
                        if resResolve:
                            res += 'resolve succeeded (' + resolveHead.sha + '), '
                        else:
                            res += 'resolve failed, '

                        if resMerge:
                            res += 'merge succeeded (' + mergeHead.sha + ')'
                        else:
                            res += 'merge failed'
                else:
                    res += 'Ignoring octupus merge'

                print res
                result.append(res)
                stdout.flush()
    finally:
        print '\n\n\nResults:'
        for r in result:
            print r
        print 'Avg resolve time:', float(totalResolveTime) / numCommits
        print 'Avg merge time:', float(totalMergeTime) / numCommits

def writeHead(head, sha):
    if sha[-1] != '\n':
        sha += '\n'

    try:
        f = open(os.environ['GIT_DIR'] + '/' + head, 'w')
        f.write(sha)
        f.close()
    except IOError, e:
        print 'Failed to write to', os.environ['GIT_DIR'] + '/' + head + ':', e.strerror
        sys.exit(1)
    return True

stdout = sys.stdout
setupEnvironment()
repoValid()

head = runProgram(['git-rev-parse', '--verify', 'HEAD^0']).rstrip()
print 'Building graph...'
stdout.flush()
graph = buildGraph([head])
print 'Graph building done.'
stdout.flush()
print 'Processing', len(graph.commits), 'commits (' + \
      str(len([x for x in graph.commits if len(x.parents) > 1])) + ' merge commits)...'

originalHead = open('.git/HEAD', 'r').read()
print 'Original head:', originalHead
stdout.flush()

writeHead('original-head', originalHead)

try:
    doWork(graph, sys.argv[1:])
finally:
    writeHead('HEAD', originalHead)

--sdtB3X0nJg68CQEu--
