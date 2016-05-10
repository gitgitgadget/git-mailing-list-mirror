From: Stephen & Linda Smith <ischis2@cox.net>
Subject: Re: [PATCH] wt-status.c: set commitable bit if there is a meaningful merge.
Date: Mon, 09 May 2016 21:51:19 -0700
Message-ID: <5686039.PQA9zH74Pi@thunderbird>
References: <72756249.nAoBccgOj7@thunderbird> <1455590305-30923-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Ovidiu Gheorghioiu <ovidiug@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 08:43:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b01Oa-0002Vw-Ls
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 08:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbcEJGnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 02:43:46 -0400
Received: from fed1rmfepo202.cox.net ([68.230.241.147]:43348 "EHLO
	fed1rmfepo202.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbcEJGno (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 02:43:44 -0400
X-Greylist: delayed 6741 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 May 2016 02:43:44 EDT
Received: from fed1rmimpo305.cox.net ([68.230.241.173])
          by fed1rmfepo203.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20160510045121.MYWL27016.fed1rmfepo203.cox.net@fed1rmimpo305.cox.net>
          for <git@vger.kernel.org>; Tue, 10 May 2016 00:51:21 -0400
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo305.cox.net with cox
	id sUrL1s00F2tqoqC01UrLjl; Tue, 10 May 2016 00:51:20 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020204.573168C8.00C5,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.1 cv=M9LtU3Es c=1 sm=1 tr=0
 a=/Rt4pg3TtX3KzfzhvVoEow==:117 a=/Rt4pg3TtX3KzfzhvVoEow==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=yrkiwgmsf1kA:10 a=6FwhlGHFbFm3aAnB3G0A:9 a=CoUHzPLtwM_ZfEJQ:21
 a=ENK3PvDoVmBf0Afc:21 a=CjuIK1q_8ugA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: by thunderbird (Postfix, from userid 1000)
	id 1B5B191EDE; Mon,  9 May 2016 21:51:20 -0700 (MST)
User-Agent: KMail/5.0.2 (Linux/4.2.0-35-generic; KDE/5.15.0; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294102>

On Tuesday, February 16, 2016 07:33:54 PM Junio C Hamano wrote:
> > ---
> 
> I think I mislead you into a slightly wrong direction.  While the
> single liner does improve the situation, I think this is merely a
> band-aid upon closer inspection.  For example, if you changed your
> "commit --dry-run" in your test to "commit --dry-run --short", you
> would notice that the test would fail.
> 
I understand.

> In fact, "commit --dry-run" is already broken without this "a merge
> ends up in a no-op" corner case.  The management of s->commitable
> flag and dry_run_commit() that uses it are unfortunately more broken
> than I originally thought.
> 
> If we check for places where s->committable is set, we notice that
> there is only one location: wt_status_print_updated().  This function
> runs an equivalent of "diff-index --cached" and flips s->committable
> on when it sees any difference.
> 
> This function is only called from wt_status_print(), which in turn
> is only called from run_status() in commit.c when the status format
> is unspecified or set to STATUS_FORMAT_LONG.
> 
> So if you do this:
> 
>     $ git reset --hard HEAD
>     $ >a-new-file && git add a-new-file
>     $ git commit --dry-run --short; echo $?
> 
> you'd get "No, there is nothing interesting to commit", which is
> clearly bogus.
> 
> I said s->committable is flipped on only when there is any change in
> "diff-index --cached".  There is nothing that flips it off, by
> noticing that there are unmerged paths, for example.  This is
> another brokenness around "git commit --dry-run".  Imagine that you
> are in a middle of a conflicted cherry-pick.  You did "git add" on a
> resolved path and you still have another path whose conflict has not
> been resolved.  If you run a "git commit --dry-run", you will hear
> "Yes, you can make a meaningful commit", which again is clearly
> bogus.
> 
Makes sense.

> These things need to be eventually fixed, and I think the fix will
> involve revamping how we compute s->committable flag.  Most likely,
> we won't be doing any of that in any wt_status function whose name
> has "print" or "show" in it.  As the original designer of the wt_*
> suite (before these multiple output formats are added), I would say
> everything should happen inside the "collect" phase, if we wanted to
> make s->committable bit usable.
Tonight I started work on a patch to remove the two locations where 
committable was set in  the *print* and *show* functions.  

I believe that what you mean by the "collect" phase is the set of functions 
that are in wt_status.c and have collect in the function name.

> 
> So in the sense, eventually the code updated by this patch will have
> to be discarded when we fix the "commit --dry-run" in the right way,
> but in the meantime, the patch does not make things worse, so let's
> think about queuing it as-is for now as a stop-gap measure.
> 
I'm happy with moveing the patch from pu (where it is now) to next.   I've
re-started my work on this.

> Thanks.
