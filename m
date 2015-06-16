From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: rebase -i might leave CHERRY_PICK_HEAD behind
Date: Tue, 16 Jun 2015 14:06:12 +0200
Message-ID: <20150616140612.Horde.a1irZQmh2o42SqDfxAytHg1@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 14:06:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4pdQ-0001yq-7Z
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 14:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754422AbbFPMG0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Jun 2015 08:06:26 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:50799 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752622AbbFPMGO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 08:06:14 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1Z4pd6-0000Fu-8I
	for <git@vger.kernel.org>; Tue, 16 Jun 2015 14:06:12 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1Z4pd6-0000qV-1W
	for git@vger.kernel.org; Tue, 16 Jun 2015 14:06:12 +0200
Received: from x590d3112.dyn.telefonica.de (x590d3112.dyn.telefonica.de
 [89.13.49.18]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Tue, 16 Jun 2015 14:06:12 +0200
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1434456372.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271750>


Hi,

When skipping an empty commit with 'git rebase --continue' a
CHERRY_PICK_HEAD file might be left behind.

What I did boils down to this:

     echo one >file
     git add file
     git commit -m first
     echo two >file
     git commit -a -m second
     echo three >file
     git commit -a -m third
     git rebase -i HEAD^^
     # change todo list to edit the "second" commit

     echo three >file
     git commit -a --amend
     # this effectively makes the third commit an empty commit
     # and rebase will ask what to do:
     git rebase --continue
     The previous cherry-pick is now empty, possibly due to conflict =20
resolution.
     If you wish to commit it anyway, use:

         git commit --allow-empty

     Otherwise, please use 'git reset'
     rebase in progress; onto 7335bbe7a5
     You are currently rebasing branch 'master' on '7335bbe7a5'.

     nothing to commit, working directory clean
     Could not apply d19f82ac6d467247117fd734ed039b03ef923c86... third

     # I didn't want an empty commit, but didn't read that carefully, s=
o I did:
     git rebase --continue
     Successfully rebased and updated refs/heads/master.
     # and was rewarded for my lack of attention with the following =20
bash prompt:
     test/rebase-empty-continue (master|CHERRY-PICKING)$
     # indeed:
     ls -l .git/CHERRY_PICK_HEAD
     -rw-r--r-- 1 szeder szeder 41 Jun 16 13:22 .git/CHERRY_PICK_HEAD

On one hand, it's user error: it told me to run 'git reset' to achive
what I want but I didn't.
Note, however, how it told me about 'git reset': while 'git commit
--allow-empty' is greatly emphasized by indentation and empty lines
before and after, 'git reset' blends in quite well into the rebase
progress.  It was late, I was tired, and there was a questionable
penalty on Copa Am=C3=A9rica as well ;), so I simply didn't notice.

On the other hand,

    1. 'git rebase' claimed that "Successfully rebased...", yet it left
       cruft behind.  I think it shouldn't.
    2. 'git rebase --continue' didn't complain by the lack of prior
       'git reset' and finished doing exacly what I expected from it to
       do (except leaving CHERRY_PICK_HEAD behind, of course).
       Perhaps it should complain, like it does when the worktree is
       dirty.
       Alternatively, it could just continue to DWIM, as it does
       already, but then it should remove CHERRY_PICK_HEAD as well.

G=C3=A1bor
