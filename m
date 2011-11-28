From: Manuel Koller <koller.manuel@gmail.com>
Subject: Git Submodule Problem - Bug?
Date: Mon, 28 Nov 2011 18:13:36 +0100
Message-ID: <38AE3033-6902-48AA-819B-DB4083F1F8EF@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: multipart/mixed; boundary="Apple-Mail=_72A5ED76-4516-491C-A788-F71A548478B6"
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 18:13:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RV4m0-0003yN-5l
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 18:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852Ab1K1RNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 12:13:39 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46861 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560Ab1K1RNi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 12:13:38 -0500
Received: by eaak14 with SMTP id k14so2017204eaa.19
        for <git@vger.kernel.org>; Mon, 28 Nov 2011 09:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:content-type:subject:date:message-id:cc:to:mime-version
         :x-mailer;
        bh=ghE8h82vvz59xYmGHuOCL8MM/oszrO6WhUAQtgsBwv0=;
        b=nfDXl68+9x4V7gTFQ3KI5Le3MznMGT+gflEYtsWg5S9zExzLTuFXUZWkdqZNHlfi8l
         gsYs0zmseeNtcfiLBB5UAeKs8fgVqhYEIkrM7nj083fDwe5I3jgFGrGMHrH5o3y3jAN0
         +/gHH+CYXN2XDSNHF5rJgn/wApRytu9UjGES0=
Received: by 10.180.80.98 with SMTP id q2mr46023529wix.53.1322500417700;
        Mon, 28 Nov 2011 09:13:37 -0800 (PST)
Received: from [192.168.1.5] (178-83-214-151.dynamic.hispeed.ch. [178.83.214.151])
        by mx.google.com with ESMTPS id es5sm39652040wbb.11.2011.11.28.09.13.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Nov 2011 09:13:36 -0800 (PST)
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186021>


--Apple-Mail=_72A5ED76-4516-491C-A788-F71A548478B6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi

I've encountered strange behavior of git submodule and I cannot think =
about a way to avoid the problem. I've added a small script that =
reproduces the problem in the current version of git (1.7.7.3, =
git-osx-installer).

The problem arises when I pull a commit that switches a submodule with =
another one and then run git submodule update. Say I have a repo "super" =
that has one submodule "sub1" in the folder "sub" and a clone "super2". =
Now I remove the submodule in "super2" and add another one ("sub2") =
again named "sub", commit this and push it. Now after pulling the commit =
to "super", I need to run git submodule sync and then git submodule =
update.=20

I expect to end up with the submodule "sub2" in sub. But the log clearly =
shows that the commits from "sub1" are still there (the master branch =
belongs to "sub1" while origin/master comes from "sub2").  I get the =
following output:

> ...
> commit 77d8d11fed3b07e1d4e47b3df9fc44c278694a39
> Author: Manuel Koller <koller@stat.math.ethz.ch>
> Date:   Mon Nov 28 17:46:45 2011 +0100
>=20
>     initial commit sub1
> commit 346fe6bd9e7957f10c5e833bb1155153379da41c
> Author: Manuel Koller <koller@stat.math.ethz.ch>
> Date:   Mon Nov 28 17:46:45 2011 +0100
>=20
>     initial commit sub2

I think it should be twice the same, and "sub2". I checked also with =
Charon, on his machine, the two log messages reported are "sub1" which =
completely baffles me.

Best regards,

Manuel


--Apple-Mail=_72A5ED76-4516-491C-A788-F71A548478B6
Content-Disposition: attachment;
	filename=submodule-bug-minimal-example.bash
Content-Type: application/octet-stream;
	name="submodule-bug-minimal-example.bash"
Content-Transfer-Encoding: 7bit

#/bin/bash

## set -e explicitly
set -e

## set current directory as working directory
wd=`pwd`

## create repositories to be used as submodules
mkdir sub1 sub2 remote
(cd sub1
    git init
    echo "test sub1" >> file
    git add file
    git commit -m "initial commit sub1"
)
git clone --bare sub1 remote/sub1.git
(cd sub2
    git init
    echo "test sub2" >> file
    git add file
    git commit -m "initial commit sub2"
)
git clone --bare sub2 remote/sub2.git

## create super repository
git init --bare remote/super.git
git clone remote/super.git super
(cd super
    git submodule add $wd/remote/sub1.git sub
    git commit -m "Added submodule sub1 as sub"
    git push -u origin master
)

## clone super repository again
## and switch submodule sub1 by sub2
git clone --recursive remote/super.git super2
(cd super2
    ## remote submodule sub
    git config --remove-section submodule.sub
    git rm .gitmodules
    rm -rf sub
    git rm sub
    git commit -m "Removed submodule sub"
    ## add submodule sub2 as sub
    git submodule add $wd/remote/sub2.git sub
    git commit -m "Added submodule sub2 as sub"
    git push
)

## now pull super
(cd super
    git pull
    ## this will fail
    git submodule update --init || echo "submodule update fails, that's ok"
    ## so sync first und update again
    git submodule sync
    git submodule update --init
    ## now sub is corrupt
    (cd sub
	git log master ## this is from sub1
	git log origin/master ## this is from sub2
    )
)
--Apple-Mail=_72A5ED76-4516-491C-A788-F71A548478B6--
