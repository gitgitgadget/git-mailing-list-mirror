From: "George Spelvin" <linux@horizon.com>
Subject: Re: Why not git reset --hard <path>?
Date: 28 Sep 2015 19:52:09 -0400
Message-ID: <20150928235209.29725.qmail@ns.horizon.com>
References: <xmqqr3lib189.fsf@gitster.mtv.corp.google.com>
Cc: git@vger.kernel.org, jacob.keller@gmail.com, tytso@mit.edu
To: gitster@pobox.com, linux@horizon.com
X-From: git-owner@vger.kernel.org Tue Sep 29 01:52:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgiDQ-0002qg-Cu
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 01:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbbI1XwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 19:52:12 -0400
Received: from ns.horizon.com ([71.41.210.147]:22673 "HELO ns.horizon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753557AbbI1XwL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 19:52:11 -0400
Received: (qmail 29726 invoked by uid 1000); 28 Sep 2015 19:52:09 -0400
In-Reply-To: <xmqqr3lib189.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278813>

Junio C Hamano <gitster@pobox.com> wrote:
> "George Spelvin" <linux@horizon.com> writes:
>> "git checkout <tree-ish> <pathspec>" modifies the index?
>>
>> Damn, I've been using git for years and I never knew that.
>
> ... which would be an indication that the behaviour is most likely
> the most natural one.

I think it's more that often, staging a file to the index
is pretty harmless, so it doesn't actually matter.

Both of the commonest forms of commit ("git commit -a" and "git commit
[-o] <paths>") aren't affected, and if I'm doing something trickier,
I'll usually examine the status and make sure I've got it right.

So I could have encountered it and put it down to fat-fingering on
my part.

>> But I just tested, and it does.  Damn, now I have to figure out
>> how to "leapfrog" a file from history into the working tree without
>> overwriting the index; that's occasionally useful.

> ... and indeed it is useful in some rare cases.  Either
>
>    git diff <tree-ish> <pathspec> | git apply -R
>
> or
> 
>    git checkout <tree-ish> <pathspec> &&
>    git reset <pathspec>

The former would work, and thanks for the idea, but for a single file
I'd probably do one of
	git show <tree-ish>:<path> > <path>
	git cat-file blob <tree-ish>:<path> > <path>

The checkout/reset wouldn't work in the case I'm thinking about, which
is when I want to import a small piece (say, helper function that got
deleted) from an old or other-branch version of a file.  I.e. a partial
revert or cherry-pick.

If I had some current changes to merge with, I'd stage them, pull the
*other* version into the tree, and use something like git-gui to add the
hunk I want to the staged version.

The whole point is that the staged state is important and I don't
want it overwritten.

There are other ways, of course:
- Show or cat-file the other version into a temporary file and manually
  copy and paste.  No need to stage anything.
- Commit the current change, then add the additional changes and amend the
  commit.
