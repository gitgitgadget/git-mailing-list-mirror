From: Fedor Sergeev <Fedor.Sergeev@Sun.COM>
Subject: overly smart rebase - bug or feature?
Date: Tue, 11 Nov 2008 00:23:34 +0300
Message-ID: <20081110212333.GU6799@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, Roman.Shaposhnick@Sun.COM
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 10 22:43:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzeY3-0002VP-Ip
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 22:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbYKJVmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 16:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754047AbYKJVmc
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 16:42:32 -0500
Received: from gmp-eb-inf-1.sun.com ([192.18.6.21]:34650 "EHLO
	gmp-eb-inf-1.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634AbYKJVm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 16:42:29 -0500
X-Greylist: delayed 1112 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Nov 2008 16:42:29 EST
Received: from fe-emea-09.sun.com (gmp-eb-lb-2-fe2.eu.sun.com [192.18.6.11])
	by gmp-eb-inf-1.sun.com (8.13.7+Sun/8.12.9) with ESMTP id mAALNtY9020218
	for <git@vger.kernel.org>; Mon, 10 Nov 2008 21:23:55 GMT
Received: from conversion-daemon.fe-emea-09.sun.com by fe-emea-09.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0KA400301ZCCMF00@fe-emea-09.sun.com>
 (original mail from Fedor.Sergeev@Sun.COM) for git@vger.kernel.org; Mon,
 10 Nov 2008 21:23:55 +0000 (GMT)
Received: from localhost ([129.159.126.120])
 by fe-emea-09.sun.com (Sun Java System Messaging Server 6.2-8.04 (built Feb 28
 2007)) with ESMTPSA id <0KA400IYFZFTRG20@fe-emea-09.sun.com>; Mon,
 10 Nov 2008 21:23:55 +0000 (GMT)
Mail-followup-to: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Roman.Shaposhnick@Sun.COM
Content-disposition: inline
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100579>

Folks,

I have recently hit a behavior which might well be a feature, 
but it was very surprising (in a bad sense) to me.

I was trying to rebase a branch with changes in some file onto a branch
where this file was recently deleted. I would expect rebase to fail and 
suggest me to  resolve conflict manually.
However it somehow succeeded managing to find another file to patch instead 
of the initial one:

] cat git-rebase-bug.sh
#!/bin/sh
git init
# create three files with the same contents
perl -e ' for ($i=0; $i < 10; $i++) { print "$i\n" } ' >Makefile
cp Makefile Makefile1
cp Makefile Makefile2
git add .
git commit -m"created 3 makefiles"
# delete one file
git rm Makefile
git commit -m"deleted 1 makefile"
# go to another branch, one step back
git checkout -b mod HEAD^
# modify contents of the file deleted in master branch
echo "#10" >>Makefile
git add -u
git commit -m"modified 1 makefile"
# now rebase "mod" on top of "master" not expecting it to succeed
git rebase master mod
]

] mkdir git-bug; cd git-bug
] ../git-rebase-bug.sh
....
First, rewinding head to replay your work on top of it...
Applying: modified 1 makefile
error: Makefile: does not exist in index
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
]

Now if I look at the rebase result I see that it chose to patch "Makefile2" 
instead of my lovely "Makefile" (why not Makefile1, btw ;) ):

] git log --stat -1 --pretty=oneline
ce0101fc7884bce3eb9724b75d654e7c40abf0fd modified 1 makefile
 Makefile2 |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
]

I has always agreed with the claim that simple but reliable merge
(rebase, whatever) is much better than smartass one smarter than yourself.

And, to be honest, both merge and cherry-pick do not try to play smart:

] git reset --hard mod@{1}
] git checkout master
] git merge mod
CCONFLICT (delete/modify): Makefile deleted in HEAD and modified in mod. Version mod of Makefile left in tree.
Automatic merge failed; fix conflicts and then commit the result.
] git reset --hard
] git cherry-pick mod
Automatic cherry-pick failed.  After resolving the conflicts,
mark the corrected paths with 'git add <paths>' or 'git rm <paths>' and commit the result.
When commiting, use the option '-c f782a81' to retain authorship and message.
]

So, why rebase is smarter?

Yeah, and if it matters I tried it on 1.6.0.2 and 1.5.3.8 on Solaris and Linux.

best regards,
  Fedor.
PS I had problems reaching this list, thus ccing Junio explicitly.
I'm not on the list, btw..
