From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and other commit links ideas)
Date: Tue, 25 Apr 2006 02:58:52 -0700
Message-ID: <7vmzeax9gj.fsf@assigned-by-dhcp.cox.net>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
	<e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
	<e2kjul$ntq$1@sea.gmane.org>
	<20060425043436.2ff53318.seanlkml@sympatico.ca>
	<BAYC1-PASMTP116C6B217F25F2ADAF0C67AEBF0@CEZ.ICE>
	<e2kp27$8ne$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jnareb@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 25 11:59:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYKK1-0004NW-5Y
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 11:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWDYJ6z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 05:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWDYJ6z
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 05:58:55 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:38644 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932162AbWDYJ6y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 05:58:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060425095854.IUFF9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Apr 2006 05:58:54 -0400
To: Jakub Narebski <jnareb@gmail.com>
cc: git@vger.kernel.org
In-Reply-To: <e2kp27$8ne$1@sea.gmane.org> (Jakub Narebski's message of "Tue,
	25 Apr 2006 11:10:56 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19142>

Jakub Narebski <jnareb@gmail.com> writes:

> Actually, this can be resolved using automatic history grafts to the remote
> repository we pulled from, if the commit is not present on local side (and
> removing graft when commit appears on local side).

You do not even need history grafts.  The "cherry-pick source"
was a bad example.  Maybe using "related" as a way to implement
"bind" would have been a better example -- we want inter-commit
relationship that requires connectivity but without ancestry for
them.

You can just have two kinds of 'related'.  One that means
connectivity, the other that does not.

At that point, the latter does not even have to belong to the
core.  The Porcelains can make use of it as long as they agree
on a common convention and use that information consistently.
It does not even have to be "related" (which implies what comes
after "related" is an object name) -- it could be an arbitrary
metainformation that the core does not have to care.  So an
updated suggestion is to have optional 0-or-more "note" and
"related" fields.  'note' is followed by one token and
additional information.  'related' is followed by an object name
that needs the additional connectivity, and and additional
information.  For example:

    tree 0aaa3fecff73ab428999cb9156f8abc075516abe
    parent 5a6a8c0e012137a3f0059be40ec7b2f4aa614355
    parent e1cbc46d12a0524fd5e710cbfaf3f178fc3da504
    related a0e7d36193b96f552073558acf5fcc1f10528917 bind linux-2.6
    note cherrypick v1.3.0~12
    note origin "next" branch at junio's repository
    note rename "foobar" to "barboz"
    author Junio C Hamano <junkio@cox.net> 1145943079 -0700
    committer Junio C Hamano <junkio@cox.net> 1145943079 -0700

    Merge branch 'pb/config' into next

The core side can say "Oh, this is a 'note' so I do not care
what it is -- I'd just skip to the end of line", while
Porcelains that "cat-file commit" this object can grep for
"note" and look at the first token to figure out what to do with
it.  The core needs to be aware of the 'related' ones and does
the connectivity crud using the object name, and Porcelains can
use the rest of the line to do intelligent things.

Now, it is debatable that such an extra information like 'note'
belongs to the header that the core deals with.  IIRC, Linus
argued that he does not want to have arbitrary cruft in the
header and instead to have it as a comment in the message part
when somebody talked about recording renames in the commit.

We have the author and the committer fields that is not used by
the core (only half of the committer field is used by the core
to date-order the commit list).  But I suspect most of the time
such metainformation is useless to the end-user humans, so if I
have to vote I'd rather put them in the header, have the UI
layer filter them out unless asked when presenting the commit to
the humans, and give Porcelains freedom to do whatever they
wish.

Things are easier to filter out when they properly follow some
structure, so I'd rather have "cruft" in the header.  Right now,
git-cherry-pick ends the commit message with "(cherry picked
from $commit commit)".  In theory, rebase can notice by parsing
commit log message, but it certainly would be easier and more
robust if we had a 'note' facility and a well established
convention to use it.
