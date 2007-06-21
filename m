From: Andy Parkins <andyparkins@gmail.com>
Subject: Moving a directory with history from one repository to another while renaming
Date: Thu, 21 Jun 2007 13:37:30 +0100
Message-ID: <200706211337.32978.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 21 14:37:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Luq-00017R-Py
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 14:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbXFUMhg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 08:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754794AbXFUMhg
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 08:37:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:3985 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790AbXFUMhf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 08:37:35 -0400
Received: by ug-out-1314.google.com with SMTP id j3so563234ugf
        for <git@vger.kernel.org>; Thu, 21 Jun 2007 05:37:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Uyd5HKIZ4pxI4PEoRfAWMHDfZBVFJEwFxqNmPN3NYgyqsrzewwd/mU92FJAAw0KU5SIa8ynpaifHTlD0f7MMwZ1ISwhEKGLJKAdbLh9PeGigsLeYvYFRZ0l1fkoiLu9Y0IMP7BWIM49U5hBl9HJ/H3x6qJrN5ySnnpNaG09G7eI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=t4T01cEXVWaUyj096MOSWllNBs0MrcMOEPHrW+UDX3Z4SE/bZxghyYcRaByhbdlIeEfT2sLVvqSaojoyBRT7tI7x3GeYxvB5ezLsWIx2aA8oVZ8vmHX8JMH7GTGwxJMiuhcs66X5gluhahOdvUzmISprF0q02C/AI1JYOwuKCeU=
Received: by 10.67.32.16 with SMTP id k16mr1989479ugj.1182429453686;
        Thu, 21 Jun 2007 05:37:33 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b33sm3586959ika.2007.06.21.05.37.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jun 2007 05:37:32 -0700 (PDT)
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50617>

Hello,

I'm sure this has come up before, and I'm sure the answer is 
git-filter-branch.

I have repositoryA, which has a subdirectory, say "repoA_directory", and I've 
done some development in it.  I now wish I'd done this development in a 
different repository, repositoryB and that it would have been in a different 
directory, "sub/dir/repoB_directory".

What's the best way to do this?

*** Stop press (I tried a bit harder before sending the above email) ***

This is what I did, and am reporting here for future googlers; and in case 
you're all interested in git-filter-branch success stories (which, 
incidentally is a fabulous little tool).

In repositoryA...

 git-filter-branch --subdirectory-filter "repoA_directory" directoryonly

Now, the branch "directoryonly" contains repoA_directory (and history) as a 
new root commit, and as the root directory of the repository.

 git checkout directoryonly
 git-filter-branch --tree-filter "mkdir -p sub/dir/repoB_directory; \
    mv file1 file2 file3 sub/dir/repoB_directory" directorymoved

Now, the branch "directorymoved" contains repoA_directory (and history) alone, 
moved to "sub/dir/repoB_directory".

In repositoryB...

 git-fetch /path/to/repositoryA directorymoved:repoAbranch

repositoryB now contains a new, independently rooted, branch containing only 
sub/dir/repoB_directory.  We would ideally at this point just rebase that 
independent branch to the appropriate point in the main development branch of 
repoB, but we can't because repoAbranch doesn't share a common ancestor with 
any of the repositoryB branches.

That is to say, we have these two branches:

 * --- * --- * --- * --- * (master)

             B --- * --- * (repoAbranch)

but we want:

 * --- * --- * --- * --- * (master)
                          \
                           B --- * --- * (repoAbranch)

Find the commit hash of the first commit in repoAbranch, B, and apply that one 
commit as a patch to your mainline branch (probably making a temporary branch 
on your way, to preserve your current master)

 git checkout -b temp
 git show --pretty=email hash-of-B | git-am

 * --- * --- * --- * --- * (master)
                          \
                           B' (temp)

             B --- * --- * (repoAbranch)

We've now got a commit that will serve as a common ancestor.

 git-rebase --onto temp hash-of-B repoAbranch
 git-branch -D temp

 * --- * --- * --- * --- * (master)
                          \
                           B' --- *' --- *' (repoAbranch)

                           B  --- *  --- *  [orphan branch]

Voila. repoAbranch is now the original repoA_directory, but stored at 
sub/dir/repoB_directory and includes the development history.

git-gc --prune will get rid of the orphan branch if you're bothered about the 
storage.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
