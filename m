From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Usability of git stash
Date: Mon, 20 Oct 2008 11:33:14 -0500
Message-ID: <iLaWuW8h9LOhSqXlSRIQTWkC7QR2AL4JEb3gIbblWjY2dzOepLLfdg@cipher.nrlssc.navy.mil>
References: <87wsg9acfv.fsf@cup.kalibalik.dk> <nKimSsYZj6xfGNCQS3i5cRwnWQfbHrtUrwdGB2zGWVfMOcfZMwJDKg@cipher.nrlssc.navy.mil> <86vdvsg4up.fsf@lola.quinscape.zz> <vCcONcOJu3QKQyRgPdT5Dws3F2P25RNAFOgM5GX6FWWKJe40papCRw@cipher.nrlssc.navy.mil> <87prly5k5r.fsf@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Mon Oct 20 23:13:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrxiP-0006JO-3x
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 18:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbYJTQde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 12:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753511AbYJTQde
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 12:33:34 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:38551 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041AbYJTQdd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 12:33:33 -0400
Received: by mail.nrlssc.navy.mil id m9KGXF2u013155; Mon, 20 Oct 2008 11:33:15 -0500
In-Reply-To: <87prly5k5r.fsf@cup.kalibalik.dk>
X-OriginalArrivalTime: 20 Oct 2008 16:33:15.0337 (UTC) FILETIME=[8D164390:01C932D1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98708>

Anders Melchiorsen wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> In exchange for allowing new users to stub their toe on new commands, the
>> work flow of more experienced users is made a little easier.
> 
> I wonder whether experienced users even use stash a lot. Personally,
> after getting my head around the DAG, and thus getting more
> comfortable with git reset, I tend to make "WIP" commits instead.

There is another use for stash, as has previously been described by someone
else on this list. That is for incrementally splitting up changes made to
the working directory into a series of commits, _and_ testing each commit.

This is what the 'git stash save --keep-index' functionality was invented for,
but I do not consider this single option to completely satisfy the
requirements. The idea is to be able to 'git add -i' commits to the index and
then stash away all of the remaining commits so that the commits in the index
can be tested alone. After testing, you may decide that you want to move
commits from the index into the stash set or vice versa as appropriate before
committing.

Easily performing the operations in the previous sentence is what is missing.
Additional hunks can be added easily, but they can not be un-staged easily.
Maybe the interactive mode of git-add needs a '-p' sub-command which will
allow selecting from the set of staged hunks, and un-staging individually in
the same way that the 'p' sub-command allows staging hunks.

There is an example of this workflow in the stash man page, but I think it
needs to be changed. It is suggested:

   # ... hack hack hack ...
   $ git add --patch foo            # add just first part to the index
   $ git stash save --keep-index    # save all other changes to the stash
   $ edit/build/test first part
   $ git commit -m 'First part'     # commit fully tested change
   $ git stash pop                  # prepare to work on all other changes
   # ... repeat above five steps until ...

The commit and pop currently need to be changed to something like:

   # git reset --hard
   # git stash pop --index
   # git commit -m 'First part'

Otherwise you are prone to merge conflicts in the working directory which
are not straight-forward to reconcile. When there are merge conflicts,
the changes from the stash are staged for committing, and the files with
conflicts are 'Changed but not updated'. The user must reconcile the
conflicts and then 'git reset'.

I'm sure the user's reaction (as mine was) will be WTF!?. I initially
concluded that this work-flow was just broken. It is still usable, but far
from perfect.

> After having used "git stash clear" at a bad time once, I am wary of
> stashing work that I actually want to keep. I prefer workflows where
> my mistakes can be (easily) corrected.

There is now a 'git stash drop' which can be used to drop individual stashes,
and a 'git stash pop' to apply and then drop an individual stash.

> The primary thing that stash does for me is preserve the index state.
> Unfortunately, --index is not default for stash apply, so I often
> forget it.

The apply can always be redone.

   git reset --hard && git stash apply --index

But, I wouldn't be against making --index the default.

-brandon
