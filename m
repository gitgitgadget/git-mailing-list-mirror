From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git workflow: how to achieve?
Date: Tue, 28 Apr 2009 17:00:10 +0200
Message-ID: <49F719FA.8050700@op5.se>
References: <20090428140248.31237.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 17:00:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyonO-0004l6-TJ
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 17:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760339AbZD1PAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 11:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753317AbZD1PAP
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 11:00:15 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:50462 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbZD1PAN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 11:00:13 -0400
Received: by fxm2 with SMTP id 2so600205fxm.37
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 08:00:12 -0700 (PDT)
Received: by 10.86.95.20 with SMTP id s20mr4470241fgb.26.1240930812244;
        Tue, 28 Apr 2009 08:00:12 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id l19sm3314325fgb.2.2009.04.28.08.00.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Apr 2009 08:00:12 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090428140248.31237.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117778>

George Spelvin wrote:
>>> We may have a language problem.  "very little detail" means almost no detail,
>>> an absence of details.  Did you mean "every little detail"?
>> No, I mean with very little detail. Usually when trying to answer a
>> question and I can't make sense of the question itself it's because
>> the person asking has already started down some road and entered into
>> a frame of mind which I cannot share. That mindset may not be correct
>> to solve the problem, so removing detail usually helps.
> 
> Ah, sorry, you wanted more abstract, not more concrete.
> 
>> "I'd like to automatically merge a bunch of branches and compile-test them
>> on every commit. How do I go about doing that?" is a much more open question
>> that invites to giving a lot more correct answers. Since you haven't asked
>> such a high-level question yet, I'm not sure what your need is, and therefore
>> I cannot help you find a suitable solution.
> 
> Okay, "I'd like to commit to somewhere further back in the history rather
> than HEAD, and have the HEAD automagically rebased".  How do I do that?
> 

Now we're talking.

If I were you, I'd do (assuming 'master' is upstream's head):

git checkout -b private/test master
git merge $all_feature_branches
# some sort of failure detected
git checkout $failed_topic
git rebase -i -p $(git merge-base HEAD master)
# select 'edit' for the commits you want to edit
git branch -D private/test
# goto 1


There may be even simpler workflows. I do not know.

>>> It actually came to mind recently during $DAY_JOB work, but let me give a
>>> concrete example based on the Linux kernel:
>>>
>>> I am running a customized Linux kernel.  On top of Linus's base,
>>> I have local patches to enable 64-bit DMA on the SB600 SATA controller,
>>> some local patches to make the RAID (md) code print out the locations
>>> of mismatches when verifying, the EDAC quilt series, a merge of the
>>> LinuxPPS code, a number of local patches to the LinuxPPS code (that
>>> I'm discussing with Rodolfo Giometti), and some revisions to the serial
>>> interrupt handler (that I'm discussing with Alan Cox).
>>>
>>> There's also the beginning of an ethernet driver that I'm trying to
>>> write, but it's going slow.
>>>
>>> Every week or two, I rebase all that on top of Linus's latest.  Plain
>>> rebase doesn't like the LinuxPPS merge, so I've been doing it manually
>>> in two parts.  Although rebase -p is apprently working much better than
>>> I remember.
>> This step is rather unnecessary unless there are changes to API's you
>> depend on. Doing a single rebase once you're done with the patch-series
>> would be far better and would, I expect, remove quite a lot of the
>> complexity you're experiencing.
> 
> *Frustration*  I'm somehow having trouble communicating.
> 
> I need to rebase it so I have a merged source tree that I can compile
> and test.  How else can I test Linus's latest plus my local changes?
> What alternative are you suggesting?
> 
> I want, AT ALL TIMES, to be running the kernel consisting of
> Linus's latest plus my various local hacks.  I want to be able to
> freely update any of the components that make up the result,
> and have the sum automatically recomputed for me.
> 

Just merge them in. You're going through an obscene amount of trouble
just to keep everything linear when there's no need for you to do so.

  git checkout private/test
  git merge master

to merge latest upstream stuff. If you get conflicts, you may have to
amend your patch-series with one or more extra commits to resolve those
conflicts, but there's no need to rebase them again if there are zero
conflicts (and all tests pass, ofcourse; Not all post-merge code
conflicts are caused by the actual merge algorithm).

If there are no new breakages or no new conflicts, there's no need to
rebase your topics again at this point.

>>> Currently, some patches get deeply buried in the stack and I have to
>>> do a lot of deep rebasing.
>> I'm not sure what you mean by "deep rebasing" or "stack", unless you've
>> started using topgit already (which, I believe, does patch-stacks).
>>
>> No patch should ever get "deeply buried" unless you do really, really
>> weird things with your topic-branches though. They *should* remain the
>> same each and every time.
> 
> I mean that the patch I want to edit is 20 or more patches back
> in history (I'm running 2.6.30-rc3-00063-gd3de9aa at the moment),
> so amending it involves a considerable amount of rebasing.
> 
> (Because I'm currently organized as a linear list of local
> patches on top of upstream.  I'd prefer separate feature
> branches plus merges, but that's what I'm asking how to make
> work efficiently.)

I think I answered this up above, but I'm superbly tired right now so
it's entirely possible I misunderstood one thing or another.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
