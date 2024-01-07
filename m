Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C89134A7
	for <git@vger.kernel.org>; Sun,  7 Jan 2024 11:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="ElUKxXn6"
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 61D804D464
	for <git@vger.kernel.org>; Sun,  7 Jan 2024 12:37:54 +0100 (CET)
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
	by smtp5-g21.free.fr (Postfix) with ESMTP id E140D5FFB1;
	Sun,  7 Jan 2024 12:37:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1704627466;
	bh=DMb7t588FY1qqyJF5GUYzTFQQzFSpftvUcR6xpBdN2k=;
	h=Date:From:To:Cc:In-Reply-To:Subject:From;
	b=ElUKxXn6LmkjFoZe1ah8vMMHBVxmX+q9Z1igKuLNY4f3Cu8TIUbbDCFzdE4YF2Wyy
	 hziS8wMY99Pwygy2kGeQvQI5b6avFuLWVgBYGfAv/dNC/uP0rQmeI7Ya24U5zs6YpF
	 CntUgyJjuzFj3Dm/ySxytnTh+q+kK9sjMhMzIjDURKrn71d0HbHu2iGc00cdvD1nLh
	 Psvd4kYQoyEH/Jw28n/gTGoarLZmgi48ZgGXp7iRUhjSUHhMFGf0jDXsB0WECmTAgr
	 Pc1JzdL9xbugfqtx5Px9EmVbYBpYma4wFzUQO5z4McbBSo1zVBWmuF6QCgujkj6PQX
	 xNPDzL4YRbodg==
Date: Sun, 7 Jan 2024 12:37:46 +0100 (CET)
From: Yann Dirson <ydirson@free.fr>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git <git@vger.kernel.org>
Message-ID: <1930018756.1822864601.1704627466836.JavaMail.root@zimbra39-e7>
In-Reply-To: <ed9f9fc5-c398-4424-9b5b-dbe618cca2ed@kdbg.org>
Subject: Re: Leveraging --rebase-merges --update-refs mechanism to rebase
 several branches in one run
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr

Johannes Sixt wrote:
> Am 06.01.24 um 20:05 schrieb Yann Dirson:
> > The "core + 1 variant" case pretty much works out of the box, with
> > --rebase-merges
> > and --update-refs generating a perfect instructions sheet.
> > 
> > But if I was to rebase just one variant while rewriting the core
> > branch, obviously
> > all other variants would still fork off the pre-rewrite core
> > branch, and we'd loose
> > all chances of automating the same work on the other variants.
> > 
> > OTOH, if I get `git-rebase` to generate the instruction sheets for
> > those other
> > variants first, strip them (manually) from the common part, and
> > insert them in the
> > instruction sheet of my "core + 1 variant" case ... I do get the
> > whole of my branches
> > rebased together, and sharing the updated core.
> 
> Not a complete automation, but... You can merge all variant branches
> into a temporary branch (or detached HEAD), even if that are merely
> -s
> ours merges, and then rebase the temporary branch with
> --rebase-merges
> --update-refs. This will generate the instruction sheet that you
> want.
> You can remove the final merge instructions (the temporary ones) from
> the instruction sheet if you do not want them to be executed.

Nice idea, and this is indeed automatable for the most part, Q&D PoC below.

There are a few things I can see missing in this PoC:

- removal of the final merge from instruction sheet

  Could be done by wrapping $EDITOR - I'm not particularly fond doing things
  behind the user's back, but I lack better ideas.

- restoration of HEAD

  In the general case it cannot be done from the script, so we would naturally
  want to do that from the instruction sheet?

  While I was at manually removing the final merge, I experimented with changing
  the "reset onto" to "reset <a branch name>", but that resulted in moving HEAD
  to the pre-rebase version of the requested branch.

- When aborting the rebase HEAD still points to the extra merge

  This is indeed a special case of the above, where instruction sheet cannot
  be used, and where the script could help since we won't be in the middle of
  a rebase when git-rebase stops.

  There does not seem to be any documented exit-code protocol to tell the
  git-rebase caller the user aborted.  I guess "HEAD pointing to this commit"
  could be used to identify the abort.



---- 8< ---- git-rebase-batch
#!/bin/bash
set -e

die() {
    echo >&2 "ERROR: $0: $*"
    exit 1
}

REBASE_OPTS=(--interactive --rebase-merges --update-refs)
# all args before "--" are passed to git-rebase
while [ $# -ge 1 ]; do
    case "$1" in
        --) shift; break;;
        *) REBASE_OPTS+=("$1"); shift;;
    esac
done

[ $# -ge 3 ] || die "need cutting-point and at least 2 refs to rebase"
CUT="$1"
shift

git checkout --detach "$CUT"
git merge -s ours "$@" -m "temporary handle for all rebased branches"
git rebase "${REBASE_OPTS[@]}" "$CUT" HEAD

# here we can be in the middle of interactive rebase, cannot perform
# any kind of cleanup (which would include restoring HEAD ref to its
# original destination)
---- 8< ----

