From: Joe Corneli <holtzermann17@gmail.com>
Subject: working with a large repository and git svn
Date: Wed, 12 Jan 2011 01:27:10 +0000
Message-ID: <AANLkTimKbS3ECzOaGtNgvx7DThJGH_DkPmg4ehKXGtwc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 12 02:27:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcpUb-000669-Er
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 02:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663Ab1ALB1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 20:27:13 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47914 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932362Ab1ALB1L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 20:27:11 -0500
Received: by iwn9 with SMTP id 9so48673iwn.19
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 17:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=Pbf/2wP/HSC7TM678282dZUDaaVTwc1wZhNlebLMZ4g=;
        b=xVRhp3XS69cbK2hu2J2Ayof0WOhtzPsrsXgmDmQg/akTi3hTfNJTOzl4ohwjnksO/y
         JPJKHvpZ55LfNeJvQF5JfZEh5HvcZ/zoxecQja3ce3HRjeXiMUse3KwmwxBXMsUnA1zM
         GAbKvyoyerA//70yzj80k1Vw1i6CdAZZr7vFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=PREB1eyMXo9R1b47J9Rzigsmo7I1r/JtQaClOYQnu3gANgdvWzeH5gb2HJRwjq7ab1
         oKbtS4jQo+XnSl7cKc1PBBOUeakvLFftzrFsCYvmptG6h79Vlats4dFVK4omryi2ZlP+
         VLZuWjxVnhNTvAG34iHKefNZjjgkWJWgfElAo=
Received: by 10.231.30.71 with SMTP id t7mr341440ibc.153.1294795630755; Tue,
 11 Jan 2011 17:27:10 -0800 (PST)
Received: by 10.231.85.146 with HTTP; Tue, 11 Jan 2011 17:27:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165002>

Greetings -

I am experiencing trouble with git svn, trying to import a
large repository (7.9 gigs, ~54000 commits) from Git into
SVN.

This has failed in a couple of different ways, depending
on the operating environment.  With Git version 1.7.3.5
running on Ubuntu 9.10, in the final step

  git svn dcommit --no-rebase

of the formula described below, I get:

 failing with "Can't fork at /usr/share/perl/5.10.0/Git.pm line 1261."

after committing just over 2000 revisions.

Previously, on Mac OS X 10.6.4 with git version 1.7.3.4,
it made it through about 18000 commits before failing with
some other error.  (I don't have that one recorded at the
moment.)

Separately from the latest attempt, I tried repacking the
repository before doing the "git svn" stuff, with

  git repack -a -d --depth=250 --window=250 -f

but that also failed ("pack-objects died of signal 11").

Any tips for dealing with new, large, repositories would
be appreciated.  The sequence of commands I used are below
the 8<.

Thanks,
Joe

8<-8<-8<-8<-8<-8<-8<-8<-8<-8<-8<-8<-8<-8<-8<-8<-8<-8<-8<-8<-8<

## Creating an svn repo

$ mkdir repo;
$ svnadmin create repo;
$ mkdir init;
$ touch init/README;
$ svn import init file://`pwd`/repo/init -m "Initial import";
$ svn checkout file://`pwd`/repo/init working;

## THIS PART FOLLOWS THE MODEL SUGGESTED BY THE FOLKS AT code.google.com
## (/Users/jac2349/planetary/destination/ IS THE LOCATION OF MY GIT REPO.)

$ mkdir cloning
$ cd cloning
$ git svn clone file:///Users/jac2349/planetary/repo/init
$ cd init
$ git fetch git:///Users/jac2349/planetary/destination/.git

$ git branch tmp $(cut -b-40 .git/FETCH_HEAD)
$ git tag -a -m "Last fetch" last tmp

$ INIT_COMMIT=$(git log tmp --pretty=format:%H | tail -1)
$ git checkout $INIT_COMMIT .
$ git commit -C $INIT_COMMIT

$ git rebase master tmp
$ git branch -M tmp master

$ git svn dcommit --no-rebase

$ mv .git/refs/tags/newlast .git/refs/tags/last

## BTW, THE --no-rebase FLAG KEEPS IT FROM BEING IMPOSSIBLY SLOW!
