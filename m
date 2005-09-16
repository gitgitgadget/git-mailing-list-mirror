From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-merge-cache / StGIT - gitmergeonefile.py: merging one tree into another rather than two trees into merge base
Date: Fri, 16 Sep 2005 12:59:02 -0700
Message-ID: <7vvf10hji1.fsf@assigned-by-dhcp.cox.net>
References: <200509102027.28812.blaisorblade@yahoo.it>
	<1126427087.8457.33.camel@localhost.localdomain>
	<200509142019.04667.blaisorblade@yahoo.it> <tnxslw6d4qt.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 22:00:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGMMb-0003Fl-Fv
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 21:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161193AbVIPT7J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 15:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbVIPT7J
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 15:59:09 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:7811 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S965317AbVIPT7F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 15:59:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050916195903.YVSM9510.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Sep 2005 15:59:03 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <tnxslw6d4qt.fsf@arm.com> (Catalin Marinas's message of "Thu, 15
	Sep 2005 11:06:50 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8722>

Catalin Marinas <catalin.marinas@gmail.com> writes:

> git-read-tree -m doesn't handle the case when a file is removed from
> one branch and unmodified in the other, which is what happens in your
> test. For each of these removed files, git-merge-cache will call
> gitmergeonefile.py which calls 'git-update-cache --remove'.
>
> An improvement would be to make git-read-tree smarter...

I think this was once discussed but the primary reason for the
behaviour is that Linus wanted to leave as much merge policy
decision to be scriptable without hardcoding it in read-tree.

For example, you would see branch A removing a path while branch
B keeping the path if A renamed it to somewhere else while B
kept it -- a cleverer merge policy than one-path-at-a-time we
currently have _could_ take a hint from the unmerged cache, go
look for the other half of the rename in branch A, and ask the
user if the rename should be honored in the merge result for
example.  If you always do "added or removed in only one head
means take that head", most likely in the above example B would
not have a new path (rename target of A) so you would end up
always taking the file rename.

>> git-diff-tree -r v2.6.13 master |grep ' D'|wc -l
>>
>> gives 189.

A completely different topic:  would it please people if I did this?

    $ git-diff-tree -r --names-and-changes A B
    M	frotz
    R93	rezrov	nitfol
    D	yomin
