From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: Re: [PATCH] Fix rebase with file move when diff.renames = copies
Date: Thu, 22 Jul 2010 14:59:49 -0700 (PDT)
Message-ID: <681325.9577.qm@web30002.mail.mud.yahoo.com>
References: <7vwsfb2k3u.fsf@gitster.siamese.dyndns.org> <1279742303-29817-1-git-send-email-ddkilzer@kilzer.net> <20100722075133.GA9292@burratino>
Reply-To: "David D. Kilzer" <ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 23:59:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc3o4-00052u-Dt
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 23:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270Ab0GVV7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 17:59:51 -0400
Received: from web30002.mail.mud.yahoo.com ([209.191.69.19]:21842 "HELO
	web30002.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751166Ab0GVV7u (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jul 2010 17:59:50 -0400
Received: (qmail 9845 invoked by uid 60001); 22 Jul 2010 21:59:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1279835989; bh=0vGdPyjByTb5uzBI9vxS22yNJwuGERxinWYq4N+7uvw=; h=Message-ID:X-YMail-OSG:Received:X-RocketYMMF:X-Mailer:References:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type; b=X6IfGyIW8l+mmM83PaYJ9cBFPoCmBgMm3VLvydLBeo+COUrfZg5wzGy7uzF98HbsS7dX94vLDYdk97VUIDBUxF2sSzpm49fVnGRvYtsfUgOVjeqD+/GlDsY5uHdL02uR+ybE5K3+7FSF4tqo96uW4u5GShMNEEhcRS60XXIpOUQ=
X-YMail-OSG: J_jcx.UVM1m8Iyr9.Lv7QPhxnqdgpOOXUR8DkjJ0LTQlRK8
 byzhlVQyBObqmgSG85FDZWuTvY3AbmLep5g0PGpUftk8Ee3n6bh_ZIQmR7t4
 SlwL_2cvHkWJ4IAnJ.8onPgz9bD_8QF9Xen.2uGMBtaDRu4GcJcgU359xY7i
 RmMs7ODUUu.ckQAlCq1qsqgK6.MczMk5Q7JB31TTOFtyG3gZn9ialOJk19_T
 x6GffCuMHQnATjIdB1eULwKzG5KD1o.CjNnpJ8bKZGeAL9B6CRCohGxqmmMO
 TCfNAPmyFb3Mv1YHiTM9zQSeI1umPa4L4UeEk6kylHMFI0tUGm9k1XN2kKGc
 yaR6j.AeLc3.5CObs2yX1BT31olUy309j
Received: from [17.202.32.26] by web30002.mail.mud.yahoo.com via HTTP; Thu, 22 Jul 2010 14:59:49 PDT
X-RocketYMMF: ddkilzer
X-Mailer: YahooMailRC/420.4 YahooMailWebService/0.8.105.277674
In-Reply-To: <20100722075133.GA9292@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151488>

On Jonathan Nieder wrote:

> David D. Kilzer wrote:
> 
> > With diff.renames = copies, a rebase with a  file move will fail with
> > the following error:
> >
> >      fatal: mode change for <file>, which is not in current  HEAD
> >     Repository lacks necessary blobs to fall back on  3-way merge.
> >     Cannot fall back to three-way  merge.
> >     Patch failed at 0001.
> 
> I would think that the  following works fine:
> 
>     git init test-repo  &&
>     cd test-repo &&
>      echo hello >greeting.txt &&
>     git add  greeting.txt &&
>     git commit -m base  &&
>     git checkout -b move  &&
>     git mv greeting.txt moved.txt  &&
>     git commit -m move  &&
>     git checkout master  &&
>     echo hi >greeting.txt  &&
>     git add greeting.txt  &&
>     git commit -m change  &&
>     git checkout move  &&
>     echo '[diff] renames = copies'  >>.git/config &&
>     git rebase  master
> 
> What am I doing wrong?


Given the following tree:

      B' topic
     /
    A---B master

A: New file "F1" is committed.
B: New file "F2" is committed.
B': New file "F2" is committed (identical in content to "F2" on B), and "F1" is 
renamed to "F3".

When the topic branch is rebased onto master with diff.renames=copies, git fails 
when attempting to build a fake ancestor for F1.  The key to reproducing the bug 
is to have an identical new file added on both B and B'.

My original patch in <http://marc.info/?l=git&m=122635667614099&w=2> addressed 
this in builtin-apply.c, but Junio didn't like this approach as noted in 
<http://marc.info/?l=git&m=122636097120953&w=2>.

> Patch does not apply to master or maint, due to conflict  with
> v1.7.1-rc0~37^2~5 (rebase: support automatic notes  copying,
> 2010-03-12).  One sneaky way to avoid this kind of thing would  be to
> insert new tests at some logical point in the middle of a test  script.


Sorry about that--I forgot to rebase it to maint before sending it.

> Test nitpicks:


Thanks!  I'll make the requested changes in the next patch.

> This wants to notice that Y  was already added so the top patch can be
> simplified to include only a  rename.


Actually, this is the key to reproducing the bug!

> Can you explain why this test will fail without your  patch?


Here is a stand-alone script that reproduces the bug:

    git init test-repo &&
    cd test-repo &&
    echo hello > F1 &&
    git add F1 &&
    git commit -m "A" &&
    git checkout -b topic &&
    echo hi > F2 &&
    git add F2 &&
    git mv F1 F3 &&
    git commit -m "B'" &&
    git checkout master &&
    echo hi > F2 &&
    git add F2 &&
    git commit -m "B" &&
    git checkout topic &&
    git config diff.renames copies &&
    GIT_TRACE=1 git rebase master

Note that the test case in my patch depended on "F1" (which was "A") being 
committed by an earlier test.

Dave
