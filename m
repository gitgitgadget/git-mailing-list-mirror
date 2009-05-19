From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: any way to apply tag across all branches in repository?
Date: Tue, 19 May 2009 14:30:30 -0500
Message-ID: <0WGSJO_TdUxCKWhDCupb3MaPOyPeVNH7Rs_7iKVnQcahmxUpwu8qzw@cipher.nrlssc.navy.mil>
References: <4A12DDB9.60608@nortel.com> <Y0WmOpNg_9ptwbJ3VHYrzAgFtDvPi5pn4Tz-0w5Phhlo9frjieUaeA@cipher.nrlssc.navy.mil> <4A12F0ED.4070707@nortel.com> <NFLo0xGp2o-oBdtr_pq1jvwATe1ZALaD9dHkr5hmKNkU30gr_isMpQ@cipher.nrlssc.navy.mil> <4A130309.2060407@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Friesen <cfriesen@nortel.com>
X-From: git-owner@vger.kernel.org Tue May 19 21:30:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6V1R-0005jb-9Y
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 21:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735AbZESTag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 15:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753650AbZESTag
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 15:30:36 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:45098 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484AbZESTag (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 15:30:36 -0400
Received: by mail.nrlssc.navy.mil id n4JJUUQF026970; Tue, 19 May 2009 14:30:30 -0500
In-Reply-To: <4A130309.2060407@nortel.com>
X-OriginalArrivalTime: 19 May 2009 19:30:30.0557 (UTC) FILETIME=[45554CD0:01C9D8B8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119561>

Chris Friesen wrote:
> Brandon Casey wrote:
> 
>> Try these commands:
>>
>>   git describe $main
>>   git describe $arch_branch
>>   git tag -m 'a test tag' my_tag $main
>>   git describe $main
>>   git describe $arch_branch
> 
> In the commands below, "main" is $main, and "arch" is $arch_branch.
> I'm starting out with the arch branch checked out.
> 
> [cfriesen@localhost linux]$ git describe main
> dynamic_ftrace_excluded-auto-mark-225-g7c2dc32
> [cfriesen@localhost linux]$ git describe arch
> dynamic_ftrace_excluded-auto-mark-225-g7c2dc32
> [cfriesen@localhost linux]$ git tag -m 'a test tag' my_tag ncgl

What's "ncgl"?  Another branch at the same tip as "arch"?

> [cfriesen@localhost linux]$ git describe arch
> my_tag
> [cfriesen@localhost linux]$ git describe arch
> my_tag

Was one of those supposed to be "main"?

> So far so good.

I expected to see:

  $ git tag -m 'a test tag' my_tag main

  $ git describe main
  my_tag

  $ git describe arch
  my_tag-X-g0123456

Where 'X' is some number equal to the number of commits _not_ reachable
from "my_tag", and the digits after the 'g' are an abbreviated sha1 of
the tip commit on the arch branch.

> Now I make a change to the arch branch, and add
> another tag to the main branch.
> 
> [cfriesen@localhost linux]$ echo a > asdf
> [cfriesen@localhost linux]$ git add asdf
> [cfriesen@localhost linux]$ git commit
> Created commit 4c8dfa7: blah
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 asdf
> 
> [cfriesen@localhost linux]$ git describe main
> my_tag
> [cfriesen@localhost linux]$ git describe arch
> my_tag-1-g4c8dfa7

Ok, so maybe this is a test repo.  I didn't expect main and arch
to ever point to the exact same state.  This won't happen in
your real repo unless you are merging arch back into main.

Ok, you tagged main, and previously arch was at the same state,
so 'git describe' printed out 'my_tag' for both of them.  Now,
the arch branch is ahead of main by one commit, so you get an
expanded string from 'git describe' (the meaning of which I
described earlier, above).

> Now we add another tag to the main branch:
> 
> [cfriesen@localhost linux]$ git tag -m 'a test tag' my_tag2 main
> [cfriesen@localhost linux]$ git describe main
> my_tag
> [cfriesen@localhost linux]$ git describe arch
> my_tag-1-g4c8dfa7
> 
> I assume that since there were no code changes on the main branch,
> it doesn't think that there is any difference between the two tags.

Right.  There is no difference.  You created another tag pointing at
the same revision as the first tag.  Here's something else to try:

   $ git rev-parse main
   $ git rev-parse my_tag
   $ git rev-parse my_tag2

You'll see that they all print out the same sha1 string.

You can also try this:

   $ git rev-parse arch^
   # prints out same sha1 as above

   $ git rev-parse arch
   # prints out the sha1 of the commit that you just created

Off-hand, I'm not sure how 'git describe' decides which tag to use
in the describe output when there is more than one candidate.
Possibly earliest created?, possible alphabetical?  I didn't look.

Starting to make sense?

-brandon
