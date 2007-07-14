From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] Add git-rewrite-commits
Date: Sat, 14 Jul 2007 12:26:01 -0700
Message-ID: <7v7ip2hjna.fsf@assigned-by-dhcp.cox.net>
References: <11842671631744-git-send-email-skimo@liacs.nl>
	<11842671631635-git-send-email-skimo@liacs.nl>
	<Pine.LNX.4.64.0707141140510.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 14 21:26:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9nFt-0003Is-Sz
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 21:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761896AbXGNT0F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 15:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760804AbXGNT0E
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 15:26:04 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:52130 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761896AbXGNT0D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 15:26:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070714192603.HDSE1393.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 14 Jul 2007 15:26:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PXS11X00J1kojtg0000000; Sat, 14 Jul 2007 15:26:02 -0400
In-Reply-To: <Pine.LNX.4.64.0707141140510.14781@racer.site> (Johannes
	Schindelin's message of "Sat, 14 Jul 2007 13:49:59 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52499>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +Examples
>> +--------
>> +
>> +Suppose you want to remove a file (containing confidential information
>> +or copyright violation) from all commits:
>> +
>> +----------------------------------------------------------------------------
>> +git rewrite-commits --index-filter 'git update-index --remove filename || :'
>
> We seem to prefer "$ git" instead of just "git" in the other man pages' 
> examples.

"git update-index --remove Foo" does not remove the index entry
Foo if the file Foo still exists in the working tree (use "git
update-index --force-remove" for that).

But this leads to more fundamental issues.  It is not obvious
from the description what environment rewrite-commits runs in.
Does it run at the toplevel of the current working tree, or is
it run in a separate temporary directory like filter-branch
does?  What "index" and "HEAD" do operations done by filters
affect (I think it is safe to assume that readers familiar
enough with other parts of git would be able to guess that
filters should operate on the "HEAD" and index given by
rewrite-commits to its execution environment without mucking
with GIT_DIR nor GIT_INDEX_FILE)?  Are filters allowed to modify
files in the working tree, and if so what is the consequence of
doing so?

>> +----------------------------------------------------------------------------
>> +
>> +Now, you will get the rewritten history saved in your current branch
>> +(the old branch is saved in refs/original).
>
> 						The "|| :" construct 
> + prevents the filter to fail when the given file was not present in the 
> + index.

prevents the filter from failing?  But is that really what we
want?  Why are we ignoring the error, and if there is a valid
reason to ignore shouldn't we explain why?

>> +To move the whole tree into a subdirectory, or remove it from there:
>> +
>> +---------------------------------------------------------------
>> +git rewrite-commits --index-filter \
>> +	'git ls-files -s | sed "s-\t-&newsubdir/-" |
>> +		GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
>> +			git update-index --index-info &&
>> +	 mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE'
>> +---------------------------------------------------------------

I see only one operation in the example, and "or remove it from
there" confuses the reader.

I'll refrain from comments on the code right now, until I read
the series over.
