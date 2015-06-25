From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] apply: fix adding new files on i-t-a entries
Date: Thu, 25 Jun 2015 19:26:17 +0700
Message-ID: <CACsJy8AVeGxOS4pWfkcbPnxRQ0-gJRC7B1NSs+Ci81x46ieDzQ@mail.gmail.com>
References: <CACfKtTAvH7FH2AkC5hUNFEQ620gF401SNYaULLy62iE8S55-7A@mail.gmail.com>
 <1435062855-26274-1-git-send-email-pclouds@gmail.com> <xmqqoak6e5dx.fsf@gitster.dls.corp.google.com>
 <CACsJy8Ap4uNi3gXV8Y+S18xtLaZ1R6DscEf7wJKjt59ZLOAJ5Q@mail.gmail.com> <xmqqzj3p9gv7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Patrick Higgins <phiggins@google.com>,
	=?UTF-8?Q?Bj=C3=B8rnar_Snoksrud?= <snoksrud@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 14:26:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z86F4-0006w2-8T
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 14:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbbFYM0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 08:26:49 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:32769 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbbFYM0r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 08:26:47 -0400
Received: by ieqy10 with SMTP id y10so53253978ieq.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 05:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qZ57h1WRpJMjXXeKl1iOl2YdkmVnxeKiH8W3NgS6YX4=;
        b=y6CG1PvV89ZXu9oKeQ8hYHItDDiReM4atzrI3VhCtAr37n9ZlnGUhPXw9c93v+G4Qv
         NO5PPbZUGDpg910ltJx6UlHQtxc1ceB8ySPluC8u+6uq7jC7YRtsFLpbGa46v74kifno
         e9IZw6SmDMkc5O+kx7Hxn+zROSJZcXvY08L3LoKIHuZNx1cAwp6gNk0MzXE2/hbzqRSk
         iygVbW42Vu2GhwWAcfKOOcgRqvsyIYvNInsO1d3uZPBOheQn0tazeoUcYxgDmv4E5VI2
         2fs72No+jiTTg7Ly2djmBvIR56o5ws9RVxptdnO2nH/+JnKFrQOw5jZJUQ2O+pdy/Iyh
         N+sg==
X-Received: by 10.50.132.70 with SMTP id os6mr3698153igb.27.1435235206637;
 Thu, 25 Jun 2015 05:26:46 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Thu, 25 Jun 2015 05:26:17 -0700 (PDT)
In-Reply-To: <xmqqzj3p9gv7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272669>

On Thu, Jun 25, 2015 at 12:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Internal "diff-index --cached" is used for another reason you did
> not mention (and scripted Porcelains literally use that externally
> for the same reason).  When we start a mergy operation, we say it is
> OK if the working tree has local changes relative to the index, but
> we require the index does not have any modifications since the HEAD
> was read.
>
>         Side note: some codepaths insist that "diff-index --cached"
>         and "diff-files" are both clean, so d95d728a is harmless;
>         the former may say "clean" on i-t-a entries more than
>         before, but the latter will still catch the difference
>         between the index and the working tree and stop the caller
>         from going forward.
>
> With d95d728a (diff-lib.c: adjust position of i-t-a entries in diff,
> 2015-03-16)'s world view, an empty output from "diff-index --cached"
> no longer means that.  Entries added with any "git add -N" are not
> reported, so we would go ahead to record the merge result on top of
> that "half-dirty" index.
>
>         Side note: a merge based on unpack-trees has an extra layer
>         of safety that unpack_trees() does not ignore i-t-a entry as
>         "not exist (yet)" and notices that the path does exist in
>         the index but not in HEAD.  But that just shows that some
>         parts of the world do need to consider that having an i-t-a
>         in the index makes it different from HEAD.
>
> If the mergy operation goes without any conflict, the next thing we
> do typically is to write the index out as a tree (to record in a new
> commit, etc.) and we are OK only in that particular case, because
> i-t-a entries are ignored.  But what would happen when the mergy
> operation conflicts?  I haven't thought about that fully, but I
> doubt it is a safe thing to do in general.
>
> But that is just one example that there are also other codepaths
> that do not want to be fooled into thinking that i-t-a entries do
> not exist in the index at all.

I think it's clear that you need to revert that commit. I didn't see
this at all when I made the commit.

> All we learned from the above discussion is that unconditionally
> declaring that adding i-t-a entries to the index without doing
> anything else should keep the index compare the same to HEAD.
>
> If d95d728a were only about what wt_status.c sees (and gets reported
> in "git status" output), which was what the change wanted to address
> anyway, we didn't have to have this discussion.  Without realizing
> that two kinds of callers want different view out of "diff-index
> --cached" and "diff-files", we broke half the world by changing the
> world order unconditionally for everybody, I am afraid.
>
> Perhaps a good and safe way forward to resurrect what d95d728a
> wanted to do is to first add an option to tell run_diff_index() and
> run_diff_files() which behaviour the caller wants to see, add that
> only to the caller in wt-status.c?  Then incrementally pass that
> option from more callsites that we are absolutely certain that want
> this different worldview with respect to i-t-a?

Agreed.
-- 
Duy
