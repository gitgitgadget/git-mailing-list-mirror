From: Junio C Hamano <junkio@cox.net>
Subject: Re: [QUESTION] about .git/info/grafts file
Date: Wed, 18 Jan 2006 16:40:47 -0800
Message-ID: <7v8xtdrqwg.fsf@assigned-by-dhcp.cox.net>
References: <cda58cb80601170928r252a6e34y@mail.gmail.com>
	<cda58cb80601170932o6f955469y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 19 01:41:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzNrB-0005Re-A3
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 01:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbWASAku (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 19:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161108AbWASAku
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 19:40:50 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:49148 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1161106AbWASAkt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 19:40:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060119003935.RVZM6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 Jan 2006 19:39:35 -0500
To: Franck <vagabon.xyz@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14874>

Franck <vagabon.xyz@gmail.com> writes:

> I'm wondering why the "grafts" files is not involved during
> push/pull/clone operations ?

Commit ancestry grafting is a local repository issue and even if
you manage to lie to your local git that 300,000th commit is the
epoch, the commit object you send out to the downloader would
record its true parent (or parents, if it is a merge), so the
downloader would want to go further back.  And no, rewriting
that commit and feeding a parentless commit to the downloader is
not an option, because such a commit object would have different
object name and unpack-objects would be unhappy.

If you choose not to have full history in your public repository
for whatever reason (ISP server diskquota comes to mind) that is
OK, but be honest about it to your downloaders.  Tell them that
you do not have the full history, and they first need to clone
from some other repository you started your development upon, in
order to use what you added upon.  "This repository does not
have all the history -- please first clone from XX repository
(you need at least xxx commit), and then do another 'git pull'
from here", or something like that.

It _might_ work if you tell your downloader to have a proper
graft file in his repository to cauterize the commit ancestry
chain _before_ he pulls from you, though.  I haven't tried it
(and honestly I did not feel that is something important to
support, so it might work by accident but that is not by
design).

>                $ git-merge-base master origin
>                # nothing

Maybe you did not use grafts properly to cauterize?  I tried the
following and am getting expected results.  I did not have
patience to do 300,000, so I cut things at #4, though.

-- 8< -- 

#!/bin/sh

rm -fr .git
git init-db
echo 0 >path
git add path

for i in 1 2 3 4 5 6 7
do
	echo $i >path
	git commit -a -m "Iteration #$i"
	git tag "iter#$i"
done


git checkout -b mine iter#4

for i in A B C D
do
	echo $i >path
	git commit -a -m "Alternate #$i"
	git tag "alt#$i"
done

git log --pretty=oneline --topo-order
echo merge base is `git merge-base master mine` | git name-rev --stdin

git-rev-parse iter#4 >.git/info/grafts
echo "Cauterize away history before #4"

git log --pretty=oneline --topo-order
echo merge base is `git merge-base master mine` | git name-rev --stdin
