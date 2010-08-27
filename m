From: "Neal Kreitzinger" <neal@rsss.com>
Subject: how to change permissions of git repo
Date: Thu, 26 Aug 2010 22:03:30 -0500
Message-ID: <i57a0n$vm2$5@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 27 05:05:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OopFz-0007JM-EM
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 05:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526Ab0H0DFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 23:05:12 -0400
Received: from lo.gmane.org ([80.91.229.12]:45209 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774Ab0H0DFK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 23:05:10 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OopFa-00078h-Mf
	for git@vger.kernel.org; Fri, 27 Aug 2010 05:05:06 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 05:05:06 +0200
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 05:05:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154577>

Here is the technique I devised to change permissions on a git repo.  I 
needed to lock down a repo so only the integration manager has write access. 
This method ensures that git sets the permissions according to gits rules. 
Please let me know if you know of an easier/better way to do this.

Change Permissions on an Existing Git Repo:

Check System for Users who may be using the Repo:
# w  (see who's logged in)
# ps -A |grep git-menu-scriptname  (where scriptname is some unique string 
in the name of the main script your users use to access that repo, if 
applicable)
# skill -KILL pts/99  (where 99 = the pts/# from w command, log the user 
off)

Change Shared=group to Shared=0644  (change group read+write to group read 
only):
Create Template for permissions:
login as fsngit0
$ cd /path/to/template
$ cat config
[core]
        sharedRepository = 0644

Clone repo to set permissions via git:
$ cd /path/to/repo-parent-dir
$ git clone --bare --template=/path/to/template file:///path/to/REPO.git 
REPOMOD.git

Compare old and new versions:
$ diff -r REPO.git REPOMOD.git
Only in REPO.git: branches  (empty, keep the old version)
diff -r REPO.git/config REPOMOD.git/config  (merge the old and new together)
1a2
>       sharedrepository = 0644
6,7c7
<         denyDeletes = true
<         denyNonFastForwards = true
---
>       denyNonFastforwards = true
Only in REPO.git: description  (keep the old version)
Only in REPO.git: gitk.cache  (gitk will recreate this)
Only in REPO.git: hooks  (contains sample scripts only or whatever scripts 
your using, keep the old version)
Only in REPO.git: info  (keep the old version: contains attributes, exclude, 
or whatever you've setup)
Only in REPO.git/objects: aa (keep new version, loose object have been 
packed)
Only in REPO.git/objects/pack: 
pack-A5735e9b894dce1498ec1c776dcabc97fd8ceAfc.idx
diff -r REPO.git/packed-refs REPOMOD.git/packed-refs  (keep the new version 
because fresh clone has been optimized)
2c2
< Xa8b7b8c8fd3920b89770f2e8356f4ecb71a58cX refs/heads/master
---
> Ya69744e46276a37932d5f0755a53f76cdf83e0dY refs/heads/master
Only in REPO.git/refs/heads: master  (old version not needed because fresh 
clone has been optimized)

Copy over REPO.git files that the clone didn't replicate, but that you need 
in order to retain all settings:
$ cp -rv /path/to/REPO.git/info .
repeat as needed...

change permissions to g-w or whatever your core.sharedRepository new value 
is supposed to be:
$ chmod -R g-w info
repeat as needed...

Validate your changes:
$ diff -r REPO.git REPOMOD.git
diff -r REPO.git/config REPOMOD.git/config
1a2
>       sharedrepository = 0644
7c8
<         denyNonFastForwards = true
---
>       denyNonFastforwards = true
Only in REPO.git: gitk.cache
Only in REPO.git/objects: aa
Only in REPO.git/objects/pack: 
pack-A5735e9b894dce1498ec1c776dcabc97fd8ceAfc.idx
diff -r REPO.git/packed-refs REPOMOD.git/packed-refs
2c2
< Xa8b7b8c8fd3920b89770f2e8356f4ecb71a58cX refs/heads/master
---
> Y69744e46276a37932d5f0755a53f76cdf83e0dY refs/heads/master
Only in REPO.git/refs/heads: master

Backup REPO.git and rename REPOMOD.git to REPO.git:
$ cp -rvp REPO.git REPO.git-old
$ diff -r REPO.git REPO.git-old
$ rm -rf REPO.git
$ cp -rvp REPOMOD.git REPO.git
$ diff -r REPO.git REPOMOD.git
$ diff -r REPO.git REPO.git-old

v/r,
Neal 
