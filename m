From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 0/6] Fix checkout-dash to work with rebase
Date: Tue, 18 Jun 2013 15:00:38 +0530
Message-ID: <CALkWK0nGeyna_vxnN0RMULRj3sEj3v=Q61cXrHDYDHYv-nZ4sg@mail.gmail.com>
References: <1371372316-16059-1-git-send-email-artagnon@gmail.com>
 <7v1u81ibjp.fsf@alter.siamese.dyndns.org> <7vk3lsei4i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 11:31:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UosG6-0005ct-2E
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 11:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125Ab3FRJbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 05:31:21 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35351 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755519Ab3FRJbT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 05:31:19 -0400
Received: by mail-ie0-f177.google.com with SMTP id aq17so8479213iec.8
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 02:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=u74ZL5t0EaNCCM6VRy9hxchIa7IDTAkalaucXifyOCI=;
        b=LqKE7iaFMjf9t3A9+eg+pJant20Q6DZFS34FoykdW5aF4DJmEy8ibcCtiLz8fhZv1T
         RF1y0bI9vkd0A6ERDTPGwKsrQzZ7bHeRZOzzoRkBKX6lUWbzZVxb4a5qfjV8ByGS3a7c
         bHVLg95Vv09hGqiJ2SqihDKI3lXQNLyC5IFpXJY8Ue8Tje3vhZGKwOFkpV39VZ5t8XTz
         L9iTN4rtY3LVQkQ3ApaeQUPCfVvWFqxw8ck30m66QWSO3GweR4M/YHpwUFBvFbtqPDhw
         U8bqPZ57iZAGxYF5ZsRV3czfJP3npuicRM8t882Cmm4JcjPFeBJCrF8mdgfnx1FCB6vU
         s1Ng==
X-Received: by 10.50.79.231 with SMTP id m7mr7010875igx.40.1371547879001; Tue,
 18 Jun 2013 02:31:19 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 02:30:38 -0700 (PDT)
In-Reply-To: <7vk3lsei4i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228179>

Junio C Hamano wrote:
> I actually tried to reorder the patches and they seem to work OK as
> expected.  And I think it makes sense to order them the way I've
> been suggesting, so I'll tentatively queue the result of reordering
> on 'rr/rebase-checkout-reflog' and push it out as a part of 'pu'.
>
> Please check to see if I introduced a new bug while doing so.

Thanks for the reorder and commit message tweaks.  I'm working on the
series you put up on `pu` now.

> For example, the one in "git reabse" does this:
>
>     GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
>     git checkout -q "$onto^0" || die "could not detach HEAD"
>     git update-ref ORIG_HEAD $orig_head
>     ...
>     run_specific_rebase
>
> But the specific rebase, e.g. git-rebase--interactive, does this:
>
>         case $head_name in
>         refs/*)
>                 message="$GIT_REFLOG_ACTION: $head_name onto $onto" &&
>                 git update-ref -m "$message" $head_name $newhead $orig_head &&
>                 git symbolic-ref \
>                   -m "$GIT_REFLOG_ACTION: returning to $head_name" \
>                   HEAD $head_name
>                 ;;
>         esac && {
>
> I think the message you added to "git reabse" is only meant for that
> specific "checkout $onto", but it is set globally.  Wouldn't it
> affect later use, which expected it to be "rebase" and nothing else?

Both rebase.sh and rebase--interactive.sh set a sane GIT_REFLOG_ACTION
right on top (using set_reflog_action), so no worries.  I'll just
double-check to make sure that no bogus/ incorrect messages are
printed.

> Perhaps something like this on top of the entire series may be
> sufficient (which will be queued as "SQUASH???" at the tip).

I think this takes the wrong approach to the problem.  In my opinion,
the correct approach is to actually overshadow die() with a function
that clears GIT_REFLOG_ACTION before calling die().

>         git grep -C2 'git checkout' -- git-rebase\*.sh

Ugh.  I'll check all the codepaths thoroughly before submitting a re-roll.

Thanks.
