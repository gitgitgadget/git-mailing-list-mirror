From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/21] Support multiple worktrees
Date: Sun, 22 Dec 2013 15:44:52 +0700
Message-ID: <CACsJy8DL5=B=jch6j6g_3xj3KRsLXxwMChVHF9MUFvafhWhYag@mail.gmail.com>
References: <CACsJy8BV6uerMyHNHviL0Jy8s+_jca8NM-hVfnM=u4cr-=JX1Q@mail.gmail.com>
 <xmqq7gaze00k.fsf@gitster.dls.corp.google.com> <CACsJy8DuXbCTjcVJNH=w6h3zgo0sxRgMfSQXZFtngYy2FLJTDg@mail.gmail.com>
 <7vvbyhjsp4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 22 09:45:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuefV-0000ok-1L
	for gcvg-git-2@plane.gmane.org; Sun, 22 Dec 2013 09:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286Ab3LVIp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Dec 2013 03:45:26 -0500
Received: from mail-qe0-f50.google.com ([209.85.128.50]:42058 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135Ab3LVIpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Dec 2013 03:45:25 -0500
Received: by mail-qe0-f50.google.com with SMTP id 1so4070675qec.23
        for <git@vger.kernel.org>; Sun, 22 Dec 2013 00:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mRfChaS5N3wx4MS0d2Xo0rXsmacJt6+7sCiZHvq9sG4=;
        b=U4H8ODwSivL3REJgCQzdYf/mSHNHsFOTpnivkCVn2iAddIpRR6W3snHGGb9SNmL08I
         CCca2epB+8y6uKkweTG0zVRsuqpJJpOrrYBQWv1wcxhoREsaL6I8V2HjSXZW2HimXfY+
         Dqy4bo56R8s6NYkDvLH/2cr4DBYSriHaykdNtsg5d56vgiPzrvdCfTiZsTmb6BZkfVVX
         YicKo6tNQikAqjTKc6cNt0Y0cbGAiDhtOfa7pFzJfRoi+CJcjsxl6ZH7Xj+WrDGTChxO
         Fl0vdjCWBxRCjayGlgbV0JH9DQ/iuXyHxTwKYZ8LdMl4Pl3obDKGXPnDzjAw1qPzUzuI
         Frtg==
X-Received: by 10.49.12.102 with SMTP id x6mr31104034qeb.5.1387701922408; Sun,
 22 Dec 2013 00:45:22 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Sun, 22 Dec 2013 00:44:52 -0800 (PST)
In-Reply-To: <7vvbyhjsp4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239640>

On Sun, Dec 22, 2013 at 1:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>>> I am not happy with the choice of "main/HEAD" that would squat on a
>>> good name for remote-tracking branch (i.e. s/origin/main/), though.
>>> $GIT_DIR/COMMON_HEAD perhaps?
>>
>> It's not just about HEAD. Anything worktree-specific of the main
>> checkout can be accessed this way, e.g. main/index,
>> main/FETCH_HEAD.... and it's not exactly "common" because it's
>> worktree info. Maybe 1ST_ as the prefix (e.g. 1ST_HEAD, 1ST_index...)
>> ?
>
> Do we even need to expose them as ref-like things as a part of the
> external API/UI in the first place?  For end-user scripts that want
> to operate in a real or borrowing worktree, there should be no
> reason to touch this "other" repository directly.  Things like "if
> one of the wortrees tries to check out a branch that is already
> checked out elsewhere, error out" policy may need to consult the
> other worktrees via $GIT_COMMON_DIR mechanism but at that level we
> have all the control without contaminating end-user facing ref
> namespace in a way main/FETCH_HEAD... do.

No, external API/UI is just extra bonus. We need to (or should) do so
in order to handle $GIT_COMMON_DIR/HEAD exactly like how we do normal
refs. Given any ref, git_path(ref) gives the path to that ref,
git_path("logs/%s", ref) gives the path of its reflog. By mapping
special names to real paths behind git_path(), We can feed
$GIT_COMMON_DIR/HEAD (under special names) to refs.c and it'll handle
correctly without any changes for special cases.

> You said
>
>     This makes it possible for a linked checkout to detach HEAD of
>     the main one.
>
> but I think that is misguided---it just makes it easier to confuse
> users, if done automatically and without any policy knob. It instead
> should error out, while saying which worktree has the branch in
> question checked out. After all, checking out a branch that is
> checked out in another worktree (not the common one) needs the same
> caution, so "main/HEAD" is not the only special one.
>
> And if your updated "git checkout 'frotz'" gives a clear report of
> which worktree has the branch 'frotz' checked out, the user can go
> there to detach the HEAD in that worktree to detach with
>
>         git -C $the_other_one checkout HEAD^0
>
> if he chooses to.

Jonathan mentions about the "checkout in portable device" case that
would make the above a bit unnatural as you just can't "cd" there (git
update-ref still works).

I don't see any problems with checking out a branch multiple times. I
may want to try modifying something in the branch that will be thrown
away in the end. It's when the user updates a branch that we should
either error+reject or detach other checkouts. I guess it's up to the
user to decide which way they want. The error+reject way may make the
user hunt through dead checkouts waiting to be pruned. But we can
start with error+reject then add an option to auto-detach.
-- 
Duy
