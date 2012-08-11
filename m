From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: cherry-pick and 'log --no-walk' and ordering
Date: Fri, 10 Aug 2012 22:34:32 -0700
Message-ID: <CAOeW2eHz5un9cNoy-=7Y8=F_G6u-n8kk7kXGHQ+dKrHD8wW6BA@mail.gmail.com>
References: <CAOeW2eE=VcUs1YcWqqEUc6vM6jW9JaXzE-_tVWy48VtPzm_+wA@mail.gmail.com>
	<7vfw7uig13.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 07:35:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T04M6-0008Ii-1X
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 07:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293Ab2HKFed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Aug 2012 01:34:33 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46936 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab2HKFec (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2012 01:34:32 -0400
Received: by pbbrr13 with SMTP id rr13so3897593pbb.19
        for <git@vger.kernel.org>; Fri, 10 Aug 2012 22:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=muvKxfWomzkcGs/u3t2VFvMu45TNNFIP+pQsIAJ8Pic=;
        b=z6E4n9vnUQPcS1uFIgC573A3Xs3FDeT3jFe1F3nRIeuupxT9K2RG15VoRFKRyEWe33
         mtWmeNBrQoIa9I1OansZyBQpOq5FpoUAehHXQniRltW/Av8aOTDHRJJviM5lSSqCwC/H
         IlYqoFTN0gyQXf93At6imNljlakjsU0jF4EXWXNh0VyzM+Ot+yz3n1UbTlyRhq24DHze
         D6IIsU2rgHtvNsHQB5okqqJmF93XS3KsTaUT+5j0HDqxUneMtg6LmolerF7qMFrS3B5W
         LWv4Iyh3S2hfQr7vxbg4Y2VArI/a3cYi4thNhKySwJF/N7cFfz8mv+miI/7VOKNwqqvV
         M7aA==
Received: by 10.68.241.99 with SMTP id wh3mr3201000pbc.16.1344663272218; Fri,
 10 Aug 2012 22:34:32 -0700 (PDT)
Received: by 10.68.42.164 with HTTP; Fri, 10 Aug 2012 22:34:32 -0700 (PDT)
In-Reply-To: <7vfw7uig13.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203278>

On Fri, Aug 10, 2012 at 2:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>
>> There is also cherry-pick/revert, which I _think_ does not really want
>> the revisions sorted.
>
> Yes, I think sequencer.c::prepare_revs() is wrong to unconditoinally
> call prepare_revision_walk().
>
> It instead should first check the revs->pending.objects list to see
> if what was given by the caller is a mere collection of individual
> objects or a range expression (i.e. check if any of them is marked
> with UNINTERESTING), and refrain from going into the body of the
> preparation steps, which has to involve sorting.

Do you mean "has to involve sorting" as in "has to involve sorting in
order not to break current users of e.g. 'git log --no-walk
--branches'"  or "revision walking inherently involves sorting"? My
current working assumption is that it is the former.

I will make rev_info.no_walk a tri-state {walk, no-walk-sorted,
no-walk-unsorted}. The third state would be used from
cherry-pick/revert (and maybe git-show, although it should make no
difference). I would also expose the third state to rev-list's command
line, maybe as --no-walk=unsorted.

Actually, all but command-line parsing is done now and test seem fine,
with quite a small patch:
$ git diff --stat
 builtin/log.c    | 2 +-
 builtin/revert.c | 2 +-
 revision.c       | 5 +++--
 revision.h       | 6 +++++-
 4 files changed, 10 insertions(+), 5 deletions(-)

Did you see a problem with this approach, since you said that
sequencer shouldn't unconditionally call prepare_revision_walk()? I
can see that git-show needs to go through revs->pending.objects
because it handles tags and stuff, but cherry-pick/revert only seem to
need the revisions.

Martin
