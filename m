From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stgit: bunch of bugreports/wishes
Date: Mon, 26 Jun 2006 22:04:07 +0100
Message-ID: <b0943d9e0606261404s38d4e316ja1af671f2d0d6e73@mail.gmail.com>
References: <20060622221425.GA7851@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 26 23:04:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuyFm-0004KM-Ni
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 23:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933031AbWFZVEN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 17:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933037AbWFZVEL
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 17:04:11 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:50310 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S933031AbWFZVEI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 17:04:08 -0400
Received: by nz-out-0102.google.com with SMTP id 12so1472400nzp
        for <git@vger.kernel.org>; Mon, 26 Jun 2006 14:04:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LvHtF4LJ4WV0w1xLhF2tSLzS69E13IBIxI5E85qf1QyF7y9CB5MPDWmIXd4SsddOlgU3oZPlHxJQQWfkyeuhQorSZE2gcI/IOUtLpBXuqgncxzNMi5HhyXZ04qzsoAqJwOpQLXBkyVbhBfM8cfkKTaAT4D3WEkEGmSd34w5LoCU=
Received: by 10.36.133.20 with SMTP id g20mr4617210nzd;
        Mon, 26 Jun 2006 14:04:07 -0700 (PDT)
Received: by 10.36.250.28 with HTTP; Mon, 26 Jun 2006 14:04:07 -0700 (PDT)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20060622221425.GA7851@nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22679>

On 22/06/06, Yann Dirson <ydirson@altern.org> wrote:
> Here are a number of problems I encountered while playing with
> uncommit with 0.10:

"uncommit" was really intended as generating some simple patches from
a linear list of commits (maybe for undoing a "stg commit" or after a
git-am to modify some patches before pushint upstream). History
re-writing is somehow outside StGIT's goals.

> - uncommit ignores grafts.  This causes "uncommit -n" to through
> "graft merges" without asking, and surely gives unexpected result
> when a graft is used to change an ancestor rather than adding one.
[...]

I could fix "uncommit" to fail at this point but, as I said above, I
wouldn't add extra features to this command.

Maybe you can explain your workflow a bit as I don't see the need for
mass uncommitting.

> - uncommit could be more flexible to help with mass-uncommitting,
> eg. with something like "--to <commit>" (to avoid counting manually),
> or "--to-merge" to cleanly stop on first merge instead of failing
> there.  This may have an impact on how uncommits are numbered.
>
> - uncommit synopsis is incomplete (lacks " | -n <n> <basename>")
>
> - after mass-uncommitting, more help to look at the stack would be
> needed.  Eg. a "stg series" flag to print more commit info (author,
> files), or to limit the listing to a given author (like "stg patches"
> limits for a file).

These would be good indeed. I also had a plan to generate the patch
name from the subject line (i.e. replacing the spaces with a dash) to
be more meaningful. But got really busy with my job recently and
didn't have time.

> - when a push is not committed because of a conflict, looking at the
> previous diff for the patch would help.  Maybe something like "stg
> show --old" ?

"stg show <patch>//top.old" should show it (well, with a bit more
typing than --old).

> - the help string for push should say "patches", and possibly document
> more precisely the syntax, something like:

I plan to change the syntax of push a bit to allow things like
patch1..patch2 without the --to option (the latter would still be
there but taking a single patch).

> -help = 'push a patch on top of the series'
> -usage = """%prog [options] [<patch1> [<patch2>...]]
> +help = 'push patches on top of the series'
> +usage = """%prog [options] [<patch1> [<patch2>...] | -n <n> <patchroot>]

Does the <patchroot> syntax work?

> - "push --undo" is not robust.  On the occasion reproduced below, I
> had to rollback the push myself by hand-modifying the stgit data,
> which took me some effort.  I'll have to gather precise info, but the
> issue occurs on patch reordering, on a genuine conflict, and seems to
> be involve a change to a non-existent file, when that file would have
> been added by a non-applied patch originally below the one I attempted
> to apply.
[...]
> ydirson$ stg push --undo
> Undoing the "patch10" push...stg push: ['git-diff-index', 'HEAD', 'path/to/the/file.java'] failed (fatal: ambiguous argument
> 'path/to/the/file.java': unknown revision or path not in the working tree.
> Use '--' to separate paths from revisions)

I got this problem as well. StGIT needs fixing but I think a quick
workaround is to create an empty file (touch patch/to/the/file.java)
before the undo and git-diff-index will be happy.

Thanks for the bug reports/suggestions.

-- 
Catalin
