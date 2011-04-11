From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: git svn dcommit errors all no-yet-commited changes are left squashed/uncommited?
Date: Mon, 11 Apr 2011 16:32:55 +0200
Message-ID: <BANLkTim9KwBSjmZO0G7BHM=q7Jdy9=K=4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 11 16:33:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9IAl-000190-SK
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 16:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412Ab1DKOc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 10:32:56 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46529 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321Ab1DKOc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 10:32:56 -0400
Received: by vws1 with SMTP id 1so4148739vws.19
        for <git@vger.kernel.org>; Mon, 11 Apr 2011 07:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=PS7tTxMNmgfnMSa7Bmo75qbODNNN3yKHwa7qRibMVKQ=;
        b=qmiAMFiSqJjV3CNo7smHgu4N4hnr6fByn8M20TG/2xN97b3SlAsMACGeOGYSXjJd4U
         Tc789LHveow51cdrhx4T5bFiB4JhTAcNEEdGci39Ke9GGDl6qeUVt9/KjgmV4HLZ3XYF
         4qcAgSc/+i6LcCWDfhoO8D6zRy76VYJ2t/ZyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=TH7layyshEdbwxH7KAVOEH0PO5vhszJIJn21J1ZzUtsDF17WwVkrysR1W0QE7/2lWy
         28QqPgd/XCUfbCarD9yU40rQ2JaS15CMk9v/JW9HbrTDk8CwF37/tWae9DTP67KwgQ7K
         8871xq4IFOmY01lj6K28f502c612RWH+SYj7g=
Received: by 10.220.96.130 with SMTP id h2mr1604152vcn.121.1302532375366; Mon,
 11 Apr 2011 07:32:55 -0700 (PDT)
Received: by 10.220.177.198 with HTTP; Mon, 11 Apr 2011 07:32:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171330>

Hi,

I've done some changes to "local" trunk, dcomitted them to svn server,
then cherry-picked those changes to "local" branch and tried to
dcommit them to svn.
Several changes where successfully dcommited, but then I got an error.

Two problems:
1. after the error I'm left with changes not sent to svn server as
unstaged changes
2. git-svn errors if someone commits something to svn during my commit
even if there is no conflict

Even if the second problem is intentional (which I'm not sure is a
good idea), the first problem means it's not possible to continue
after the error (which is not really an error but should be a warning,
even if it stops the dcommit).


Full story:

The log looked like this:

[... this is the end of older commit, which succeeded ...]
W: -empty_dir: cptests/branches/a_branch/src/file
r23939 = 400e84221ca15be3976ba4dcd6d7a2eb1464b00e (refs/remotes/a_branch)
No changes between current HEAD and refs/remotes/a_branch
Resetting to the latest refs/remotes/a_branch
Unstaged changes after reset:
M	src/file
[... next commit preparation and commit ...]
	R	src/file
Committed r23941
	M	etc/file.xml
r23940 = 420c7b2c8f155563a4f4c8e5421857846bf3ebe5 (refs/remotes/a_branch)
	D	src/file
[...]
r23941 = 010c5b3883c473dd236de1a146fad1e90bd323fd (refs/remotes/a_branch)
W: bfb909cb21e26930364331660460ccd7be355a2e and refs/remotes/a_branch
differ, using rebase:
:040000 040000 5df0982b1cf277dd7d915d32a9ff145554fb9c94
a662095f06bd349c1a458d52697561ba9d005bac M	etc
Cannot rebase: You have unstaged changes.
Please commit or stash them.
rebase refs/remotes/a_branch: command returned error: 1

Now I was left with all the remaining changes "squashed" - git status
showed a list of unstaged changes. So all changes not yet commited
were in fact lost as commits and left in the working tree as one bit
not-yet-added change.

I believe the reason for this was that while I was dcommiting my
changes someone changed the "etc/file.xml"

So my previous dcommit was r23939 (src/*). Then someone else checked
into svn r23940 (etc/file.xml). Then (or earlier) git svn dcommited
r23941 (src/*). After that dcommit stopped with error.


In this case I have just reset --hard and cherry-picked changes that
were not commited, and it worked this time, but I wonder what should I
do next time.
What if those are not cherry-picked changes, but normal changes? Will
I have to use reflog to get back in time?

Also, I think in this case svn might continue with dcommit. It already
commited one revision after the other-person commit. The other commit
changed a completely different directory.

Even if this is left as error, it should be possible to continue
dcommit in an easy way. Not-commited changes should not be deleted and
left as unstaged changes.

Also, the "you have unstaged changes" error is not very helpful. I
thought it meant it commited a change partially, or maybe some other
weird thing happened.


Thanks,

-- 
Piotr Krukowiecki
