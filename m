From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (3rd try)] Add git-stash script
Date: Sat, 30 Jun 2007 10:19:35 -0700
Message-ID: <7v8xa1e4wo.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706300304480.4438@racer.site>
	<200706300539.l5U5dHLh003989@mi1.bluebottle.com>
	<Pine.LNX.4.64.0706301641000.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	GIT <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 30 19:20:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4gc9-0005pE-5P
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 19:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757443AbXF3RTr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 13:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757422AbXF3RTp
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 13:19:45 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:38789 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756213AbXF3RTh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 13:19:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070630171935.XHKU17683.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Jun 2007 13:19:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HtKb1X00P1kojtg0000000; Sat, 30 Jun 2007 13:19:36 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51229>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> diff --git a/git-stash.sh b/git-stash.sh
>> [...]
>> +	printf >&2 'Saved WIP on %s\n' "$msg"
>
> You have an awful lot of printfs in the code. Why not just use echos?

I had the same impression, but I would say it is Ok (actually
printf is even better).  Judging from our recent changes
(e.g. a23bfae) I think it is prudent to avoid echo when printing
user supplied messages.  Not that corrupted backslash sequence
matters that much on stderr, though ;-).

>> +list_stash () {
>> +	git-log --pretty=oneline -g "$@" $ref_stash |
>
> Wouldn't you want "--default $ref_stash" here?

But "git log --pretty=oneline -g master --default refs/stash"
would not make much sense would it?  The design currently seems
to follow what I suggested earlier, namely to use a single stash
ref per repository, so $ref_stash is spelled as a variable but
it is a constant.  IOW, you do not specify "alternate stash"
from the command line.

Unfortunately we do not have a good way to reject non-flag rev
parameters in "$@" to error out "git stash list master".  What
we would want here is a way to allow things like --since=1.hour
and -20 while rejecting branch/tag names and other parameters.

>> +apply_stash () {
>> +	git-diff-files --quiet ||
>> +		die 'Cannot restore on top of a dirty state'
>
> You meant "no_changes", right? I think you miss changes in the index 
> otherwise.

Interestingly, I think this is actually correct in the sense
that the code is internally consistent, as it uses the current
index, not the HEAD, as the base of application.  It however is
debatable if this sequence (which is allowed because it does not
use no_changes here) makes sense:

	: hack hack hack
	: get interrupted
	$ git stash
	: do something else on a clean slate
	$ git commit
        : hack hack hack
        $ git add -u
        $ git unstash

>> +		git-diff --cached --name-only --diff-filter=A $c_tree >"$a" &&
>> +		git-read-tree --reset $c_tree &&
>> +		git-update-index --add --stdin <"$a" ||
>> +			die "Cannot unstage modified files"
>
> Isn't there a way to avoid the temporary file here?

We could obviously do

	files=$(git-diff --cached ...) &&
        git-read-tree --reset $c_tree &&
        echo "$files" | git-update-index --add --stdin

Oops, the last "echo" may have to be "printf '%s'" ;-)

There might be quite many files that have been added to make the
$files variable too big to be given to echo, though.

	git-diff --cached ... |
        (
        	git-read-tree --reset $c_tree &&
                git-update-index --add --stdin
	)

would not work, unless you copy the index into a temporary file
and have the upstream git-diff use it.  But then we are using a
temporary file anyway.

>> +		set x -n 10
>> +		shift
>
> This is more elegantly written as "set -- -n 10", or in our context even 
> "set -- -10".

That is Ok in POSIX only world, but so far we have stayed away
from using "set -- potentially-dangerous-string" in any of our
scripts.  I would feel x + shift is safer and more comfortable
but probably that is largely because I am old fashioned.
