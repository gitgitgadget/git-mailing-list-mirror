From: Jan Hudec <bulb@ucw.cz>
Subject: Re: how git pull works?
Date: Fri, 19 Nov 2010 22:27:29 +0100
Message-ID: <20101119212729.GH30870@efreet.light.src>
References: <4CE3FBA5-3DF0-493F-9600-6D424B5CBA2F@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dowlin Yang <dowlin0820@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 22:27:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJYUb-00069v-N1
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 22:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851Ab0KSV1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 16:27:33 -0500
Received: from cuda1.bluetone.cz ([212.158.128.5]:34988 "EHLO
	cuda1.bluetone.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756806Ab0KSV1c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 16:27:32 -0500
X-ASG-Debug-ID: 1290202049-0701433d0001-QuoKaX
Received: from efreet.light.src (152-31-80-78.tmcz.cz [78.80.31.152]) by cuda1.bluetone.cz with ESMTP id SIpG3Gj5gpodggPp; Fri, 19 Nov 2010 22:27:29 +0100 (CET)
X-Barracuda-Envelope-From: bulb@ucw.cz
X-Barracuda-Apparent-Source-IP: 78.80.31.152
Received: from bulb by efreet.light.src with local (Exim 4.72)
	(envelope-from <bulb@ucw.cz>)
	id 1PJYUT-0007qJ-7o; Fri, 19 Nov 2010 22:27:29 +0100
X-ASG-Orig-Subj: Re: how git pull works?
Content-Disposition: inline
In-Reply-To: <4CE3FBA5-3DF0-493F-9600-6D424B5CBA2F@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Barracuda-Connect: 152-31-80-78.tmcz.cz[78.80.31.152]
X-Barracuda-Start-Time: 1290202049
X-Barracuda-URL: http://212.158.128.5:8000/cgi-mod/mark.cgi
X-Barracuda-Bayes: INNOCENT GLOBAL 0.6845 1.0000 1.2545
X-Barracuda-Spam-Score: 1.25
X-Barracuda-Spam-Status: No, SCORE=1.25 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=4.5 KILL_LEVEL=4.8 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.47109
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161789>

On Fri, Nov 19, 2010 at 23:15:51 +0800, Dowlin Yang wrote:
> I sent an email earlier but it seems rejected. I resent again with plain
> text format. I am sorry for any inconvenience if you receive my messages
> twice, and please read the new one.

If it was HTML it was rejected by the list software and nobody ever saw it.
HTML is not accepted by any of the lists on vger.kernel.org.

> Suppose A had a branch b1 and B had a branch b2. They work on their own
> branch separately but b1 and b2 share the same file f1. Suppose A made
> a few changes to f1 on Nov 5th.

Dates are irrelevant. What is the most recent common ancestor?

Note, that most recent common ancestor is such commit, that is reachable from
both branches ("common ancestor") and it is not reachable from any other
common ancestor ("most recent"). No mention of dates anywhere -- just
parent-child relation between commits.

> Here are A's changes:
> [snip]
> A removed one line and added a few lines to f1 and then committed on Nov
> 5th.
>
> On the other hand, B made a few changes to f1 too on the next day Nov 6th.
> Here are B's changes:
> [snip] 
> B removed a few lines and then committed on Nov 6th.
>
> They kept updating other files in the following days. After a few days, we
> decide to merge A's branch b1 with B's branch b2. So A did git pull origin
> b2 in b1, and the expected resultant file is sth like this:
> [snip]

Now git -- and for that matter any other version control system out there
that ever had a merge command -- looks for the most recent common ancestor.
Let's call it 'a'(1).

Now git applied both changes from a to b1 and changes from a to b2. It uses
the 3-way merge algorithm, which is basically:
 - match up all lines that are the same in all three versions
 - for lines where a and b1 is the same, take b2
 - for lines where a and b2 is the same, take b1
 - for lines where b1 and b2 are the same, take b1 (== b2)
 - for lines where a, b1 and b2 all differ, declare conflict

You can equally think about this algorithm as applying diff from a to b1 to
b2 or applying diff from a to b2 to b1. All should give the same results(2).

For adding/removing files, just think of the tree as file listing what files
are included (where order is ignored, so the same name is always matched up).

The individual changes are not considered, ever. Only the sum of changes
since most recent common ancestor on one and the other side.

> Aren't newer changes supposed to be applied? Why older changes are the
> final results?

No. All changes since branch point or last merge are applied.

> B's b2 branch had com/category_bar.js added earlier than A's b1. A manually
> added the same changes to b1 on Nov 5th, but later B decided to remove
> com/category_bar.js from b2 on Nov 6h as I described.

b2 had category_bar.js added and removed again, so in the end it had no
changes in category_bar.js

b1 had category_bar.js added

No change (between a and b2) versus addition (between a and b1) is addition.
So category_bar.js is added in the result.

If you didn't add category_bar.js independently on b1, but instead pulled
from b2, the pulled revision would have been most recent common ancestor, so
b1 would see no further change and b2 would see deletion and result would be
deletion.

Footnotes:
~~~~~~~~~~
1) You can query most recent common ancestor with 'git merge-base b1 b2'.
   You can view/list all commits from common ancestor to b2 with 'b1..b2'
   refspec to gitk/git log. You can view/list all commits from common
   ancestor to both b1 and b2 with 'b1...b2' refspec to gitk/git log. You can
   get the cumulative diff from common ancestor to b2 with 'git diff
   b1...b2'.

2) Unless there are conflicts or a repeated text, in which case patch
   application (with limited context) would not have enough information on
   where to apply while 3-way merge would.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
