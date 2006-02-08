From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-annotate - a tool for annotating files with the revision and person that created each line in the file.
Date: Wed, 08 Feb 2006 13:45:11 -0800
Message-ID: <7vlkwlo788.fsf@assigned-by-dhcp.cox.net>
References: <11394103753694-git-send-email-ryan@michonline.com>
	<7vd5hxpr2d.fsf@assigned-by-dhcp.cox.net>
	<20060208210756.GA9490@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 22:45:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6x7x-0005CA-Sf
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 22:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWBHVp1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 16:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWBHVp1
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 16:45:27 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:18314 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750968AbWBHVp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 16:45:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060208214236.ZCMA26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Feb 2006 16:42:36 -0500
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20060208210756.GA9490@mythryan2.michonline.com> (Ryan Anderson's
	message of "Wed, 8 Feb 2006 16:07:57 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15754>

Ryan Anderson <ryan@michonline.com> writes:

>> It's been a while since I looked at it the last time so it may
>> not even work with the current git, but here it is..
>
> I'll take a look through this in greater detail later, hopefully your
> approach can be applied.  Diff-analyzing is apparently tricky.

Reading diff is tricky but I was lazy to match up the lines by
hand, which is also a real work ;-).

There are a few things I should add to that ancient code:

 - It wants old ls-tree behaviour.  The command line used in the
   "sub find_file" needs to be updated to something like this:

    open $fh, '-|', 'git-ls-tree', '-z', '-r', $commit->{TREE}, $path
	or die "cannot read git-ls-tree $commit->{TREE}";

 - It only cares about the line numbers and its output is meant
   to be postprocessed with the contents from the latest blob.

 - It predates the recent rev-list that skips commits that do
   not change the specified paths, and it literally follows each
   parent and optimizes not to diff with uninteresting parents
   by hand.

I suspect if you go with the diff-reading approach, it might be
easy to convert it to C (or even write the initial version in C)
using the machinery similar to what is in combine-diff.c.

The algorithm combine-diff.c uses keeps the lines discarded from
each parent in lline structure linked to the sline structure
(which keeps track of the lines in the final version), but for
your annotate purposes what you care about is only what the
child adds to the parent (IOW, we do not care about the lines
that do not appear in the final version), so the logic and the
data structure could be greatly simplified.  You only need to
keep "flag" element in the sline structure, and maybe bol and
len that point at the contents of the resulting line from the
final version.  In addition, you would need to store "the
current suspect commit" (starts from the final revision and
updated as you pass the blame along) and another bool that says
if "the current suspect" is known to be the guilty party or if
the true culprit is one of its ancestors (capital vs lowercase
difference in that explanatory note).
