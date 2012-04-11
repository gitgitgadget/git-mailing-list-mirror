From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v3 1/4] git-cherry-pick: add allow-empty option
Date: Wed, 11 Apr 2012 14:29:27 -0400
Message-ID: <20120411182927.GA24833@hmsreliant.think-freely.org>
References: <1334072868-9435-2-git-send-email-nhorman@tuxdriver.com>
 <7v62d7qzu9.fsf@alter.siamese.dyndns.org>
 <20120410181317.GA17776@hmsreliant.think-freely.org>
 <7vfwcbpem5.fsf@alter.siamese.dyndns.org>
 <20120410200019.GC17776@hmsreliant.think-freely.org>
 <7v8vi3pbtf.fsf@alter.siamese.dyndns.org>
 <20120410203944.GA12139@hmsreliant.think-freely.org>
 <7v4nsrpa4i.fsf@alter.siamese.dyndns.org>
 <20120411004419.GA19616@neilslaptop.think-freely.org>
 <7v62d6mcsa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 20:29:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI2IY-0000JO-DU
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 20:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760647Ab2DKS3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 14:29:37 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:36194 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695Ab2DKS3g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 14:29:36 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SI2IK-000438-UZ; Wed, 11 Apr 2012 14:29:31 -0400
Content-Disposition: inline
In-Reply-To: <7v62d6mcsa.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195232>

On Wed, Apr 11, 2012 at 09:52:21AM -0700, Junio C Hamano wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > No, you covered all the cases, but I disagree with your assertion that the advice
> > is correct (or at least optimal) in any of these cases. If a cherry-pick without
> > any options is preformed and the commit is empty (regardless of the reason), the
> > advice given is that git commit --allow-empty should be used.  With the addition
> > of these new options, thats not true any longer.  Instead of using git commit
> > --allow-empty, you can use git cherry-pick --allow-empty.
> 
> Sorry, I am confused.  Do you mean that the sequence goes like this (with
> concrete examples of command line args)?
> 
> 	$ git cherry-pick nh/empty-rebase
>         ... stops because "git show nh/empty-rebase" is empty
>         $ git cherry-pick --allow-empty
> 

No, currently what happens is the following:
$ git cherry-pick nh/empty-rebase
       ... either gets accepted as empty if the cherry-pick qualifies for
fast-forward, or stops if it doesn not, indicating the empty_cherry_pick advice
that git commit --allow-empty should be used.

While that advice is accurate, in that a git commit --allow-empty will accept
the empty commit, it would seem (at least to me) preferable to offer guidance
that git cherry-pick should be used instead in this case, because that is the
command the user was issuing.

> But that cannot be correct, without --continue [*1*], i.e.
> 
> 	$ git cherry-pick --allow-empty --continue
> 
> no?  I didn't check, but if the command without --continue in the above
> sequence does not error out, I think it is a bug.
> 
No, it errors out.  I'm sorry to have confused you.  The only point that I was
trying to make here is that, when running git cherry-pick, its seems awkward to
a user to get advice indicating that git commit --allow-empty should be run.  My
change was intended to resolve that so that advice no how to use cherry-pick
options to avoid the error was  issued instead.  Thats all.  I hadn't considered
the fact that manual resolution of a cherry-pick (where getting advice about git
commit makes more sense) was also a factor here

> I am actually OK with suggesting "git cherry-pick --continue", but then
> "cherry-pick --allow-empty" (or "--keep-unnecessary-commits") that punts
> and gives the control back to the user should leave enough clue for a
> later invocation of itself so that it can realize that the original
> invocation was made with "--allow-empty".  In other words, I am OK if the
> interaction goes like this:
> 
> 	$ git cherry-pick --keep-unnecessary-commits nh/empty-rebase
>         ... stops due to a conflict
>         $ edit builtin/revert.c
>         ... the result ends up being empty
>         $ git add -u ;# resolved
>         $ git cherry-pick --continue
> 
No, Id rather not do that thanks.  The intent of these options we really to
automate the rebase process, so rebasing doesn't stop on empty commits.  Using
the model above seems to disagree with that.

> 
> [Side note]
> 
> *1* It was an original UI mistake to make the users conclude a "git merge"
> that asked the user to help resolving the conflict with "git commit",
> which was inherited by "git cherry-pick" and "git revert", especially when
> these three commands are merely a special "possibly zero or one stoppage"
> case of more general sequencing commands like "am" and "rebase" that can
> stop zero or more times to ask the user for help and the way to resume
> them is to re-run the same command with "--continue" option (and without
> any other arguments), e.g.
> 
> 	$ git am -3 ./+nh.mbox
>         ... stops due to conflict and asks to resolve them
>         $ edit builtin/revert.c
>         $ git add builtin/revert.c
>         $ git am --continue
> 
> and also discussed that in the longer-term it would be nice to teach the
> oddball commands to honor "--continue".  "am" originally took "--resolved"
> (and it still does, and it will do so in the future) for the same purpose,
> and we taught it and "cherry-pick" and "revert" to honor "--continue".
> Probably we should start teaching "merge" to honor it as well to complete
> the vision.
> 
I won't pretend to fully understand the implications of what you said on your
side note here, but yes, from the ways I've used merge in the past, allowing it
to continue would be very nice I think.
Neil
