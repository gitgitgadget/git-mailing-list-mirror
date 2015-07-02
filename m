From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Thu, 2 Jul 2015 13:06:25 -0400
Message-ID: <CAPig+cR1uLa7yiDn9EnTzfkDTOoToc6BTDRn5sYr12yPr6rXPg@mail.gmail.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
	<xmqqr3orakex.fsf@gitster.dls.corp.google.com>
	<CAPig+cRLpJK-C7MApH1vigZS=gmHNeo6RL3S2wXv4B-TFfnq4g@mail.gmail.com>
	<CACsJy8BdvLiM8Ki=N1k-fBrqqoEONhjwcN6jzGUk=3NPRRujQw@mail.gmail.com>
	<CAPig+cT=U6LxpJuUMaCd-x=gQPvh89SDNUo12+2_3uYb_q3=Og@mail.gmail.com>
	<CACsJy8Dce4ErwaRM7zTgLmRzcHxKOr4J8St46urettr5R4DbVg@mail.gmail.com>
	<CACsJy8CYtey9d6dFhf+bKCPe0aKzm1GNURDR0sJ4NNEmdZeLGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 19:06:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAhwY-00034n-VM
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 19:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbbGBRGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 13:06:30 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:36029 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736AbbGBRG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 13:06:27 -0400
Received: by ykdr198 with SMTP id r198so73849969ykd.3
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 10:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=bPXMmVll+YPBbA/GfGWi9koqDARtQbJU5AEd3YP+vq8=;
        b=j8Smqxp36uWFfyziEBEbe2Ef4Nox8QXtshzXM0H8J2Q6eaEuG+Dq51fUnNKjxDEFZb
         cXBTGJVPIdyr7+IXq58eH94gTkFpiY8YpMwmZ3WAvR9S3aC2ux89AvYtDfkJjC+laTOQ
         iV9T/4RA3NmH6PpWIXGzFhLctubXYtmIyOgQn3Y+Tc7LOqDzC87SD/+Q0CDuGm2AiZGv
         k/tPAuh+so4vh48Yf3/mVp7UFn6ODR6p9IMTjsZZHnsEuEvS4Io6gAlJ2DqxrflFV+R4
         0JrWH8bya0JGTd4NN2/1NZlcx7oPd0mo+YtG95retz4APSfbXGTI0TWVcr2mTHab/vH3
         z5Pw==
X-Received: by 10.13.207.1 with SMTP id r1mr39900113ywd.166.1435856786000;
 Thu, 02 Jul 2015 10:06:26 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 2 Jul 2015 10:06:25 -0700 (PDT)
In-Reply-To: <CACsJy8CYtey9d6dFhf+bKCPe0aKzm1GNURDR0sJ4NNEmdZeLGQ@mail.gmail.com>
X-Google-Sender-Auth: 5kWc-BiTyMqVwcLpa83KXZN5u1E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273247>

On Thu, Jul 2, 2015 at 8:50 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Jul 2, 2015 at 7:41 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> merge_working_tree:
>>>     tree = parse_tree_indirect(old->commit &&
>>>         !opts->new_worktree_mode ?
>>>             old->commit->object.sha1 :
>>>             EMPTY_TREE_SHA1_BIN);
>>
>> I think it's to make sure empty sha-1 is used with --to. If
>> old->commit->object.sha1 is used and it's something, a real two way
>> merge may happen probably with not-so-fun consequences. If it's empty
>> sha1, the effect is like "reset --hard", silent and reliable..
>>
>>> switch_branches:
>>>     if (!opts->quiet && !old.path && old.commit &&
>>>         new->commit != old.commit && !opts->new_worktree_mode)
>>>             orphaned_commit_warning(old.commit, new->commit);
>>
>> to suppress misleading warning if old.commit happens to be something.
>
> Actually you may be right about not reverting these. We prepare the
> new worktree with a valid HEAD, that would make "old" valid and may
> trigger things if "git checkout" is used to populate the worktree. To
> suppress those "things", we need new_worktree_mode or something
> similar.

Indeed. Since this is merely a private implementation detail, we don't
necessarily have to resolve the issue fully for the "checkout --to" to
"worktree add" conversion. It can be dealt with in a follow-on patch.

> Unless we want to borrow fancy checkout options for "git worktree
> add", we probably should just export checkout() function from clone.c
> and use it instead of "git checkout". Much more lightweight and
> simpler (it's one-way merge). Then we can revert checkout.c to the
> version before "--to".

Interesting idea, but doesn't this lose the ability to create a new
branch ("worktree add foo -b bar") and other useful options like
--track?
