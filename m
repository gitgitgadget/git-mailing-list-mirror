From: Stephen Major <smajor@gmail.com>
Subject: Re: post-receive for web deployment
Date: Sun, 18 Dec 2011 18:42:56 -0800
Message-ID: <CALzTOm+sJHF_7WzjD7bCqAiAbQSV0A3hEX1KdWfFzV7-ePzX2w@mail.gmail.com>
References: <CALzTOmJUqzO8H5UxyFaodi98DBJtFvsbQsHsYh1U=Ggq3NRO5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 03:43:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcTBu-0005MZ-Km
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 03:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145Ab1LSCm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Dec 2011 21:42:58 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58305 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053Ab1LSCm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2011 21:42:57 -0500
Received: by qcqz2 with SMTP id z2so2837158qcq.19
        for <git@vger.kernel.org>; Sun, 18 Dec 2011 18:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=lKFB50EY5bYdt3d17ekSuU2McnM8TOTXvK0wshsAOrI=;
        b=CDCGXNdgrgRjrR3ceA2pRC7KR6jrIsOTnZ92ORamVxPkCDv1B8nI518KdQdlwRqbMA
         BX/OLYxwQG9cVG2qMY9iQXAjMGBtfzkz35Z/Nl+BZM+xJylFjGSMDMujuWzkHzJOpIiU
         Qd/zNyBM6CM0ur6GMVCmogUsOzXQvSRGkDRDw=
Received: by 10.229.77.134 with SMTP id g6mr4776193qck.125.1324262576958; Sun,
 18 Dec 2011 18:42:56 -0800 (PST)
Received: by 10.229.33.67 with HTTP; Sun, 18 Dec 2011 18:42:56 -0800 (PST)
In-Reply-To: <CALzTOmJUqzO8H5UxyFaodi98DBJtFvsbQsHsYh1U=Ggq3NRO5A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187434>

Hello,

I am having some difficulty understanding what I am doing wrong when
working with git to deploy a website through the use of a post-receive
hook on the remote.

Here is the script:

#!/bin/sh

staging_path="/home/user/domains/domain.com/public_html/staging"
live_path="/home/user/domains/domain.com/public_html/live"


while read oldrev newrev ref
do

    branch=$(echo $ref | cut -d/ -f3)

    # ***
    # update the live site
    #
    if [[ "master" == "$branch" ]]; then

        export GIT_WORK_TREE=$live_path
        git checkout -f $branch

        echo "Release has been pushed to production"

    # ***
    # we update the staging server with the latest push
    #
    elif [[ "develop" == "$branch" ]]; then

        echo "Resetting staging tree"
        export GIT_WORK_TREE=$staging_path

        git checkout -f $branch

        echo "Develop has been pushed to staging"

    fi

done



This is what we have done:

git checkout develop
touch 1 2 3 4 5 6
git add .
git commit -am "added some files"
git push origin develop

checking the remote server now all files are found in:
/home/user/domains/domain.com/public_html/staging

git checkout master
git merge develop
git push origin master

checking the remote server now all files are found in:
/home/user/domains/domain.com/public_html/live

git checkout develop
git rm 4 5 6
git commit -am "removed some files"
git push origin develop

checking the remote server now files 4 5 6 have been removed from:
/home/user/domains/domain.com/public_html/staging

git checkout master
git merge develop
git push origin master

checking the remote server files 4 5 6 are still found in:
/home/user/domains/domain.com/public_html/live

Why is this happening? checking the local repo for master shows the
files are removed there... pulling the latest from origin:master shows
the files have been removed... but why were they not removed from the
working tree like they were on the staging working tree?


well I think it has something to do with later commits and therefor
the working tree of the live server could quickly become out of sync
with the development tree

a quick test, lets checkout master again and perform the removes
directly on it then push it back:

git checkout master
git rm 1 2 3
git commit -am "removed 1 2 3"
git push origin master

checking the remote server now files 1 2 3 have been removed from:
/home/user/domains/domain.com/public_html/live


Okay weird so they remove when the commit happens directly on that
branch and is pushed to the remote but they dont get removed if the
removal happened on a different branch and is merged in then pushed to
the remote....

anyone have an explanation or a workaround?
