From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make gc a builtin.
Date: Wed, 14 Mar 2007 00:19:07 -0700
Message-ID: <7vodmwfg2c.fsf@assigned-by-dhcp.cox.net>
References: <11738375021267-git-send-email-jbowes@dangerouslyinc.com>
	<20070314060727.GC20978@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Bowes <jbowes@dangerouslyinc.com>, git@vger.kernel.org,
	junkio@cox.net, Johannes.Schindelin@gmx.de
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 14 08:19:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRNlb-0005mc-Ht
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 08:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030690AbXCNHTK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 03:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030693AbXCNHTK
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 03:19:10 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:60458 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030690AbXCNHTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 03:19:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314071909.LUYX321.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 03:19:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aXK71W0081kojtg0000000; Wed, 14 Mar 2007 03:19:08 -0400
In-Reply-To: <20070314060727.GC20978@spearce.org> (Shawn O. Pearce's message
	of "Wed, 14 Mar 2007 02:07:27 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42179>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> James Bowes <jbowes@dangerouslyinc.com> wrote:
>> Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
>
> ACK.  Very nicely done.

Perhaps.  But we lost another sample script which made an entry
barrier higher to a new person.

>> +	if (run_command_v_opt(argv_rerere, RUN_GIT_CMD))
>> +		return error(FAILED_RUN, argv_rerere[0]);
>
> And isn't the above so much more readable than this mess?
>
>> -test "true" != "$pack_refs" ||
>> -git-pack-refs --prune &&
>> -git-reflog expire --all &&
>> -git-repack -a -d -l &&
>> ...

I do not necessarily think so.  This is not even a performance
critical part of the system, so if there _were_ no other
constraints, I would rather keep scripts like this as scripts.

For things like this, scripts are much easier to read,
understand and futz with, and command lists chained with && in
shell scripts are very nice and compact way to express what is
going on.

This is especially true if you have some specialized needs, if
you do not expect you need to keep that change forever, and if
you are lazy.  For example, if you have a repository that you
for some reason need to keep available to older dumb transport
clients for now, you would disable "git-pack-refs --prune" line
from your copy of the script version.  No need to recompile.

Another example is git-repack script.  When you have a
specialized repacking needs (say, repack from a specific
revision to make a .keep pack to avoid future excessive
repacking), being able to check how the plumbing is used in
git-repack script and run customized version of it is very
handy.  Once you rewrite it to sequence of

	if (run_command_v_opt(blech, RUN_GIT_CMD))
        	...

it becomes much harder to learn what the shell command
equivalent that would suit your needs would be, and we would
lose another command that would serve as a good example.

We are doing built-in _only_ because people on some platforms
cannot sanely use POSIX shell scripts.  I do not reject these
"make X built-in" patches (when X is perfectly fine as a shell
script) because I sympathize with people stuck on Windows, not
because I think built-in is easier to read nor work with than
scripts.  There is a downside.
