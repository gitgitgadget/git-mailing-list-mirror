From: Junio C Hamano <junkio@cox.net>
Subject: Re: [wishlist] git branch -d -r remotename
Date: Sun, 18 Mar 2007 23:18:34 -0700
Message-ID: <7v8xdtkb7p.fsf@assigned-by-dhcp.cox.net>
References: <45FD0804.6010401@vilain.net>
	<20070318110507.5701413A382@magnus.utsl.gen.nz>
	<20070318113210.5843E13A382@magnus.utsl.gen.nz>
	<7vvegyl4nt.fsf@assigned-by-dhcp.cox.net> <45FDB322.10904@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 07:18:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTBCX-0005LR-Cb
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 07:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965645AbXCSGSg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 02:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965658AbXCSGSg
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 02:18:36 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:48518 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965645AbXCSGSf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 02:18:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070319061835.UXUK321.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Mar 2007 02:18:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cWJa1W00K1kojtg0000000; Mon, 19 Mar 2007 02:18:34 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42593>

Sam Vilain <sam@vilain.net> writes:

> It doesn't do that because the head doesn't match any revision that was
> given to us by `rev-list refs/remotes/foo/*`

Gaah.  That goes all the way down to the root commit.

+		print "fetching revs for ".@refs." remote refs\n";

Is this meant to be final message to the end-user, or debug?

+		my %r = map { ($_ => undef) }
+			$git->command("rev-list", @refs);

This traverses all the way down to the root commit, doesn't it?

That is probably good enough for a toy repository for testing,
but is impractical in real repositories, I am afraid.  See below
for the standard ways to check ancestry.

+		# don't delete the current branch
+		my ($checked_out) = $git->command(qw(symbolic-ref HEAD));

When the HEAD is detached, does the error message go directly to
the end user?

+		while ( my ($ref, $rev) = each %l ) {
+			next if $checked_out and $ref eq $checked_out;
+			if ( exists $r{$rev} ) {
+				print "$ref is obsolete\n";
+				$git->command(qw(update-ref -d), $ref, $rev);
+			}
+		}
 
The standard way to check if commit A is included in (i.e. is an
ancestor of) commit B, without traversing the ancestry chain of
B all the way down to the root commit, is to run:

	git merge-base --all A B

and see if A appears in its output (if so, then A is an ancestor
of B, otherwise it is not).  This is a pair-wise check, and for
your purpose the check would become N*M operation (Yuck).

The same check can be done in parallel with:

	git show-branch --independent A B C D...

whose output would include A if the commit is not included in
any of the other commits B C D...  This parallel traversal has a
limit --- you can only check 25 branches at a time.

>> If the above is the usage scenario you are trying to help, then
>> wouldn't it be helpful if you could also help removing 'my-next'
>> in this slightly altered example?
>>
>> 	$ git clone
>>         ... time passes ...
>>         $ git checkout -b my-next origin/next
>>         ... build, install, have fun ...
>> 	$ git checkout master
>>         ... time passes ...
>>         $ git branch
>>         ... notice that you do not hack on your copy of 'next'
>>         ... which is 'my-next', and want to remove it
>> 	$ git remote prune -c
>
> Yes, the idea was to "sweep" all branches that were just local branches
> of a remote and never worked on. This is most useful right now for
> people switching from Cogito or old-style remotes, who have a lot of
> branches that are remote tracking branches. Using this, they can just
> set up a new remote, fetch and prune -c and be left in a tidy state.

You make it sound like this is just a one-shot conversion issue,
in which case I really doubt we would want that.  But it appears
to be a useful feature in general, provided if the assumed use
case is described clearly so that new users know when to use it.
In the form that was given to me, I think the documentation
leaves the user in a "Huh?" state.
