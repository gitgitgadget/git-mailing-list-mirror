From: Daniele Segato <daniele.segato@gmail.com>
Subject: Git shouldn't allow to push a new branch called HEAD
Date: Fri, 14 Oct 2011 13:31:17 +0200
Message-ID: <1318591877.2938.20.camel@mastroc3.mobc3.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 14 13:30:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REfxh-0006ET-27
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 13:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387Ab1JNL34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 07:29:56 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:43144 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab1JNL3z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 07:29:55 -0400
Received: by wwn22 with SMTP id 22so631999wwn.1
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 04:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:subject:from:to:date:content-type:x-mailer
         :content-transfer-encoding:mime-version;
        bh=H6qq609BPnAAyJnZn0SolfTPRIPKU7o9B7K0GcWDfRE=;
        b=ZR5xYqcYYBQIeb1KfKdtU8u6r5eBhryezlrRMq4Ip6JfbMi2kkJ2yBPP/gB92A9rB9
         Rzi1pMZ8DjC9BmLi7CYd7eOsyso3G7MY68ps1zduHiqpVa2j5h5d57NxcTUVVBXkKY7u
         gG/T5dTeGgIBtmoqy/UMJkkPG4mH5ZXgZ5lNQ=
Received: by 10.227.129.77 with SMTP id n13mr2771579wbs.37.1318591794316;
        Fri, 14 Oct 2011 04:29:54 -0700 (PDT)
Received: from [192.168.1.69] (host182-72-dynamic.4-87-r.retail.telecomitalia.it. [87.4.72.182])
        by mx.google.com with ESMTPS id es10sm13670965wbb.4.2011.10.14.04.29.51
        (version=SSLv3 cipher=OTHER);
        Fri, 14 Oct 2011 04:29:53 -0700 (PDT)
X-Mailer: Evolution 3.0.3-2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183563>

Hi all,


following from a discussion in IRC freenode #git between me, sitaram an
shruggar


step to reproduce:

$ mkdir /tmp/gitbug
$ cd /tmp/gitbug/

$ # create a fake remote repo
$ git init --bare remote.git

$ # clone it with the user that will generate the bug
$ git clone remote.git buggenerator
$ cd buggenerator/
$ touch whatever
$ git add .
$ git commit -m "first commit"
$ git push origin master 

$ # now clone the same repo the other guy is the "victim" of this issue
$ cd ..
$ git clone remote.git victim

$ # time to create the remote HEAD branch
$ cd buggenerator/
$ git push origin HEAD:HEAD

$ # the remote refs has been created!
$ git ls-remote

$ # another commit
$ echo 'any change' >> whatever 
$ git commit -a -m "some change"
$ git push origin master 

$ # the refs/heads/HEAD is still where it was
$ git ls-remote

$ # now from the victim perspective
$ cd ../victim/

$ # every time executing a fetch he will get a force update
$ # or maybe even an error, seen it my real repo, don't know how
$ # to reproduce
$ git fetch 
$ git fetch 
$ git ls-remote
$ git fetch 
$ git ls-remote
$ git branch -a



full console log:

mastro@mastroc3 ~  $ mkdir /tmp/gitbug
mastro@mastroc3 ~  $ cd /tmp/gitbug/
mastro@mastroc3 /tmp/gitbug  $ git init --bare remote.git
Initialized empty Git repository in /tmp/gitbug/remote.git/
mastro@mastroc3 /tmp/gitbug  $ git clone remote.git buggenerator
Cloning into buggenerator...
done.
warning: You appear to have cloned an empty repository.
mastro@mastroc3 /tmp/gitbug  $ cd buggenerator/
mastro@mastroc3 /tmp/gitbug/buggenerator (master #) $ touch whatever
mastro@mastroc3 /tmp/gitbug/buggenerator (master #) $ git add .
mastro@mastroc3 /tmp/gitbug/buggenerator (master #) $ git commit -m
"first commit"
[master (root-commit) 11d0a12] first commit
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 whatever
mastro@mastroc3 /tmp/gitbug/buggenerator (master) $ git push origin
master 
Counting objects: 3, done.
Writing objects: 100% (3/3), 213 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
To /tmp/gitbug/remote.git
 * [new branch]      master -> master
mastro@mastroc3 /tmp/gitbug/buggenerator (master) $ cd ..
mastro@mastroc3 /tmp/gitbug  $ git clone remote.git victim
Cloning into victim...
done.
mastro@mastroc3 /tmp/gitbug  $ cd buggenerator/

# now creating the HEAD remote branch

mastro@mastroc3 /tmp/gitbug/buggenerator (master) $ git push origin
HEAD:HEAD
Total 0 (delta 0), reused 0 (delta 0)
To /tmp/gitbug/remote.git
 * [new branch]      HEAD -> HEAD
mastro@mastroc3 /tmp/gitbug/buggenerator (master) $ git ls-remote
From /tmp/gitbug/remote.git
11d0a122125e50e78c7aa4aa81a3d6090dba648e	HEAD
11d0a122125e50e78c7aa4aa81a3d6090dba648e	refs/heads/HEAD <-----
shouldn't be there!
11d0a122125e50e78c7aa4aa81a3d6090dba648e	refs/heads/master
mastro@mastroc3 /tmp/gitbug/buggenerator (master) $ echo 'any change' >>
whatever 
mastro@mastroc3 /tmp/gitbug/buggenerator (master *) $ git commit -a -m
"some change"
[master 77852ef] some change
 1 files changed, 1 insertions(+), 0 deletions(-)
mastro@mastroc3 /tmp/gitbug/buggenerator (master) $ git push origin
master 
Counting objects: 5, done.
Writing objects: 100% (3/3), 253 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
To /tmp/gitbug/remote.git
   11d0a12..77852ef  master -> master
mastro@mastroc3 /tmp/gitbug/buggenerator (master) $ git ls-remote
From /tmp/gitbug/remote.git
77852effa972187d60d4c75145198991f1c0f868	HEAD
11d0a122125e50e78c7aa4aa81a3d6090dba648e	refs/heads/HEAD
77852effa972187d60d4c75145198991f1c0f868	refs/heads/master
mastro@mastroc3 /tmp/gitbug/buggenerator (master) $ cd ../victim/
mastro@mastroc3 /tmp/gitbug/victim (master) $ git fetch 
remote: Counting objects: 5, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
From /tmp/gitbug/remote
   11d0a12..77852ef  master     -> origin/master
mastro@mastroc3 /tmp/gitbug/victim (master) $ git fetch 
From /tmp/gitbug/remote
 + 77852ef...11d0a12 HEAD       -> origin/HEAD  (forced update)
mastro@mastroc3 /tmp/gitbug/victim (master) $ git fetch 
From /tmp/gitbug/remote
   11d0a12..77852ef  master     -> origin/master
mastro@mastroc3 /tmp/gitbug/victim (master) $ git ls-remote
From /tmp/gitbug/remote.git
77852effa972187d60d4c75145198991f1c0f868	HEAD
11d0a122125e50e78c7aa4aa81a3d6090dba648e	refs/heads/HEAD
77852effa972187d60d4c75145198991f1c0f868	refs/heads/master
mastro@mastroc3 /tmp/gitbug/victim (master) $ git fetch 
From /tmp/gitbug/remote
 + 77852ef...11d0a12 HEAD       -> origin/HEAD  (forced update)
mastro@mastroc3 /tmp/gitbug/victim (master) $ git ls-remote
From /tmp/gitbug/remote.git
77852effa972187d60d4c75145198991f1c0f868	HEAD
11d0a122125e50e78c7aa4aa81a3d6090dba648e	refs/heads/HEAD
77852effa972187d60d4c75145198991f1c0f868	refs/heads/master
mastro@mastroc3 /tmp/gitbug/victim (master) $ git branch -a
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/master




this can be fixed with:

git push --delete origin HEAD
(or git push origin :HEAD)

then
git remote prune origin



But I think that git shouldn't allow the remote HEAD reference to be
created in the first place

regards,
Daniele
