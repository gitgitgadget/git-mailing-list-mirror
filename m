From: linux@horizon.com
Subject: Re: Change set based shallow clone
Date: 11 Sep 2006 08:39:37 -0400
Message-ID: <20060911123937.6521.qmail@science.horizon.com>
References: <17669.13028.198886.947400@cargo.ozlabs.ibm.com>
Cc: git@vger.kernel.org, jonsmirl@gmail.com, junkio@cox.net,
	mcostalba@gmail.com, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Mon Sep 11 14:39:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMl4m-0001AF-F2
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 14:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWIKMjk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 08:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWIKMjk
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 08:39:40 -0400
Received: from science.horizon.com ([192.35.100.1]:38439 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751440AbWIKMjj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Sep 2006 08:39:39 -0400
Received: (qmail 6522 invoked by uid 1000); 11 Sep 2006 08:39:38 -0400
To: linux@horizon.com, paulus@samba.org
In-Reply-To: <17669.13028.198886.947400@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26850>

>> I'm trying to figure out the gitk code, but I'm not fluent in tcl, and
>> it has 39 non-boilerplate comment lines in 229 functions and 6308 lines
>> of source, so it requires fairly intensive grokking.
>
> Sorry :)

I was more making excuses for my failure to understand its properties.
Still, if you get the chance, a couple of paragraphs of comments on the
primary data structures would be an immense help.

Anyway, thanks for the summary.

>> For example, is fixing a small number of out-of-place commits practical,
>> or is it better to purge and restart?  The former avoids deleting
>> already-existing objects, while the latter avoids moving them.

> For gitk, I'm thinking of a reorder buffer of say 10 entries at the
> front end to cope with minor misorderings; then if misordering occurs
> that is outside the scope of the reorder buffer to fix, freeze the
> layout algorithms at that point, read in the rest of the commits and
> reorder as necessary, then at the end restart the layout algorithm
> from scratch, probably with a popup to inform the user what happened.
> If the user could set the size of the reorder buffer then they could
> avoid having that happen in future, at the cost of it taking longer to
> show the first screenful of commits.

My thoughts were that anything you could do, git-rev-list could do better,
including the re-order buffer, so don't even bother.  (For example, I
was thinking of a time- or depth-based one rather than a count-based one.)

So I read your suggestion as a "purge and restart" preference, with
git-rev-list keeping a cache of problems encountered so that on most
runs, it doesn't have to do it.  Putting that logic in git-rev-list
means that you don't have to detect ordering problems or do any sorting,
just handle an "oops!" line in the output.

Basically, given the example graph (with letters indicating timestamps)

...G--D--C--B---A
          \    /
           F--E

You'd get something like
A B E
B C
C D
D G
E F
*** ERROR -  restarting - please wait
A B E
B C
E F
F C
C D
D G
G ...
