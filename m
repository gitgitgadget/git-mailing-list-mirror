From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Fake linear history in a deterministic manner.
Date: Mon, 13 Feb 2006 14:46:38 +1300
Message-ID: <46a038f90602121746v5adb448ej73cc2be6dd3745ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Feb 13 02:47:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8Snf-0000V7-02
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 02:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbWBMBqk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 20:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbWBMBqk
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 20:46:40 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:32551 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751503AbWBMBqj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 20:46:39 -0500
Received: by wproxy.gmail.com with SMTP id i34so737705wra
        for <git@vger.kernel.org>; Sun, 12 Feb 2006 17:46:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TdJGvH6/Lx0VyaralJ+OKrAts+ifQQpX0KBQxYiQD10GMgH/k8DaMr6D4ZtlY/nhaObuOQJ2qI9Tx3Sga5WzIcLxGTe2uVERFs9aeZL0hyO7/6CaJbp+IKAV/Oh+9A5wcsdDuNcQG6nraOSlpvtysrQ5FlPQZr7mHTZag0Fi1WY=
Received: by 10.54.143.17 with SMTP id q17mr1780482wrd;
        Sun, 12 Feb 2006 17:46:38 -0800 (PST)
Received: by 10.54.71.8 with HTTP; Sun, 12 Feb 2006 17:46:38 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>, martyn@catalyst.net.nz
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16035>

To emulate `cvs log somepath` I need to munge history to look linear.
I am working on the theory that I will tell the cvs client about *one*
linear history, and show merges from parallel histories as a merge
commit, "flattened" so to speak, and with a commit message where I'll
list the hash and first line of each commit that it involves.

Now, we are keeping a sqlite db (bad dependency, I know) with a list
of the lies we tell to the clients, so we can at least be consistent
(and fast). The fact that true git clients will be able to commit to
the repo means that actual parallel development will happen in the
repo.

Now, I can't think of an approach to drawing the linearized history
that is deterministic. I can't chose any branch with any confidence,
because the repo always has a very limited view. A client could come
in any time and push onto the repo a series of commits based on an
ancient commit, with ancient dates, and a merge to todays head.

We've been talking about updating the sqlite db with a post update
hook, which means that in that context we never have to choose, the
commits that get to the repo first win because they now drive the
linearized history.

But when creating a new lies database, we have no
"pushed-to-this-repo" timestamp in the commits so we'll have to pick.
At the moment, I suspect I'll pick the one with the earliest
"following" commit.

I thought briefly about delaying the decision until I see the merge,
and pick the leftmost, or rightmost, if there is some bias in
git-merge or cg-merge on putting whatever origin has on a particular
side. It'd mean running backwards through history and that the very
last merge can flip the decision entirely. Hmmm... any strategy I can
come up with means that each new merge throws the dice again entirely.

Ideas?

(As a result of this, the git-cvsserver we're drafting is of limited
usefulness to projects that really do use git to do what it does best:
DSCM. Projects with a mostly linearized history -- using git-rebase
liberally to avoid uninteresting merges -- do get a reasonable cvs
history. Or will get. Sometime. Soon.)



martin
