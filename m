From: "Ondrej Certik" <ondrej@certik.cz>
Subject: bidirectional hg <-> git syncing
Date: Wed, 5 Nov 2008 13:48:37 +0100
Message-ID: <85b5c3130811050448s28f2a26by266f9d674ecdacfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 05 13:50:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxhpy-0007tl-Kn
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 13:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbYKEMsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 07:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753546AbYKEMsl
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 07:48:41 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:49495 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641AbYKEMsk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 07:48:40 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3153853fgg.17
        for <git@vger.kernel.org>; Wed, 05 Nov 2008 04:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=WlA63nnt+VVgLNv8KC1iynioN2S6drRfnxrRNZx1EzA=;
        b=hHn+sIlOpa7OMXrC5JLawaM0S3mcAOTeUK85sZf82fEDZaBBbvogmcN5prjrCsglRv
         /GH4UBaOCuytgtzC2FBdK1CFcX31okqLCOJ4g2eBZywhjhWVcDTF7UW1tsUEbi6LNabT
         qenilftp9X+z/B8cljLJPwMCYnTfLCoLtoLd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=G62728EVpXLFWSPaSOmyfmR5Q1+5qGQY/0Tmksg+zTS0RbP0xe3j8DyHEsGfbT9xq+
         akh9cxz5Np/zg0vZMRqvCvl2tcdQVzEaCJMZ7S6rHYau/CbfdUMyzDzEhtajnOTTjZW+
         a7Bx79jXm24XWQz2Ck/yalbeazNr8IlpixthY=
Received: by 10.86.51.10 with SMTP id y10mr1009947fgy.51.1225889317192;
        Wed, 05 Nov 2008 04:48:37 -0800 (PST)
Received: by 10.86.54.9 with HTTP; Wed, 5 Nov 2008 04:48:37 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: 90d3b918fb722069
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100156>

Hi,

I wanted to share how we sync hg and git repo and I am interested if
anyone has any comments to it.

In our project [0], we used Mercurial, but recently several of the
core developers including me switched to git, but because we already
wrote docs and taught our users to use mercurial (see for example
[1]), we want to support both. So currently our main repo is still
mercurial and we automatically convert to git using

Our /home/hg/repos/sympy/.hg/hgrc contains:

[hooks]
#update the git repo
changegroup = /home/git/update-sympy.sh

where /home/git/update-sympy.sh is:

-----------
#!/bin/bash

cd /home/git/repos/sympy
sudo /bin/su git -c "../fast-export/hg-fast-export.sh -r /home/hg/repos/sympy"
cd /home/git/repos/
sudo /bin/su git -c "rm -rf sympy.git"
sudo /bin/su git -c "git clone --bare sympy/.git/ sympy.git"
sudo /bin/su git -c "echo 'main SymPy repository' > sympy.git/description"
sudo /bin/su git -c "touch sympy.git/git-daemon-export-ok"
---------


Which uses hg-fast-export to update the git repo.


Before pushing any patches in, we need to convert them to mercurial.
So if the user uses mercurial, nothing changes. If the user (like me)
uses git, I need to convert the patches to mercurial first, so that I
can push it in. So I do the following sequence, starting off my master
branch:

git checkout -b fix
# do some commits
./hgconvert

where the ./hgconvert script is:

-----
#! /bin/bash

work=`mktemp -t -d sym.XXX`
git format-patch -k -p -o $work master..HEAD
# add a new line after the subject line so that Mercurial imports it fine.
sed -i '4a\\' $work/*
cd ~/repos/sympy.hg/
hg import $work/*
rm -r $work
---------

This takes all patches commited after the master and commits them to
my hg repo at ~/repos/sympy.hg/. I'll then push them in, both our hg
and git repo updates and then I do in my local git repository:

git checkout master
git pull   # this pulls the changes, essentially the same as in the
"fix" branch, only from our official git repo
git branch -D fix


This works nicely as long as I do not do any merges in my local git
repo. Is there some way to also convert the branches and merges? As I
understood it, there are tools that only convert the whole repo, but
since we already convert the whole repo from hg to git, I need to only
convert the latest commits from git back to hg.

One solution is to fully switch to git and convert to hg automatically
on our server -- and that's what we'll do soon probably. Then we'll be
able to push nonlinear history in git, but only linear in mercurial.

Thanks,
Ondrej

[0] http://code.google.com/p/sympy/
[1] http://docs.sympy.org/sympy-patches-tutorial.html

Ondrej
