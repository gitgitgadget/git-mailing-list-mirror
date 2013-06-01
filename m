From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: can we prevent reflog deletion when branch is deleted?
Date: Sat, 1 Jun 2013 15:17:58 +0530
Message-ID: <CALkWK0mwAc0bFon7B7nw1Nbvcwdf8m2_531qtrN-r28r9F+70Q@mail.gmail.com>
References: <CAMK1S_jY1tDCkyOamX8XNW9g8Dzf6yN9znwN6he-EVcOkBM1fQ@mail.gmail.com>
 <51A963B7.6060002@alum.mit.edu> <20130601050355.GA23408@sigill.intra.peff.net>
 <CALkWK0kcJH0t4i0BAPmMkNWwNzeJNdmg_wbt3ao-=R31kJ5noA@mail.gmail.com> <20130601090934.GA13904@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Elijah Newren <newren@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 01 11:48:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiiQX-00006U-Ic
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 11:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318Ab3FAJsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 05:48:42 -0400
Received: from mail-bk0-f41.google.com ([209.85.214.41]:47155 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932137Ab3FAJsk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 05:48:40 -0400
Received: by mail-bk0-f41.google.com with SMTP id jc10so1131821bkc.0
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 02:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=x8sYsElYQ3Ge5Di9lrb2Xi26KUVw1g0CVNeQMO1XuRY=;
        b=KL76KsksW0h+eZ80JL6SSv8nat3+8wTiBY207LQ2jLxGMijNGfDsO2fCn0XwjCNbji
         X/7V6C9Iw0yNyhcSd90h+qHhiP66wZRqlkM023Xvou0fAUkhAikswy5uWrh4pxo6JGh2
         2rphZGqHVBpUrOMpD18Uu3K3GRz7G88iQJjVMkQBWejv1Kl1n4z/Ze9UMIt/LsJIKKZd
         rRMoL0+Q8L1SOJOoDsqK1R3KDENlbMnHAcn74yjmECTG+ZTZjNyhTk+0JXgEuYI9OFOq
         uikqZx5Be7G9BXWQd2O+1giVo4eyr79vgK0kM9kkr4uvnlkgTyH552T9UxIeqOsqEiLq
         cMFw==
X-Received: by 10.204.240.79 with SMTP id kz15mr3324622bkb.112.1370080119057;
 Sat, 01 Jun 2013 02:48:39 -0700 (PDT)
Received: by 10.204.172.209 with HTTP; Sat, 1 Jun 2013 02:47:58 -0700 (PDT)
In-Reply-To: <20130601090934.GA13904@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226119>

Jeff King wrote:
> Why don't the branch names have significance? If I deleted branch "foo"
> yesterday evening, wouldn't I want to be able to say "show me foo from
> 2pm yesterday" or even "show me all logs for foo, so that I can pick the
> useful bit from the list"?

Oh, I misunderstood then.  I didn't realize that your usecase was actually

    git log foo@{yesterday}

where foo is a deleted branch.  Just to give some perspective, so we
don't limit our problem space:

I only ever batch-delete "cold" branches: if I haven't touched a
branch in ~2 months, I consider the work abandoned (due to disinterest
or otherwise) and remove it.  Most of my branches are short-lived, and
I don't remember branch names, much less of the names of the cold
branches I deleted.  My usecase for a graveyeard is "I lost something,
and I need to find it": I don't want to have to remember the original
branch name "foo"; if you can tell everything I deleted yesterday, I
can spot foo and the commit I was looking for.  The HEAD reflog is
almost good enough for me.

To be clear: I'm not against including branch name information; I just
don't want to _have_ to remember them to find what I'm looking for.

> Defining
> a new GRAVEYARD format would need an additional field for the ref name
> of each entry, but lets us drop the other naming complexities.

Certainly.  Putting it in the description will only lead to more
problems (like bugs in the @{<N>} parser).

> The HEAD reflog is not sufficient for two reasons:
>
>   1. Not all ref updates were part of the HEAD reflog (e.g.,
>      refs/remotes, tags).

Would be nice to solve, but it's not a big itch in my opinion.

>   2. It is not easy to see deduce which ref each entry comes from, which
>      makes "deleted_branch@{yesterday}" difficult. You can sometimes
>      deduce the branch by reading the surrounding entries (e.g., for
>      "checkout" entries), but I do not know offhand whether it can be
>      done reliably in all cases (I suspect not, given that unreachable
>      reflog entries may be pruned sooner than reachable ones, leaving
>      "holes" in the reflog's story).

Yeah, this makes sense.

> I do not necessarily disagree with your criticisms of the tooling around
> reflogs, but they are just not my interest right now, and I do not think
> working on one concept needs to hold up the other.

Oh, I didn't mean to hold up anything.  I brought it up because I
thought it would be of interest to heavy reflog users.
