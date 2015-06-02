From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 11/14] pull: teach git pull about --rebase
Date: Tue, 2 Jun 2015 19:26:06 +0800
Message-ID: <CACRoPnQiqkm0SS0TQ-ovbp+k1oyZ-d+SnSqE-+yForHJAgkn2w@mail.gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
	<1431961571-20370-12-git-send-email-pyokagan@gmail.com>
	<ea07c7ecec761a0bb2d9f4936a8d2411@www.dscho.org>
	<CACRoPnRvjyjtbdT4CY7f4kFqq1rTiksp7eUnpFza+h8ZAq-4gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 02 13:27:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzkL8-0006x5-6O
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 13:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757668AbbFBL0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 07:26:15 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:35327 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756256AbbFBL0I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 07:26:08 -0400
Received: by labko7 with SMTP id ko7so119217754lab.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 04:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YeQqRM9NbnjHYZ/xm8iqWJHPcdzCNfkn0hN81Cry8vw=;
        b=CiQU34koxNsBvQARiZpN0xjZfhI8lxV5U97KoH18toxx5wS2ZO+9/BYpA+R8nsSXOo
         UUaVJJ1YLlFe3xSClzYQkBdQcvoxahWewfXXJpUlXYEUDN57Zo7E9+CSoGWXLuyyIZ4a
         xrvGz4lCky6f2/m1D+/nBR1fqVsdp11bb3f34kYnCqb/Hxd0etLSN25Og67miYhrJQdL
         8atB5v9l1FVsErJNdxw5qgtOxFry6JWrM5kSswEMjOoRWqbhHm0qsDkuwJwiBh/x8PZn
         tthnn6Y89DQF+AzJK41Gl3M1vlZ40FiOfrqAVKMBayDi/bsFNr+V8Skh+LX08nOXogpy
         KqRA==
X-Received: by 10.112.42.16 with SMTP id j16mr25014464lbl.98.1433244366325;
 Tue, 02 Jun 2015 04:26:06 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Tue, 2 Jun 2015 04:26:06 -0700 (PDT)
In-Reply-To: <CACRoPnRvjyjtbdT4CY7f4kFqq1rTiksp7eUnpFza+h8ZAq-4gg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270524>

On Sun, May 31, 2015 at 4:18 PM, Paul Tan <pyokagan@gmail.com> wrote:
> On Tue, May 19, 2015 at 9:04 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>> Also, I wonder if something like this would do the job:
>>         spec = parse_fetch_refspec(1, &refspec);
>>         if (spec->dst)
>>                 return spec->dst;
>
> Hmm, I notice that get_remote_merge_branch() only looks at the src
> part of the refspec. However, I guess it is true that if the dst part
> is provided, the user may be wishing for that to be interpreted as the
> "remote tracking branch", so we should be looking at it to calculate
> the fork point.
>
>>         if (!(remote = get_remote(remote_name)))
>>                 return NULL;
>>         if (remote_find_tracking(remote, spec))
>>                 return spec->dst;
>
> ... and if the dst part of the refspec is not provided, we fall back
> to see if there is any remote tracking branch in the repo for the src
> part of the ref, which matches the intention of
> get_remote_merge_branch() I think, while being better because
> remote_find_tracking() takes into account the actual configured fetch
> refspecs for the remote.
>
> However, we also need to consider if the user provided a wildcard
> refspec, as it will not make sense in this case. From my reading,
> remote_find_tracking(), which calls query_refspecs(), would just match
> the src part literally, so I guess we should explicitly detect and
> error out in this case.

With all that said, after thinking about it I feel that this patch
series should focus solely on rewriting git-pull.sh 1:1. While I do
agree with the above suggested improvements, I think they should be
implemented as separated patch(es) on top of this series since we
would be technically changing git-pull's behavior, even if we are
improving it.

As such, the issue that I think should be focused on for this patch
is: does get_merge_branch_1() and get_merge_branch_2() in this patch
implement the same behavior as get_remote_merge_branch() in
git-parse.remote.sh? If it does, then its purpose is fulfilled.

So, I'll keep the overall logic of get_merge_branch_2() the same for
the next re-roll. (Other than renaming the function and fixing code
style issues). Once this series is okay, I'll look into doing a
separate patch on top that changes the function to use
remote_find_tracking() so that we fix the assumption that the default
fetch mapping is used.

The other possibility is that we fix this in git-parse-remote.sh, but
I'm personally getting a bit tired from having to re-implement the
same thing in shell script and C. Furthermore, the only script using
get_remote_merge_branch() is git-pull.sh.

> [...]
> Since this is just a 1:1 rewrite I just tried to keep as close to the
> original as possible. However, thinking about it, since we *are* just
> using the first refspec for fork point calculation, I do agree that we
> should probably give an warning() here as well if the user provided
> more than one refspec, like "Cannot calculate rebase fork point as you
> provided more than one refspec. git-pull will not be able to handle a
> rebased upstream". I do not think it is fatal enough that we should
> error() or die(), as e.g. the first refspec may be a wildcard refspec
> that matches nothing, and the second refspec that matches one merge
> head for rebasing. This is pretty contrived though, but still
> technically legitimate. I dunno.
>[...]
>> We should probably `return error(_"No tracking branch found for %s@, refspec ? refspec : "HEAD");` so that the user has a chance to understand that there has been a problem and how to solve it.
>
> Just like the above, I don't think this is serious enough to be
> considered an error() though. Sure, this means that we cannot properly
> handle the case where the upstream has been rebased, but this is not
> always the case. We could probably have a warning() here, but I think
> the message should be improved to tell the user what exactly she is
> losing out on. e.g. "No tracking branch found for %s. git-pull will
> not be able to handle a rebased upstream."

Likewise, I won't introduce the error()s or warning()s for now.

Other than that, all other code style related issues have been/will be
fixed. Thanks for the reviews.

Regards,
Paul
