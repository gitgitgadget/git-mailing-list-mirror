From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git repo corruption
Date: Wed, 05 Jan 2011 12:33:13 -0600
Message-ID: <4D24B969.50007@gmail.com>
References: <AANLkTi=TSy1WQZARNQgGfPiV93hQ-xmCTip75JAixgDB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 05 19:34:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaYBi-0004Zn-QZ
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 19:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281Ab1AESeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 13:34:00 -0500
Received: from lo.gmane.org ([80.91.229.12]:37271 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752217Ab1AESd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 13:33:58 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PaYBG-0004H8-3E
	for git@vger.kernel.org; Wed, 05 Jan 2011 19:33:54 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 19:33:54 +0100
Received: from nkreitzinger by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 19:33:54 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTi=TSy1WQZARNQgGfPiV93hQ-xmCTip75JAixgDB@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164580>

On 1/4/2011 3:10 AM, Levend Sayar wrote:
> Hi, all.
>
> We have a repo on a corporate server. The sysadmin changed access
> rights of files on our repo by accedant.
> Some directories have 2750 acces rights before, but he changed as
>
> chmod -R 2770 *
>
> Now when you make git status, every file that is tracked by git is said as
>
> changed but not updated
>
> So is there a way to get this back to normal ?
>
> TIA
>
> _lvnd_
> (^_^)

If you want to reset the permissions back to exactly what git would do, 
here is the way I did it after hours one night to fix the repo at our 
shop (modify the permissions value to what you want):

Here is the technique I devised to change permissions on a git repo.  I
needed to lock down a repo so only the integration manager has write 
access.
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
Only in REPO.git: info  (keep the old version: contains attributes, 
exclude,
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
