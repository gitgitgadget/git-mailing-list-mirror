From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git svn push, git dcommit leads to commit duplication?
Date: Thu, 21 Jul 2011 12:25:42 +0200
Message-ID: <201107211225.42860.trast@student.ethz.ch>
References: <CAJs9aZ8T+LSOGs-kdncfSJeLANtZqudwc0r-epV7BQ1t4huX9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: rupert THURNER <rupert.thurner@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 12:32:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjqY4-0003sF-LX
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 12:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048Ab1GUKcD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 06:32:03 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:55009 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834Ab1GUKb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 06:31:58 -0400
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jul 2011 06:31:57 EDT
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Thu, 21 Jul
 2011 12:25:41 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.289.1; Thu, 21 Jul
 2011 12:25:43 +0200
User-Agent: KMail/1.13.7 (Linux/2.6.39.1-33-desktop; KDE/4.6.4; x86_64; ; )
In-Reply-To: <CAJs9aZ8T+LSOGs-kdncfSJeLANtZqudwc0r-epV7BQ1t4huX9Q@mail.gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rupert THURNER wrote:
> we keep a svn clone of
> https://gar.svn.sourceforge.net/svnroot/gar/csw/mgar/pkg on
> https://github.com/opencsw/pkg-all . usually i synchronize it with
> "git svn rebase" and "git push" from a local clone created with "git
> svn clone https://gar.svn.sourceforge.net/svnroot/gar/csw/mgar/pkg".
> 
> last time i changed something in this local clone and pushed it to
> github, and commited it to sourceforge via git svn dcommit. now the
> commits are there two times, different. my guess was that dcommit
> would add the svn related stuff to the existing git commits. what is
> the correct usage to keep svn and git in sync?

Your guess is mostly correct.  To best understand what is going on,
keep in mind that "you can never modify, you can only rewrite and
forget"[1].

Suppose you say 'git svn dcommit' on history that looks like

  1---2---3--(4)--(5)    SVN

  o---o---o    (svn/trunk)
           \
            a---b---c   (master)

where 4 and 5 are commits not yet fetched from SVN (if any).


1. git-svn will first fetch the new SVN history, let's call them N:

     1---2---3---4---5    SVN

     o---o---o---N---N    (svn/trunk)
              \
               a---b---c   (master)

2. Then it will rebase your own work on top of the new SVN stuff:

     1---2---3---4---5    SVN

     o---o---o---N---N    (svn/trunk)
              \
               a---b---c   (master)


3. Then it will rebase your own work on top of the new SVN stuff:

     1---2---3---4---5    SVN

     o---o---o---N---N    (svn/trunk)
                      \
                       a'--b'--c'   (master)

4. Then it will commit all of that to SVN:

     1---2---3---4---5---6---7---8    SVN

     o---o---o---N---N    (svn/trunk)
                      \
                       a'--b'--c'   (master)

5. Then it will annotate your commits o' with the info coming back
   from SVN (such as author, etc.) and "replace" your master with it:

     1---2---3---4---5---6---7---8    SVN

     o---o---o---N---N---A---B---C    (svn/trunk, master)

   From the point of view of 'master', this is also much like a
   rebase, except that authors and timestamps change too and (unless
   disabled) git-svn-id: lines appear in your commit messages.


Does that clarify what happens?

[For the sake of completeness, I should point out that this is a
simplification.  Steps 3--5 are actually all done in one go *per
commit*, and step 3 does not use 'git-rebase' but a variant on the
theme that preserves merges of side branches.]


As for

> what is the correct usage to keep svn and git in sync?

the only way I know of that avoids constantly rebasing branches is to
never push anything before it has been dcommitted.


[1] Quoting Tv; he said it much better than I can.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
