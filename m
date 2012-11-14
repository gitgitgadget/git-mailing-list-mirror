From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: creation of empty branches
Date: Wed, 14 Nov 2012 23:54:44 +1100
Message-ID: <CAH5451mkcszgJxziKn3q3OwSDM-qQ71PtT5+UWb=PG7VYAcFyQ@mail.gmail.com>
References: <CAB9Jk9CaBECT7c_M9HvCbB8mFYGvdsmq_jFW4DF4NCO8Narnmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 13:55:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYcV3-0003hY-4B
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 13:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422801Ab2KNMzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 07:55:07 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:48386 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422711Ab2KNMzG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 07:55:06 -0500
Received: by mail-qa0-f46.google.com with SMTP id c11so1798953qad.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 04:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xqa2b0LLUpDNWi3FbSlJbcI2+VBBJD2H3zOdVxDMusk=;
        b=pQ2fE8ueRLHY//fzIlVarmIrCdFdlhthQgzPgiYrSxATCSI7W/xfI0JTSLrRWvW+at
         eBEAU7ozEm8XRsx/D2IJ2ZHkiL7C8JxJ1vIQ21FGuyoiM0A3imdAzrr0aIU4S24bMJGV
         yrMLmtPxgW/VDDoAuxllvrBUs5TjVhQlbBN6G6bKEQa9ZG2Cv+7tjur2W1zhAmeGZ4SG
         3GaF3dE8A1C8wMFK/9h0NQKmPcl9CiehhpsaDNl5Ci2sX1wVpoOksu4X2vUtALBvrZbt
         jGZ4RNLlko1Fj4D1TqCCJ4moql78YBlLjhXAZmNsLiJWt2PBcvgi7pYwFsTdvPBYNOQs
         +e2g==
Received: by 10.49.28.231 with SMTP id e7mr30607089qeh.49.1352897704830; Wed,
 14 Nov 2012 04:55:04 -0800 (PST)
Received: by 10.49.119.65 with HTTP; Wed, 14 Nov 2012 04:54:44 -0800 (PST)
In-Reply-To: <CAB9Jk9CaBECT7c_M9HvCbB8mFYGvdsmq_jFW4DF4NCO8Narnmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209713>

On 14 November 2012 21:10, Angelo Borsotti <angelo.borsotti@gmail.com> wrote:
> ... why should git
> branch master issue an error while git checkout does not? I have the
> impression that also git branch should not issue an error in this
> case.
>

Just to help a little, let's first define:
- An empty file in refs/heads is a broken head.
- A non-existent file in refs/heads is an empty branch. Most
references to empty branches are probably mistakes.
- If HEAD points to an empty branch it is in 'root commit' or 'orphan'
mode. A commit made in such a mode first creates the root or orphan
commit object, and then creates the branch head in refs/heads pointing
to that object.

As I understand it, git branch and git checkout without a start point
defined are both intended to create a new branch and point it to the
current HEAD. Checkout will additionally reset HEAD to point to the
new branch, rather than whatever it was pointing to before (which will
normally be either a direct or indirect reference to a commit object).
The problem is that the behaviour when HEAD points to empty branch is
undefined, and this situation is seen to occur when there are no
commit objects at all, in an empty repository. This will also happen
when a branch has been checked out in orphan mode.

Since git branch has the default behaviour to create a branch 'in the
background' it makes sense to fail when trying to create a new branch
this way from an empty branch. The error message should be improved to
handle this edge case in a nicer way. If we allow for renaming empty
branches (described below) then the message can be even more helpful.
Instead of
    fatal: Not a valid object name: 'master'.
perhaps
    fatal: Cannot create branch 'foo' from empty branch 'master'. To
rename 'master' use 'git branch -m master foo'.

git checkout -b changes the current branch, and so it does make sense
to allow renaming an empty branch, which is the current behaviour.
However, note that currently when HEAD points to an empty branch, 'git
checkout -b foo HEAD' fails because HEAD is an invalid reference.
Obviously some special logic has been added or a very odd bug has
appeared. Perhaps it is most useful to continue to error out on any
reference explicitly listed on the command line as the start point
that points to an empty branch, unless it is pointed to by HEAD. Thus
we would only make HEAD point to a new empty branch when the start
point is omitted or when it matches the current empty branch HEAD
points to.

It would be useful to extend this renaming of empty branches to the
branch commands, and 'git branch -m' is a perfect fit for this from a
user perspective.


So explicitly, I am proposing the following behaviour changes:

When trying to create a new branch without specifying a start point,
  if HEAD points to an empty branch, error with a more useful message
that assumes the user might want to rename the empty branch.
When trying to create a new branch whilst specifying an empty branch
as the start point,
  if HEAD points to the same empty branch that is listed as the start
point, error with a more useful message that assumes the user might
want to rename the empty branch.
  otherwise error due to invalid ref

When checking out a new branch without specifying a start point,
  if HEAD points to an empty branch then HEAD should be pointed to the
new branch, which will also be empty.
When checking out a new branch whilst specifying an empty branch as
the start point,
  if HEAD points to the same empty branch that is listed as the start
point, HEAD should be pointed to the new, empty branch
  otherwise error due to invalid ref

When moving to a new branch without specifying an old branch,
  if HEAD points to an empty branch then HEAD should be pointed to the
new branch, which will also be empty.
When moving to a new branch whilst specifying an empty branch as the old branch,
  if HEAD points to the same empty branch that is listed as the old
branch, HEAD should be pointed to the new, empty branch
  otherwise error due to invalid ref

Note that since HEAD points to an empty branch there should be no
conflicts with the working directory or the index, so leave them
unchanged.

Some examples that might help:

~$ git init test
~$ cd test
~/test (master)$ git branch foo
fatal: Cannot create branch 'foo' from empty branch 'master'. To
rename 'master' use 'git branch -m master foo'.
~/test (master)$ git checkout -b foo
~/test (foo)$ git checkout -b bar fo
fatal: Not a valid object name: 'fo'.
~/test (foo)$ git checkout -b bar foo
~/test (bar)$ git branch -m foo
~/test (foo)$ git branch -m fo bar
error: refname refs/heads/fo not found
fatal: Branch rename failed
~/test (foo)$ git branch -m foo bar
~/test (bar)$



I wouldn't mind trying to code this up at the moment, but as I don't
have heaps of time if someone else feels like it go ahead (assuming
it's a good suggestion of course!).

Regards,

Andrew Ardill
