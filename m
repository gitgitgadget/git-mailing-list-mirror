From: Nathan Yergler <nathan@creativecommons.org>
Subject: Re: Short "git commit $file" syntax fails in the face of a resolved 
	conflict
Date: Wed, 21 Jan 2009 13:46:02 -0800
Message-ID: <c1a864630901211346j4b702fb3tcc5a098ed7e1541d@mail.gmail.com>
References: <alpine.DEB.2.00.0901211549070.15860@vellum.laroia.net>
	 <49779521.9040208@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Asheesh Laroia <asheesh@asheesh.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 22:47:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPkv7-0002PY-SU
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 22:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbZAUVqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 16:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbZAUVqI
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 16:46:08 -0500
Received: from rv-out-0506.google.com ([209.85.198.231]:3786 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbZAUVqF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 16:46:05 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3795175rvb.1
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 13:46:02 -0800 (PST)
Received: by 10.140.158.4 with SMTP id g4mr4169992rve.160.1232574362186; Wed, 
	21 Jan 2009 13:46:02 -0800 (PST)
In-Reply-To: <49779521.9040208@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106682>

Can you elaborate on why doing -i automatically is a bad idea in this
case?  [It may really be, I don't pretend to have enough knowledge
about git's internals to make a reasoned argument.]  This was
unexpected behavior for me as I'd always experienced "git add path &&
git commit" and "git commit path" as being equivalent and so I assumed
they would work equivalently in this situation.

Nathan

On Wed, Jan 21, 2009 at 1:35 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Asheesh Laroia venit, vidit, dixit 01/21/09 22:00:
>> I have found what seems to be a bug in the short "git commit $file" mode
>> of interaction with git. To reproduce it, you can:
>>
>> 1. Create a repository with some content.
>>
>>       $ (mkdir a ; cd a ; git init ; echo hi > file ; git add file ; git commit -m 'initial commit')
>>       Initialized empty Git repository in /tmp/playground.2009-01-21.w15613/a/.git/
>>       Created initial commit 276d6eb: initial commit
>>        1 files changed, 1 insertions(+), 0 deletions(-)
>>        create mode 100644 file
>>
>> 2. Clone that repository.
>>
>>       $ git clone a b
>>       Initialized empty Git repository in /tmp/playground.2009-01-21.w15613/b/.git/
>>
>> 3. Create changes in "a" that are not yet cloned into "b".
>>
>>       $ (cd a ; echo ho > file ; git add file ; git commit -m update)
>>       Created commit 91deff9: update
>>        1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> 4. Make changes in "b", the clone.
>>
>>       $ echo lol > file
>>       $ git add file ; git commit -m 'Some changes'
>>       Created commit 5d74b5b: Some changes
>>        1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> 5. Fetch and merge (AKA pull) from the first repo.
>>
>>       $ git pull
>>       remote: Counting objects: 5, done.
>>       remote: Total 3 (delta 0), reused 0 (delta 0)
>>       Unpacking objects: 100% (3/3), done.
>>       From /tmp/playground.2009-01-21.w15613/a/
>>          276d6eb..91deff9  master     -> origin/master
>>       Auto-merged file
>>       CONFLICT (content): Merge conflict in file
>>       Automatic merge failed; fix conflicts and then commit the result.
>>
>> 6. Resolve the conflict (in our case, by discarding the changes in the "b"
>> clone).
>>
>>       $ echo ho > file
>>
>> 7. Commit the resolved conflict.
>>
>> NOTE: The normal way to do step 6 is to "git add file ; git commit -m
>> yay". But I will now try to use the "git commit file" shorthand:
>>
>>       $ git commit file -m 'Resolved conflict'
>>       fatal: cannot do a partial commit during a merge.
>>
>> 8. Declare a bug.
>>
>> I believe that the "git commit file" command issued in step 6 should have
>> worked as well as the "git add file ; git commit" that us old-time git
>> users do.
>>
>> 9. Discuss on the git list.
>>
>> Do y'all agree that the git behavior is strange and unnecessarily
>> user-impeding here?
>>
>> Cheers!
>>
>> -- Asheesh.
>>
>> P.S. I'm not the one who ran into the bad behavior here; Nathan (CC:d) is
>> the one who did. You don't have to keep him CC:d, though.
>>
>
> You want git commit -i:
>
>       -i, --include
>           Before making a commit out of staged contents so far, stage
> the contents of paths given on the command line as well.
>           This is usually not what you want unless you are concluding a
> conflicted merge.
>
> Without -i, git commit path ignores the index, which would be bad in the
> middle of a merge, which is why git refuses to do so. You may argue for
> git commit to use -i automatically here, but I don't think it's a good idea.
>
> So, out of
> 1) git add path && git commit
> 2) git commit path
> 3) git commit -i path
> only 1) and 3) are always equivalent.
>
> Michael
>
