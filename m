From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: interaction between cvsimport and cvsexportcommit
Date: Fri, 8 Jun 2007 17:11:57 +0200
Message-ID: <200706081711.57463.robin.rosenberg.lists@dewire.com>
References: <20070608154222.56870830@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: picca <picca@synchrotron-soleil.fr>
X-From: git-owner@vger.kernel.org Fri Jun 08 17:11:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwg84-0000l1-B3
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 17:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936276AbXFHPLU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 11:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938372AbXFHPLU
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 11:11:20 -0400
Received: from [83.140.172.130] ([83.140.172.130]:29946 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S935637AbXFHPLS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 11:11:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 29E848030B2;
	Fri,  8 Jun 2007 17:04:44 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05246-02; Fri,  8 Jun 2007 17:04:43 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id B4DD780264D;
	Fri,  8 Jun 2007 17:04:43 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070608154222.56870830@localhost.localdomain>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49478>

fredag 08 juni 2007 skrev picca:
> Hello
> 
> In the institut where I am working www.synchrotron-soleil.fr, the
> "computing department" use CVS for all their projects. As I am not from
> this department (I am a scientist), I can use my own tools and git is
> one of them.
> Nevertheless I need to interact with them (I am writting a C++
> library to control diffractometers) so I use cvsimport and
> cvsexportcommit.
> 
> The point is that I find this over complicate compare to my git
> day-to-day experience.
> 
> I do not understand why cvsimport and cvsexportcommit do not
> interact nicelly to ease git <-> cvs.

git-cvsexportcommit was written (I assume, since I did not actually write the
original version) to solve a problem and not to be a perfect solution. 

Later I found it didn't do what I needed so I made improvements (to solve /my/ 
problems, mainly in reliability and completeness (binaries, add remove, all 
or nothing). The rest was just inconvenience and I did not consider my 
solution to that universally viable so I didn't include it in in 
cvsexportcommit. 

> For example as a neeby I expect this to work out of the box
> after the first cvsimport
>
> git cvsimport
> do some work
> git commit -a
> git cvsexportcommit

This assume you really want to export all. I don't, but I agree that it should
in principle be this simple. Patches anyone?

> and that's all
> 
> Instead of this we have this:
> 
> $ export GIT_DIR=~/project/.git
> $ cd ~/project_cvs_checkout
> $ git-cvsexportcommit -v <commit-sha1>
> $ cvs commit -F .mgs <files>
> 
> or even worse
> 
> $ export GIT_DIR=~/project/.git
> $ cd ~/project_cvs_checkout
> $ git-cherry cvshead myhead | sed -n 's/^+ //p' | xargs -l1
> git-cvsexportcommit -c -p -v

> 
> what is missing in cvsexportcommit and cvsimport to lower the git <->
> cvs barrier.

Here is my script that I use to export. It takes as arguments a number of 
commits or stgit patches. Note that hardcoded path to the CVS checkout...

Here's an exercise to the reader: Modify git-cvsexportcommit so it takes the 
path to the CVS checkout from 1) a parameter (e.g. -w /checkout) or 2) a git 
config variable. That will get get us a small step closer. It will be fairly 
easy.

Cheers
	-- robin

--------------------------8<-------------------------
#!/bin/bash -ex

if [ "$1" = "-p" ]
then
        P="-p $2"
        shift 2
fi
export GIT_DIR=$(git-rev-parse --git-dir)
GIT_DIR=$(cd $GIT_DIR;pwd)
cd ../Iris.CVSsynconly
for patch in "$@"
do
        if commit=$(git-rev-parse $patch 2>/dev/null); then
            git-cvsexportcommit-u $(echo $P) -c $commit
        else
            head=$(git-symbolic-ref HEAD)
            br=${head#refs/heads/}
            if commit=$(git-rev-parse refs/patches/$br/$patch); then
                git-cvsexportcommit -u $(echo $P) -c $commit
            fi
        fi
done
