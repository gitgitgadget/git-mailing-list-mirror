X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] xdiff: add xdl_merge() (was: (unknown))
Date: Wed, 22 Nov 2006 10:29:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611221005470.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0611212316080.26827@wbgn013.biozentrum.uni-wuerzburg.de>
 <ek0170$h53$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1598645148-1164187795=:30004"
NNTP-Posting-Date: Wed, 22 Nov 2006 09:30:25 +0000 (UTC)
Cc: Davide Libenzi <davidel@xmailserver.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <ek0170$h53$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32074>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmoQo-0000PL-IV for gcvg-git@gmane.org; Wed, 22 Nov
 2006 10:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755563AbWKVJaB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 04:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755573AbWKVJaB
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 04:30:01 -0500
Received: from mail.gmx.de ([213.165.64.20]:19591 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1755563AbWKVJaA (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 04:30:00 -0500
Received: (qmail invoked by alias); 22 Nov 2006 09:29:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp032) with SMTP; 22 Nov 2006 10:29:59 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1598645148-1164187795=:30004
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 22 Nov 2006, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > [PATCH] xdiff: add xdl_merge()
> 
> Shouldn't this be in the subject of message?

Did I mention that I was tired and hungry?

> > This new function implements the functionality of RCS merge, but 
> > in-memory. It returns < 0 on error, otherwise the number of conflicts.
> 
> Only RCS merge, or can you implement whole diff3 (from GNU diffutils) 
> functionality with that?

As I am interested only in the in-memory merge, only RCS merge. Which 
feature would you be interested in? An ed script? :-)

> > Finding the conflicting lines can be a very expensive task. You can
> > control the eagerness of this algorithm:
> > 
> > - a level value of 0 means that all overlapping changes are treated
> >   as conflicts,
> > - a value of 1 means that if the overlapping changes are identical,
> >   it is not treated as a conflict.
> > - If you set level to 2, overlapping changes will be analyzed, so that
> >   almost identical changes will not result in huge conflicts. Rather,
> >   only the conflicting lines will be shown inside conflict markers.
> > 
> > With each increasing level, the algorithm gets slower, but more accurate.
> > Note that the code for level 2 depends on the simple definition of
> > mmfile_t specific to git, and therefore it will be harder to port that
> > to LibXDiff.
> 
> How it compares performance with RCS merge/GNU diff3?

Speedwise, I have no clue. It was enough work for a day.

Accuracywise: often I sent a patch (series) which was in my current git 
tree (no topic branch), and Junio did some minor adjustments. I _hated_ 
the fact that RCS merge marked _all_ overlapping changes as conflicts, 
even when there was just a minor correction here and there. And "git diff 
--ours" does not help at all.

Here is where my implementation should help. With level 2, it will look 
again at these conflicting regions, and only output the actual differences 
as conflicts.

> It is really nice to have that. Bram Cohen (of Codeville, SCM built around
> sophisticated merge algorithm) wrote about recursive three-way merge in
> http://revctrl.org/CrissCrossMerge
> 
>    Recursive three-way merge _usually_ provides the right answer, however
>    there are some edge cases. For example, conflict markers can be matched
>    incorrectly, because they aren't given any special semantic meaning for
>    the merge algorithm, and are simply treated as lines. In particular,
>    there are (somewhat complicated) cases where the conflict markers of two
>    unrelated conflicts get matched against each other, even though the
>    content sections of them are totally unrelated.
> 
> I'm not sure if he has specific examples, or is it just theoretical talk,
> but having built-in merge would certainly help revursive merge strategy
> (and perhaps also git-rerere).

It should be easy to construct such an example. However, the relevance in 
practice is about zero.

Git was built from the beginning to aim to do a merge as good as possible, 
but not perfect. There is no such thing as a perfect merge algorithm. You 
will always be able to construct cases which are mismerged.

Thus, git takes the pragmatic approach and stops "early": merges work in 
99% of the time, and in 99% of the remaining 1% the merge will fail so 
that you know you have to fix it manually. (Take these numbers with a 
grain of salt, please.) The advantage of stopping there is that we can 
make it really fast.

You could probably raise the 99% to 99.5%, by implementing a "rebasing 
merge", i.e. cherry-picking the branch-to-be-merged committing only in the 
end (if there has not been any conflict). Obviously, this is slow as 
Parnell's pitch[1].

As for git-rerere: I could not use it everywhere, because of some Perl 
dependencies which I could not compile on some platforms. However, IMHO 
git-rerere does not necessarily depend on merge being available in libgit.

Ciao,
Dscho

Footnote 1: http://www.physics.uq.edu.au/pitchdrop/pitchdrop.shtml

