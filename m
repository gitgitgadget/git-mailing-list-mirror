From: John Keeping <john@keeping.me.uk>
Subject: Re: [BUG] rebase no longer omits local commits
Date: Mon, 7 Jul 2014 22:14:57 +0100
Message-ID: <20140707211456.GA2322@serenity.lan>
References: <53B57352.50202@tedfelix.com>
 <20140703190917.GE13153@serenity.lan>
 <20140703222501.GF13153@serenity.lan>
 <xmqqbnt1dpdk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Felix <ted@tedfelix.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 23:15:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4GFt-0006Nm-9v
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 23:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbaGGVPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 17:15:11 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:40415 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbaGGVPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 17:15:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 2B43D21846;
	Mon,  7 Jul 2014 22:15:08 +0100 (BST)
X-Quarantine-ID: <IcndTtbRu0iO>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IcndTtbRu0iO; Mon,  7 Jul 2014 22:15:07 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 26DA31FFC0;
	Mon,  7 Jul 2014 22:15:01 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqqbnt1dpdk.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252988>

On Mon, Jul 07, 2014 at 10:56:23AM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > Perhaps we shuld do something like this (which passes the test suite):
> >
> > -- >8 --
> > diff --git a/git-rebase.sh b/git-rebase.sh
> > index 06c810b..0c6c5d3 100755
> > --- a/git-rebase.sh
> > +++ b/git-rebase.sh
> > @@ -544,7 +544,8 @@ if test "$fork_point" = t
> >  then
> >  	new_upstream=$(git merge-base --fork-point "$upstream_name" \
> >  			"${switch_to:-HEAD}")
> > -	if test -n "$new_upstream"
> > +	if test -n "$new_upstream" &&
> > +	   ! git merge-base --is-ancestor "$new_upstream" "$upstream_name"
> >  	then
> >  		upstream=$new_upstream
> >  	fi
> > -- 8< --
> >
> > Since the intent of `--fork-point` is to find the best starting point
> > for the "$upstream...$orig_head" range, if the fork point is behind the
> > new location of the upstream then should we leave the upstream as it
> > was?
> 
> Probably; but the check to avoid giving worse fork-point should be
> in the implementation of "merge-base --fork-point" itself, so that
> we do not have to do the above to both "rebase" and "pull --rebase",
> no?

I don't think so, since in that case we're not actually finding the fork
point as defined in the documentation, we're finding the upstream rebase
wants.

Having played with this a bit, I think we shouldn't be replacing the
upstream with the fork point but should instead add the fork point as an
additional negative ref:

	$upstream...$orig_head ^$fork_point

Here's a script that creates a repository showing this:

-- >8 --
#!/bin/sh
git init rebase-test &&
cd rebase-test &&
echo one >file &&
git add file &&
git commit -m one &&
echo frist >file2 &&
git add file2 &&
git commit -m first &&
git branch --track dev &&
echo first >file2 &&
git commit -a --amend --no-edit &&
echo two >file &&
git commit -a -m two &&
echo three >file &&
git commit -a -m three &&
echo second >file2 &&
git commit -a -m second &&
git checkout dev &&
git cherry-pick -2 master &&
echo four >file &&
git commit -a -m four &&
printf '\nWithout fork point (old behaviour)\n' &&
git rev-list --oneline --cherry @{u}... &&
printf '\nFork point as upstream (current behaviour)\n' &&
git rev-list --oneline --cherry $(git merge-base --fork-point master HEAD)... &&
printf '\nWith fork point\n' &&
git rev-list --oneline --cherry @{u}... ^$(git merge-base --fork-point master HEAD)
-- 8< --

In this case the rebase should be clean since the only applicable patch
changes "three" to "four" in "file", but the current rebase code fails
both with `--fork-point` and with `--no-fork-point`.

With `--fork-point` we try to apply "two" and "three" which have already
been cherry-picked across (as Ted originally reported) and with
`--no-fork-point`, we try to apply "first" which conflicts because we
have the version prior to it being fixed up on master.

I hacked up git-rebase to test this and the change to use the fork point
as in the last line of the script above does indeed make the rebase go
through cleanly, but I have not yet looked at how to cleanly patch in
that behaviour.

I haven't tested git-pull, but it looks like it has always (since 2009)
behaved in the way `git rebase --fork-point` does now, failing to detect
cherry-picked commits that are now in the upstream.
