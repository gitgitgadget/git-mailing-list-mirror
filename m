From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Git Submodule Problem - Bug?
Date: Tue, 29 Nov 2011 10:24:01 +0100
Message-ID: <201111291024.01230.trast@student.ethz.ch>
References: <38AE3033-6902-48AA-819B-DB4083F1F8EF@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: Manuel Koller <koller.manuel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 10:24:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVJvE-0000UZ-EI
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 10:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754286Ab1K2JYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 04:24:12 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:37087 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754315Ab1K2JYE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 04:24:04 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.339.1; Tue, 29 Nov
 2011 10:24:00 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 29 Nov
 2011 10:24:01 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.0-47-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <38AE3033-6902-48AA-819B-DB4083F1F8EF@gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186047>

Manuel Koller wrote:
> 
> The problem arises when I pull a commit that switches a submodule with another one and then run git submodule update. Say I have a repo "super" that has one submodule "sub1" in the folder "sub" and a clone "super2". Now I remove the submodule in "super2" and add another one ("sub2") again named "sub", commit this and push it. Now after pulling the commit to "super", I need to run git submodule sync and then git submodule update. 
> 
> I expect to end up with the submodule "sub2" in sub. But the log clearly shows that the commits from "sub1" are still there (the master branch belongs to "sub1" while origin/master comes from "sub2").  I get the following output:
> 
> > ...
> > commit 77d8d11fed3b07e1d4e47b3df9fc44c278694a39
> > Author: Manuel Koller <koller@stat.math.ethz.ch>
> > Date:   Mon Nov 28 17:46:45 2011 +0100
> > 
> >     initial commit sub1
> > commit 346fe6bd9e7957f10c5e833bb1155153379da41c
> > Author: Manuel Koller <koller@stat.math.ethz.ch>
> > Date:   Mon Nov 28 17:46:45 2011 +0100
> > 
> >     initial commit sub2
> 
> I think it should be twice the same, and "sub2". I checked also with Charon, on his machine, the two log messages reported are "sub1" which completely baffles me.

I used the test script at the end (just a testification of your
attachment) to bisect this to the following commit:

    commit 501770e1bb5d132ae4f79aa96715f07f6b84e1f6
    Author: Fredrik Gustafsson <iveqy@iveqy.com>
    Date:   Mon Aug 15 23:17:47 2011 +0200

        Move git-dir for submodules
        
        Move git-dir for submodules into $GIT_DIR/modules/[name_of_submodule] of
        the superproject. This is a step towards being able to delete submodule
        directories without loosing the information from their .git directory
        as that is now stored outside the submodules work tree.
        
        This is done relying on the already existent .git-file functionality.
        When adding or updating a submodule whose git directory is found under
        $GIT_DIR/modules/[name_of_submodule], don't clone it again but simply
        point the .git-file to it and remove the now stale index file from it.
        The index will be recreated by the following checkout.
        
        This patch will not affect already cloned submodules at all.
        
        Tests that rely on .git being a directory have been fixed.
        
        Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
        Mentored-by: Jens Lehmann <Jens.Lehmann@web.de>
        Mentored-by: Heiko Voigt <hvoigt@hvoigt.net>
        Signed-off-by: Junio C Hamano <gitster@pobox.com>

That is, before 501770 I get sub1/sub2 as Manuel said above.  After
501770 I get sub1/sub1 (!).  I have not been able to reproduce the
sub2/sub2 behavior with any version I tried (1.7.0, 1.7.3.4, 1.7.6,
etc.).  Perhaps there is a configuration setting that changes this?

In any case, since it's -rc4 time and 501770 is set to go into the
release, it would be nice if you could check whether this is indeed
correct/intended.



---- 8< ----
#!/bin/sh

test_description='submodule change bug'
. ./test-lib.sh

## set current directory as working directory
wd=`pwd`

test_expect_success 'set up submodules' '
## create repositories to be used as submodules
mkdir sub1 sub2 remote &&
(cd sub1 &&
    git init &&
    echo "test sub1" >> file &&
    git add file &&
    git commit -m "initial commit sub1"
) &&
git clone --bare sub1 remote/sub1.git &&
(cd sub2 &&
    git init &&
    echo "test sub2" >> file &&
    git add file &&
    git commit -m "initial commit sub2"
) &&
git clone --bare sub2 remote/sub2.git
'

test_expect_success 'set up super-repo' '
## create super repository
git init --bare remote/super.git &&
git clone remote/super.git super &&
(cd super &&
    git submodule add "$wd"/remote/sub1.git sub &&
    git commit -m "Added submodule sub1 as sub" &&
    git push -u origin master
)'

test_expect_success 'make super-repo with sub1->sub2' '
## clone super repository again
## and switch submodule sub1 by sub2
git clone --recursive remote/super.git super2 &&
(cd super2 &&
    ## remote submodule sub
    git config --remove-section submodule.sub &&
    git rm .gitmodules &&
    rm -rf sub &&
    git rm sub &&
    git commit -m "Removed submodule sub" &&
    ## add submodule sub2 as sub
    git submodule add "$wd"/remote/sub2.git sub &&
    git commit -m "Added submodule sub2 as sub" &&
    git push
)
'

test_expect_success 'pull from super2' '
## now pull super
(cd super &&
    git pull &&
    ## this will fail
    if ! git submodule update --init; then
    ## so sync first und update again
        git submodule sync &&
        git submodule update --init
    fi &&
    ## now sub is corrupt
    (cd sub &&
        git log master >log1 && ## this is from sub1
        echo "# next line should be: initial commit from sub1" &&
        grep sub1 log1 &&
        echo "# next line should be: initial commit from sub2" &&
        git log origin/master >log2 && ## this is from sub2
        grep sub2 log2
    )
)
'

test_done
