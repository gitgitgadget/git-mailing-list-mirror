From: Derek Moore <derek.p.moore@gmail.com>
Subject: Re: RCS Keywords in Git done right
Date: Wed, 26 Nov 2014 13:22:51 -0600
Message-ID: <CAMsgyKZywnac_b2RV0dGs9zOdemJDUQ8oR=bSydBuSxp1VDixQ@mail.gmail.com>
References: <CAMsgyKbTRY5=cHj8Ar8zHDd5WdbcNwZC5caGV-snvZU4aek=YQ@mail.gmail.com>
	<CAGZ79kZz4_q+p91e7fn8uS--DRqEUPj_eeQPf2WPOWEk=R8fkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 20:22:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtiAz-0000Fd-3E
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 20:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbaKZTWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 14:22:53 -0500
Received: from mail-oi0-f50.google.com ([209.85.218.50]:51223 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbaKZTWv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 14:22:51 -0500
Received: by mail-oi0-f50.google.com with SMTP id a141so2434794oig.37
        for <git@vger.kernel.org>; Wed, 26 Nov 2014 11:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5jw2ydVIzBWG2Ky9QAW0BImNNXeFduxLbFai9yL28Mc=;
        b=a+mgm1huKEn5GaS99cMwIGjuxS/xaLoO6pdXL7zkfgSLyIj4dVA+0qGxDBuQn3Kz2R
         ut/mTCp9yQfqnU/GofufFucQt0cR3XlKE/jML2yvQ937zjgiR8VE/w51u+NAiyShimhW
         TIQBluqIXmOthzZFGVjkV41b6e/10pZCK24OL0ArC2Qehe+UN3FOl1G0Hj5Q80/3hOYb
         ww+U6Ewzt5r2Qpb/0BAjifhLxg1IETbe3BttUkm6/eDV2A+seKDGebFcCSBKTRkGaHJW
         LwHqDLUk9I8gJw1n20AdSslb3a+ZRddJlpjmNlHlizFswoblUKhbkThy1SDkUPmA3QLw
         01+w==
X-Received: by 10.202.207.78 with SMTP id f75mr20215257oig.46.1417029771386;
 Wed, 26 Nov 2014 11:22:51 -0800 (PST)
Received: by 10.76.33.68 with HTTP; Wed, 26 Nov 2014 11:22:51 -0800 (PST)
In-Reply-To: <CAGZ79kZz4_q+p91e7fn8uS--DRqEUPj_eeQPf2WPOWEk=R8fkw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260296>

> Now knowing the edge cases won't work, I did not get an idea about the
> standard case of what should work with this. Would you mind to write
> a more detailed example or a more advertising paragraph of what this can do?
> Not getting the big picture may be related to me having not worked with RCS yet.

Stefan,

RCS Keywords, while originating from RCS, are commonly used in CVS and
SVN. A lot of LaTeX workflows in the scientific community, for
example, use these keyword substitutions, trapping scientists in
legacy SCMSes. In my environment, we do builds and deployments from
within pristine working copies or "checkouts of trunk", we also have
some deployments that are symlinks into live checkouts of trunk, and
we have production support workflows where support personnel inspect
files remotely and subsequent escalation procedures rely on the
contents of the $Author$ substitutions, etc. As a result of this,
projects that have migrated to git are demanding the restoration of
their RCS keyword substitutions.

In CVS/SVN, keywords are expanded on checkout, placing text related to
the most recent history of a give file into that file. RCS has one
keyword that takes action on check-in (or commit), being the $Log$
keyword, which is a running commit log of the file in the file.
Keyword expansions are not stored in the repo, but are substituted on
their out of the repo into the working copy, and substitutions are
reversed on their way from the working copy into the repo.

Git's export-subst feature in git-archive is very similar to RCS
Keywords. What I'm providing here is a mechanism to enable
export-subst functionality throughout normal git workflows and not
just during builds that employ git-archive, as if export-subst worked
alongside git's ident feature.

Perhaps described the known issues I've found will also help towards
understanding...


Known Issues
------------

Edge Case #1 (aka, modified smudge filter)

1. create new branch
2. edit smudge filter
3. commit
4. switch back to previous branch
5. smudge filter is temporarily disappeared at the moment the smudge
filter wants to run

This edge case is a side-effect of the order in which git performs
deletions in the worktree and extractions from the index and
executions of the filters. This edge case is related to a similar to
one seen in older git versions where the smudge is disappeared during
a "git checkout-index -a -f", but the sequence of operations has been
fixed in more recent gits, so the smudge does not disappear during a
checkout-index.


Edge Case #2

1. create branch B from branch A
2. make changes in branch A, commit
3. checkout branch B
4. git merge A
5. while editing commit file, file being modified lacks keywords (expected)
6. delete commit message, cancelling commit
7. file remains w/o substituted keywords
8. cancel merge w/ git reset --merge ORIG_HEAD & restored original
file is w/o substituted keywords

Reason: no available state transition on reset --merge


Edge Case #3

1. create branch B from branch A, checkout B
2. modify file, commit
3. checkout A
4. make conflicting edit to same file
5. git rebase B, rebase will conflict
6. git rebase --abort
7. file will be w/o substituted keywords


Known Unissues
--------------

Not-an-Edge-Case #1

1. create branch B from branch A, checkout B
2. modify file, commit
3. checkout A
4. git merge --squash B
5. file as modified from B is w/o substituted keywords
AS EXPECTED - that version of file does not yet contain history in A,
file will gain substitutions following commit
