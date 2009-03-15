From: Tom Huybrechts <tom.huybrechts@gmail.com>
Subject: git-svn: creating tags from a subdirectory of trunk
Date: Sun, 15 Mar 2009 22:18:41 +0100
Message-ID: <632a37a0903151418u483ca6cal1582518b9120da8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 15 22:20:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lixl4-0001Zu-Tf
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 22:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755463AbZCOVSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2009 17:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbZCOVSp
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 17:18:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:31633 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbZCOVSp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 17:18:45 -0400
Received: by nf-out-0910.google.com with SMTP id d21so914283nfb.21
        for <git@vger.kernel.org>; Sun, 15 Mar 2009 14:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=+Jp4MrIWWgNeKElK+i8Se64GGYXOkAXAnuuHOym9r5w=;
        b=QsLntrfd97vF0+zZm1KeCUYKqXdt3iQP6iTHa6TW9+fGH/8Q77spTBqkSndOUPSoIv
         i2squEovi5OlMv/uAHafUc1PWpvt2vTTgLiB2p/E+iqNON9WbMXhCjiqmVgAN3TdwtYn
         1GNieo95JF8VAQnqnIeL5BPXyDmm6XY/ZyvYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=J43RWAJZFlXeHaSNVcUYXcujvgau2PCcU3uoJpNWW/oY/Z/LL2a814AtSL+NGlFYEA
         aRvJjqqaNu6A9Qwh81FZ0llzdMU3e7Y5yEG3n8VScs/zRtbWcMLYkXVLqWumHgum8oM0
         atnqbTKprXpXKHaoKiqKYPjynSZEyjddhm+jQ=
Received: by 10.210.130.14 with SMTP id c14mr1532574ebd.33.1237151921916; Sun, 
	15 Mar 2009 14:18:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113299>

Hi,

I'm trying to setup a git mirror of a svn repository.  The tags in
this repository are not created trunk it self, but from subdirectories
of trunk. The tags and branches are in the standard places.
e.g:
/trunk/main -> tags/main-1
/trunk/plugins/foo -> tags/foo-1
/trunk/plugins/bar -> tags/bar-1

I run 'git svn clone -s svn-url target'. It starts going over the
history nicely until it reaches the first branch. It calls this branch
something like tags/tag-name@revision, and starts retrieving the
entire project history again from r1. This is repeated for every
branch.

I've created a very small standalone shell script that demonstrates the problem:

=====
#!/bin/bash

REPO=`pwd`/svn-repo
WC=`pwd`/svn-wc
svnadmin create $REPO
REPO=file://$REPO
svn co $REPO $WC
SUBDIR=$WC/trunk/subdir

mkdir $WC/tags $WC/trunk $WC/branches $SUBDIR
svn add $WC/*
svn commit -m "structure" $WC
svn cp -m "create a tag" $REPO/trunk/subdir $REPO/tags/1

git svn clone -s $REPO git-repo
=====


When you run this, the output of git-svn is:

=====
Initialized empty Git repository in /home/tom/experiment/git-repo/.git/
W: +empty_dir: trunk/subdir
r1 = 3b90e67a4d8e9a2d32d4389b0f6ac93e23f38a46 (trunk)
Found possible branch point:
file:///home/tom/experiment/svn-repo/trunk/subdir =>
file:///home/tom/experiment/svn-repo/tags/1, 1
Initializing parent: tags/1@1
r1 = 0ad93ba4a7f6c43de30ab4dd05161662b75a6adb (tags/1@1)
Found branch parent: (tags/1) 0ad93ba4a7f6c43de30ab4dd05161662b75a6adb
Following parent with do_switch
Successfully followed parent
r2 = ce47fc7b4e21000c84da63ad5f643c18118d1918 (tags/1)
Checked out HEAD:
  file:///home/tom/experiment/svn-repo/tags/1 r2
=====

Note the tags/1@1 and then starting over again from r1.

It's not so bad in this little example, but try this on a repository
with  200 tags and 16000 revisions...
So my question: is this normal or a bug ? Can I do something to import
this repository correctly ?

Thanks,

Tom
