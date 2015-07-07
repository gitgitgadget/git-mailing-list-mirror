From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 18/23] checkout: retire --to option
Date: Tue, 7 Jul 2015 03:08:36 -0400
Message-ID: <CAPig+cSBp-U_jC3fcPXkZQ6kEPh7TRs2bAwKYQGGTtoGR3UYeg@mail.gmail.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
	<1436203860-846-19-git-send-email-sunshine@sunshineco.com>
	<xmqqh9physyu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 09:08:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCMzk-0000JI-Vv
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 09:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701AbbGGHIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 03:08:40 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:34374 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494AbbGGHIh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 03:08:37 -0400
Received: by ykfy125 with SMTP id y125so170290558ykf.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 00:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gCD7xnSvaR5PkUhGq5/4o5jToD92fO9tI20Lr7HYZJA=;
        b=zuaAm1CzoplzDui+xDXBx1iF1Ca30d2t1k5EBlIOSwMoZ42+I6DCpzXzWITHhkiHzv
         wwYke0crXcKayoOpSyDnGS1TnZDv2B4Ufj1Z81oVxUUrkZwCdDbP3uQe+7qfWZxoQFID
         YnSvKA6Tf/dH2fvJrpZs34TQicVXL+iODAAKlXvTHXgRCyHphcVpohEyIXspRtJBubmr
         udh49CGuDH1+NKKTgAN3pSGwQeZNR4kIn6oktN8yge3e189+kHvl8UpbNlkDzEp4YMyt
         4C+MQuYzNk0qtbpGe0qu1q/1M/KSKg1WAisSTY8LcLbjOQWlT1gZpdGpxoW1/3lFk9+n
         J4nA==
X-Received: by 10.13.207.1 with SMTP id r1mr3265191ywd.166.1436252916799; Tue,
 07 Jul 2015 00:08:36 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 7 Jul 2015 00:08:36 -0700 (PDT)
In-Reply-To: <xmqqh9physyu.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: Ryrf7aHaOC_MF6ui5GHZSUjfRrA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273482>

On Mon, Jul 6, 2015 at 3:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> Now that "git worktree add" has achieved user-facing feature-parity with
>> "git checkout --to", retire the latter.
>> [...]
>> This effectively reverts changes to checkout.c by 529fef2 (checkout:
>> support checking out into a new working directory, 2014-11-30) with the
>> exception of merge_working_tree() and switch_branches() which still
>> require specialized knowledge that a the checkout is occurring in a
>> newly-created linked worktree (signaled to them by the private
>> GIT_CHECKOUT_NEW_WORKTREE environment variable).
>
> I do not quite understand why we still need the hidden environment
> variable.  Is this a sign that the implementation is shared too much
> between unrelated codepaths (or to put it another way, perhaps API
> functions that are not best fit are being used)?

Duy had responded[1][2] to my inquiry about these two remaining bits
of checkout.c code with intimate knowledge of the initial
linked-worktree checkout (merge_working_tree & switch_branches), but I
don't know the checkout code well enough (yet) to fully understand his
responses or to answer your question satisfactorily. This is also why
I was afraid to rip out those final two bits of code, even though in
my own testing, having ripped them out locally, I was unable to
trigger any sort of "bad" behavior, as far as I could tell. Thus, I
wasn't sure if those two bits of code were needed, and was hoping
someone more qualified (Duy, for instance) would be able to provide a
more authoritative answer.

Having now re-read and finally digested Duy's response about
switch_branches(), when I rip out the `new_worktree_mode` check
locally, I find that I can trigger the misleading warning about an
orphaned commit, so that bit of code still serves a practical purpose.
This doesn't justify that such ugly intimacy between git-worktree and
git-checkout is desirable; only that it still seems to be needed until
"git reset --hard" can be swapped in to replace "git checkout".

[1]: http://article.gmane.org/gmane.comp.version-control.git/273225
[2]: http://article.gmane.org/gmane.comp.version-control.git/273226

> Stepping back a bit, with or without the new "linked worktree"
> feature, when you came across a repository whose working tree does
> not have any file (i.e. somebody ran "git ls-files | xargs rm"), you
> do not know and care what is in .git/index right now, you do not
> know and care what branch its .git/HEAD points at, but you *do* know
> what branch you want to be on (or where you want its HEAD detached
> at), what would be the command you would use?
>
> The state immediately after a new worktree is constructed by
> populating /path/main/.git/worktrees/test-next/ and pointing it from
> /path/other/test-next/.git but before the index or the files under
> /path/other/test-next/ are populated is exactly that situation, no?
> Wouldn't "symbolic-ref HEAD the-branch-i-want" (or "update-ref HEAD
> the-commit-i-want" in the detached case) followed by "reset --hard"
> the more natural thing to use, instead of merge-working-tree and
> switch-branches that are implementation details of "checkout"?

It seems so to me. I didn't repeat it in the v3 cover letter, but the
v2 cover letter said this (which still holds true for v3):

    v2 does not attempt either of the suggestions by Junio[*3*] or
    Duy[*4*] for eliminating git-checkout from the equation, which
    would allow us to remove the final couple bits of code in
    git-checkout which require intimate knowledge that the checkout
    is occurring in a newly created linked worktree. This series is
    already too long, and I didn't want it to grow further by
    implementing either of those ideas. Instead, this series leaves
    git-worktree at a state where one or the other of those
    suggestions can be done as follow-on patches touching only the
    underlying machinery, without affecting the user-facing
    interface.

    [*3*]: via private email which suggested using "git-reset --hard"
           rather than "git checkout" to populate the new linked
           worktree.
    [*4*]: http://thread.gmane.org/gmane.comp.version-control.git/273032/focus=273226

In order to use "git reset --hard" in place of "git checkout",
git-worktree will need to handle -b/-B, --detach, --force (and
possibly --track and --orphan) itself. I'm still in the process of
familiarizing myself with the code needed to perform those actions, as
well as whatever else is needed to make "git reset --hard" a reality,
so I am not yet in a position to say now much time or work will be
required to swap out "git checkout" for "git reset --hard". As such, I
didn't want to hold up the series for an unknown amount of time while
studying the issue; and, as the series stands, the remaining ugly
intimate knowledge between git-worktree and git-checkout is
behind-the-scenes and localized (not affecting the user experience).
