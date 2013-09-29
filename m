From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] builtin/push.c: Add `--notes` option
Date: Sun, 29 Sep 2013 13:59:43 +0200
Message-ID: <CALKQrgcdk8==Qf3z9yuxu=9BBmFJ-8Dj+WZALXoc9j+GAKqEgg@mail.gmail.com>
References: <1379679608-72475-1-git-send-email-rodolphe.belouin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Rodolphe Belouin <rodolphe.belouin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 14:00:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQFfG-0002js-HS
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 13:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233Ab3I2L7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 07:59:51 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:53010 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab3I2L7t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 07:59:49 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VQFf9-00057m-K7
	for git@vger.kernel.org; Sun, 29 Sep 2013 13:59:47 +0200
Received: from mail-pd0-f172.google.com ([209.85.192.172])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VQFf9-0006km-Bg
	for git@vger.kernel.org; Sun, 29 Sep 2013 13:59:47 +0200
Received: by mail-pd0-f172.google.com with SMTP id z10so4476959pdj.3
        for <git@vger.kernel.org>; Sun, 29 Sep 2013 04:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5mKuYKJYotn5WLFVwXNpgHRQym0tYviU6/KoWAo3TLQ=;
        b=lpRxtjsHw+kP3Guh7IgMHrpYH2+wR0W+u477TtSyIVxTxYmLxAQg0yvyfxfJWzEBDx
         goUrir9f7AnKewKAvjhVk0ltPzKuXDPzMZvtXlk9w2Xz0GxHFlF1hgqbBefc52faU1dF
         PWi26JZq9YK28ULavDtRqfPtjcCU/5DlihKaKIzKNEu8IPjOm3BuLiJ8nzknWi7z7vCn
         TMU1GuJ6nH8/xV9Y4GiPr5gWLg0TxUXtRtywj5gH/I4ZQW+YBCcIRjRmLb6KFjIhNICe
         +7x4LH16AkuHV1PPed49EdUSZMmGMgfmDHz0sZvg453Nwa3vhUSbqVZ6YgWjcacZhW3D
         tz6A==
X-Received: by 10.67.14.231 with SMTP id fj7mr22324776pad.115.1380455983438;
 Sun, 29 Sep 2013 04:59:43 -0700 (PDT)
Received: by 10.70.24.226 with HTTP; Sun, 29 Sep 2013 04:59:43 -0700 (PDT)
In-Reply-To: <1379679608-72475-1-git-send-email-rodolphe.belouin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235597>

On Fri, Sep 20, 2013 at 2:20 PM, Rodolphe Belouin
<rodolphe.belouin@gmail.com> wrote:
> Make the user able to call `git push --notes` instead of
> `git push refs/notes/*`

I'm sorry for not replying to this earlier. I'm unsure how much of the
earlier discussions around pushing and pulling notes you have
followed, but the short story is that (as demontrated by the script in
[1]) pushing and pulling notes is not as simple as it might initially
seem.

Notes behave more like branches than tags (in that we expect them to
change over time, and we (often) want to collaborate on advancing
them). In order to support distributed collaboration on branches, we
have remote-tracking branches (remotes/$remote/$branch) and associated
behavior in git, which keeps track of the state of other repos, and
supports the integration of remote and local changes. That
infrastructure does not yet exist for notes.

As a result, collaborating on notes quickly becomes painful when you
have to fetch "magic" refspecs and manually orchestrate the
integration of remote and local notes changes (as shown in [1]).

The proposed solution for this is to reorganize the refs/remotes/
hierarchy to allow for remote-tracking notes in addition to
remote-tracking branches (and also other kinds of remote-tracking
refs). However this reorganization is itself a big project and will
not be completed in the short term.

So, how does this apply to your patch?

There is (AFAICS) nothing wrong with the patch itself (except maybe
some added tests would be nice...), but we must consider its
implications and how it guides the use of notes.

First, as you state in the commit message, this allows use of a simple
option instead of a supplying a refspec. And as long as you are the
only person pushing notes into that repo (and you only fast-forward),
this should work well, and lower the barrier for exchanging notes with
a remote repo.

However, as soon as you start collaborating with others, you will need
to integrate their changes, and that's where current Git stops
providing any help: You are left to do the manual integration shown in
[1]. This integration requires you to know about and juggle refspecs
quite intimately, and it could even be argued that the simplicity of
"git push --notes" tricks an unsuspecting user into a future manual
integration regime that is probably outside most git users' comfort
zone...

That said, if there is consensus that "push --notes" is valuable in
the short term (before the larger remote refs reorg is complete), and
that it won't set a user interface precedent that will obviously be
broken by said reorg, then I am not opposed to this patch.


Hope this helps,

...Johan


[1]:
#!/bin/sh

set -e

rm -rf notes_test_area
mkdir notes_test_area
cd notes_test_area

# Prepare server with initial note
git init server
cd server
echo foo>foo
git add foo
git commit -m foo
git notes add -m "Initial note on foo"
echo bar >>foo
git commit -a -m bar
cd ..

# Clone two clients and transfer notes
git clone server clientA
cd clientA
git fetch origin refs/notes/commits:refs/notes/commits
cd ..

git clone server clientB
cd clientB
git fetch origin refs/notes/commits:refs/notes/commits
cd ..

# Add notes in both clients
cd clientA
git notes add -m "clientA's note on bar"
cd ../clientB
git notes add -m "clientB's note on bar"
cd ..

# Push notes from clientA
cd clientA
git push origin 'refs/notes/*' # This works
cd ..

# Push notes from clientB
cd clientB
git push origin 'refs/notes/*' || echo "This command fails!"
# Must merge changes from origin's refs/notes/commits into our own
# refs/notes/commits, but there is no built-in machinery to do so.
# Do it manually instead:
git fetch origin refs/notes/commits:refs/notes/commits_from_origin
git notes merge commits_from_origin || echo "Oops, conflict!"
# Conflict in .git/NOTES_MERGE_WORKTREE/$SHA1. Resolve manually
commit=$(git rev-parse HEAD)
echo "clientA's and clientB's notes on bar" >
".git/NOTES_MERGE_WORKTREE/$commit"
# Commit conflict resolution to finalize notes merge
git notes merge --commit
# Remove temporary placeholder for origin's notes
git update-ref -d refs/notes/commits_from_origin
# Now we can finally try to push again
git push origin 'refs/notes/*' # This works
cd ..

# Behold the end result
cd server
git log --graph -p -c refs/notes/commits
cd ..

echo "done"
