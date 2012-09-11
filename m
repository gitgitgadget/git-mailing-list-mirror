From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: How to update a cloned git repository
Date: Tue, 11 Sep 2012 13:06:08 +0200
Message-ID: <vpq7gs0es4f.fsf@bauges.imag.fr>
References: <k2n4v2$88t$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Tue Sep 11 13:06:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBOIY-0003BX-20
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 13:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758808Ab2IKLGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 07:06:18 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43803 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758087Ab2IKLGR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 07:06:17 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q8BB17Vf010341
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 11 Sep 2012 13:01:07 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TBOID-0007Ra-H9; Tue, 11 Sep 2012 13:06:09 +0200
In-Reply-To: <k2n4v2$88t$1@ger.gmane.org> (Joachim Schmitz's message of "Tue,
	11 Sep 2012 12:49:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 11 Sep 2012 13:01:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8BB17Vf010341
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1347966072.87294@SmbaXbUNRrDc1/00B1/fkQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205217>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> Hi folks
>
> Probably a beginner's question...
>
> If I did a
>    git clone git://guthub.com/git/git.git
> and worked on some own branches of pu
>    git checkout pu;git checkout -p mybranch;

I guess you meant "git checkout -b mybranch" (not -p).

> hack;hack;...;git commit -a -s
>
> how to update my repository once the the one on github changed? A
> plain git pull or git fetch;git merge keeps failing on my with lots of
> conflicts, none of which relate to any of the changes I did (and hence
> wouldn't know how to resolve)

Short answer: don't work on pu. Work on master unless you have a good
reason not to.

Longer answer: the pu branch in git.git is often re-written, hence the
commit on which you started hacking once existed in git.git's pu, but it
probably no longer is.

You cloned this:

--A---B---C <-- origin/pu

Hacked to this

         origin/pu
          |
          v
--A---B---C---D---E <-- mybranch

and the next fetch resulted in something like this:

    B'---C'---D'---F <-- origin/pu
   /
--A---B---C---D---E <-- mybranch

while you could have expected that if origin/pu had just been
fast-forwarded with a new commit F:

            F <-- origin/pu
           /
--A---B---C---D---E <-- mybranch

As a result, "git merge" computes a common ancestor very far backward in
history. Instead of merging only your changes with new pu content, it
merges the old history of pu (plus your changes) with the new history of
pu, and you get spurious conflicts.

The solution is to rebase your changes (and only yours). My advice is to
rebase them on master, like this (replace 42 by the number of commits
you want to rebase in HEAD~42):

  git rebase HEAD~42 --onto origin/master

Once you did this, you can start using "git pull" (or "git pull
--rebase") as usual.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
