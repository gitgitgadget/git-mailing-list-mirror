From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix "git log -z" behaviour
Date: Sat, 10 Feb 2007 01:36:37 -0800
Message-ID: <7vlkj6mk0q.fsf@assigned-by-dhcp.cox.net>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com>
	<Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org>
	<Pine.LNX.4.64.0702070919320.8424@woody.linux-foundation.org>
	<Pine.LNX.4.64.0702071139090.8424@woody.linux-foundation.org>
	<7v7iusz3c2.fsf@assigned-by-dhcp.cox.net>
	<7vtzxumps5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Don Zickus <dzickus@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Feb 10 10:37:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFofG-00038C-EF
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 10:37:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039AbXBJJgk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 04:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752221AbXBJJgk
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 04:36:40 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:57950 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039AbXBJJgi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 04:36:38 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070210093638.ELQY21704.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 10 Feb 2007 04:36:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Mlcd1W00M1kojtg0000000; Sat, 10 Feb 2007 04:36:38 -0500
In-Reply-To: <7vtzxumps5.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 09 Feb 2007 23:32:10 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39212>

Junio C Hamano <junkio@cox.net> writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>
>>> For the normal case where the termination character is '\n', this 
>>> obviously doesn't change anything at all, since we just switched two 
>>> identical characters around. So it's very safe - it doesn't change any 
>>> normal usage, but it definitely fixes "git log -z".
>>
>> Gaah.
>>
>> I have already applied this but I think this has fallout for
>> existing users of "-z --raw".  Nothing in-tree uses "git log" as
>> the upstream of a pipe as far as I know because in-tree stuff
>> tend to stick to plumbing when it comes to scripting, but I
>> think your patch would affect the plumbing level as well.
>
> I think the new semantics for -z ("inter-record termination is
> NUL") makes a lot more sense for "-p -z" format that shows
> commit log message and the patch text.  It makes filtering the
> output with "grep -z" feel much more natural.
>
> The new semantics is however quite inconsistent with the other
> formats: --raw, --name-only and --name-status.  These already
> use NUL for separating pathnames and fields when -z is given, in
> order to allow scripts sensibly deal with pathname that contain
> funny characters (e.g. LF and HT).  Nobody is likely to feed
> their output to "grep -z", but one problematic case I see is to
> use this:
>
> 	git log -z --raw -r --pretty=raw $commit
>
> or its equivalent:
>
> 	git rev-list $commit |
>         git diff-tree --stdin --raw -r --pretty=raw
>
> to prepare data to feed something like fast-import.
>
> But such newly written scripts can read from non -z and unwrap
> paths themselves just as easily (the pathname safety with NUL
> was invented before we started using c-quote consistently), so
> it might be Ok to leave them (slightly) broken.
>
> So, I give up.

... well, it just occured to me that it might make sense not to
let this new "use NUL as inter-commit separator for grep -z"
semantics hijack existing -z option, but introduce another
option, say, -Z.  Then you could even do something like:

	git log -Z -r --numstat |
        grep -z -e '^[1-9][0-9][0-9][0-9]*	'

to find commits that has more than 100 lines of additions to a
file.  (or use --stat and grep for '| *[1-9][0-9][0-9][0-9]* ' to
look for sum of addition+deletion ).

Hmmmm.
