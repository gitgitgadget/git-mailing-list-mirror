From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-send-pack segfaulting on DebianPPC
Date: Wed, 19 Oct 2005 14:15:48 -0700
Message-ID: <7vzmp52oor.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90510190202n60101c5cgf27bd714dce00513@mail.gmail.com>
	<Pine.LNX.4.64.0510190724000.3369@g5.osdl.org>
	<46a038f90510191356w56b78413p6b9fe5b67fc9ee74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Oct 19 23:18:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESLHt-00046a-Kf
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 23:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbVJSVPv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 17:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbVJSVPv
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 17:15:51 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:45236 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751351AbVJSVPu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 17:15:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051019211517.QVVU2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Oct 2005 17:15:17 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90510191356w56b78413p6b9fe5b67fc9ee74@mail.gmail.com>
	(Martin Langhoff's message of "Thu, 20 Oct 2005 09:56:35 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10311>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> There is a second bug during the tag fetch. Some of the references
> (created by git-cvsimport) are multiline, and break cg-fetch. It's
> probably a bug in git-cvsimport, but I'm fixing cg-fetch to use head
> -n1 instead of cat. I'll deal with git-cvsimport later.

When you update git-cvsimport, please make the tags it generates
git-check-ref-format happy.  The rules are:

 - No pathname component starting with a dot '.' (cg-fetch uses
   refs/heads/.$name-fetching to store the SHA1 it has not fully
   completed; for_each_ref() deliberately ignores path component
   that start with a dot to ignore them, probably to work this
   around).

 - No double-dots anywhere (ref1..ref2 notation is used on the
   command line and ref with embedded double-dots introduces
   ambiguities in parsing).

 - No byte with value lower than \040 (SP) nor \177 (DEL).

 - No tilde '~', caret '^' or colon ':' (the first two are used
   in extended SHA1 expressions; colon is used as src:dst
   notation in push and pull).

 - Not ending with a slash '/'.

> On this broken-ish repo, git-fetch-pack segfaults as I've reported.
> Running it under strace shows that it dies walking the local repo,
> trying to find a missing commit. Unlikely that this is PPC only ;-)
