From: "Rhodes, Kate" <masukomi@gmail.com>
Subject: [Bug?] uncommited changes cross branches
Date: Tue, 5 Feb 2008 09:45:30 -0500
Message-ID: <CB070331-8CA6-42CD-9CAD-20371F16DCD8@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 15:52:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMP9r-0003xd-4E
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 15:52:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbYBEOvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 09:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbYBEOvt
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 09:51:49 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:17479 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbYBEOvs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 09:51:48 -0500
Received: by ug-out-1314.google.com with SMTP id z38so179613ugc.16
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 06:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        bh=77PbeA0mfH8zOTUkt+ZwWaCWgpOY+joYst9u33f7Fro=;
        b=rF4Bxil+ThAK+egEfhwxOP6la4twxDjhiUdYDmVJxBMuCC9ESRrk5t08tQ4G+q4/flB4XTgoM4CWH7KRUudL7zRISmOxn+ArG5Woo+OpEScGUAGngvWKEK0/XnllOKaxt0CRsuSa7AYk5NvL3vY3zJLjf6kxU2p/ettBTVJ1370=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        b=t7DOqMQN96FVnCJi7hAt7U9IHvlk0V/fCe8yXkCjF2A3ZG3VSQnefBSrLRnWyxyOSWa1LkDKIyU/0Z8aq1Pc6vdLG1Tva26Ewj5E6ztiHcwZvWBHpanwNwPEHFr24OBsCT94wMkQcp86vJVgey3nFdA9+9ep+Js7EU/mn4w0Alo=
Received: by 10.78.182.17 with SMTP id e17mr14904080huf.67.1202222739704;
        Tue, 05 Feb 2008 06:45:39 -0800 (PST)
Received: from ?172.30.1.160? ( [80.67.64.10])
        by mx.google.com with ESMTPS id 23sm5037868hud.3.2008.02.05.06.45.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Feb 2008 06:45:38 -0800 (PST)
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72662>

If you have a file that exists in two branches in the same repo, make  
a change to it without committing, then switch branches the changes  
carry over, but if you make changes to a file that exists in only one  
of the repos and try and switch branches Git complains that the file  
isn't uptodate.  The latter behavior seems correct to me.

Changes I make in any branch should not just follow me around as I  
switch through other branches. It seems not only conceptually broken  
to me, but also something that make it very easy to accidentally  
commit changes to an unintended branch if you weren't paying close  
attention when you switched. I think that the appropriate action is to  
not allow a user to switch branches whenever there are files that  
aren't up to date (committing, git-stash, and checkout -m  being the  
obvious, and safe, ways around the blockage).

The documentation *seems* to agree with me and it looks like it was  
the intent of the code to prevent this too, but it obviously doesn't.


In case my description was a little confusing below is a real world  
example of what I'm talking about. The last command is what I believe  
should not be possible:

$ temp krhodes$ mkdir foo
$ temp krhodes$ cd foo/
$ foo krhodes$ git --version
git version 1.5.4.2.g41ac4
$ foo krhodes$ git init
Initialized empty Git repository in .git/
$ foo krhodes$ echo "foo" > foo.txt
$ foo krhodes$ git add foo.txt
$ foo krhodes$ git commit -a -m " initial commit"
Created initial commit 10d7a21:  initial commit
  1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 foo.txt
$ foo krhodes$ git checkout -b branch_one
Switched to a new branch "branch_one"
$ foo krhodes$ echo "bar" > bar.txt
$ foo krhodes$ git add bar.txt
$ foo krhodes$ git commit -a -m "initial branch_one_commit"
Created commit 3251c16: initial branch_one_commit
  1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 bar.txt
$ foo krhodes$ echo "baz" > bar.txt
$ foo krhodes$ git checkout master
fatal: Entry 'bar.txt' not uptodate. Cannot merge.
$ foo krhodes$ git checkout bar.txt
$ foo krhodes$ git checkout master
Switched to branch "master"
$ foo krhodes$ echo "baz" > foo.txt
$ foo krhodes$ git checkout branch_one
M	foo.txt
Switched to branch "branch_one"

-------
-masukomi
