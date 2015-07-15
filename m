From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 00/16] worktree: use "git reset --hard" to populate worktree
Date: Wed, 15 Jul 2015 02:48:17 -0400
Message-ID: <CAPig+cTXAdGFmq+QkNAgmHJuZgM6-Ckg_-StrTQUxmJSpX4=Qg@mail.gmail.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
	<xmqqsi8rzyzo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 08:48:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFGUa-00050P-Vp
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jul 2015 08:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839AbbGOGsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2015 02:48:22 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:35402 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711AbbGOGsS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2015 02:48:18 -0400
Received: by ykdu72 with SMTP id u72so28465835ykd.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 23:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FAeGt5bkYvFFWZkFTTEld/OIosuUisrnLcHe62NGcRI=;
        b=PLVtVi5sbqcUDgKpQBmrrkAuge1L1x7GWE5LOvSt6JROFylJ/15oJZhkChD5t6V+rO
         4DHxuAnBErTiL9edaL3q4iDSJN85msoUpdOLLx5+Xt8WeBkkpoLbcJ+5ODSSMiGUUyGY
         1z6g9ghC7zDyQXSIs+znvHYh5JFNVO8fPzHAJpGSf7wbEka9sT4kdYCnYrcUj3t8SUSy
         YXIBhW4YM6m6lP3AL7y5vpr0jkhq4zCEvOTKYO1oBmnMayOxfHTEl8jPiQpwkFxKwwlf
         r4lyGE82QLOzYErZgVWv9nmapsM/c0qz0PjidMLIMz/zCN5yBgjlD0zytXSOv/Qoax7P
         e4dw==
X-Received: by 10.170.138.134 with SMTP id f128mr2657702ykc.90.1436942897777;
 Tue, 14 Jul 2015 23:48:17 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 14 Jul 2015 23:48:17 -0700 (PDT)
In-Reply-To: <xmqqsi8rzyzo.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: PBoFrpYU2HCwpaEOum7aT5K1U-Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273980>

On Mon, Jul 13, 2015 at 2:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> This series eliminates git-checkout from the picture by instead
>> employing "git reset --hard"[2] to populate the new worktree initially.
>
> A few comments on things I noticed while reading (mostly coming from
> the original before this patch series):
>
>  - What does this comment apply to?
>
>         /*
>          * $GIT_COMMON_DIR/HEAD is practically outside
>          * $GIT_DIR so resolve_ref_unsafe() won't work (it
>          * uses git_path). Parse the ref ourselves.
>          */
>
>    It appears in front of a call to check-linked-checkout, but I
>    think the comment attempts to explain why it manually decides
>    what the path should be in that function, so perhaps move it to
>    the callee from the caller?

The placement of the comment in the original code wasn't bad, but
after patch 3/16 moves code around, the comment does become somewhat
confusing, so moving it to the callee seems a reasonable idea.

>  - check_linked_checkout() when trying to decide what branch is
>    checked out assumes HEAD is always a regular file, but I do not
>    think we have dropped the support of SYMLINK_HEAD yet.  It needs
>    to check st_mode and readlink(2), like resolve_ref_unsafe() does.

Hmm, I wasn't aware of SYMLINK_HEAD (and don't know if Duy was). The
related code in resolve_ref_unsafe() is fairly involved, worrying
about race conditions and such, however, I guess
check_linked_checkout()'s implementation can perhaps be simpler, as
it's probably far less catastrophic for it to give the wrong answer
(or just die) under such a race?

>  - After a new skelton worktree is set up, the code runs a few
>    commands to finish populating it, under a different pair of
>    GIT_DIR/GIT_WORK_TREE, but the function does so with setenv(); it
>    may be cleaner to use cp.env[] for it, as the process we care
>    about using the updated environment is not "worktree add" command
>    we are running ourselves, but "update-ref/symbolic-ref" and
>    "reset" commands that run in the new worktree.

After sending the series, I was realized that this could be done more
cleanly with -C, but that would have to be repeated for each command,
so cp.env[] might indeed be a better choice.

> Other than that, looks nicely done.
>
> I however have to wonder if the stress on "reset --hard" on log
> messages of various commits (and in the endgame) is somewhat
> misplaced.
>
> The primary thing we wanted to see, which this series nicely brings
> us, is to remove "new-worktree-mode" hack from "checkout" (in other
> words, instead of "reset --hard", "checkout -f" would also have been
> a satisfactory endgame).

I'll see if the commit messages can be reworded a bit without becoming
too wordy. ("git reset --hard" has a nice conciseness.)
