From: "Neal Groothuis" <ngroot@lo-cal.org>
Subject: Finding all commits which modify a file
Date: Fri, 20 Jan 2012 16:35:31 -0500 (EST)
Message-ID: <46043.208.70.151.129.1327095331.squirrel@mail.lo-cal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 20 22:41:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoMDM-0007az-Vk
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 22:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594Ab2ATVlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 16:41:36 -0500
Received: from dharma.lo-cal.org ([208.70.151.129]:43022 "EHLO
	dharma.lo-cal.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906Ab2ATVlf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 16:41:35 -0500
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Jan 2012 16:41:35 EST
Received: from mail.lo-cal.org (localhost [127.0.0.1])
	by dharma.lo-cal.org (Postfix) with ESMTP id D6C6E2AEAB4
	for <git@vger.kernel.org>; Fri, 20 Jan 2012 15:35:31 -0600 (CST)
Received: from 208.70.151.129
        (SquirrelMail authenticated user ngroot)
        by mail.lo-cal.org with HTTP;
        Fri, 20 Jan 2012 16:35:31 -0500 (EST)
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188904>

Hello,

I'm trying to find /all/ commits that change a file in the
repository...and its proving to be trickier than I thought. :-)

The situation that we were dealing with is this:

- Person A and person B both pull from the same central repository.

- Person A makes a change to file foo.txt and bar.txt, commits, and pushes
to the central repository.

- Person B makes a similar change to bar.txt and commits it.

- Person B does a fetch and merge.  Since both A and B made changes to
bar.txt, this requires conflicts to be resolved manually.

- B reverts A's changes to foo.txt. (If B is coming from a different
revision control system, this may happen due to confusion about how merges
are handled.)

- B commits the changes.

- B makes more changes to bar.txt, commits them, and pushes to the central
repository.

At this point, A's changes to foo.txt have been undone.

Graphically:

    A1
   /  ^
  v    \
  C1   B2<-B3
  ^    /
   \  v
    B1

B1, B2, and B3 have the same version of foo.txt as C1, A1 modifies it.

Person A discovers that his changes are missing and wants to know what
happened.

git log foo.txt doesn't help; it won't even show commit A1, due to history
simplification.

git log --full-history foo.txt will show commit A1.  It still won't show
commit B2, though, which we'd also like to show (because that's where the
change to foo.txt got removed).

I would think that git log --simplify-merges foo.txt would have done what
I'd wanted, but it still does not show commit B2.   Based on what I'm
reading in the man page, I would expect the simplification to go like
this:

    A1
    | ^
    |  \
    |  B2<-B3
    |  /
    v v
    C1

(since B1 is TREESAME as C1 if we're only considering foo.txt)

    A1
    | ^
    |  \
    |  B2<-B3
    |
    v
    C1

(since C1 is an ancestor of A1)

However, the actual output only includes A1, not B2.

 - Can someone explain this, and/or
 - can someone offer a command to display all commits (including merges)
in which ANY parent is not TREESAME?

Thanks!

- Neal
