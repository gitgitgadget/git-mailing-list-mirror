From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-cvsimport "you may need to merge manually"
Date: Fri, 17 Mar 2006 00:06:21 -0800
Message-ID: <7vk6at1on6.fsf@assigned-by-dhcp.cox.net>
References: <86veud23v0.fsf@blue.stonehenge.com>
	<7vu09x7puo.fsf@assigned-by-dhcp.cox.net>
	<86r75122yj.fsf@blue.stonehenge.com>
	<7vk6at7o06.fsf@assigned-by-dhcp.cox.net>
	<20060317064618.GG14562@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 17 09:06:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FK9yg-00059O-4D
	for gcvg-git@gmane.org; Fri, 17 Mar 2006 09:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbWCQIGY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 03:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752554AbWCQIGY
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 03:06:24 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:40942 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1752535AbWCQIGX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Mar 2006 03:06:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060317080245.XRH17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 17 Mar 2006 03:02:45 -0500
To: smurf@smurf.noris.de
In-Reply-To: <20060317064618.GG14562@smurf.noris.de> (smurf@smurf.noris.de's
	message of "Fri, 17 Mar 2006 07:46:18 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17663>

smurf@smurf.noris.de writes:

> Junio C Hamano:
>> ..., and you are expected to say:
>> 
>> 	$ git pull . origin
>> 
> Exactly.

I think the second and subsequent run of "git cvsimport"
currently is similar to "git fetch", but earlier one that tried
to do checkout was probably similar to "git pull".  I think most
people would expect it to behave more like "git pull",
i.e. fetch from the upstream (that happens to be CVS) and merge
that into your branch.  It may not be operated that way
correctly and that might have been the reason we removed the
"master updates" code, but if that is the case I'd rather fix it
properly.

>> assuming that you are on "master" branch and cvsimoprt tracks
>> CVS head with "origin" branch, that is.
>> 
>> Smurf, help?
>> 
> What for? You got it, after all. *g*

Not really, I am afraid.  There is one snag _if_ you use the
current branch as the tracking branch.  Merlyn's setup is
exactly that -- he has "master" which is given to the command
with -o flag.  The branch head commit is already updated, but
the index and working tree is not.

Now, unlike git-fetch, git-cvsimport _requires_ you to have a
pristine tracking branch (otherwise we cannot discard already
seen patchsets from what we read from CVSPS), and leaving that
tracking branch checked out is calling for trouble because you
might be tempted to make your own commit on top of it.  So we
could argue that one solution would be to forbid importing into
the current branch.

But that breaks well behaving people who are used to leave a
tracking branch checked out _and_ promises not to touch that
branch head from the git side.

So what I would suggest is to do something like this:

 - Before starting to interpret CVSPS output, keep the commit
   object name of the current branch tip.

 - After we are done, read the current branch tip.  If they are
   different, we updated the current branch tip without matching
   the index and working tree, so we match them just like
   git-pull does.  Otherwise, we run 'git-merge' to merge the
   $opt_o branch into the current branch.

That is, perhaps, like this untested patch.  What do you think?

-- >8 --
cvsimport: act more like pull, not fetch

After updating tracking branches with upstream CVS changes, if
the current branch is one of the tracking branches, match the
index and working tree just like "git-pull" that was started
with one of the tracking branches checked out.  Otherwise, merge
the trunk ($opt_o) branch into the current branch.  This would
match users' expectation more closely.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 02d1928..b9cebaf 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -453,6 +453,7 @@ chdir($git_tree);
 my $last_branch = "";
 my $orig_branch = "";
 my %branch_date;
+my $tip_at_start = undef;
 
 my $git_dir = $ENV{"GIT_DIR"} || ".git";
 $git_dir = getwd()."/".$git_dir unless $git_dir =~ m#^/#;
@@ -487,6 +488,7 @@ unless(-d $git_dir) {
 		$last_branch = "master";
 	}
 	$orig_branch = $last_branch;
+	$tip_at_start = `git-rev-parse --verify HEAD`;
 
 	# populate index
 	system('git-read-tree', $last_branch);
@@ -873,7 +875,18 @@ if (defined $orig_git_index) {
 
 # Now switch back to the branch we were in before all of this happened
 if($orig_branch) {
-	print "DONE; you may need to merge manually.\n" if $opt_v;
+	print "DONE.\n" if $opt_v;
+	my $tip_at_end = `git-rev-parse --verify HEAD`;
+	if ($tip_at_start ne $tip_at_end) {
+		print "Fetched into the current branch.\n" if $opt_v;
+		system(qw(git-read-tree -u -m),
+		       $tip_at_start, $tip_at_end);
+		die "Fast-forward update failed: $?\n" if $?;
+	}
+	else {
+		system(qw(git-merge cvsimport HEAD), "refs/heads/$opt_o");
+		die "Could not merge $opt_o into the current branch.\n" if $?;
+	}
 } else {
 	$orig_branch = "master";
 	print "DONE; creating $orig_branch branch\n" if $opt_v;
