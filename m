From: Josef Wolf <jw@raven.inka.de>
Subject: Re-Transmission of blobs?
Date: Tue, 10 Sep 2013 15:08:38 +0200
Message-ID: <20130910130837.GA14259@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 10 15:32:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJO3g-0005zO-01
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 15:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831Ab3IJNcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 09:32:39 -0400
Received: from quechua.inka.de ([193.197.184.2]:47925 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401Ab3IJNci (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 09:32:38 -0400
X-Greylist: delayed 1337 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Sep 2013 09:32:37 EDT
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1VJNhz-0000CQ-FV; Tue, 10 Sep 2013 15:10:19 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 37C8B76184; Tue, 10 Sep 2013 15:08:38 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234435>

Hello,

as we all know, files are identified by their SHA. Thus I had the impression
that when transfering files, git would know by the SHA whether a given file is
already available in the destination repository and the transfer would be of
no use. But this don't seem to be tha case. Lets see this example:

  $ cat t.sh
  #! /bin/sh -ex
  
  LANG=
  
  rm -rf 1 2
  git init 1
  git clone 1 2
  
  cd 1
  git commit --allow-empty -m "initial structure"
  git co -b somebranch
  dd if=/dev/urandom count=10 bs=1024k >t
  git add t
  git commit -m "blah"
  
  cd ../2
  git pull
  git cherry-pick origin/somebranch
  git push -v
  
  $ ./t.sh
  + LANG=
  + rm -rf 1 2
  + git init 1
  Initialized empty Git repository in /home/jw/test/1/.git/
  + git clone 1 2
  Cloning into '2'...
  warning: You appear to have cloned an empty repository.
  done.
  + cd 1
  + git commit --allow-empty -m 'initial structure'
  [master (root-commit) 97e52e2] initial structure
  + git co -b somebranch
  Switched to a new branch 'somebranch'
  + dd if=/dev/urandom count=10 bs=1024k
  10+0 records in
  10+0 records out
  10485760 bytes (10 MB) copied, 1.3202 s, 7.9 MB/s
  + git add t
  + git commit -m blah
  [somebranch b11cf51] blah
   1 file changed, 0 insertions(+), 0 deletions(-)
   create mode 100644 t
  + cd ../2
  + git pull
  remote: Counting objects: 5, done.
  remote: Compressing objects: 100% (3/3), done.
  remote: Total 5 (delta 0), reused 0 (delta 0)
  Unpacking objects: 100% (5/5), done.
  From /home/jw/test/1
   * [new branch]      master     -> origin/master
   * [new branch]      somebranch -> origin/somebranch
  + git cherry-pick origin/somebranch
  [master 9e8f1c6] blah
   1 file changed, 0 insertions(+), 0 deletions(-)
   create mode 100644 t
  + git push -v
  warning: push.default is unset; its implicit value is changing in
  Git 2.0 from 'matching' to 'simple'. To squelch this message
  and maintain the current behavior after the default changes, use:
  
    git config --global push.default matching
  
  To squelch this message and adopt the new behavior now, use:
  
    git config --global push.default simple
  
  See 'git help config' and search for 'push.default' for further information.
  (the 'simple' mode was introduced in Git 1.7.11. Use the similar mode
  'current' instead of 'simple' if you sometimes use older versions of Git)
  
  Pushing to /home/jw/test/1
  Counting objects: 4, done.
  Delta compression using up to 2 threads.
  Compressing objects: 100% (2/2), done.
  Writing objects: 100% (3/3), 10.00 MiB, done.
  Total 3 (delta 0), reused 0 (delta 0)
  To /home/jw/test/1
     97e52e2..9e8f1c6  master -> master
  updating local tracking ref 'refs/remotes/origin/master'
  $


As we can see in this example, the big file is tranferred back to the first
repository, although it is already available there. This is very annoying if
you have a very slow connection.

Am I missing some important point here?

-- 
Josef Wolf
jw@raven.inka.de
