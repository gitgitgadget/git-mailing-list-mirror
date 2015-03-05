From: Troy Moure <troy.moure@gmail.com>
Subject: Re: [BUG] Segfault with rev-list --bisect
Date: Wed, 4 Mar 2015 21:15:31 -0500
Message-ID: <CAMo-WNaS-at4oE2xS-07O=7R4VTXLrPeDJ84c_HbikXhN-W99g@mail.gmail.com>
References: <CAMo-WNYNeShbbhNfG455o7krGfY7_9zVU3dMpJ7b4Smh_AiATg@mail.gmail.com>
	<xmqq61ag72gc.fsf@gitster.dls.corp.google.com>
Reply-To: troy.moure@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 03:16:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTLKR-0005dq-8X
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 03:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754311AbbCECPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 21:15:51 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:43662 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000AbbCECPc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 21:15:32 -0500
Received: by lbvp9 with SMTP id p9so13177170lbv.10
        for <git@vger.kernel.org>; Wed, 04 Mar 2015 18:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=g4S3njvznlETsTqQ57WyygImdghxGeftcLZEQXcq2PQ=;
        b=ORPQC/0asShvDaZNV6xwgoRzLBgBKkl/Cw9SUHjELPt64fvUBurH5qfLvRrNsV3NlB
         Q4w/U/2oDzxeZMzzv7S7egfUhFCoCDvKTob1iMoSJ46LXbjyARQ87Le0tvdBpQRzerwa
         IKTS2BCt9E8F6nwddqDtNLcbbo7UXdLtVKlptWdBW8CkdKHhoTE35enoYauNXv7OkpUC
         CMbt4SXIjZTviG5NIOgtWaY34z9AaD1cRddJpVcGiTqH3M1tj41ZWGUGhhyO6yBiikVW
         Z+3Yyz221zG9C75loW4v/aa7N3sF0+zr6msZTtO2AC//znIX5/Nbuqe2dk2Y6Sa47PMj
         joLg==
X-Received: by 10.152.20.131 with SMTP id n3mr5723290lae.120.1425521731238;
 Wed, 04 Mar 2015 18:15:31 -0800 (PST)
Received: by 10.25.216.140 with HTTP; Wed, 4 Mar 2015 18:15:31 -0800 (PST)
In-Reply-To: <xmqq61ag72gc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264810>

On Wed, Mar 4, 2015 at 6:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Troy Moure <troy.moure@gmail.com> writes:
>
>> git rev-list --bisect --first-parent --parents HEAD --not HEAD~1
>
> Hmm, as "rev-list --bisect" is not end-user facing command (it is
> purely an implementation detail for "git bisect") and we never call
> it with --first-parent, I am not sure if it is worth labelling it as
> a BUG.  Surely, the command can refuse to operate when it sees both
> options given, but that would be a fairly low priority.

Hrm, ok. I didn't realize "--bisect" is only intended to be used by git-bisect
(although I suppose the fact that it treats ref/bisect/* specially should have
been a hint). If uses of "--bisect" other than by git-bisect are considered
unsupported, IMO it would be good to say that in the documentation - right now
it looks like just another rev-list parameter. (I realize rev-list itself is
"plumbing", but that's not the same as "not user facing", is it?)

If you're curious, I ran into this because I am working on a script that can be
run repeatedly to process commits, and uses git notes to mark commits that have
been processed.  Parents are always processed before their children, so if a
commit has a note, it means all its ancestors also have notes. I want to
quickly find the set of commits that have not yet been processed. I am thinking
of finding the "boundary" commits (commits that have a note and at least one
child that does not) by using a binary search to find the boundary commit on
the first-parent chain, and then recursively doing the same thing starting from
each non-first parent of each merge commit between the boundary commit and the
starting point.

Upon further thought, it's probably better to just read the whole first-parent
chain and do the binary search in the script, since "git rev-list --bisect"
would have generate the chain each time it's called. But I'd already run into
the segfault, so I thought I'd report it.

Of course, I'd appreciate any thoughts or comments on the problem I'm trying to
solve as well.

Thanks,
Troy
