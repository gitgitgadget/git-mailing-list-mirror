From: linux@horizon.com
Subject: More merge questions
Date: 30 Nov 2005 08:10:45 -0500
Message-ID: <20051130131045.28149.qmail@science.horizon.com>
References: <7vwtiqzljr.fsf@assigned-by-dhcp.cox.net>
Cc: junkio@cox.net, linux@horizon.com
X-From: git-owner@vger.kernel.org Wed Nov 30 15:55:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhRjc-0000Nn-Ny
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 14:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVK3NKx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 08:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbVK3NKx
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 08:10:53 -0500
Received: from science.horizon.com ([192.35.100.1]:9258 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751209AbVK3NKx
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 08:10:53 -0500
Received: (qmail 28150 invoked by uid 1000); 30 Nov 2005 08:10:45 -0500
To: git@vger.kernel.org
In-Reply-To: <7vwtiqzljr.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12998>

I'm working my way through a thorough understanding of merging.

First I got git-read-tree's 3-way merge down to 6 conditionals, where
a missing entry is considered equal to a missing entry, and a missing
index entry is considered clean.

a) If stage2 == stage3, use stage2
b) If stage1 == stage3, use stage2
c) If the index entry exists and is dirty (working dir changes), FAIL
d) If stage1 == stage2, use stage3
e) If trivial-only, FAIL
f) Return unmerged result for 3-way resolution by git-merge-index.

Case c is needed so you don't change the world out from under
your working directory changes.  You could move it earlier and
make things strictire, but that's the minimal restriction.

Then I started thinking about 2-way merge, and how that differed
from a 3-way merge where stage2 was the previous index contents.

If you apply the same rules (with trivial-only true), the only differences
to the big 22-case table in the git-read-tree docs are:

3) This says that if stage1 and state3 exist, use stage3.
   3-way says if they're equal, delete the file, while if they're
   unequal, it's fail.

If 3-way git-merge-index were allowed, then the conditions that would
change to do it are cases 8 and 12.

The full list of cases and the conditional that applies, is:

0) a
1) d
2) a
3) see above.  It's b or e by my logic, but d by the table.

4) b
5) b
6) a
7) a
8) e
9) c

10) d
11) c
12) e
13) c

14) a or b
15) a or b

16) e
17) c
18) a
19) a
20) d
21) c

Given that it all matches up so nicely, I'd like to honestly ask if
case 3 of the conditions is correct.  I'd think that if I deleted
a file form te index, and the file wasn't changed on the head I'm
tracking, the right resolution is to keep it deleted.  Why override
my deletion?

Sorry if this is a dumb question, but it's not obvious to me.
