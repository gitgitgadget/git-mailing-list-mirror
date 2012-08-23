From: Mina Almasry <almasry.mina@gmail.com>
Subject: Re: Feature request - discard hunk in add --patch mode
Date: Wed, 22 Aug 2012 23:32:02 -0400
Message-ID: <1345692722.6059.40.camel@mina-asus>
References: <BLU0-SMTP37070ADBEC060E1EA15944693B60@phx.gbl>
	 <87txw41okl.fsf@thomas.inf.ethz.ch>
	 <7vvcgk58le.fsf@alter.siamese.dyndns.org>
	 <7vmx1w56z1.fsf@alter.siamese.dyndns.org>
	 <BLU0-SMTP112EF6B9308C55734C4F10293B60@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Mina Almasry <almasry.mina@hotmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 05:33:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4OAU-00069S-IU
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 05:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078Ab2HWDcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 23:32:10 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37207 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754098Ab2HWDcI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 23:32:08 -0400
Received: by ialo24 with SMTP id o24so560266ial.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 20:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:x-mailer:content-transfer-encoding:mime-version;
        bh=54wEaxj6A65diLVFuotD8UJ/Ooc5HozAFACqPpnMy6c=;
        b=GfXr6u5qXveOlk5KbxJYzhMrfIHG7WtDpQk7jhLqYyUWxbIdGkMI13Lyl5p1qi1b1t
         z8kyIQ1CKhTZVNoSRru5Pm+RaWKe2v9KMex8IJKvzuNK+lRZ4RKuVd8Av9Y6MA2wp+cC
         ftuH7v8Ky7WxbyxvYC5xnbA4Y4Sdw27xs3/dnh6TLvlnl0qMSqOI+t0/fZwJotsbz8qo
         cpdizIjqesHjFMG9mZLq4DmkOUWfKrWUUvJ9dnbzdmlW+JUl/CSqzVDnlWZ/9CvVhMQD
         ndWnUpivAsgomM4bUHZ0VPkDv3CH+jG3YMUUpDyymNo6ZnQHXeTV64nn9Q9uwQe0bWWE
         3r6g==
Received: by 10.50.182.226 with SMTP id eh2mr4389834igc.69.1345692727184;
        Wed, 22 Aug 2012 20:32:07 -0700 (PDT)
Received: from [192.168.1.101] (user268.innisres.utoronto.ca. [142.151.169.12])
        by mx.google.com with ESMTPS id nh1sm20780428igc.11.2012.08.22.20.32.03
        (version=SSLv3 cipher=OTHER);
        Wed, 22 Aug 2012 20:32:04 -0700 (PDT)
In-Reply-To: <BLU0-SMTP112EF6B9308C55734C4F10293B60@phx.gbl>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204109>

Well I actually didn't know about stash -p when I asked for this, but I
still see room for us removing some more friction here:

>     # start from N-commit worth of change, debug and WIP
>     git stash save -p debug ;# stash away only the debugging aid
>     # now we have only N-commit worth of change and WIP
>     git stash save -p wip ;# stash away WIP
> 
> Then after that, you need N round of "git add -p && git commit".
> 
> Now, with what we have already, can we also give final testing
> before committing?  Each round may now start with:
> 
>     git add -p ;# prepare the index for the next commit
>     git stash save -k ;# save away the changes for later commits
> 
Here you have to _at least_ go through all your hunks once to stash the
debug code, once to stash the WIP, and once to add -p and commit.

Going through hunks is expensive... it takes quite a bit of time. Each
time you launch one of those commands you have to go through all hunks
you haven't decided on yet - could be a lot of hunks.

Now, what if we had a command where you would go through all your hunks
one, by one, and will give you an option to stage, stash, or discard
what you want as you please? In the above scenario, lets say N was 1,
then the scenario would be:

    # start from 1-commit worth of change, debug and WIP
    
    # stash debugging and WIP code, 
    # and stage the code you want to commit
    git mystery-command
    
    # everything done
    git commit

Then we would reduce 3 -p commands to 1 -p command.

Now what should this command be called? You resist making git-add unsafe
and I understand that. How about: 

  1. Give git add -p options that expose this extra functionality. So:

git add -p ; # can only stage code
git add -p --with-discard ; # does git add -p, plus discards hunks
git add -p --with-discard --with-stage ; # plus discard, plus stage

So in the hunks you can go:
  - discard; # and it would discard it
  - stage <stash>; # and it would stash it into <stash>

The argument I am making is that if a programmer explicitly asks for one
of those features then git will cooperate, and add becomes unsafe. We
are trusting that the programmer knows what they are doing. In all other
cases git add is the same, and will never touch the working tree.

We can also change git checkout -p and git stash -p so that they behave
the same:

  git stash -p --with-add; # does everything -p stash, and stages too
  git checkout -p --with-add; # does everything -p checkout, and stages

  2. We can come up with a whole new git command that does this.
Something like git patch-process

  # start from 1-commit worth of change, debug and WIP

  git patch-process ; # Stage, stash, and discard hunks as you please

  # ready for commit
  git commit

How does this sound?

PS: Newbish question: I am looking to help out with git, either with
this feature or others. How do I get around getting assigned a work to
do? Thanks.

Mina

On Wed, 2012-08-15 at 16:58 -0400, Mina Almasry wrote:
> On 12-08-15 02:46 PM, Junio C Hamano wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> Thomas Rast <trast@student.ethz.ch> writes:
> >>
> >>> This has come up before, and actually led to the introduction of
> >>> 'checkout -p' and 'reset -p':
> >>>
> >>>    http://thread.gmane.org/gmane.comp.version-control.git/123854
> >> That is a blast from the past.
> >>
> >> Why is saying "git checkout ." too much work, after "add -p" that
> >> you excluded the debugging cruft?
> > Please forget this question.  A better way in the form of "stash -p"
> > was suggested in the old thread to get rid of debug cruft in the
> > tree before an "add -p" session (or during a series of "add -p"
> > sessions).
> >
> > So is this still an issue?
> >
> >
> I read most of the thread, and I do think it still is. Here are my 2 cents:
> 
> 1. The alternative commands aren't nearly as time efficient:
>      - git checkout . is fast and awesome, but you can't use it if, for 
> example, you have to maintain a dirty         working tree
>      - git (stash|reset|checkout) -p make you go through (all|most) of 
> the hunks you have to hunt down             those 2 lines that say "echo 
> 'This line is runningantoeuhaoeuaoae'"
> 
> 2. All of the safety concerns can be alleviated with the right 
> interface. I am glad the u option mentioned in the thread did not go 
> through since I agree it is not ideal. However, if the command is:
>      (a) something with a '!', then no one will hit it by mistake, and
>      (b) the prompt makes it clear that work is lost
> then I think it would be fine
> 
> The advantages of a command like this are pretty huge IMO. I can see 
> this being a big time saver.
> 
> How about adding this to the git add -p prompt:
> 
>      r! - remove this hunk. The hunk is discarded from the working tree, 
> and is irrevocably lost.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
