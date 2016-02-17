From: Stephen & Linda Smith <ischis2@cox.net>
Subject: Re: [PATCH] wt-status.c: set commitable bit if there is a meaningful merge.
Date: Tue, 16 Feb 2016 21:58:15 -0700
Message-ID: <2247870.Eu9nZ6eGrl@thunderbird>
References: <72756249.nAoBccgOj7@thunderbird> <1455590305-30923-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Ovidiu Gheorghioiu <ovidiug@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 05:58:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVuBx-0005Fc-H8
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 05:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933658AbcBQE5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 23:57:43 -0500
Received: from fed1rmfepo102.cox.net ([68.230.241.144]:59785 "EHLO
	fed1rmfepo102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756053AbcBQE5m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 23:57:42 -0500
Received: from fed1rmimpo110 ([68.230.241.159]) by fed1rmfepo102.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20160217045741.JNV7752.fed1rmfepo102.cox.net@fed1rmimpo110>
          for <git@vger.kernel.org>; Tue, 16 Feb 2016 23:57:41 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo110 with cox
	id KGxg1s00Q2tqoqC01GxgiU; Tue, 16 Feb 2016 23:57:41 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020205.56C3FDC5.001B,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=MZeyTeDf c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=jFJIQSaiL_oA:10 a=kviXuzpPAAAA:8
 a=VwQbUJbxAAAA:8 a=6FwhlGHFbFm3aAnB3G0A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
 a=nhCt00SIBsryeqjw:21 a=SJbtdOW_pYyhywBj:21 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.localnet (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 1605813F83B;
	Tue, 16 Feb 2016 21:58:16 -0700 (MST)
User-Agent: KMail/5.0.2 (Linux/4.4.0-4-generic; KDE/5.15.0; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286482>

On Tuesday, February 16, 2016 07:33:54 PM Junio C Hamano wrote:
> "Stephen P. Smith" <ischis2@cox.net> writes:
> 
> > The 'commit --dry-run' and commit return values differed if a
> > conflicted merge had been resolved and the commit would be the same as
> > the parent.
> >
> > Update show_merge_in_progress to set the commitable bit if conflicts
> > have been resolved and a merge is in progress.
> >
> > Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> > ---
> 
> I think I mislead you into a slightly wrong direction.  While the
> single liner does improve the situation, I think this is merely a
> band-aid upon closer inspection.  For example, if you changed your
> "commit --dry-run" in your test to "commit --dry-run --short", you
> would notice that the test would fail.
> 
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
> These things need to be eventually fixed, and I think the fix will
> involve revamping how we compute s->committable flag.  Most likely,
> we won't be doing any of that in any wt_status function whose name
> has "print" or "show" in it.  As the original designer of the wt_*
> suite (before these multiple output formats are added), I would say
> everything should happen inside the "collect" phase, if we wanted to
> make s->committable bit usable.
> 
> So in the sense, eventually the code updated by this patch will have
> to be discarded when we fix the "commit --dry-run" in the right way,
> but in the meantime, the patch does not make things worse, so let's
> think about queuing it as-is for now as a stop-gap measure.
> 
Hmmmm....  that makes sense.   

Let me fix the commit message per what I told Philip and then 
I will start working on a rework of the commitable bit with 
this in mind as a follow on patch.  

> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
