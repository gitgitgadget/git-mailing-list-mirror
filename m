From: Jean Privat <jean.privat@gmail.com>
Subject: [RFC] teach --edit to git rebase
Date: Tue, 11 Oct 2011 17:21:53 -0400
Message-ID: <CAMQw0oOBEjW3yS2+wcktXDuEuUiHKjfbK2qDzKvBOiwxo7Zkow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 11 23:22:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDjmZ-0004sd-MM
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 23:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044Ab1JKVWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 17:22:35 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62793 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994Ab1JKVWe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 17:22:34 -0400
Received: by wwf22 with SMTP id 22so44737wwf.1
        for <git@vger.kernel.org>; Tue, 11 Oct 2011 14:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=bxnrZAqWhIwJREN4ri4+ME/EdWPBDvtFSuwjKfF+aRw=;
        b=IiXlzEsELrxk7wT1pVoVu1M2OFctk6s1JM6qsyrIWk/DepcK0Ky5dsy/eBq6q8wToD
         WItATXd9VFtGo9UeZJQFRXBDE/WMGignJgwoNRqJWqW6fe+TaDuMAbC1WqKLUg5vTXd9
         CDCPZz/J/q19sJfKxsz4Qiwh5NqVoDPbn6gw0=
Received: by 10.223.7.18 with SMTP id b18mr23093290fab.31.1318368153088; Tue,
 11 Oct 2011 14:22:33 -0700 (PDT)
Received: by 10.223.79.3 with HTTP; Tue, 11 Oct 2011 14:21:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183327>

The idea of this patch is to allow a simple edition of a buggy commit
in the history.

## Motivation

The motivation behind the option is that sometime I have to do a
simple fixup of a previous commit.
Usually the way to do it is just to commit the fix on the top of the
branch (git commit --fixup) then doing a 'git rebase  --autosquash'.
However, the way is often not optimal if the context of commit on the
top of the branch is different from the context of the buggy commit,
thus the rebase with a fixup will lead to a conflict when git will
apply the fixup patch to the buggy commit (and a second conflict
later).

An other way is to do a 'git rebase --interactive' with an edit in the
todo list (instead of a pick). This is what I propose to simplify.

## Proposal

My idea is to add a --edit option to 'git rebase' in order to
automatize the 'git rebase --interactive' workflow.

Currently:

    $ git rebase -i commit-to-fix^
    # replace the first 'pick' with 'edit' then save and quit
    $ hack hack hack...
    $ git commit --amend  # or whatever you want to do like split commit
    $ git rebase --continue  # and resolve possible conflicts

With the --edit option:

    $ git rebase --edit commit_to_fix # note: no caret, no editor ! yeah !
    $ hack hack hack...
    $ git commit --amend  # or what ever like split commit
    $ git rebase --continue  # and resolve possible conflicts

Note that for a more complex history modification, a standard git
rebase with reordering, squashing and stuff the way to go is a good
old git rebase --interactive.

## Implementation proposal

Yes I know "show me the code" but because I am lazy I prefer ask 1-if
the proposal makes sense, and 2-if the following way of doing it makes
sense.

The idea is to extend git-rebase and git-rebase-interactive.

* detect and check the option --edit in git-rebase
* automatically prepare the todolist in git-rebase-interactive without
launching the editor.

## Alternative proposals

A weak point of the proposal it that it is a new option to a
overloaded git command (git rebase). In fact is is even a new synopsis
to git rebase since the --edit option will be incompatible with
--interactive (it is an automatic interactive) and with --onto (since
there is no real point to ``move'' the base if you want to fixup a
single commit).
A counter proposal could be to not extend the command 'git rebase' but
add a new git command (for instance 'git edit buggy_commit') but since
the edit may[1] lead to conflicts the user has to do some 'git edit
--continue' to finish the editing (or 'git edit --abort' if bored). It
will also require to adapt a lot of tinny things because hint
messages, error messages, and prompts will talk about 'rebase' and not
'edit'.

[1] In fact, it is probable that the *may* is in fact a *will* since
if no conflict arise, it is likable that a simple 'commit --fixup'
(followed by a later 'git rebase --autosquash') will just work and be
simpler.

An other alternative is to use a simple git alias for myself (and do
not bother the git community) but I do not know how to automatize the
command 'git rebase --interactive' I suppose I need more complex
infrastructure in the existing 'git rebase' (Maybe I did not look
enough and there is a way to do it with a git alias).

A last alternative is do do nothing. What I propose is just a way to
1-do not need a caret ('git rebase --edit commit' instead of 'git
rebase --interactive commit^') and 2-avoid launching the editor.
Therefore, maybe the itch do not really need a patch.

-- Jean Privat
